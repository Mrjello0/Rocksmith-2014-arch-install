#!/bin/bash

cd /home/me/.steam/steam//steamapps/common/Rocksmith2014/
#PIPEWIRE_LATENCY="256/48000" 
PIPEWIRE_LATENCY="128/48000" %command%
SteamAppId=221680 STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/me/.local/share/Steam SteamGameId=221680 STEAM_COMPAT_SHADER_PATH=/home/me/.local/share/Steam/steamapps/shadercache/221680 STEAM_COMPAT_MEDIA_PATH=/home/me/.local/share/Steam/steamapps/shadercache/221680/fozmediav1 STEAM_COMPAT_INSTALL_PATH=/home/me/.local/share/Steam/steamapps/common/Rocksmith2014 STEAM_COMPAT_APP_ID=221680 STEAM_COMPAT_DATA_PATH=/home/me/.local/share/Steam/steamapps/compatdata/221680 SteamClientLaunch=1 SteamOverlayGameId=221680 SteamEnv=1 "/home/me/.local/share/Steam/steamapps/common/Proton 10.0/proton" waitforexitandrun "/home/me/.local/share/Steam/steamapps/common/Rocksmith2014/Rocksmith2014.exe" -uplay_steam_mode
