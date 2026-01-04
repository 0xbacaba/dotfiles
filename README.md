# Dotfiles

## hyprland setup:

<details>
    <summary>
    Requirements
    </summary>

- [hyprland](https://github.com/hyprwm/Hyprland) (duh)
- [vicinae](https://github.com/vicinaehq/vicinae) (app-launcher)
- [wofi](https://hg.sr.ht/~scoopta/wofi) (menus)
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

## firenvim setup:

<details>
  <summary> How to use </summary>

  1. see [firenvim's github](https://github.com/glacambre/firenvim), especially [SECURITY.md](https://github.com/glacambre/firenvim/blob/master/SECURITY.md) \
     $\to$ Install the browser plugin
  2. Run `NVIM_APPNAME="firenvim" nvim` \
     This should install the neovim plugin and run its installer.

</details>

<details>
  <summary> Browser support </summary>

  The following are officially supported and should *just work*
  - arc
  - brave
  - chrome
  - chrome-canary
  - chrome-dev
  - chromium
  - edge
  - firefox
  - librewolf
  - opera
  - ungoogled-chromium
  - vivaldi
  - waterfox

  For other firefox based browsers (like zen) this should work (assuming firefox is installed):
  ```bash
  # This assumes firefox is installed, any other fork will probably work too
  # just replace .mozilla with e.g. .librewolf
  ln -s ~/.mozilla/native-messaging-hosts ~/.zen/

  # Or just this if ~/.zen/native-messaging-hosts/ exists
  ln -s ~/.mozilla/native-messaging-hosts/firenvim.json ~/.zen/native-messaging-hosts/
  ```

</details>
