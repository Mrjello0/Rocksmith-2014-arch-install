# Rocksmith-2014-arch-install

just a reminder to get this working for me not suggesting to others

Now using **PipeASIO** (not wineasio) + **RS ASIO 0.7.5+** on **Proton Native** (proton-cachyos-native).
RS ASIO 0.7.5 is the release that fixed the Proton 11 patching issue (issue #629), which was a
hard requirement for PipeASIO (needs new WoW64, so Proton 11-era; wineasio won't run on it).

Old "don't use cachyos proton as of 1.10, it detects some libraries as a debugger" warning:
no longer relevant with Proton Native, works fine.

## Quick install (everything below is automated)

```
~/install_rs_asio.sh
```

That one script:
- installs PipeASIO into `~/.local/lib/wine` (user-local is REQUIRED for Proton: its container
  can't see `/usr/lib/wine`, so the AUR package won't work)
- writes `~/.config/pipeasio/config.ini` with `buffer_size` matching the PipeWire quantum
- registers PipeASIO in the game prefix
- downloads latest RS ASIO and copies `avrt.dll`, `RS_ASIO.dll`, `RS_ASIO.ini` into the game folder
- sets `Driver=PipeASIO` in all `[Asio.*]` sections, strips the CRLF from the released ini
- backs up old files to `rs_asio_backup_<timestamp>/`

Skip parts with `--no-pipeasio` / `--no-register`, pick another driver with `--driver=NAME`.

## Manual steps (what the script does, in case it needs doing by hand)

Game folder: `~/.local/share/Steam/steamapps/common/Rocksmith2014`
Prefix:       `~/.local/share/Steam/steamapps/compatdata/221680/pfx`

### 1. PipeASIO

Grab the latest `pipeasio-*-archlinux-x86_64.tar.gz` from
https://github.com/M0n7y5/pipeasio/releases and extract to `$HOME/.local`:

```
tar -xzf pipeasio-*-archlinux-x86_64.tar.gz -C "$HOME/.local"
```

Register in the game prefix:

```
env WINEPREFIX=~/.local/share/Steam/steamapps/compatdata/221680/pfx \
    ~/.local/bin/pipeasio-register
```

### 2. RS ASIO

Download the latest release zip (v0.7.5+ — the Proton 11 patch fix) from
https://github.com/mdias/rs_asio/releases and copy into the game folder:
`avrt.dll`, `RS_ASIO.dll`, `RS_ASIO.ini`.

### 3. Configs

`~/.config/pipeasio/config.ini` — the important one. PipeASIO IGNORES RS_ASIO's buffer settings;
its own `buffer_size` defaults to 1024 and with `fixed_buffer_size=1` the host can't change it.
If that differs from the PipeWire quantum you get stutter. Match them:

```
[pipeasio]
buffer_size = 256
```

`~/.config/pipewire/pipewire.conf.d/99-rocksmith.conf` — forces the graph to 48k / 256:

```
context.properties = {
    default.clock.rate = 48000
    default.clock.allowed-rates = [ 48000 ]
    default.clock.quantum = 256
    default.clock.min-quantum = 256
    default.clock.max-quantum = 256
}
```

`RS_ASIO.ini` — `Driver=PipeASIO` in `[Asio.Output]` and all `[Asio.Input.*]`.

`Rocksmith.ini` — `ExclusiveMode=1` and `Win32UltraLowLatencyMode=1`.

### 4. Steam launch options

```
PROTON_USE_WOW64=1 WINEDLLPATH=$HOME/.local/lib/wine %command%
```

`PROTON_USE_WOW64=1` is needed because Rocksmith is 32-bit and PipeASIO's 32-bit half requires
new WoW64. `WINEDLLPATH` tells Proton's wine where to find the driver.

## Debugging

- `grep ASIOBufferSize RS_ASIO-log.txt` after a run. Should show `min: 256 max: 256 preferred: 256`
  and `actual buffer duration: 5ms (256 frames)`. If it shows 1024, the pipeasio config didn't
  apply (game must be restarted; the ini is only read at startup).
- Still stuttery? Drop both the quantum and `buffer_size` to 128 together, keep them equal.
- VBASIOTest (https://download.vb-audio.com/Download_MT128/VBAsioTest_1013.zip) is still a quick
  way to sanity-check the ASIO path with PipeASIO selected.
- Interface must be at 48 kHz.
