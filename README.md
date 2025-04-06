# Dotfiles

## hyprland setup:

<details>
    <summary>
    Requirements
    </summary>

- [hyprland](https://github.com/hyprwm/Hyprland) (duh)
- [wofi](https://hg.sr.ht/~scoopta/wofi) (app-launcher/menu)
- [dunst](https://github.com/dunst-project/dunst) (notification daemon)
- [waybar](https://github.com/Alexays/Waybar) (taskbar)
- [hyprpaper](https://github.com/hyprwm/hyprpaper) (wallpaper utility)
- [polkit-kde-agent](https://github.com/KDE/polkit-kde-agent-1) (authentication agent)
- [hyprlock](https://github.com/hyprwm/hyprlock) (lockscreen)
- [hyprshot](https://github.com/Gustash/Hyprshot) (screenshot utility)
- [clipse](https://github.com/savedra1/clipse) (clipboard manager)
- [hypr-zoom](https://github.com/FShou/hypr-zoom/tree/main) (zoom utility)
- [obs-cmd](https://github.com/grigio/obs-cmd) (communicate with obs-websocket)
</details>

<br>

Files you probably want to change:
- [*/hypr*](hypr)
    - [`hyprlock.conf`](hypr/hyprlock.conf)
    - [`hyprpaper.conf`](hypr/hyprpaper.conf)
    - [*/config*](hypr/config)
        - [`monitors.conf`](hypr/config/monitors.conf)
        - [`apps.conf`](hypr/config/apps.conf)
        - [`rules.conf`](hypr/config/rules.conf)  # if you have a different monitor or app setup
        - [`binds.conf`](hypr/config/binds.conf)  # if you remove any apps completely
    - [*/.secrets*](hypr/.secrets)  # See `hypr/.secrets/README.md` for details
        - obs\_ws

## tmux setup:

Keybinds: 
- CTRL-[HJKL] to move between split panes with respect to (n)vim splits

Style:
- catppuccin theme
- rounded window status

Other:
- Copy-Mode: vi
- Passthrough enabled
- Mouse enabled

## neovim setup:

See [nvim](https://github.com/0xbacaba/nvim_config) for details
