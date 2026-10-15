#!/usr/bin/env bash
# =============================================================================
# Run build_bitstream_linux.tcl under a watchdog that keeps the shared server healthy.
#
#   ./run_build_watchdog.sh            # start (detaches, survives logout)
#   tail -f watchdog.log               # follow status
#   ./run_build_watchdog.sh stop       # abort the build
#
# Every CHECK_SEC the watchdog checks and ABORTS the build (kills the whole Vivado
# session) when:
#   - total runtime          > TIMEOUT_H hours
#   - Vivado (all processes) PSS > MAX_RSS_GB
#   - server MemAvailable    < MIN_AVAIL_GB         (protect other users)
#   - server load (1 min)    > MAX_LOAD for LOAD_STRIKES checks in a row
#   - free disk on build dir < MIN_DISK_GB
#   - no log progress for    STALL_MIN minutes      (hung tool)
# All limits can be overridden from the environment.
# =============================================================================
set -u
cd "$(dirname "$(readlink -f "$0")")"
HERE=$PWD

VIVADO_SETTINGS=${VIVADO_SETTINGS:-/ssd3/tools/Xilinx/2025.2/Vivado/settings64.sh}
export VIVADO_THREADS=${VIVADO_THREADS:-2}
TIMEOUT_H=${TIMEOUT_H:-10}
MAX_RSS_GB=${MAX_RSS_GB:-12}
WARN_RSS_GB=${WARN_RSS_GB:-4}
MIN_AVAIL_GB=${MIN_AVAIL_GB:-4}
MAX_LOAD=${MAX_LOAD:-$(( $(nproc) * 3 / 2 ))}
LOAD_STRIKES=${LOAD_STRIKES:-5}
MIN_DISK_GB=${MIN_DISK_GB:-10}
STALL_MIN=${STALL_MIN:-60}
CHECK_SEC=${CHECK_SEC:-60}

WD_LOG=$HERE/watchdog.log
PID_FILE=$HERE/.build.pid
STATUS_FILE=$HERE/build_status.txt

log() { echo "$(date '+%F %T') $*" | tee -a "$WD_LOG"; }

if [ "${1:-}" = stop ]; then
  [ -f "$PID_FILE" ] || { echo "no build running"; exit 0; }
  sid=$(cat "$PID_FILE"); pkill -TERM -s "$sid"; sleep 10; pkill -KILL -s "$sid"
  log "STOPPED by user (session $sid)"; echo ABORTED_BY_USER > "$STATUS_FILE"; exit 0
fi

# --- detach the watchdog itself so it survives the terminal / ssh session ---
if [ "${WD_DETACHED:-0}" != 1 ]; then
  WD_DETACHED=1 setsid nohup "$0" "$@" > /dev/null 2>&1 < /dev/null &
  echo "watchdog started (pid $!), follow with: tail -f $WD_LOG"
  exit 0
fi

: > "$WD_LOG"
echo RUNNING > "$STATUS_FILE"
log "limits: threads=$VIVADO_THREADS timeout=${TIMEOUT_H}h rss<=${MAX_RSS_GB}G (warn ${WARN_RSS_GB}G)" \
    "memavail>=${MIN_AVAIL_GB}G load<=$MAX_LOAD x$LOAD_STRIKES disk>=${MIN_DISK_GB}G stall<=${STALL_MIN}min"

# --- start Vivado in its own session, low priority ---
setsid bash -c "source '$VIVADO_SETTINGS' && exec nice -n 10 vivado -mode batch -notrace \
  -source '$HERE/build_bitstream_linux.tcl' -log '$HERE/build.log' -journal '$HERE/build.jou'" \
  > "$HERE/build.stdout" 2>&1 < /dev/null &
VPID=$!
echo "$VPID" > "$PID_FILE"          # session id == pid of the setsid leader
log "vivado started, session $VPID"

kill_build() {
  log "ABORT: $*"
  pkill -TERM -s "$VPID"; sleep 15; pkill -KILL -s "$VPID" 2>/dev/null
  echo "ABORTED: $*" > "$STATUS_FILE"; rm -f "$PID_FILE"; exit 1
}

