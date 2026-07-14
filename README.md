# Ruby API Pack Core

`ruby_api_pack_core` provides the shared connection wrapper, response
validator, and configuration pattern used by every `ruby_api_pack_*` gem, so
each vendor-specific API pack only has to implement its own authentication
headers and resource endpoints.

Maintained by [PHCDevworks](https://go.phcdev.co). It is the shared
foundation that `ruby_api_pack_active_campaign`, `ruby_api_pack_cloudways`,
and `ruby_api_pack_wordpress` all depend on for their HTTP client behavior.

## Repository Snapshot

| Field | Value |
|-------|-------|
| Project team | `project-ruby` |
| Repository role | Shared HTTP client foundation for all `ruby_api_pack_*` gems |
| Package/artifact | `ruby_api_pack_core` |
| Current version/status | 0.1.0 |

## Standard Workflow

1. Read [AGENTS.md](AGENTS.md), then the agent-specific guide for the task.
2. Check [TODO.md](TODO.md) and [ROADMAP.md](ROADMAP.md) for current scope.
3. Make the smallest repo-local change that satisfies the task.
4. Run `bundle exec rspec`, `bundle exec rubocop`, and
   `gem build ruby_api_pack_core.gemspec` when validation is required or
   practical.
5. Update docs and changelog history only when behavior, public contracts, or
   release-relevant metadata changed.

## Documentation Map

| Guide | Path |
|-------|------|
| Agent rules | [AGENTS.md](AGENTS.md) |
| Claude Code | [CLAUDE.md](CLAUDE.md) |
| Codex | [CODEX.md](CODEX.md) |
| Copilot | [COPILOT.md](COPILOT.md) |
| Jules | [JULES.md](JULES.md) |
| Roadmap | [ROADMAP.md](ROADMAP.md) |
| Todo | [TODO.md](TODO.md) |
| Changelog | [CHANGELOG.md](CHANGELOG.md) |
| Security | [SECURITY.md](SECURITY.md) |
| Code of Conduct | [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) |
| Contributing | [CONTRIBUTING.md](CONTRIBUTING.md) |

[![Gem Version](https://img.shields.io/gem/v/ruby_api_pack_core.svg)](https://rubygems.org/gems/ruby_api_pack_core)
[![CircleCI](https://img.shields.io/circleci/build/github/phcdevworks/ruby_api_pack_core/main.svg)](https://circleci.com/gh/phcdevworks/ruby_api_pack_core)
[![codecov](https://codecov.io/gh/phcdevworks/ruby_api_pack_core/graph/badge.svg)](https://codecov.io/gh/phcdevworks/ruby_api_pack_core)
[![License](https://img.shields.io/github/license/phcdevworks/ruby_api_pack_core.svg)](MIT-LICENSE)

`ruby_api_pack_core` is the shared HTTP client foundation consumed by every
`ruby_api_pack_*` gem (ActiveCampaign, Cloudways, WordPress, and any future
vendor pack). It owns the connection wrapper's HTTParty/Oj plumbing, a
generic response-shape validator, and the `configure`/`configuration`
singleton pattern, so each vendor-specific gem only has to implement its own
authentication headers, `Configuration` fields, and resource endpoint
classes — instead of every gem reinventing the same request/response
boilerplate.

[Contributing](CONTRIBUTING.md) | [Code of Conduct](CODE_OF_CONDUCT.md) |
[Changelog](CHANGELOG.md) | [Roadmap](ROADMAP.md) |
[Security Policy](SECURITY.md) | [AI Guide](AGENTS.md)

## Source of Truth

The gem's public behavior is defined by its connection base class, response
validator, configurable mixin, and specs. Keep those surfaces aligned — every
`ruby_api_pack_*` gem depends on this contract staying stable.

| Layer | Path | Rule |
| --- | --- | --- |
| Gem entry point | `lib/ruby_api_pack_core.rb` | Loads the connection, validator, and configurable surfaces |
| Connection base | `lib/ruby_api_pack_core/connection/base.rb` | Template-method HTTParty/Oj connection wrapper; subclasses implement `#auth_headers` |
| Response validator | `lib/ruby_api_pack_core/handlers/response_validator.rb` | Generic `expected_type: :array`/`:hash` response-shape validation |
| Configurable | `lib/ruby_api_pack_core/configurable.rb` | Shared `configure`/`configuration` singleton mixin |
| Version | `lib/ruby_api_pack_core/version.rb` | Gem release version |
| Specs | `spec/` | Contract and regression coverage, exercised against dummy subclasses/modules |

After behavior changes, run:

```bash
bundle exec rspec
bundle exec rubocop
gem build ruby_api_pack_core.gemspec
```

## What This Gem Owns

- A template-method `RubyApiPackCore::Connection::Base` class providing
  `api_get`/`api_post`/`api_put`/`api_delete`, URL building, `200..299`
  status handling, content-type-checked JSON parsing via `Oj`, and
  descriptive error messages
- `RubyApiPackCore::Handlers::ResponseValidator`, a generic response-shape
  validator (`expected_type: :array`/`:hash`) with Rails-aware error logging
- `RubyApiPackCore::Configurable`, a mixin providing the standard
  `MyGem.configure { |c| ... }` / `MyGem.configuration` singleton pattern
- RSpec coverage for all of the above, exercised against synthetic dummy
  subclasses and modules

## What This Gem Does Not Own

- Any vendor-specific API knowledge — API tokens, OAuth flows, Basic Auth,
  endpoint paths, or resource classes belong in the consuming
  `ruby_api_pack_*` gem
- Host application models, persistence, background jobs, or authorization
- User-facing Rails controllers or UI components
- Storage of production credentials or API tokens

## Installation

Add the gem to your application's Gemfile:

```ruby
gem "ruby_api_pack_core"
```

Install dependencies:

```bash
bundle install
```

Or install the gem directly:

```bash
gem install ruby_api_pack_core
```

In practice, most consumers won't install this gem directly — it's a runtime
dependency declared by each `ruby_api_pack_*` gem's own gemspec.

## Building a New API Pack on `ruby_api_pack_core`

A new vendor API pack gem needs three pieces built on top of this
foundation:

### 1. Configuration

```ruby
module RubyApiPackExample
  class Configuration
    attr_accessor :api_url, :api_token

    def initialize
      @api_url = 'https://api.example.com/v1'
      @api_token = nil
    end
  end
end

module RubyApiPackExample
  extend RubyApiPackCore::Configurable

  def self.configuration_class
    Configuration
  end
end
```

This gives consumers the standard pattern:

```ruby
RubyApiPackExample.configure do |config|
  config.api_url = ENV.fetch("EXAMPLE_API_URL")
  config.api_token = ENV.fetch("EXAMPLE_API_TOKEN")
end
```

### 2. Connection wrapper

Subclass `RubyApiPackCore::Connection::Base` and implement only
`#auth_headers` — everything else (URL building, verb dispatch, status
handling, JSON parsing) is inherited:

```ruby
module RubyApiPackExample
  module Connection
    class ExampleConnect < RubyApiPackCore::Connection::Base
      private

      def auth_headers
        { 'Api-Token' => RubyApiPackExample.configuration.api_token }
      end
    end
  end
end
```

### 3. Resource classes

Extend `RubyApiPackCore::Handlers::ResponseValidator` and follow the
`ENDPOINT` constant + `class << self` + private `connection(id = nil)`
factory pattern used by every existing `ruby_api_pack_*` resource class:

```ruby
module RubyApiPackExample
  module Api
    class Widgets
      extend RubyApiPackCore::Handlers::ResponseValidator

      ENDPOINT = '/widgets'

      class << self
        def widget_list
          validate_response(connection.api_get, expected_type: :array)
        end

        def widget_by_id(id)
          validate_response(connection(id).api_get, expected_type: :hash)
        end

        private

        def connection(id = nil)
          path = id ? "#{ENDPOINT}/#{id}" : ENDPOINT
          Connection::ExampleConnect.new(RubyApiPackExample.configuration.api_url, path)
        end
      end
    end
  end
end
```

This is the same architecture used by `ruby_api_pack_active_campaign`,
`ruby_api_pack_cloudways`, and `ruby_api_pack_wordpress` — see those gems for
worked, real-world examples.

## Error Handling

`Connection::Base` raises a plain `RuntimeError` (via `raise "..."`) for
non-2xx responses, unparseable JSON, or an unexpected content type. This
matches the existing behavior of every `ruby_api_pack_*` gem. A typed error
class hierarchy is tracked in [ROADMAP.md](ROADMAP.md) as a future
enhancement, but is not yet implemented — do not assume specific error
classes are raised.

## Development

Install dependencies:

```bash
bundle install
```

Run the test suite:

```bash
bundle exec rspec
```

Run style checks:

```bash
bundle exec rubocop
```

Build the gem locally:

```bash
gem build ruby_api_pack_core.gemspec
```

## Documentation and AI Guides

This repository follows the PHCDevworks documentation model used across the
Spectre and Rails/Ruby workspaces:

- `AGENTS.md` defines shared AI boundaries.
- `CLAUDE.md`, `CODEX.md`, `COPILOT.md`, and `JULES.md` define agent-specific
  working rules.
- `.github/copilot-instructions.md` and `.github/codex-instructions.md` provide
  GitHub-integrated assistant guidance.
- `CHANGELOG.md`, `ROADMAP.md`, and `TODO.md` keep release and planning context
  visible.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for setup, coding standards, pull
request expectations, and release hygiene.

## Security

Please do not report vulnerabilities through public issues. Follow
[SECURITY.md](SECURITY.md) for responsible disclosure.

## License

The gem is available as open source under the terms of the
[MIT License](MIT-LICENSE).
