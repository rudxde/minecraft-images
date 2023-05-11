#!/bin/bash
JAVA_XMX=${JAVA_XMX:-1G}
JAVA_XMS=${JAVA_XMS:-256M}

echo "eula=true" > /minecraft/eula.txt

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
