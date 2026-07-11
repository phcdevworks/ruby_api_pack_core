# Release Readiness

Use this checklist before a maintainer publishes `ruby_api_pack_core`.

## Validation

- [ ] `bundle exec rspec` passes.
- [ ] `bundle exec rubocop` passes.
- [ ] `gem build ruby_api_pack_core.gemspec` succeeds.

## Release Records

- [ ] `lib/ruby_api_pack_core/version.rb` has the intended version.
- [ ] `CHANGELOG.md` has a dated entry for the intended version.
- [ ] README usage reflects the current public contract.
- [ ] Security guidance is current.

## Downstream Coordination

- [ ] If the change is anything other than additive, confirm
      `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`, and
      `ruby_api_pack_wordpress` still pass their own validation gates against
      this version.

## Safety

- [ ] No real API tokens or credentials are present in source, docs, logs,
      examples, or fixtures.
- [ ] No vendor response bodies are committed.

## Handoff

- [ ] Summarize change classification.
- [ ] Include validation results.
- [ ] Note any known release risks or skipped checks.
