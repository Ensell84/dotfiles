# dotfiles

## Install

To generate all simlinks:

```bash
source link.sh
```

## Keyd

```bash
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd
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
sudo pacman -Syu bash-completion btop tlp powertop ghostty neovim gopls lua-language-server ttf-jetbrains-mono-nerd ttf-jetbrains-mono rclone crontab vi
```
