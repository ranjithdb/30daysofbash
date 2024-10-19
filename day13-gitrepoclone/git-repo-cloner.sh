#!/bin/bash

REPO_LIST_FILE="repos.txt"

BASE_CLONE_DIR="gitrepoclones"

LOGFILE="git_repo_cloner.log"


if [[ ! -f "$REPO_LIST_FILE" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Configuration file '$REPO_LIST_FILE' not found." | tee -a "$LOGFILE"
    exit 1
fi

if [[ ! -d "$BASE_CLONE_DIR" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Base clone directory '$BASE_CLONE_DIR' does not exist, creating it." | tee -a "$LOGFILE"
    mkdir -p "$BASE_CLONE_DIR"
fi

clone_repos() {
    while IFS= read -r repo_url; do
        if [[ -z "$repo_url" ]]; then
            continue
        fi

        repo_name=$(basename "$repo_url" .git)
        REPO_CLONE_DIR="$BASE_CLONE_DIR/$repo_name"

        echo "$(date '+%Y-%m-%d %H:%M:%S') - Cloning repository: $repo_url into $REPO_CLONE_DIR" | tee -a "$LOGFILE"

        git clone "$repo_url" "$REPO_CLONE_DIR" >> "$LOGFILE" 2>&1

        if [[ $? -ne 0 ]]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Failed to clone $repo_url" | tee -a "$LOGFILE"
        else
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully cloned $repo_url" | tee -a "$LOGFILE"
        fi
    done < "$REPO_LIST_FILE"
}

clone_repos

