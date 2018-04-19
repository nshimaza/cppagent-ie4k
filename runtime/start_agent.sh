#!/bin/sh
. /data/.env
cd $CAF_APP_APPDATA_DIR
/usr/local/bin/agent run agent.cfg
echo "$(date) agent exited." >> $CAF_APP_LOG_DIR/start_agent.log
while true; do
    sleep 1000
done
