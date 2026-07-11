# Roadmap

This roadmap tracks the direction for `ruby_api_pack_core` as the shared HTTP
client foundation for every `ruby_api_pack_*` gem. It is planning context, not
a release promise.

## Current Focus

- Keep `Connection::Base`, `Handlers::ResponseValidator`, and `Configurable`
  stable now that `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`,
  and `ruby_api_pack_wordpress` all depend on this gem.
- Keep this gem free of any vendor-specific knowledge.
- Improve release hygiene for RubyGems publishing.

## Near-Term

- Confirm all three consuming gems pass their own validation gates against
  the published `ruby_api_pack_core` version.
- Expand README examples showing how a new `ruby_api_pack_*` gem should
  subclass `Connection::Base` and extend `Configurable`.
- Consider a typed error class hierarchy (e.g.
  `RubyApiPackCore::Errors::HttpError`,
  `RubyApiPackCore::Errors::ParseError`) shared by all consuming gems, since
  every gem currently raises plain `RuntimeError`s independently.
- Confirm supported Ruby versions across CI and gem metadata.

## Later

- Consider an optional retry/backoff hook on `Connection::Base` if more than
  one consuming gem needs rate-limit handling (currently only
  `ruby_api_pack_cloudways` retries on rate limits, implemented locally).
- Add a generator or documented scaffold for creating a new `ruby_api_pack_*`
  gem from this foundation.
- Evaluate whether `Handlers::ResponseValidator`'s `expected_key` unwrapping
  style (used historically by `ruby_api_pack_cloudways`) should be offered as
  an alternative mode alongside `expected_type`.

## Out of Scope

- Any vendor-specific API knowledge (tokens, endpoint paths, resource classes)
- Host application data models or persistence
- User-facing Rails controllers or views
- Storage or management of production secrets
