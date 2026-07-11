# GitHub Copilot Instructions for ruby_api_pack_core

## Role

GitHub Copilot is the general development support assistant for this Ruby gem.

- Claude Code owns implementation leadership (`CLAUDE.md`).
- Codex owns documentation, release readiness, repo hygiene, and stabilization
  (`CODEX.md`).
- Jules owns bounded automated maintenance (`JULES.md`).
- Copilot supports editing, refactors, tests, and Ruby productivity inside the
  IDE.

Copilot does not own architecture direction, release decisions, or final handoff
authority.

## Package Conventions

- Keep HTTParty/Oj plumbing centralized in `Connection::Base`.
- Keep this gem free of vendor-specific knowledge — that belongs in the
  consuming `ruby_api_pack_*` gems.
- Add focused RSpec coverage for connection, validator, or configurable
  behavior changes.
- Keep README and changelog aligned with public usage.

## Working Style

- Prefer narrow, pattern-aligned changes.
- Keep docs and specs in sync when behavior changes.
- Preserve unrelated local changes.
- Do not create commits unless explicitly asked.

## Validation

- Run `bundle exec rspec` for behavior changes.
- Run `bundle exec rubocop` before handoff.
- Build the gem when release packaging changes.

## Security

Never add real API tokens, credentials, or vendor response bodies to source
control.

## Pull Request Creation

When opening a PR, populate every section of the repo's PR template:

- Linked issue - issue number (`#N`) or `N/A`
- Summary of changes - one or two bullets
- Change classification - additive, behavior change, breaking, or docs/config only
- Checklist - completed items checked; blocked items left unchecked with a brief note

Never submit a PR with an empty body or only template headings.

## References

- Shared boundaries: `AGENTS.md`
- Lead implementation rules: `CLAUDE.md`
- Codex/release readiness rules: `CODEX.md`
- Copilot support context: `COPILOT.md`
