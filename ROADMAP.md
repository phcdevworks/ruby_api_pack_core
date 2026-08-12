# Roadmap

`ruby_api_pack_core` is the shared HTTP client foundation for every
`ruby_api_pack_*` gem. Its job is to own `Connection::Base`,
`Handlers::ResponseValidator`, and `Configurable` so each downstream gem only
has to implement its own authentication headers, `Configuration` fields, and
resource endpoints — without adding integration-specific knowledge here.

This document tracks what's next. For what already shipped and why, see
[CHANGELOG.md](CHANGELOG.md) (release-by-release detail) and git history —
this file does not restate delivered work.

---

## Delivered Phases

| Phase | Summary | Shipped in |
| --- | --- | --- |
| 0 | Shared foundations — extracted `Connection::Base`, `Handlers::ResponseValidator`, and `Configurable` from the architecture already converged on by three downstream integrations; full RSpec coverage (100% line); standard documentation scaffold | 0.1.0 |

---

## What's Next

- Keep `Connection::Base`, `Handlers::ResponseValidator`, and `Configurable`
  stable now that three downstream integrations depend on this gem.
- Keep this gem free of any vendor-specific knowledge.
- Confirm all three consuming gems pass their own validation gates against
  the published `ruby_api_pack_core` version.
- Expand README examples showing how a new downstream integration should
  subclass `Connection::Base` and extend `Configurable`.
- Consider a typed error class hierarchy (e.g.
  `RubyApiPackCore::Errors::HttpError`,
  `RubyApiPackCore::Errors::ParseError`) shared by all consuming gems, since
  every gem currently raises plain `RuntimeError`s independently.
- Confirm supported Ruby versions across CI and gem metadata.
- Consider an optional retry/backoff hook on `Connection::Base` if more than
  one consuming gem needs rate-limit handling (currently only one downstream
  integration retries on rate limits, implemented locally).
- Add a generator or documented scaffold for creating a new downstream gem
  from this foundation.
- Evaluate whether `Handlers::ResponseValidator`'s `expected_key` unwrapping
  style (used historically by a downstream integration) should be offered as
  an alternative mode alongside `expected_type`.

See [TODO.md](TODO.md) for the itemized open backlog.

---

## Explicitly Out of Scope

- Any vendor-specific API knowledge (tokens, endpoint paths, resource classes)
- Host application data models or persistence
- User-facing Rails controllers or views
- Storage or management of production secrets
