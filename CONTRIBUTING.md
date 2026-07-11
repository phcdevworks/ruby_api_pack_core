# Contributing to Ruby API Pack Core

Thanks for helping improve `ruby_api_pack_core`. This gem is maintained by
PHCDevworks as the shared HTTP client foundation for every `ruby_api_pack_*`
gem — it has no vendor-specific knowledge of its own.

## Development Setup

1. Clone the repository.
2. Install dependencies with `bundle install`.
3. Run `bundle exec rspec`.
4. Run `bundle exec rubocop`.
5. Build the gem with `gem build ruby_api_pack_core.gemspec` when preparing a
   release or changing packaging metadata.

## Project Structure

- `lib/ruby_api_pack_core.rb`: public gem entry point
- `lib/ruby_api_pack_core/configurable.rb`: shared `configure`/`configuration`
  singleton mixin
- `lib/ruby_api_pack_core/connection/base.rb`: shared HTTParty/Oj connection
  template class
- `lib/ruby_api_pack_core/handlers/response_validator.rb`: shared
  response-shape validator
- `lib/ruby_api_pack_core/version.rb`: gem version
- `spec/`: RSpec coverage for the connection base class, validator, and
  configurable mixin, tested against synthetic dummy classes

## Contribution Guidelines

### Connection, validator, and configurable changes

1. Keep public method names stable
   (`api_get`/`api_post`/`api_put`/`api_delete`, `validate_response`,
   `configure`/`configuration`) unless the change is intentionally breaking.
2. Add or update focused specs for any behavior change, exercised against a
   dummy subclass or dummy module — never against a real vendor API.
3. Keep this gem free of vendor-specific knowledge. If a change requires
   knowing which third-party API is being called, it belongs in a consuming
   `ruby_api_pack_*` gem instead.
4. Any breaking change here must be coordinated with
   `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`, and
   `ruby_api_pack_wordpress` before or alongside release.

### Code and tooling

- Follow the repo's RuboCop configuration.
- Prefer small, pattern-aligned changes.
- Keep comments brief and only add them when they explain a non-obvious reason.
- Preserve unrelated local changes.
- Do not create commits, tags, releases, or publish gems unless explicitly
  asked by a maintainer.

## Behavior-Impacting Change Checklist

Use this checklist when touching any public behavior surface:

- `lib/ruby_api_pack_core.rb`
- `lib/ruby_api_pack_core/configurable.rb`
- `lib/ruby_api_pack_core/connection/base.rb`
- `lib/ruby_api_pack_core/handlers/response_validator.rb`
- `README.md`

Before merge:

1. Update or add focused specs.
2. Run `bundle exec rspec`.
3. Run `bundle exec rubocop`.
4. Build with `gem build ruby_api_pack_core.gemspec` when packaging metadata
   changed.
5. Update `README.md` if installation, usage, or contract guidance changed.
6. Update `CHANGELOG.md` under `[Unreleased]`.
7. Classify the change as additive, behavior change, breaking, or docs/config
   only in the pull request.
8. If the change is breaking, note the required follow-up in the three
   consuming gems.

## Pull Request Checklist

1. Keep the change focused.
2. Fill out every section of `.github/pull_request_template.md`.
3. Link an issue or write `N/A`.
4. Include a concise summary and reviewer notes.
5. Leave blocked checklist items unchecked with a short note.

## Release Hygiene

For maintainers, a release should keep these records aligned:

1. Update `lib/ruby_api_pack_core/version.rb`.
2. Move relevant `CHANGELOG.md` `[Unreleased]` notes into a dated version entry.
3. Run `bundle exec rspec`.
4. Run `bundle exec rubocop`.
5. Build the gem from the matching source state.
6. Confirm the three consuming gems still pass their own validation gates
   against the new version, if the change is anything other than additive.
7. Publish release notes from the matching changelog entry.

## Questions

Open an issue if you need direction before making a larger change.

## Code of Conduct

By participating in this project, you agree to follow the
[Code of Conduct](CODE_OF_CONDUCT.md).

## License

By contributing, you agree that your contributions will be licensed under the
MIT License.
