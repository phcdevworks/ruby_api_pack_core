# CLAUDE.md - Ruby API Pack Core

## Project Identity

**Gem:** `ruby_api_pack_core`
**Owner:** PHCDevworks
**Primary implementation agent:** Claude Code

This repository is a Ruby gem providing the shared HTTP client foundation used
by every `ruby_api_pack_*` gem (ActiveCampaign, Cloudways, WordPress, and any
future vendor pack). It owns the connection wrapper's HTTParty/Oj plumbing,
the response-shape validator, and the `configure`/`configuration` singleton
pattern, so each vendor-specific gem only implements its own authentication
headers, `Configuration` fields, and resource endpoint classes. This file is
the implementation guide for Claude Code. Read `AGENTS.md` first for shared
agent boundaries.

This gem has no vendor-specific knowledge of any kind — no API tokens, no
endpoint paths, no resource classes. If a change requires knowing which
third-party API is being called, it belongs in the consuming
`ruby_api_pack_*` gem, not here.

## Commit Policy

Claude Code does not create commits in this repository unless explicitly asked.
Prepare changes, run validation, and leave commit, tag, push, and release
authority to the human maintainer.

## Development Workflow

```bash
bundle install
bundle exec rspec
bundle exec rubocop
gem build ruby_api_pack_core.gemspec
```

## Ruby Gem Contract

The public behavior surface is:

- `lib/ruby_api_pack_core.rb`
- `lib/ruby_api_pack_core/configurable.rb`
- `lib/ruby_api_pack_core/connection/base.rb`
- `lib/ruby_api_pack_core/handlers/response_validator.rb`
- `README.md`

Connection, validator, configurable, and response behavior changes require
matching specs and a changelog entry, because every downstream
`ruby_api_pack_*` gem inherits this behavior directly.

## Implementation Rules

1. Keep this gem free of vendor-specific knowledge — no API tokens, endpoint
   paths, resource classes, or third-party response shapes.
2. `RubyApiPackCore::Connection::Base` is a template-method base class.
   Subclasses in consuming gems must only override `#auth_headers`; do not add
   vendor-specific public methods to `Base` itself.
3. Preserve the public method names on `Connection::Base`
   (`api_get`/`api_post`/`api_put`/`api_delete`) and
   `Handlers::ResponseValidator` (`validate_response`) unless the change is
   intentionally breaking — every `ruby_api_pack_*` gem depends on this
   surface staying stable.
4. Any breaking change here requires a coordinated migration plan across
   `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`, and
   `ruby_api_pack_wordpress` before or alongside the release — do not publish
   a breaking `ruby_api_pack_core` version without updating consumers.
5. Avoid broad refactors unless they directly support the requested change.
6. Do not expose credentials, tokens, or vendor response bodies in logs,
   fixtures, docs, or test output — this gem's specs use synthetic fixtures
   only, never real API traffic.

## Testing Expectations

- `Connection::Base` changes need GET, POST, PUT, DELETE, parsing, and
  failure specs, exercised against a dummy subclass (see
  `spec/ruby_api_pack_core/connection/base_spec.rb`).
- `Handlers::ResponseValidator` changes need specs for every `expected_type`
  branch plus the Rails/non-Rails logging paths.
- `Configurable` changes need specs covering memoization and multiple
  `configure` calls.
- Security-sensitive changes should include both success and failure coverage.

## Documentation Expectations

Update:

- `README.md` for public installation, usage, or contract changes.
- `CHANGELOG.md` for every behavior-impacting change.
- `SECURITY.md` when security reporting or guidance changes.
- AI docs when agent workflows or authority boundaries change.
- The consuming gems' own `CLAUDE.md`/`README.md` if this gem's contract
  changes in a way that affects how they subclass or extend it.

## Release Procedure

1. Update `lib/ruby_api_pack_core/version.rb`.
2. Move changelog notes from `[Unreleased]` into a dated version section.
3. Run `bundle exec rspec`.
4. Run `bundle exec rubocop`.
5. Confirm `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`, and
   `ruby_api_pack_wordpress` still pass their own validation gates against the
   new version before publishing, if the change is anything other than
   additive.
6. Build and publish only when the maintainer explicitly approves.
