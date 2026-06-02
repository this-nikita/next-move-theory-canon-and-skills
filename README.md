# Next Move Theory Canon & Skills

**An algorithm for any product and business decision — and the AI skills that run it.**

By Ivan Zamesin ([X](https://x.com/zamesin) · [LinkedIn](https://www.linkedin.com/in/ivan-zamesin/)). This repository is the open canon (the methodology, written as theses) plus a set of Claude Code skills that operationalize it. It is written for the people who decide *what to build*: founders, indie hackers, product managers, and product marketers.

---

## There is an algorithm

**There is an algorithm for making any business decision.**

Most product decisions today are guesswork — feeling your way through the fog, betting everything on the one idea that happened to land in your head from a book, a conference talk, or a friend's, a colleague's, or an investor's advice. With an algorithm you stop guessing: you lay out every strategy actually open to you and choose among them deliberately, weighing many factors, instead of going all-in on the first one you saw.

Next Move Theory is that algorithm. There is one for each of the questions that decide a product's fate:

- How to launch a product and find Product-Market Fit
- How to scale a product
- How to save a dying product — or know when it's time to shut it down
- How to create value
- How to differentiate from competitors
- How to position a product
- How to exit direct competition
- How to create a Disruptive Innovation
- How to grow conversion
- How to raise average order value
- How to improve retention
- How to build an acquisition channel

This canon is the result of the last eight years of my work. Eight years ago I discovered Jobs To Be Done, saw enormous potential in it, and made an unreasonable decision: rebuild it from scratch so it would finally yield an algorithm. I did — rebuilding it into a thousands of foundational theses. But Advanced Jobs To Be Done on its own still didn't produce the algorithm; to get there I had to fold in Unit Economics, the Riskiest Assumption Test, ABCDX segmentation, and other disciplines, and that integration became Next Move Theory. I've since taught this methodology to more than 13,000 people in my home country — and this public canon is how I give its foundations to the world.

**This public canon is about 30% of the methodology's theses.** You won't find every one of those algorithms here yet — but you will find **the main algorithm** ([`Algorithms/the-algorithm.md`](Next-Move-Theory-Canon/Algorithms/the-algorithm.md)) and the core theses the whole framework rests on. The step-by-step algorithms for the tasks above will keep appearing at [nextmovetheory.com](http://nextmovetheory.com/?utm_source=github&utm_medium=readme&utm_campaign=canon).

The canon is the algorithm written out — Jobs, the Job Graph, value, and segments, built up thesis by thesis. The **skills** are that algorithm turned into tools: feed in a product idea and get back a *decision*, not a description.

---

## Who this is for

This canon is written for **product builders** and the Jobs they perform:

- **Early-stage founders (pre-PMF)** — *decide what to build, and whether to keep building.*
- **Indie hackers / solopreneurs** — *pick a niche that pays before sinking weeks into code.*
- **Product managers** — *prioritize a roadmap that isn't theater; diagnose why a metric stalled.*
- **Senior PMs / VPs / CPOs** — *set product strategy that beats annual-planning rituals.*
- **Product marketers / growth** — *position in a crowded category; write messaging that converts.*

If you build, market, or decide the direction of a product, this is for you. You don't have to discard what you already know — customer interviews, CJM, ICP, willingness-to-pay, feature backlogs all still work; they just get grounded in the right unit of analysis and connected to business decisions instead of floating free. Expect the rewire to take practice: most people arrive with a feature-first or persona-first model, and the Job-first model takes a few honest attempts before it feels natural.

---

## The skills

The `Skills/` directory holds Claude Code skills that run the methodology for you. Each one reads the canon at runtime, so its output is grounded in *this* methodology — not in the generic JTBD an LLM would otherwise reach for.

| Skill | What it does |
|---|---|
| **[`market-research`](Skills/market-research/)** | Sizes a market and scores customer segments to answer *"which Jobs of which segment should we compete for first?"* Output: an A4 one-pager with a **GO / NARROW / PIVOT** verdict, segments scored on a five-factor screen, direct and indirect competitors, a differentiation hypothesis, an action-first RAT plan, and alternative Big-Job markets to pivot into. |
| **[`craft-value-proposition`](Skills/craft-value-proposition/)** | Turns a chosen segment + Job into a sharp **Value Proposition Statement**. Output: the Job Graph one level below the Core Job, three ranked value-prop candidates scored against the methodology's value-creation mechanics, the chosen statement (mechanic × Core Job × alternative), an Aha Moment hypothesis, and the top-3 RAT cards to test it. |
| **[`product-requirements`](Skills/product-requirements/)** | Turns a product idea into a full PRD package via a team of agents — segment analysis, risks, competitors, an analytics plan, landing copy, marketing hypotheses, and unit economics. |

All three are **user-invocable**: once installed, type `/market-research`, `/craft-value-proposition`, or `/product-requirements` in Claude Code. `market-research` and `craft-value-proposition` each have a fast **Quick** mode (no internet) and a deeper **Deep** mode (subagents + web research).

> The skills produce **hypotheses, not conclusions.** Every number is an LLM-generated estimate with a verification path attached. Validate before any decision with expensive consequences — that's the RAT discipline the methodology is built on.

### Install

The skills read the canon by relative path, so **the canon and the skills must stay together in one repo.** The simplest setup is to clone the repo and run Claude Code from inside it:

```bash
# 1. Clone the repo (canon + skills ship together)
git clone https://github.com/zamesin/Next-Move-Theory-Canon-and-Skills.git
cd Next-Move-Theory-Canon-and-Skills

# 2. Make the skills discoverable to Claude Code in this repo
mkdir -p .claude
cp -r Skills/* .claude/skills/
# (or symlink to keep them in sync with git pull:)
# ln -s "$(pwd)/Skills" .claude/skills

# 3. Run Claude Code from the repo root — the canon is now at ./Next-Move-Theory-Canon
claude
```

Then invoke a skill:

```
/market-research a tool that drafts SOC 2 evidence for early-stage SaaS
```

**To use the skills in another project**, copy them into your personal skills directory so they're always available — but keep a clone of this repo's `Next-Move-Theory-Canon/` reachable from where you run them, since the skills read it at runtime:

```bash
cp -r Skills/* ~/.claude/skills/
```

---

## How to read the canon

The canon lives in [`Next-Move-Theory-Canon/`](Next-Move-Theory-Canon/) — around two dozen interlinked files. You don't have to read them in order. If you want the fastest path to understanding, read these four key-theses files first, in order:

1. **[`Next-Move-Theory/nmt-key-theses.md`](Next-Move-Theory-Canon/Next-Move-Theory/nmt-key-theses.md)** — the integrative root: what the whole framework is and how its pillars (AJTBD, Unit Economics, RAT, ABCDX) fit into one system. *Start here for the big picture.*
2. **[`AJTBD/ajtbd-key-theses.md`](Next-Move-Theory-Canon/AJTBD/ajtbd-key-theses.md)** — the substrate the rest stands on: Jobs, the Job Graph, value and the Aha Moment, segmentation. The core you'll use most.
3. **[`Riskiest-Assumption-Test/rat-key-theses.md`](Next-Move-Theory-Canon/Riskiest-Assumption-Test/rat-key-theses.md)** — before you build: list the assumptions the idea rests on, rank them by how lethal they are if wrong, and buy the cheapest evidence against the deadliest first.
4. **[`ABCDX/abcdx-segmentation-key-theses.md`](Next-Move-Theory-Canon/ABCDX/abcdx-segmentation-key-theses.md)** — the theory turned into a concrete operating move on a real customer base: focus the high-margin A/B, fire C/D, and read X as the signal of where to grow next.

Then read the rest in whichever cluster matches your problem.

### Advanced Jobs To Be Done — Foundations

| File | What it teaches |
|---|---|
| [`AJTBD/ajtbd-key-theses.md`](Next-Move-Theory-Canon/AJTBD/ajtbd-key-theses.md) | The foundational theses — the methodology in one document. The map to everything else. |
| [`AJTBD/scientific-foundations.md`](Next-Move-Theory-Canon/AJTBD/scientific-foundations.md) | The brain as an energy-budget investor; why needs fail as a unit and Jobs succeed. |
| [`AJTBD/job-structure.md`](Next-Move-Theory-Canon/AJTBD/job-structure.md) | The eight elements that fully specify a single Job, element by element, with interview questions. |

### The Job Graph — where strategy lives

| File | What it teaches |
|---|---|
| [`AJTBD/job-graph.md`](Next-Move-Theory-Canon/AJTBD/job-graph.md) | The hierarchy of Jobs around your product; the four levels, defined *relative to your product's reach*. |
| [`AJTBD/job-types-and-properties.md`](Next-Move-Theory-Canon/AJTBD/job-types-and-properties.md) | The taxonomy of Jobs — Regular, Orientation, Tax, Fake, Emotional, Viral — as a diagnostic instrument. |
| [`AJTBD/critical-chain.md`](Next-Move-Theory-Canon/AJTBD/critical-chain.md) | The Job Graph projected onto time — the lived path a team actually ships, where the Aha Moment fires. |

### Creating value

| File | What it teaches |
|---|---|
| [`AJTBD/value-creation.md`](Next-Move-Theory-Canon/AJTBD/value-creation.md) | The deep canon on value: energy efficiency, success criteria as the specification of value, the Aha Moment. |
| [`AJTBD/value-creation-mechanics.md`](Next-Move-Theory-Canon/AJTBD/value-creation-mechanics.md) | The foundational catalog of value-creation mechanics — kill a Job, take a Job off the customer, climb a level. |
| [`AJTBD/behaviour-change.md`](Next-Move-Theory-Canon/AJTBD/behaviour-change.md) | Why switching is swapping one Job Graph for another; a Solution as a *label* for the sub-graph it installs. |
| [`AJTBD/customers-attention-management.md`](Next-Move-Theory-Canon/AJTBD/customers-attention-management.md) | Attention as the metabolic resource every value-creation mechanism routes through. |

### Reaching and converting customers

| File | What it teaches |
|---|---|
| [`AJTBD/consideration-activators.md`](Next-Move-Theory-Canon/AJTBD/consideration-activators.md) | The five Consideration Activators — what you load into the customer's head to move their choice your way. |
| [`AJTBD/barrier-removal.md`](Next-Move-Theory-Canon/AJTBD/barrier-removal.md) | Removing the objective barriers that make a better Job Graph non-executable for a segment. |
| [`AJTBD/communication.md`](Next-Move-Theory-Canon/AJTBD/communication.md) | Communication in the language of Jobs — the value-proposition formula and the landing-page structure. |

### Choosing where to compete

| File | What it teaches |
|---|---|
| [`AJTBD/segmentation.md`](Next-Move-Theory-Canon/AJTBD/segmentation.md) | Segmentation by Job Graph similarity, not demographics — the most expensive cut to get wrong. |
| [`ABCDX/abcdx-segmentation-key-theses.md`](Next-Move-Theory-Canon/ABCDX/abcdx-segmentation-key-theses.md) | ABCDX — splitting your paying base by margin × satisfaction; refocus on A/B, fire C/D, read X as a signal. |
| [`Riskiest-Assumption-Test/rat-key-theses.md`](Next-Move-Theory-Canon/Riskiest-Assumption-Test/rat-key-theses.md) | RAT — list the assumptions an idea rests on, rank them by lethality, and buy the cheapest evidence first. |

### Next Move Theory — the meta-framework above AJTBD

| File | What it teaches |
|---|---|
| [`Next-Move-Theory/nmt-key-theses.md`](Next-Move-Theory-Canon/Next-Move-Theory/nmt-key-theses.md) | The integrative root — how AJTBD, Unit Economics, RAT, and ABCDX combine into one system. *The product is a single organism.* |
| [`Next-Move-Theory/focus-as-company-attention-management.md`](Next-Move-Theory-Canon/Next-Move-Theory/focus-as-company-attention-management.md) | Focus as pointing the whole company's attention at specific Core Jobs of one segment; the Innovator's Dilemma as focus that ossified. |
| [`Next-Move-Theory/subtraction.md`](Next-Move-Theory-Canon/Next-Move-Theory/subtraction.md) | Subtraction as the meta-operator across all four pillars — removing Jobs, unprofitable units, risky assumptions, and C/D customers. |

### Practice, B2B, and the operating loop

| File | What it teaches |
|---|---|
| [`HowTos/basic-ajtbd-interview-guide-and-principles.md`](Next-Move-Theory-Canon/HowTos/basic-ajtbd-interview-guide-and-principles.md) | The practical interview guide — principles and a question bank that reconstruct Jobs, criteria, Aha Moments, and Barriers from what a customer actually did. |
| [`AJTBD/b2b.md`](Next-Move-Theory-Canon/AJTBD/b2b.md) | The B2B deal as a Job Graph across roles — and why personal Jobs usually outweigh business Jobs. |
| [`Algorithms/the-algorithm.md`](Next-Move-Theory-Canon/Algorithms/the-algorithm.md) | How the pieces combine into a single cyclical algorithm — and the anti-patterns that kill products. |

> The public canon covers the most foundational theses and mechanics. The full methodology — the 100+-mechanic catalog, full unit-economics integration, and more — expands over time. **For new theses and book chapters as they're published, subscribe at [nextmovetheory.com](http://nextmovetheory.com/?utm_source=github&utm_medium=readme&utm_campaign=canon)** — home to the canon, the books, and the newsletter.

---

## What's inside

```
Next-Move-Theory-Canon-and-Skills/
├── Next-Move-Theory-Canon/        # the methodology, written as theses
│   ├── AJTBD/                      #   the Jobs framework — start with ajtbd-key-theses.md
│   ├── ABCDX/                      #   segmenting a paying base by margin × satisfaction
│   ├── Riskiest-Assumption-Test/   #   validating ideas before you build them
│   ├── Next-Move-Theory/           #   the integrative meta-framework above AJTBD
│   ├── HowTos/                     #   practical guides — start with the interview guide
│   └── Algorithms/                 #   how the pieces combine into one loop
└── Skills/                         # Claude Code skills that run the methodology
    ├── market-research/
    ├── craft-value-proposition/
    └── product-requirements/
```

---

## How this methodology came to be

By 2018, companies already paid me to teach product — customer research, segmentation, interviews. Then one interview made something embarrassing obvious: I didn't actually know, at the root, how products get created. We were interviewing entrepreneurs who had already published business books, hunting for the *problems* I was trained to find and fix. They reported none — they liked the process, the publisher was good, the book came out well. And then they bought more, twenty or thirty thousand dollars, right there in the conversation. Satisfied customers, no problem to solve, buying anyway. The model I taught — find the pain, build the painkiller — had no explanation for it.

Then the same confusion got personal. I was building a service that matched people with therapists, with my own money, against a larger competitor whose unit margin was roughly twice mine. Every advisor I trusted offered a different move — change pricing, change the channel, kill the segment, move upmarket, copy the leader — and not one came with a rule for *choosing*. I had options and no way to decide, and the wrong bet could end the company.

So in 2018 I made an unreasonable decision: build the methodology from scratch. I went deep into Jobs To Be Done and kept its deepest intuition — a person sits in a situation and wants to *transition* into a different state — but deliberately left the existing machinery behind, because it never told me how to research, segment, choose where to compete, or create value.

I spent eight years studying that transition — consulting, teaching, interviewing customers, watching my own behavior. It started to come together when I read the right books at the right time: Lisa Feldman Barrett's work pushed me into allostasis, prediction, reward prediction error, the science of needs and emotions, habit, identity, and loss aversion — the foundations that turned a good intuition into a buildable algorithm. I called it **Advanced Jobs To Be Done (AJTBD)**.

I had hoped AJTBD would answer every product and business question on its own. It couldn't — and reaching past it is what eventually became Next Move Theory, with AJTBD as its skeleton. The first thing I had to give up to get there was the word that had built my career: *problem.* The full story — the scenes, the mistakes, the breaks where the wrong model stopped working — is the subject of the book; see [nextmovetheory.com](http://nextmovetheory.com/?utm_source=github&utm_medium=readme&utm_campaign=canon).

---

## Talks & questions

**Want me to speak?** If you'd like me to walk your team, company, or event through the methodology — a talk, a workshop, or a conversation about how it applies to your product — I'd genuinely welcome that. Email me at [ivan@nextmovetheory.com](mailto:ivan@nextmovetheory.com) or reach out on [LinkedIn](https://www.linkedin.com/in/ivan-zamesin/).

Same channels for anything else — where to start, how the methodology applies to your product, or a disagreement with a thesis. Found an error in a thesis or a broken link? Open an issue or a pull request.

## License

The canon and the skills are licensed under [**CC BY-NC-SA 4.0**](https://creativecommons.org/licenses/by-nc-sa/4.0/) (Creative Commons Attribution–NonCommercial–ShareAlike 4.0 International) — see [`LICENSE`](LICENSE). You are free to **share** and **adapt** the material, as long as you:

- **Attribution** — credit Ivan Zamesin and link back to this repository and the license;
- **NonCommercial** — don't use the material for commercial purposes;
- **ShareAlike** — license your adaptations under the same terms.

---

*A note on how this was written. The methodology is mine, built over years of practice. But a canon this size is an enormous number of theses to put into words — and Claude Code is how I got them onto the page. I leaned on it not to manufacture volume, but because it was the only realistic way for me to write all of this down. There's a lot of material here; without that help, this canon wouldn't exist yet.*

*Built by Ivan Zamesin — [nextmovetheory.com](http://nextmovetheory.com/?utm_source=github&utm_medium=readme&utm_campaign=canon) · [X](https://x.com/zamesin) · [LinkedIn](https://www.linkedin.com/in/ivan-zamesin/). The canon is a living document — it grows as new theses are validated in practice.*
