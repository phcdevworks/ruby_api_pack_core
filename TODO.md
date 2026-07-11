# TODO

## Documentation

- [x] Standardize README structure.
- [x] Add AI operating guides.
- [x] Standardize community health docs.
- [x] Add changelog and roadmap.
- [ ] Add a worked example of scaffolding a new `ruby_api_pack_*` gem from
      this foundation.

## Ruby Gem

- [x] Extract shared connection wrapper, response validator, and
      configurable pattern from `ruby_api_pack_active_campaign`,
      `ruby_api_pack_cloudways`, and `ruby_api_pack_wordpress`.
- [ ] Consider a custom error class hierarchy for HTTP and parse failures,
      shared across all consuming gems.
- [ ] Consider timeout configuration for HTTParty requests.
- [ ] Evaluate whether `Handlers::ResponseValidator` should support
      Cloudways's historical `expected_key` unwrapping mode alongside
      `expected_type`.

## Requested by Downstream

(none yet)

## Release

- [ ] Confirm gemspec metadata links point to the repository and changelog.
- [ ] Document RubyGems release steps.
- [ ] Confirm supported Ruby versions in CI match the gemspec.
