# Codex Workspace Notes

This folder keeps Codex-facing operational notes for `ruby_api_pack_core`.

## Default Checks

```bash
bundle exec rspec
bundle exec rubocop
gem build ruby_api_pack_core.gemspec
```

## Documentation Standard

Keep these files synchronized:

- `README.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `CHANGELOG.md`
- `ROADMAP.md`
- `TODO.md`
- `AGENTS.md`
- `CLAUDE.md`, `CODEX.md`, `COPILOT.md`, `JULES.md`
- `.github/codex-instructions.md`, `.github/copilot-instructions.md`

## Security Reminder

Do not include real API tokens, credentials, or vendor response bodies in
docs, specs, logs, or examples. This gem carries no vendor credentials of its
own by design.
