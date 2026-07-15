#!/bin/zsh
# zsh -lc "path to this script" => cuz my SSH stuff can be obtained by my shell, but not the GUI at startup (Startup Applications)

# so that it doesn't run more than once on the same day
STAMP="$HOME/.local/state/sync_dotfiles.log"
THIS_DAY=$(date +%F)
# safeguard if the STAMP's folder doesn't exist (e.g. changing folder location, or computers, etc)
mkdir -p "$(dirname "$STAMP")"
# check log/state
if [[ -f "$STAMP" ]] && [[ $(cat "$STAMP") == "$THIS_DAY" ]]; then
    exit 0
fi

# try to ping GitHub up to x times before giving up
# the next line is shell synonym of "for ((i = 0; i < x; i++)); do"
for i in {1..3}; do
    if ping -c 1 github.com &> /dev/null; then
        break
    else
        sleep 5
    fi
done

# Path to my dotfiles repo
REPO_DIR="$HOME/dotfiles"

# Get the current day of the month as a number (e.g., 01, 02, 15, 31)
DAY=$(date +%d)

# Strip leading zeros (e.g. '09' = '9') to prevent arithmetic errors
DAY_NUM=$((10#$DAY))

# change math to change the update interval frequency
if (( DAY_NUM % 2 == 0 )); then

    git -C "$REPO_DIR" add -A

    # Check if there are actual changes to commit
    if ! git -C "$REPO_DIR" diff-index --quiet HEAD; then

        git -C "$REPO_DIR" commit -m "Automated backup on startup: $(date)"
        git -C "$REPO_DIR" push origin main
    fi
    echo "$THIS_DAY" > "$STAMP"
fi

