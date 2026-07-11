# COPILOT.md - Ruby API Pack Core

## Role

GitHub Copilot is a support assistant for local development in this repository.
It may help with Ruby, RSpec, documentation, and small refactors, but it does
not own architecture, release decisions, or final handoff authority.

## Repository Conventions

- Keep HTTParty/Oj plumbing centralized in `Connection::Base`.
- Keep this gem free of vendor-specific knowledge (API tokens, endpoint paths,
  resource classes) — that belongs in the consuming `ruby_api_pack_*` gems.
- Add focused RSpec coverage for behavior changes.
- Keep README and changelog aligned with public usage.
- Do not create commits unless explicitly asked.

## Validation

Run these before handing off non-trivial changes:

```bash
bundle exec rspec
bundle exec rubocop
```

## Security

Never suggest adding real API tokens, credentials, or vendor response bodies
to source control. This gem's specs use synthetic fixtures only.
