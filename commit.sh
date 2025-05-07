#!/bin/bash

# Usage: ./commit.sh <commit_message>
echo "here"

# Check if a commit message is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <commit_message>"
  exit 1
fi

og_pwd=$(pwd)

find . -name .git | while read -r git_dir; do
  directory=$(echo "$git_dir" | rev | cut -d'/' -f2- | rev)
  cd $directory
  git add .
  git commit --dry-run -m "$1"
  if [ $? -ne 0 ]; then
    echo "Failed to commit in $directory"
    exit 1
  fi
  cd $og_pwd 
done

find . -name .git | while read -r git_dir; do
  directory=$(echo "$git_dir" | rev | cut -d'/' -f2- | rev)
  cd $directory
  git add .
  git commit -m "$1"
  cd $og_pwd
done
