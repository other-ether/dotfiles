# basic stuff
chmod cheatsheet: 644 for regular files (incl. .c), 755 for folders and scripts (incl. a.out), 600 super secret files, 700 super secret folders
ctrl c = cancel; ctrl d = i'm done inputting or whatever; ctrl \ = coredump forcekill

i set up help=run-help, so 'help' works for both shell stuff and external programs that 'man' would cover (e.g. grep, strcpy, nano, git)
whatis == micro version of man/help, but isn't universal either; whence for other scopes e.g. local aliases or bin files
man -k blah = searches for manuals containing blah

/ == root directory, top level, OS stuff, must sudo
versus
~ == home directory, personal stuff, I have full control
!! previous command
mv overwrites, but mv -b creates a backup
e.g. mv -b cat dog -> dog already exists; original dog -> dog~
rmdir = empty folders only
grep -i=caseinsensitive, -r=recurs, -v=invert/EXCLUDE matches, -l=filenames not their lines

* only looks at folders but won't look inside sub folders or any sub-subfolders
**/* recursively looks inside all folders and any sub/subsub/etc foldedrs

CTRL+R in terminal to look through command history

LESS COMMAND to navigate big output. q=quit, arrow keys, g=start G=endh /search
HEAD = slices top x lines of a file/pipe, TAIL = bottom x lines; tail -f = streams new incoming lines e.g. from an IP

# ZSH-SPECIFIC
(/) == only folders; (.) plain files; (*) executables
ls *(Lm+50) == list files larger than 50mb
ls *(Lk-10), ls *(Lg-10) etc == less than. k=kb,g=gb
IGNORE, I can't seem to get ^ to work: 
mv *(^Folder1) Folder1/
'(^blah) means to exclude that thing; this is a glob qualifier NOTE: (^Folder1/) doesn't work because while globbing it's matching names, not paths

# ZSH VS BASH
bash is the default on linux, zsh is the default on macos,
bash is most cross-platform compatible, zsh is more beautiful and useful
(!!) shellcheck my_script.sh == to flag if I used a zsh-only feature
bash arrays: 0-indexed; zsh arrays: 1-indexed?!
zsh: can handle floats natively; word splitting is OFF by default
e.g. folder="My Docs"; mkdir $folder; zsh creates 1 folder "My Docs" BUT bash creates 2 folders "My" "Docs"
export and read commands are a little different too (ignore for now)(not the same read() as in C)

# hist
history is different on bash vs zsh!!!!
show last 5 commands: 
bash: history 5 VERSUS zsh: history -5
on zsh, history 5 means show all commands from the 5th onwards
could use "| head/tail -n x" to avoid doubt I guess..
fyi: -c means byte in head/tail/wc because originally each character was one byte (pre emojis, CJK, UTF-8 etc)

# misc
-p == create parent directories as needed
e.g. mkdir -p folder1/folder2 == create folder1 then folder2 even if folder1 didn't exist before
-i == interactive (ask for confirmation before mv cp rm)
yes == outputs yes continuously (useful to pipe)
-y == say yes to all prompts (apt, rsync, etc)

- sudo visudo = to safely edit sudo configs
- flatpak = mostly for desktop apps I guess. more updated perhaps but could take more space
- secure boot = disabled for now. ignoring MOK.
- dual booting = I should log into Windows occasionally (every month? few months?) to update ASUS/BIOS/etc stuff
- dotfiles, with the zshrc symlinked for aliases, means that I can git push/pull this repo to my github and then I can take all my aliases AND custom shell scripts with me across devices and distros etc
- epkl works very differently on linux. not sure if i should make the jump or if i should NOT rely on the extend/shortcuts on epkl so that i have the muscle memory for my OWN layouts on moonlander.
- omg Bottles is 5GB... ignore for now. Lutris is also 5GB; similar but more gaming-focused (BUT includes playstation nintendo etc simulators, hence bg size). 
- shell scripts i'll add later: mkproj (arg1) (that creates a folder called arg1, with a readme.md, a gitignore, a Makefile)

# WHEN LINUX HANGS
ctrl alt F3 = enter text console,
pkill (specific program; use 'top' or 'ps aux | grep programname' to find) or 
pkill cinnamon,
ctrl alt f7 = exit text console,
sudo systemctl restart lightdm = LOGS OUT of session entirely;
sudo reboot (third last resort),
alt + sysrq/printscr,
hold power button
# KILLING
kill = by process ID number, pkill = by name. pkill can kill wrongly if similar name,
so -x flag = exact match for pkill
kill/pkill -9 flag: force kill (possible data loss or zombie child processes)
pgrep (name) = outputs the PID, without having to sift through 'top' or 'ps aux'

# WHAT IS THIS PROCESS IM LOOKING AT?
1. cat /proc/[PID]/cmdline
2. ls -l /proc/[PID]/exe

# troubleshooting:
1. journalctl --system -S yyyy-mm-dd (day since, eg yesterday)
2. can remove --system to see application logs, but then more to sift through
3. OR: journalctl -xb -1 -e
4. need to try troubleshooting more 

# git release v1.0.0
the numers correspond to: MAJOR.MINOR.PATCH
patch=small bug or typo; minor=new feature; major=groundbreaking change
# github release workflow
1. add/commit changes
git commit -am "finalize v1.0.0" (auto adds all already-git-tracked files)
2. push code
git push
3. tag version locally, optional but good practice or something
git tag v1.0.0
git push origin v1.0.0
4. create GitHub release

# CLEARING CORE DUMPS
1. find ~ -name "core.*" -o -name "core" -type f -delete
2. sudo coredumpctl list
3. sudo journalctl --vacuum-time=1d
basically I only really need core dumps for C/C++ debugging w/ gdb

# things to set and forget
Windows and Linux read time differently (bios/utc/hardware) so the next time
I need to sync both in a dual-boot, just google Windows RealTimeIsUniversal UTC registry fix lol

# Export Flatpaks and apts (future use)
flatpak list --app --columns=application > ~/flatpak_list.txt
apt-mark showmanual > ~/apt_list.txt

# terminal redirection & flows
< > >>: ONLY FOR STATIC FILES; |: for commands that generate text
>> append
<: 'cat file' looks the same as 'cat < file' but the mechanism (e.g. argv argc) is different
< is useful for programs that DON'T accept filenames as arguments
e.g. cat names.txt | sort
just becomes: sort < names.txt
2>: stderr (error messages)
&>: stdout + stderr
ls | wc: both ls and wc run AT THE SAME TIME beneath the surface!! it's not sequential
tee: it's like piping (static files AND live streams) except to stdout AND to multiple files
e.g. echo "Hi" | tee copy1 copy2 (it'll appear on stdout too)
e.g. tee copy1 copy2 < orig
to hide stdout from screen, add a > at the end to redirect the stdout:
echo "Secret Data" | tee file1.txt file2.txt > /dev/null

[!!] "head -n 4 jaber > jaber" doesn't work because linux doesn't read left to right,
the shell reads the redirection operators first (so it sees >jabber first and then makes an empty file called jabber AND THEN does 'head')

# history / private shell use
1. fc -p: creates blank temp history
2. (do stuff)
3. fc -P: ends private session

clearing command history permanently (2 ways):
1. "> ~/.zsh_history && fc -Ri" : zsh specific, keeps temp/session vars/aliases/etc
2. "> "$HISTFILE" && exec "$SHELL"" : universal, resets session