start=$(date +%s); strikes=0; peak_rss=0; warned=0
while kill -0 "$VPID" 2>/dev/null; do
  sleep "$CHECK_SEC"
  kill -0 "$VPID" 2>/dev/null || break
  now=$(date +%s); el_min=$(( (now - start) / 60 ))

  # PSS = real memory of the Vivado session (RSS double-counts libraries shared between processes)
  rss_kb=$(for p in $(ps -o pid= -s "$VPID" 2>/dev/null); do awk '/^Pss:/{print $2}' /proc/$p/smaps_rollup 2>/dev/null; done \
           | awk '{s+=$1} END {print s+0}')
  rss_gb=$(awk -v k="$rss_kb" 'BEGIN{printf "%.1f", k/1048576}')
  [ "$rss_kb" -gt "$peak_rss" ] && peak_rss=$rss_kb
  avail_gb=$(awk '/MemAvailable/ {printf "%.1f", $2/1048576}' /proc/meminfo)
  load=$(cut -d' ' -f1 /proc/loadavg)
  disk_gb=$(df -BG --output=avail "$HERE" | tail -1 | tr -dc 0-9)
  last_mod=$(find "$HERE/build.log" "$HERE/rocket_kv260_lnx" -name '*.log' -newermt "-${STALL_MIN} minutes" 2>/dev/null | head -1)
  stage=$(grep -hoE '=== STAGE [a-z]+|Starting [A-Za-z ]+Task|Phase [0-9.]+ [A-Za-z ]+' \
            "$HERE/build.log" $(ls -t "$HERE"/rocket_kv260_lnx/rocket_kv260.runs/*/runme.log 2>/dev/null | head -1) 2>/dev/null | tail -1)

  log "t=${el_min}m mem=${rss_gb}G memavail=${avail_gb}G load=$load disk=${disk_gb}G | ${stage:-starting}"

  [ "$now" -gt $(( start + TIMEOUT_H * 3600 )) ] && kill_build "timeout ${TIMEOUT_H}h"
  awk -v a="$rss_gb" -v m="$MAX_RSS_GB" 'BEGIN{exit !(a>m)}' && kill_build "Vivado memory ${rss_gb}G > ${MAX_RSS_GB}G"
  if [ $warned = 0 ] && awk -v a="$rss_gb" -v m="$WARN_RSS_GB" 'BEGIN{exit !(a>m)}'; then
    log "WARN: Vivado memory ${rss_gb}G above soft target ${WARN_RSS_GB}G"; warned=1
  fi
  awk -v a="$avail_gb" -v m="$MIN_AVAIL_GB" 'BEGIN{exit !(a<m)}' && kill_build "server MemAvailable ${avail_gb}G < ${MIN_AVAIL_GB}G"
  if awk -v l="$load" -v m="$MAX_LOAD" 'BEGIN{exit !(l>m)}'; then
    strikes=$((strikes + 1)); log "WARN: load $load > $MAX_LOAD ($strikes/$LOAD_STRIKES)"
    [ "$strikes" -ge "$LOAD_STRIKES" ] && kill_build "server load $load > $MAX_LOAD for $LOAD_STRIKES checks"
  else strikes=0; fi
  [ "${disk_gb:-0}" -lt "$MIN_DISK_GB" ] && kill_build "free disk ${disk_gb}G < ${MIN_DISK_GB}G"
  [ "$el_min" -gt "$STALL_MIN" ] && [ -z "$last_mod" ] && kill_build "no log progress for ${STALL_MIN} min"
done

wait "$VPID" 2>/dev/null; rc=$?
rm -f "$PID_FILE"
peak_gb=$(awk -v k="$peak_rss" 'BEGIN{printf "%.1f", k/1048576}')
if grep -q "=== BUILD DONE" "$HERE/build.log" 2>/dev/null; then
  log "SUCCESS in $(( ($(date +%s) - start) / 60 )) min, peak mem ${peak_gb}G -> $HERE/kv260_bd_wrapper.bit"
  echo "DONE peak_rss=${peak_gb}G" > "$STATUS_FILE"
else
  err=$(grep -m3 -E '^ERROR' "$HERE/build.log" 2>/dev/null | tr '\n' ' ')
  log "FAILED (vivado rc=$rc, peak mem ${peak_gb}G): ${err:-see build.log}"
  echo "FAILED rc=$rc" > "$STATUS_FILE"
fi
