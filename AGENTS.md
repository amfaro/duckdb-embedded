# AGENTS.md

## Git

- Always use Conventional Commits for every commit in this repository.

## Project shape

- Keep the repository surface area minimal.
- Treat `build/` and `vendor/` as generated directories.
- Use `mise run build-duckdb` as the primary local build entrypoint.
