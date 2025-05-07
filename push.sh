#!/bin/bash

# Usage: ./push.sh

# Find all git repositories (both .git folders and gitfiles), deepest first
git_dirs=$(find . \( -type d -name ".git" -o -type f -name ".git" \) | sort -r)

for git_entry in $git_dirs; do
    repo_dir=$(dirname "$git_entry")
    echo "Processing repository: $repo_dir"
    
    cd "$repo_dir" || continue
    
    # Verify it's a git repo
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # Get current branch
        branch=$(git rev-parse --abbrev-ref HEAD)
        
        # Check if branch has an upstream
        upstream=$(git rev-parse --abbrev-ref "$branch@{upstream}" 2>/dev/null)
        
        if [ -n "$upstream" ]; then
            echo "  Pushing branch '$branch' to '$upstream'..."
            git push
        else
            echo "  No upstream configured for branch '$branch'. Skipping push."
        fi
    else
        echo "  Not a valid git repository: $repo_dir"
    fi

    cd - > /dev/null
done

echo "All repositories processed."
