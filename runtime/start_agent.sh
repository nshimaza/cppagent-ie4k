#!/bin/sh
. /data/.env
/usr/local/bin/agent run $CAF_APP_APPDATA_DIR/agent.cfg
echo "$(date) agent exited." >> $CAF_APP_LOG_DIR/start_agent.log
while true; do
    sleep 1000
done
