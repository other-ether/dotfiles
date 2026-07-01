chmod cheatsheet: 644 for regular files (incl. .c), 755 for folders and scripts (incl. a.out), 600 super secret files, 700 super secret folders

sudo visudo = to safely edit sudo configs
flatpak = mostly for desktop apps I guess. more updated perhaps but could take more space
secure boot = disabled for now. ignoring MOK.
dual booting = I should log into Windows occasionally (every month? few months?) to update ASUS/BIOS/etc stuff

dotfiles, with the zshrc symlinked for aliases, means that I can git push/pull this repo to my github and then I can take all my aliases AND custom shell scripts with me across devices and distros etc

epkl works very differently on linux. not sure if i should make the jump or if i should NOT rely on the extend/shortcuts on epkl so that i have the muscle memory for my OWN layouts on moonlander.

omg Bottles is 5GB... ignore for now

shell scripts i'll add later: mkproj (arg1) (that creates a folder called arg1, with a readme.md, a gitignore, a Makefile)

WHEN LINUX HANGS
ctrl alt F3 = enter text console,
pkill (specific program; use 'top' or 'ps aux | grep programname' to find) or 
pkill cinnamon,
ctrl alt f7 = exit text console,
sudo systemctl restart lightdm = LOGS OUT of session entirely;
sudo reboot (third last resort),
alt + sysrq/printscr,
hold power button

troubleshooting: journalctl --system -S yyyy-mm-dd (day since, eg yesterday)
can remove --system to see application logs, but then more to sift through





