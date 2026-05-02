---
name: git-push-gitbash
description: >
  Push Wayne's website changes to GitHub using Git Bash (mintty) via computer use.
  Use this skill whenever the user wants to commit and push changes to waynefu.com,
  says "push my changes", "deploy", "publish", "push to GitHub", "push the website",
  "commit and push", or "ship this". This skill is required on this Windows machine
  because the workspace bash tool is unreliable — it uses a proven clipboard-paste
  workflow with Git Bash instead. Always prefer this skill over the generic git-push
  skill when working on the GitHubWebsite project. Also use it after any edits to
  HTML, CSS, or JS files in the GitHubWebsite folder that should go live on waynefu.com.
---

# Git Push via Git Bash (Wayne's Website)

This skill commits and pushes changes to Wayne's GitHub website (waynefu.com /
https://github.com/Turbo0696/waynefu.github.io) using Git Bash on Windows via
computer use. The workspace bash tool is unreliable on this machine, so this skill
uses a clipboard-paste workflow with Git Bash (mintty).

> **WARNING: Do NOT use `bash push.sh` or `sh push.sh`.**
> Neither `bash` nor `sh` is available in the PATH of the MINGW64 shell on this
> machine. Always run git commands directly inline — no shell scripts.

## Repo details

- **Local path (Git Bash)**: `/c/Users/waynefu/Documents/Claude/Projects/GitHubWebsite`
- **Remote**: `https://github.com/Turbo0696/waynefu.github.io.git`
- **Branch**: `main`
- **Live site**: https://waynefu.com

---

## Step 1: Understand what changed

Use Read/Glob to inspect recent changes in the GitHubWebsite folder. Note what
content changed — this informs the commit message.

## Step 2: Generate a commit message

Write a message in Conventional Commits format:

```
<type>(<scope>): <short summary>
```

**Types**: `feat` (new content/feature), `fix` (bug fix), `refactor` (restructure),
`docs` (documentation), `style` (formatting only), `chore` (tooling/config)

**Scope**: use the filename or section affected (e.g., `journal2`, `nav`, `index`)

**Summary**: imperative mood, lowercase, no trailing period, ≤72 characters

Good examples:
- `feat(journal2): add May 1 chemical use newsletter as weekly roundup entry`
- `fix(nav): correct dropdown link for journal pages`
- `style(css): tighten spacing on mobile journal filter bar`

## Step 3: Load computer-use tools

Before requesting access, load the computer-use tools via ToolSearch:
```
query: "computer-use", max_results: 30
```

## Step 4: Request access to Git Bash

Call `request_access` with:
- `apps: ["Notepad", "mintty.exe"]` — include a new app to force the dialog so clipboard flags appear
- `clipboardWrite: true`
- `clipboardRead: true`

After the call, run `list_granted_applications` and confirm `grantFlags.clipboardWrite`
is `true`. If it's still `false`, stop — do not proceed (see Step 5).

## Step 5: Sentinel round-trip — REQUIRED

**Do not skip. A 2026-04-25 incident saw private clipboard content pasted into the
terminal when `write_clipboard` silently no-op'd.**

1. `write_clipboard("GIT_PUSH_SENTINEL_OK")`
2. `read_clipboard()` — confirm it returns `GIT_PUSH_SENTINEL_OK` exactly
3. Only proceed if the round-trip matches

If it fails: re-call `request_access` adding a new app to force the dialog. If it
still fails, abort and ask the user to run the command themselves.

## Step 6: Open Git Bash

Call `open_application("Mintty")`. Wait 2 seconds and screenshot to confirm a `$`
prompt is visible.

If a shell selection dialog appears (MSYS2 / Mingw-w64 32 bit / Mingw-w64 64 bit),
click **Mingw-w64 64 bit**.

## Step 7: Write the git command to clipboard

Build the full inline git command using your commit message from Step 2:

```
cd /c/Users/waynefu/Documents/Claude/Projects/GitHubWebsite && git remote set-url origin https://github.com/Turbo0696/waynefu.github.io.git && git config user.name "Wayne Fu" && git config user.email "waynefu@umich.edu" && git add -A && git commit -m "YOUR COMMIT MESSAGE HERE" && git push
```

Replace `YOUR COMMIT MESSAGE HERE` with your actual commit message. Write this
full string with `write_clipboard`, then immediately `read_clipboard` to confirm
the clipboard holds exactly what you wrote before pasting.

The `git remote set-url` part fixes a known issue where the stored remote URL is
missing the `https://` prefix, which would cause the push to fail.

## Step 8: Paste into the terminal and run

Do NOT use the `type` action — mintty interprets Ctrl+V as literal `^V`.

Use right-click → Paste:
1. Right-click inside the terminal body (not the title bar)
2. Click **"Paste"** in the context menu (shows Shift+Ins)
3. Screenshot to confirm the command appeared at the `$` prompt
4. **Sanity check**: confirm pasted text starts with `cd /c/Users/waynefu/` and
   contains `git commit -m`. If wrong content landed: press Ctrl+C immediately,
   call `write_clipboard("")` to clear the clipboard, tell the user what happened,
   and do not retry until the sentinel round-trip in Step 5 passes cleanly.
5. Press **Return** to execute

## Step 9: Wait for completion

Wait 10–12 seconds, then screenshot. Look for success output:
```
To https://github.com/Turbo0696/waynefu.github.io.git
   abc1234..def5678  main -> main
```

Report to the user: the commit hash and message.

## Step 10: Verify the live site

Use the Claude-in-Chrome MCP to navigate to https://waynefu.com and confirm the
changes appear. GitHub Pages deploys within ~2 minutes of a successful push.

---

## Troubleshooting

**"nothing to commit, working tree clean"**
Changes were already committed. Run `git push` alone.

**Garbled characters / `$'\302\226cd': command not found`**
An invisible Unicode character got prepended. Open a fresh Git Bash window and
retry the clipboard write + paste cycle.

**Terminal not receiving paste**
Click once inside the black terminal body for focus before right-clicking.

**Authentication prompt appears**
A browser window may open. Follow the GitHub auth flow and click Authorize.
The push resumes automatically.
