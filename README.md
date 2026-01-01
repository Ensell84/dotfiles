# dotfiles

## Install

To generate all simlinks:

```bash
source link.sh
```

## Keyd

```bash
sudo pacman -Syu keyd
sudo systemctl enable --now keyd.service
```

## Kernel params

```bash
random.trust_cpu=on rcu_nocbs=all rcutree.enable_rcu_lazy=1 amdgpu.abmlevel=0
```

## Powertop

Run `powertop.sh`(callibration + auto-tune service):
```bash
source powertop.sh
```

## Rclone sync

```bash
rclone config -- to start initial configuration process
	(Client ID + Client secret)
rclone lsd gdrive:path -- list directories in remote
rclone copy /home/source gdrive:path -- copy files from local to remote
```
Test run:
```bash
rclone sync $HOME/Documents gdrive:Documents --progress --drive-acknowledge-abuse --dry-run
```

Setup:
```bash
rclone sync $HOME/Documents gdrive:Documents --progress --drive-acknowledge-abuse
rclone sync $HOME/Desktop gdrive:Desktop --progress --drive-acknowledge-abuse
```

`--drive-acknowledge-abuse` --- to allow transfering some files that Google blocks

CronJob: (`crontab -e` to edit)
```bash
*/4 * * * * /usr/bin/rclone sync $HOME/Documents gdrive:Documents --drive-acknowledge-abuse >> $HOME/.logs/rclone/rclone-gdrive-doc.log 2>&1
10 */4 * * * /usr/bin/rclone sync $HOME/Desktop gdrive:Desktop --drive-acknowledge-abuse >> $HOME/.logs/rclone/rclone-gdrive-desk.log 2>&1
```
Alias added to `.bashrc` - `gsync` to do manual sync.

## Apps:

Gnome apps to remove:
```bash
sudo pacman -Rns yelp orca gnome-weather gnome-user-docs gnome-user-share gnome-tour gnome-software gnome-maps gnome-contacts epiphany malcontent
```

```bash
sudo pacman -Syu noto-fonts noto-fonts-emoji ttf-bigblueterminal-nerd ttf-fira-code ttf-firacode-nerd ttf-cascadia-mono-nerd
sudo pacman -Syu mako grim slurp cliphist xdg-utils waybar fuzzel brightnessctl \
                 usbmuxd idevicepair \
                 udiskie \
                 polkit-kde-agent \
                 qt5-wayland qt6-wayland qt5ct qt6ct \
                 hyprcursor hypridle hyprlock

sudo pacman -Syu papers loupe showtime gst-libav
sudo pacman -Syu man git wl-clipboard libqalculate btop powertop tlp bash-completion neovim telegram-desktop impala ripgrep wiremix fd fzf tmux
sudo pacman -Syu go gopls lua-language-server golangci-lint
sudo systemctl enable --now tlp.service
```
