#!/usr/bin/env bash
# Clean up paste-glitch files, fix author, sync with remote, push.
set -e

cd "$(dirname "$0")"

echo ""
echo "=== Step 1: unstaging anything that was accidentally staged ==="
git reset

echo ""
echo "=== Step 2: deleting paste-glitch files ==="
rm -f "er.name Wayne Fu" "et -e"
ls -la | grep -iE "er\.name|et -e" || echo "(none found — good)"

echo ""
echo "=== Step 3: setting git identity (global + repo-local) ==="
git config --global user.name "Wayne Fu"
git config --global user.email "waynefu@umich.edu"
git config user.name "Wayne Fu"
git config user.email "waynefu@umich.edu"

echo ""
echo "=== Step 4: fixing author on the last commit ==="
git commit --amend --reset-author --no-edit

echo ""
echo "=== Step 5: pulling remote changes (this may open a browser for auth) ==="
git pull --rebase

echo ""
echo "=== Step 6: pushing to GitHub ==="
git push

echo ""
echo "=== DONE. Recent log: ==="
git log --oneline -5
