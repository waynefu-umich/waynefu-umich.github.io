# How to Deploy Your Portfolio to GitHub Pages

## What You'll Need
- A free GitHub account → https://github.com/signup
- Git installed on your computer → https://git-scm.com/downloads
- Your portfolio files (the ones Claude just made)

---

## Step 1 — Create a GitHub Account
Go to https://github.com/signup and sign up if you don't have an account.

---

## Step 2 — Create a New Repository

1. Click the **+** icon in the top right → **New repository**
2. Name it exactly: `yourusername.github.io`
   *(Replace `yourusername` with your actual GitHub username — this is important)*
3. Set it to **Public**
4. Leave everything else as default
5. Click **Create repository**

Your site will live at: `https://yourusername.github.io`

---

## Step 3 — Install Git (if you haven't)

Download from https://git-scm.com/downloads and install.

Then open **Terminal** (Mac/Linux) or **Git Bash** (Windows) and run:
```
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
```

---

## Step 4 — Upload Your Files

In Terminal/Git Bash, navigate to your portfolio folder:
```
cd path/to/your/portfolio
```

Then run these commands one by one:
```
git init
git add .
git commit -m "Initial portfolio upload"
git branch -M main
git remote add origin https://github.com/yourusername/yourusername.github.io.git
git push -u origin main
```

*(Replace `yourusername` with your GitHub username in the remote URL)*

---

## Step 5 — Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** (top tabs)
3. In the left sidebar, click **Pages**
4. Under "Source", select **Deploy from a branch**
5. Under "Branch", select **main** and **/ (root)**
6. Click **Save**

Wait 1–2 minutes, then visit: `https://yourusername.github.io`

---

## How to Update Your Site Weekly (Journal entries)

Every time you want to add a new journal entry:

1. Open `journal.html` in any text editor (VS Code, Notepad, TextEdit)
2. Find the comment that says `<!-- ENTRY: Copy this block to add a new weekly entry -->`
3. Copy the entire `<article>...</article>` block
4. Paste it **above** the existing first entry
5. Update the date, title, tags, and content
6. Save the file
7. In Terminal, from your portfolio folder:
```
git add journal.html
git commit -m "Journal update - Week of [date]"
git push
```
8. Your site updates in ~30 seconds ✓

---

## Optional: Add a Custom Domain

If you have a domain (e.g., `yourname.com`):
1. In GitHub → Settings → Pages → Custom domain → type your domain
2. At your domain registrar (GoDaddy, Namecheap, etc.), add a CNAME record:
   - Name: `www`
   - Value: `yourusername.github.io`
3. Save and wait up to 24 hours for DNS to propagate

---

## Quick Reference

| Task | Command |
|---|---|
| Push updates | `git add . && git commit -m "update" && git push` |
| Check status | `git status` |
| See history | `git log --oneline` |

---

## If You Get Stuck

- GitHub Pages docs: https://docs.github.com/en/pages
- Git basics: https://rogerdudler.github.io/git-guide/
- Or ask Claude to help debug any error messages
