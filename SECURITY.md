# Security Policy

## Supported Versions

PHCDevworks applies security fixes to the current release line of this gem.
Please use the latest published version of `ruby_api_pack_core` whenever
possible.

## Reporting a Vulnerability

Do not open a public issue for security problems.

Use GitHub Security Advisories for this repository whenever possible. If that
is not available, contact the maintainers through GitHub.

Include:

1. A clear description of the issue and its impact
2. Steps to reproduce or a proof of concept
3. Affected versions, if known
4. Any suggested mitigation

## Response Expectations

1. We aim to acknowledge reports within 48 hours.
2. We aim to provide an initial assessment within 5 business days.
3. We will coordinate disclosure timing with the reporter when possible.

## Security Guidance

- Keep Ruby, Bundler, HTTParty, and development dependencies up to date.
- This gem carries no vendor credentials of its own — API tokens, OAuth
  secrets, and Basic Auth credentials live in the consuming
  `ruby_api_pack_*` gems' configuration objects, not here.
- Because every `ruby_api_pack_*` gem depends on this one, a vulnerability
  here has broader blast radius than a vulnerability in a single vendor pack
  — treat reports against `Connection::Base` and
  `Handlers::ResponseValidator` with correspondingly higher urgency.
- Review automated dependency updates and advisories before release.
- Specs use synthetic fixtures and mocked HTTParty responses only — never
  record real vendor API traffic against this repository.

## Contact

For non-sensitive security questions, open an issue or discussion in this
repository.
