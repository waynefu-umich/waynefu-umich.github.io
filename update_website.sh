#!/usr/bin/env bash
# Update git identity to new owner, then commit teaching.html changes and push.
set -e

cd "$(dirname "$0")"

echo ""
echo "=== Setting git identity to Turbo.0696 (global + repo-local) ==="
git config --global user.name "Turbo.0696"
git config --global user.email "turbo.0696@gmail.com"
git config user.name "Turbo.0696"
git config user.email "turbo.0696@gmail.com"

echo ""
echo "=== Staging teaching.html, journal.html, journal2.html ==="
git add teaching.html journal.html journal2.html

echo ""
echo "=== Current status ==="
git status

echo ""
echo "=== Committing ==="
git commit -m "update website"

echo ""
echo "=== Pushing to origin/main ==="
git push

echo ""
echo "=== Done. Recent log: ==="
git log --oneline -3
