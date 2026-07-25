# CODEX.md - Ruby API Pack Core

## Role

Codex owns documentation standardization, release readiness, repo hygiene,
production stabilization, and configuration consistency for this Ruby gem.
Claude Code leads implementation changes. Codex has commit, push, and tag
authority for its own scope of work, including cutting the release itself
(see "Release Mechanics" below). `gem push` (RubyGems publish) and merge
decisions stay with Bradley Potts.

## Default Workflow

1. Inspect the current working tree and preserve unrelated local changes.
2. Read the relevant source, specs, and docs before editing.
3. Make focused changes using existing Ruby and RSpec patterns.
4. Update README, changelog, and AI docs when public guidance changes.
5. Run the validation gate described in [AGENTS.md](AGENTS.md) when feasible.
6. Report any validation that could not be run.

## Documentation Scope

Codex may update:

- `README.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `CODE_OF_CONDUCT.md`
- `CHANGELOG.md`
- `ROADMAP.md`
- `TODO.md`
- `AGENTS.md`, `CLAUDE.md`, `CODEX.md`, `COPILOT.md`, `JULES.md`
- `.github/` templates and assistant instructions
- `.codex/` workspace notes

## Review Scope

When reviewing changes, Codex checks:

1. `Connection::Base`, `Handlers::ResponseValidator`, and `Configurable`
   behavior drift.
2. Missing RSpec coverage for connection, validator, or configurable changes.
3. Vendor-specific knowledge (API tokens, endpoint paths, resource classes)
   accidentally introduced into this gem.
4. Inconsistent response parsing or error behavior.
5. README or changelog drift from the public behavior surface.
6. CI and release workflow mismatch with documented commands.
7. Breaking changes that were not flagged as requiring coordination with
   `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`, and
   `ruby_api_pack_wordpress`.

## Validation Commands

Run the validation gate described in [AGENTS.md](AGENTS.md), plus:

```bash
gem build ruby_api_pack_core.gemspec
```

## Release Mechanics

1. Update `lib/ruby_api_pack_core/version.rb` to the new version.
2. Move `[Unreleased]` notes in `CHANGELOG.md` into a new versioned entry:
   `## [<version>] - <YYYY-MM-DD>`, with a release title line in the format
   `**Release Title:** Phase <N> - <short title>`, where `Phase <N>` is the
   active phase name from this repo's own `ROADMAP.md` and `<short title>`
   is a concise summary of what shipped. If the release spans no single
   ROADMAP phase, state that explicitly instead of inventing one.
3. Run the validation gate described in [AGENTS.md](AGENTS.md) plus
   `gem build ruby_api_pack_core.gemspec` — must pass clean.
4. If the release is anything other than additive, confirm
   `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`, and
   `ruby_api_pack_wordpress` still pass their own validation gates against
   the new version before proceeding — those three gems depend on this one.
5. Stage and commit the version bump and changelog update.
6. Create the git tag: `git tag v<version>` (matching `version.rb` exactly),
   then push the commit and tag.
7. Publish the GitHub Release from that tag: `gh release create v<version>
   --title "v<version>: Phase <N> - <short title>" --notes-file` (extract the
   new version's changelog section, or `--notes` inline for a short release).
8. `gem push` is **not** run by Codex — that stays with Bradley Potts.

## Hard Limits

- Commit, tag, and GitHub Release authority is granted per "Release
  Mechanics" above; do not run `gem push` or merge PRs unless explicitly
  asked.
- Do not overwrite unrelated local changes.
- Do not add vendor-specific knowledge, real credentials, or sensitive
  payloads to documentation or tests.
