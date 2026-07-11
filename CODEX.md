# CODEX.md - Ruby API Pack Core

## Role

Codex owns documentation standardization, release readiness, repo hygiene,
production stabilization, and configuration consistency for this Ruby gem.
Claude Code leads implementation changes. Human maintainers own final commit,
merge, tag, publish, and release decisions.

## Default Workflow

1. Inspect the current working tree and preserve unrelated local changes.
2. Read the relevant source, specs, and docs before editing.
3. Make focused changes using existing Ruby and RSpec patterns.
4. Update README, changelog, and AI docs when public guidance changes.
5. Run `bundle exec rspec` and `bundle exec rubocop` when feasible.
6. Build with `gem build ruby_api_pack_core.gemspec` when packaging or release
   metadata changed.
7. Report any validation that could not be run.

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

```bash
bundle exec rspec
bundle exec rubocop
gem build ruby_api_pack_core.gemspec
```

## Hard Limits

- Do not publish the gem unless explicitly asked.
- Do not create commits, tags, or releases unless explicitly asked.
- Do not overwrite unrelated local changes.
- Do not add vendor-specific knowledge, real credentials, or sensitive
  payloads to documentation or tests.
