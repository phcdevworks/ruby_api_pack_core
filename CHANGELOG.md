# Changelog

All notable changes to this project will be documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the versioning
reflects gem releases published to RubyGems.

## [0.1.0] - 2026-07-11 — Phase 0 - Shared Foundations

Change type: additive (initial extraction)

### Added

- Initial extraction of `ruby_api_pack_core` from the shared architecture
  already converged on by `ruby_api_pack_active_campaign`,
  `ruby_api_pack_cloudways`, and `ruby_api_pack_wordpress`:
  - `RubyApiPackCore::Connection::Base`, a template-method HTTParty/Oj
    connection wrapper providing `api_get`/`api_post`/`api_put`/`api_delete`,
    shared URL building, `200..299` status handling, content-type-checked
    JSON parsing, and descriptive error messages. Subclasses implement only
    `#auth_headers`.
  - `RubyApiPackCore::Handlers::ResponseValidator`, a generic response-shape
    validator (`expected_type: :array`/`:hash`) with Rails-aware error
    logging, matching the validator already used by
    `ruby_api_pack_active_campaign` and `ruby_api_pack_wordpress`.
  - `RubyApiPackCore::Configurable`, a mixin extracted from the
    `configure`/`configuration` singleton pattern duplicated across all
    three existing gems.
- Full RSpec coverage (19 examples, 100% line coverage) for the connection
  base class, response validator, and configurable mixin, exercised against
  synthetic dummy subclasses/modules.
- Standard PHCDevworks documentation scaffold: `README.md`, `AGENTS.md`,
  `CLAUDE.md`, `CODEX.md`, `COPILOT.md`, `JULES.md`, `CONTRIBUTING.md`,
  `SECURITY.md`, `CODE_OF_CONDUCT.md`, `MIT-LICENSE`, `ROADMAP.md`,
  `TODO.md`, GitHub issue/PR templates, CI workflows, and `.coderabbit.yaml`.

### Changed

- Bumped `httparty` to `~> 0.24.0` (from `~> 0.22.0`) and `rubocop-rake` to
  `~> 0.7.0` (from `~> 0.6.0`) to track current RubyGems releases.
- Reverted an attempted development `bundler` bump to `~> 4.0`; kept `~> 2.5`
  after CI failed to resolve/install the newer major version.
- Raised `required_ruby_version` to `>= 3.3.0` (from `>= 3.1.0`), matching
  Rails 8's own Ruby floor. `httparty` and `rubocop` both carry unbounded
  transitive dependencies (`multi_xml`, `parallel`) whose newer majors
  require Ruby >= 3.2 and >= 3.3 respectively; rather than pin those
  transitive deps indefinitely, dropped support for Ruby versions below what
  Rails 8 itself requires. Updated the CI matrix to `['3.3.4', '3.4']`
  accordingly.
