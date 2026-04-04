# Rocksmith-2014-arch-install
just a reminder to get this working for me not suggesting to others


Don't use cachyos proton as of 1.10 as the application indentifies some libraries as a "debugger"


set PROTON "/home/me/.local/share/Steam/steamapps/common/Proton 10.0/files"
set STEAMLIBRARY "$HOME/.steam/steam/"

download RS_ASIO and build
https://github.com/mdias/rs_asio/releases
make the packages or download the prebuilthe t from this repo
copy all os's respectives dll to all the respect os folders regardless of bit
I belive the 32 bit librarys don't need the 64 like the 64 needs 32 but regardless give it so don't mix .so and .dll tho .dll goes to windows and .so to linux put them in lib wine folder and the proton you'll use 
next we need to register them
like so
WINEPREFIX=$STEAMLIBRARY/steamapps/compatdata/221680/pfx \
      $PROTON/bin/wine regsvr32 /usr/lib/wine/x86_64-windows/wineasio64.dll
 WINEPREFIX=$STEAMLIBRARY/steamapps/compatdata/221680/pfx \
      $PROTON/bin/wine regsvr32 /usr/lib/wine/i386-windows/wineasio32.dll

maybe register the wine64 doubt it's needed

 WINEPREFIX=$STEAMLIBRARY/steamapps/compatdata/221680/pfx \
      $PROTON/bin/wine winecfg

add wineasio in the librarys I never found it in the list so I type it out manually
<img width="188" height="70" alt="image" src="https://github.com/user-attachments/assets/21902db1-2fe9-4e01-b63e-e36d27726d75" />
like so next we can download VBASIOTEST and test both 64 and 32
https://download.vb-audio.com/Download_MT128/VBAsioTest_1013.zip
select devices and selected WINEASIO
<img width="292" height="84" alt="image" src="https://github.com/user-attachments/assets/80a2e8c4-45fe-4321-bf8f-b3b07f9b59ef" />

both mic passthrough and tone tests should work
use WINEPREFIX=$STEAMLIBRARY/steamapps/compatdata/221680/pfx LD_PRELOAD=/usr/lib/libjack.so $PROTON/bin/wine ~/Downloads/VBASIOTest32.exe
may help if no audio is working

