#!/bin/bash

# Usage: ./commit.sh "<commit message>"

commit_message="$1"

if [ -z "$commit_message" ]; then
    echo "Usage: $0 \"<commit message>\""
    exit 1
fi

# Find all git repositories (both .git folders and gitfiles), deepest first
git_dirs=$(find . \( -type d -name ".git" -o -type f -name ".git" \) | sort -r)

for git_entry in $git_dirs; do
    repo_dir=$(dirname "$git_entry")
    echo "Processing repository: $repo_dir"
    
    cd "$repo_dir" || continue
    
    # Verify it's a git repo
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # Check if there are any changes
        if [[ -n $(git status --porcelain) ]]; then
            echo "  Adding changes..."
            git add .
            
            echo "  Committing changes..."
            git commit -m "$commit_message"
        else
            echo "  No changes to commit."
        fi
    else
        echo "  Not a valid git repository: $repo_dir"
    fi

    cd - > /dev/null
done

echo "All repositories processed."
