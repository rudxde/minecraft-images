#!/bin/bash
JAVA_XMX=${JAVA_XMX:-1G}
JAVA_XMS=${JAVA_XMS:-256M}

if [[ -z "${EULA}" ]]; then
    echo "eula=true" > /minecraft/eula.txt
fi

plugins=${PLUGINS:-}
# Loop through each file in the list
for file in $plugins; do
  # Check if the file exists
  if [[ -e $file ]]; then
    # Copy the file to the destination folder
    cp "$file.jar" /minecraft/plugins/
  else
    echo "Plugin $file does not exist."
  fi
done

java \
-Xms$JAVA_XMS \
-Xmx$JAVA_XMX \
-XX:+UseG1GC \
-XX:+UnlockExperimentalVMOptions \
-XX:MaxGCPauseMillis=100 \
-XX:+DisableExplicitGC \
-XX:TargetSurvivorRatio=90 \
-XX:G1NewSizePercent=50 \
-XX:G1MaxNewSizePercent=80 \
-XX:G1MixedGCLiveThresholdPercent=50 \
-XX:+AlwaysPreTouch \
-jar /jar/server.jar nogui
