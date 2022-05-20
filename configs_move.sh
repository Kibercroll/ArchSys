cp .bash_profile ~/
cp .bashrc ~/
cp .xinitrc ~/
cp .xmobarrc ~/
sudo cp 10-keyboard.conf /etc/X11/xorg.conf.d/
sudo cp mouse.conf /etc/X11/xorg.conf.d/
mkdir ~/.xmonad
cp xmonad.hs ~/.xmonad/
mkdir ~/.config/gtk-3.0
cp settings.ini ~/.config/gtk-3.0/
cp scrot_screen.sh ~/.config/
sudo cp 50-ioscheduler.rules /etc/udev/rules.d/
sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo cp override.conf  /etc/systemd/system/getty@tty1.service.d/