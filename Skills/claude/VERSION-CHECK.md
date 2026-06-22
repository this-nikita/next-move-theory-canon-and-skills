# Version check (run first — best-effort, never blocks)

Every NMT skill runs this once at launch, BEFORE its own work. It is best-effort:
keep it quiet unless an update is available, and never let it block, slow, or fail
the skill.

## Steps

1. **Installed version.** Read `.nmt-version` at the project root (the folder that
   contains `Next-Move-Theory-Canon/` or `.claude/skills/`). If the file is
   missing, treat the installed version as *unknown*.

2. **Fetch the feed (hard 2s timeout, best-effort).** Pass the name of the skill
   you are currently running as the `skill` parameter (this also counts the run):
   ```bash
   curl -fsSL --max-time 2 "https://nextmovetheory.com/version?skill=<this-skill-name>"
   ```
   e.g. for `nmt-diagnose`: `…/version?skill=nmt-diagnose`. If `curl` is missing,
   the request errors, or it times out → **stop the check silently** and go
   straight to the skill's work. Do not retry. Do not mention it.

3. **Parse the JSON.** `entries` is newest-first; `latest` = `entries[0].version`.

4. **Compare:**
   - installed `== latest` → up to date → say nothing, continue.
   - installed *unknown* → print the short note using `latest` only (you cannot
     compute the gap), then continue.
   - otherwise → walk `entries` from the top, collecting each entry until you reach
     the one whose `version == installed` (do **not** include it). Those collected
     entries are everything that changed since the user's version.

5. **If behind, print ONE compact block, then continue** (never stop here):
   ```
   ℹ️ NMT update available — you're on <installed>, latest is <latest> (<N> behind).
   What changed:
   • <version> — <summary>
   • <version> — <summary>
   Update: curl -fsSL https://nextmovetheory.com/install.sh | bash   (or /nmt-upgrade)
   Changelog: https://nextmovetheory.com/changelog
   ```
   Cap the list at 10 entries; if there are more, add a final
   `• …and older — see the changelog`.

6. **Continue with the actual skill.** This check is informational only — it never
   changes what the skill does.

## Rules

- 2-second cap, then move on. Never block or delay the skill for the check.
- Show the block ONLY when the user is behind. Never print "checking…", request
  errors, or an "up to date" message.
- Always include `?skill=<current-skill-name>` — it lets the project count
  anonymous skill runs (no personal data is sent).
