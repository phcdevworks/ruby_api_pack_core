# Ruby API Pack Core Agent Guide

## Repository Snapshot

| Field | Value |
|-------|-------|
| Project team | `project-ruby` |
| Repository role | Shared HTTP client foundation for all `ruby_api_pack_*` gems |
| Package/artifact | `ruby_api_pack_core` |
| Validation gate | `bundle exec rspec` + `bundle exec rubocop` + `gem build ruby_api_pack_core.gemspec` |

## Standard Authority Model

| Agent | Role | Authority |
|-------|------|-----------|
| Claude Code | Lead implementation and validation | [CLAUDE.md](CLAUDE.md) |
| OpenAI Codex | Documentation, release readiness, stabilization, and repo hygiene | [CODEX.md](CODEX.md) |
| ChatGPT | Strategy, coordination, prompt design, and external review | Support only |
| GitHub Copilot | Development assistance | [COPILOT.md](COPILOT.md) |
| Google Jules | Bounded automated maintenance | [JULES.md](JULES.md) |

Bradley Potts holds final authority for commits, merges, tags, publishing, and
releases.

## Cross-Repo Access

This repo may be worked on standalone or alongside any combination of other
PHCDevworks repos — do not assume the company root or sibling project areas
are present. The following rules are self-contained and apply whether or not
that broader context is available.

**File access.** An agent working in this repo has full read/write access to
every file in this repo. When this repo is present alongside other
PHCDevworks repos (company root or sibling `project-*` areas), the same full
read/write access extends to those repos too — there is no per-repo access
restriction anywhere in this workspace. What differs repo-to-repo is not
*access*, it's *editorial ownership*: each repo's own `CLAUDE.md`/`AGENTS.md`
still governs what changes make sense there (design-token authority, layer
boundaries, etc.) — being able to open and edit a file is not the same as it
being this repo's job to change it.

**Cross-repo changelog sync.** When a change in this repo has direct
downstream or upstream impact on another present repo (e.g. a breaking token
rename, an API contract change), an agent may append a `CHANGELOG.md
[Unreleased]` entry directly into that other repo's own changelog — not just
leave a note asking its owner to add it. Rules:

1. Only append new `[Unreleased]` entries — never edit, reorder, or remove
   another repo's existing changelog entries, version headers, or release
   history.
2. Every cross-repo entry must be self-contained and attributed: which repo
   caused it and why, what changed from the affected repo's perspective, and
   the date added.
3. Add it in the same change that produced the impact, not a later session.
4. This never grants release authority — cutting a release, bumping a version
   header, or publishing a package stays gated by that repo's own release
   process and the human owner's final sign-off.

**TODO/roadmap requests.** When work here surfaces a need that belongs to
another repo, an agent may append the request directly to that repo's own
`TODO.md` under a clearly labeled "Requested by Downstream" section (create
it if absent), stating which repo is requesting it, why, the date, and a
link back if the other repo's `TODO.md`/`ROADMAP.md` is reachable.

No AI agent creates commits, tags, publishes packages, or merges changes in
this repo or any other unless that repo's own agent guide explicitly grants
that authority or the human owner has explicitly requested the action.

## Standard Handoff

Every AI-prepared change should report files changed, validation performed,
public behavior or contract impact, and unresolved risks. Do not edit generated
outputs directly. Do not update [CHANGELOG.md](CHANGELOG.md) unless the change
is release-relevant.

This repository is maintained by PHCDevworks and contains the
`ruby_api_pack_core` Ruby gem: the shared connection wrapper, response
validator, and configuration pattern consumed by every other
`ruby_api_pack_*` gem in this project team.

## Upstream Requests and Roadmap Self-Expansion

Full directive: project-team [AGENTS.md](../AGENTS.md) "Upstream Requests and
Roadmap Self-Expansion." Applied to this repo:

- This gem is **upstream** of `ruby_api_pack_active_campaign`,
  `ruby_api_pack_cloudways`, and `ruby_api_pack_wordpress` — those gems depend
  on this one. This repo has no dependency on any other repo in this
  workspace.
- Any breaking change to `Connection::Base`, `Handlers::ResponseValidator`, or
  `Configurable`'s public method names must be coordinated with those three
  consuming gems before or alongside release. Do not treat a breaking change
  here as "docs/config only" — it has real downstream blast radius.
- If a consuming gem requests new shared behavior (e.g. a new HTTP verb, a new
  validator mode), record it in this repo's own `TODO.md` under `## Requested
  by Downstream`, kept visible and separate from self-planned work.
- This repo's own `ROADMAP.md` may be proactively expanded with new or
  reordered phases by the agent's own analysis — but never mark a phase
  delivered without `bundle exec rspec`, `bundle exec rubocop`, and
  `gem build ruby_api_pack_core.gemspec` all passing.
- Surface any new TODO request or roadmap expansion in the handoff for Bradley
  Potts in the same change it was made, and reflect cross-repo-relevant
  changes in the project-team's own ROADMAP.md/TODO.md.

## Shared Source Rules

| Path | Status | Notes |
| --- | --- | --- |
| `lib/ruby_api_pack_core.rb` | May edit carefully | Public gem entry point |
| `lib/ruby_api_pack_core/configurable.rb` | May edit carefully | Shared configure/configuration mixin used by every consuming gem |
| `lib/ruby_api_pack_core/connection/base.rb` | May edit carefully | Shared HTTParty/Oj connection template — every consuming gem subclasses this |
| `lib/ruby_api_pack_core/handlers/response_validator.rb` | May edit carefully | Shared response-shape validator used by every consuming gem |
| `lib/ruby_api_pack_core/version.rb` | May edit for releases | Gem version authority |
| `spec/` | May edit | Required for behavior changes |
| `README.md`, `CHANGELOG.md`, docs | May edit | Keep public guidance synchronized |
| Credentials, secrets, tokens | Never commit | This gem has no vendor credentials of its own; keep it that way |

Full validation command:

```bash
bundle exec rspec
bundle exec rubocop
gem build ruby_api_pack_core.gemspec
```

## Core Rules

1. Treat `Connection::Base`, `Handlers::ResponseValidator`, `Configurable`,
   and specs as the public behavior contract — every `ruby_api_pack_*` gem
   depends on this surface staying stable.
2. Keep this gem free of any vendor-specific knowledge (API tokens, endpoint
   paths, resource classes). If a change needs to know which third-party API
   is being called, it belongs in a consuming gem instead.
3. `Connection::Base` subclasses in consuming gems should only need to
   override `#auth_headers` — do not grow vendor-specific public methods on
   `Base` itself.
4. Do not log or document real API tokens, response bodies, or credentials —
   this gem's specs use synthetic fixtures only.
5. Update README and changelog when public usage changes.
6. Add focused tests for changed connection, validator, or configurable
   behavior.
7. Preserve unrelated local changes.

## Agent-Specific Guides

- `CLAUDE.md` - primary implementation workflow.
- `CODEX.md` - documentation, release readiness, and stabilization workflow.
- `COPILOT.md` and `.github/copilot-instructions.md` - IDE support workflow.
- `JULES.md` - bounded automated maintenance workflow.

## Pull Request Creation

Every agent that opens a PR must populate every section of the repository PR
template:

- Linked issue - issue number (`#N`) or `N/A`
- Summary of changes - one or two bullets
- Change type - additive, behavior change, breaking, or docs/config only
- Checklist - completed items checked; blocked items left unchecked with a note

Never submit a PR with an empty body or only template headings.
