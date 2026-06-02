# Market Research skill — changelog

## v10 (2026-06) — current
- **Decision deliverable.** Report now opens with an A4 **one-pager** carrying a **GO / NARROW / PIVOT** verdict, disclaimers, and the top-3 risks; the one-pager is computed last from the finished analysis.
- **Four Forces dropped** (deprecated in `ajtbd-key-theses.md §21`) → replaced by the **five-factor selection screen** (noticeable added value · demand we can generate · target margin per unit · size in money × switchability · existential-risk gate). Switchability ("the Problem is the trigger") is now first-class.
- **New primary result — pivot.** A pivot sub-pipeline (asset extraction → market & segment-Jobs generation → evaluation & ranking) recommends alternative Big-Job markets that fit the idea's technology, team, and resources. Team competencies are captured again in STAGE 1 (assets & constraints) to power it.
- **Action-first RAT.** The risk section pairs every assumption with the action to validate it, then gives an ordered Step 1/2/3 plan; the "≤1 week" constraint is removed. Backbone is the canon's cause-and-effect chain (Market → Segment+Jobs → Value → Unit economics → Channels).
- **Methodology refreshed to current canon.** Job grammar uses "in order to" + expected-outcome + Aha Moment; Aha Moment / Problem instead of PPE/NPE; published value-creation mechanics only (no "19 mechanics"); Job Graph levels, Map of Segments, Consideration Activators, Barrier Removal, Critical Chain added.
- **Portability + publishing fixes.** Runtime read set trimmed to four canon files via correct **relative** paths (no absolute `/Users/...` paths; broken `main-idea.md` / `RAT/risk-assumption-test.md` removed). Those files must be in `PUBLIC_MANIFEST.yml` to ship.
- **Readability.** Internal methodology citations and canon paths moved out of the user-facing report into `debug.md`; plain-language-first with a linked `references/glossary.md`; every segment kept at equal depth.
- **Lighter run.** Dead weight removed (old changelogs, the duplicated "do-not-spawn" Critic block); one tight canon read set per agent; self-critic trimmed to 11 methodology checks (format guaranteed by templates); heavy live `progress.log` / `tail -f` / `Monitor` streaming dropped in favour of a few milestone lines in `debug.md`. **Quick mode is now the default**; Deep mode is opt-in.

## v4–v9 (historical, superseded by v10)
- **v9** — 3 waves / 4 agents; Critic folded into Synthesis; RAT folded into Differentiation; per-segment competitors inline; segments ordered by recommendation; conversational recommendation phrasing; tightened web caps.
- **v8** — pipeline parallelised into 3 waves; discovery split into mining + synthesis; critic capped at 1 pass; live `progress.log` streaming + `Monitor` introduced.
- **v7** — Core Jobs format anchors bolded; variable Core Job count; Differentiation reordered (positioning first).
- **v6** — output moved from `TMP/` to `Skill-Results/`; time-stamped run folders; result file renamed `{product-slug}-market-research-result.md`.
- **v5** — two-part disclaimer; source-link rule (Rule 2); compact body + Appendix A/B; 3-method sizing.
- **v4** — questions batched into 2 calls; team competencies removed (now re-added in v10 for the pivot pipeline); "I don't know — find them" defaults; runnable verification algorithms.
