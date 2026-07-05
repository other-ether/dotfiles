#!/bin/zsh
# zsh -lc "path to this script" => cuz my SSH stuff can be obtained by my shell, but not the GUI at startup (Startup Applications)

# Path to my dotfiles repo
REPO_DIR="$HOME/dotfiles"

# Get the current day of the month as a number (e.g., 01, 02, 15, 31)
DAY=$(date +%d)

# Strip leading zeros (e.g. '09' = '9') to prevent arithmetic errors
DAY_NUM=$((10#$DAY))

# Check if the day is even; I can change the math to change the update interval frequency
if (( DAY_NUM % 2 == 0 )); then
    
    # 1. Add all changes inside the dotfiles directory
    git -C "$REPO_DIR" add -A

    # 2. Check if there are actual changes to commit
    if ! git -C "$REPO_DIR" diff-index --quiet HEAD; then
        
        # Commit with a timestamp
        git -C "$REPO_DIR" commit -m "Automated backup on startup: $(date)"
        
        # 3. Push to GitHub
        git -C "$REPO_DIR" push origin main
    fi
else
    # remove else block after testing
    echo "Today is day $DAY_NUM (Not even/etc day). Skipping Git push."
fi
