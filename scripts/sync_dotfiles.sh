#!/bin/zsh
# zsh -lc "path to this script" => cuz my SSH stuff can be obtained by my shell, but not the GUI at startup (Startup Applications)

# Path to my dotfiles repo
REPO_DIR="$HOME/dotfiles"

# SECTION JUST FOR TESTING
LOG_FILE="$HOME/dotfiles_test.log"
echo "=== Startup Sync Test: $(date) ===" > "$LOG_FILE"
# Try to ping GitHub up to 5 times before giving up
for i in {1..5}; do
    if ping -c 1 github.com &> /dev/null; then
        echo "Success! Connected to GitHub on attempt #$i." >> "$LOG_FILE"
        break
    else
        echo "Attempt #$i failed. Retrying in 5 seconds..." >> "$LOG_FILE"
        sleep 5
    fi
done

# # try to ping GitHub up to 5 times before giving up
# # the next line is the shell version of C way: for ((i = 0; i < 5; i++)); do
# for i in {1..5}; do
#     if ping -c 1 github.com &> /dev/null; then
#         break
#     else
#         sleep 5
#     fi
# done

# Get the current day of the month as a number (e.g., 01, 02, 15, 31)
DAY=$(date +%d)

# Strip leading zeros (e.g. '09' = '9') to prevent arithmetic errors
DAY_NUM=$((10#$DAY))

# change math to change the update interval frequency
if (( DAY_NUM % 1 == 0 )); then
    
    # 1. Add all changes inside the dotfiles directory
    git -C "$REPO_DIR" add -A

    # 2. Check if there are actual changes to commit
    if ! git -C "$REPO_DIR" diff-index --quiet HEAD; then
        
        # Commit with a timestamp
        git -C "$REPO_DIR" commit -m "Automated backup on startup: $(date)"
        
        # 3. Push to GitHub
        git -C "$REPO_DIR" push origin main
    fi
fi

