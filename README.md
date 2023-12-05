# Hyprland smart borders (aka dynamic borders)

A bash script to enable dynamic borders (aka smart borders) in hyprland using hyprland-ipc. This does what could be done via scripting mentioned [here](https://github.com/hyprwm/Hyprland/issues/2324).

Handles almost all the cases which I could think of.

See the demo to see how it works.

https://github.com/devadathanmb/hyprland-dynamic-borders/assets/84301852/c32d2c2d-5d94-4063-b053-5dcdab05c296

## Dependencies

1. [socat](https://man.archlinux.org/man/socat.1.en) : For communicating with hyprland ipc instance
2. [jq](https://man.archlinux.org/man/jq.1.en) : For parsing hyprctl response

## How?

1. Download the script using `wget https://raw.githubusercontent.com/devadathanmb/hyprland-dynamic-borders/main/dynamic-borders.sh`
2. Move the file to your preferred location `(eg : ~/.local/bin using mv dynamic-borders.sh ~/.local/bin)`
3. Make sure the script is executable `(eg : chmod a+x ~/.local/bin/dynamic-borders.sh)`
4. Put the script to your auto start section in `hyprland.conf` `(eg : exec-once = ~/.local/bin/dynamic-borders.sh
)`
