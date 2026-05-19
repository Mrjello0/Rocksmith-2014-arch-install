#!/bin/bash

cd /home/me/.steam/steam/steamapps/common/Rocksmith2014/

export PIPEWIRE_LATENCY="128/48000"
export LD_PRELOAD=/usr/lib/libjack.so

SteamAppId=221680 \
STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/me/.local/share/Steam \
STEAM_COMPAT_DATA_PATH=/home/me/.local/share/Steam/steamapps/compatdata/221680 \
"/home/me/.local/share/Steam/steamapps/common/Proton 10.0/proton" \
waitforexitandrun \
"./Rocksmith2014.exe" -uplay_steam_mode
