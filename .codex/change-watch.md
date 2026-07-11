# Change Watch

Use this file as a lightweight review log when preparing a documentation,
release, or stabilization handoff.

## Current Watch Points

- Any change to `Connection::Base`, `Handlers::ResponseValidator`, or
  `Configurable` public method names is breaking for every consuming gem —
  check for downstream coordination before merging.
- Vendor-specific knowledge (API tokens, endpoint paths, resource classes)
  showing up in this gem is a scope violation, not a feature.
- Release changes should keep `VERSION`, `CHANGELOG.md`, gem build output, and
  RubyGems publishing state aligned.

## Validation Notes

Record command results here only when useful for a release or PR handoff. Do
not paste secrets or live vendor response payloads.
