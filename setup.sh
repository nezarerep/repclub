#!/bin/bash
# RepCenter GitHub Setup Script
# Run this once to initialize and push to GitHub
#
# Requirements:
#   - git installed
#   - GitHub account
#   - Either: GitHub CLI (gh) installed, OR create repo manually on github.com

set -e

REPO_NAME="repcenter"
echo "🚀 Setting up RepClub GitHub repository..."

# Init git if not already
if [ ! -d ".git" ]; then
  git init
  echo "✅ Git initialized"
fi

# Configure git (edit these if needed)
# git config user.name "Your Name"
# git config user.email "your@email.com"

git add .
git commit -m "🚀 Initial RepClub site — 480 curated KakoBuy links" || echo "Nothing new to commit"

echo ""
echo "Choose setup method:"
echo "  1) GitHub CLI (gh) — automatic"
echo "  2) Manual — paste your repo URL"
read -p "Enter 1 or 2: " METHOD

if [ "$METHOD" = "1" ]; then
  if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI not found. Install from https://cli.github.com"
    exit 1
  fi
  gh auth status || gh auth login
  gh repo create "$REPO_NAME" --public --push --source=.
  echo ""
  echo "✅ Done! Your site will be live at:"
  echo "   https://$(gh api user --jq .login).github.io/$REPO_NAME"
  echo ""
  echo "📌 Enable GitHub Pages:"
  echo "   Settings → Pages → Source: GitHub Actions"

else
  echo ""
  read -p "Enter your GitHub repo URL (e.g. https://github.com/username/repclub.git): " REMOTE_URL
  git remote add origin "$REMOTE_URL" 2>/dev/null || git remote set-url origin "$REMOTE_URL"
  git branch -M main
  git push -u origin main
  echo ""
  echo "✅ Pushed! Now go to:"
  echo "   Settings → Pages → Source: GitHub Actions"
  echo "   Your site will be live in ~60 seconds."
fi
