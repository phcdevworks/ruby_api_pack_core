# TODO

Phase 0 (initial extraction) is complete — see [ROADMAP.md](ROADMAP.md) for
the delivered-phases table and [CHANGELOG.md](CHANGELOG.md) for release
detail.

Remaining open work:

## Documentation

- Add a worked example of scaffolding a new downstream integration from this
  foundation.

## Ruby Gem

- Consider a custom error class hierarchy for HTTP and parse failures, shared
  across all consuming gems.
- Consider timeout configuration for HTTParty requests.
- Evaluate whether `Handlers::ResponseValidator` should support a downstream
  integration's historical `expected_key` unwrapping mode alongside
  `expected_type`.

## Requested by Downstream

(none yet)

New work here should also be reflected in [ROADMAP.md](ROADMAP.md)'s "What's
Next" section.
