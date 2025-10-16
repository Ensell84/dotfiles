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

```bash
sudo pacman -Rns yelp orca gnome-weather gnome-user-docs gnome-user-share gnome-tour gnome-software gnome-maps gnome-contacts epiphany malcontent
```

```bash
sudo pacman -Syu git wl-clipboard btop powertop tlp bash-completion gopls lua-language-server neovim telegram-desktop ttf-0xproto-nerd impala ripgrep fd
sudo systemctl enable --now tlp.service
```
