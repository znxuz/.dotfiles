# arch-ISO

## internet connection

```sh
device list
station <device> scan
station <device> get-networks
station <device> connect <SSID>
# or
iwctl --passphrase <password> station <device> connect <SSID>
```

## update pacman database

`pacman -Syy`

---

# installation

## archinstall

`pacman -S archinstall`

## manually

TODO

---

# Post-Install

- `useradd -mG wheel z -s /usr/bin/zsh # TODO test -s flag`
- `chsh -s /usr/bin/zsh`
- `noatime` mount option in `/etc/fstab`

## vendor-specific configurations

- [blacklist watchdog](#blacklist watchdog)

## blacklist watchdog

- add `nowatchdog` kernel parameter and
- `modprobe.blacklist=iTCO_wdt` for intel CPUS or
- `blacklist sp5100_tco` in `/etc/modprobe.d/disable-sp5100-watchdog.conf` for
  amd
