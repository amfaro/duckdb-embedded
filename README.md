# duckdb-embedded

Builds a custom shared `libduckdb` with `evalexpr_rhai`, `json`, and `parquet`
linked in.

## Build

```sh
mise install
mise run build-duckdb
```

Output:

- macOS: `build/release/src/libduckdb.dylib`
- Linux: `build/release/src/libduckdb.so`

Headers:

- `vendor/duckdb/src/include/duckdb.h`
- `vendor/duckdb/src/include/duckdb.hpp`

## Extensions dir

`extensions/.keep` exists so the repo keeps an `extensions/` directory around
for future first-party extensions. `build/` and `vendor/` are generated during
the build and are intentionally not kept in git.

## Consumer env

```sh
DUCKDB_LIB_DIR=/path/to/duckdb-embedded/build/release/src
DUCKDB_INCLUDE_DIR=/path/to/duckdb-embedded/vendor/duckdb/src/include
DYLD_LIBRARY_PATH=/path/to/duckdb-embedded/build/release/src
# Linux: LD_LIBRARY_PATH=/path/to/duckdb-embedded/build/release/src
```

## Release artifacts

The release workflow publishes:

- `libduckdb-osx-arm64.zip`
- `libduckdb-linux-amd64.zip`

## Release flow

Releases are driven by pull requests and the `VERSION` file.

1. Normal code changes merge to `main`
2. `prepare-release.yml` runs on pushes to `main` and delegates to `mise run release:prepare`
3. `release:prepare` reads `DUCKDB_VERSION` from `mise.toml`, infers the next tag in the form `vX.Y.Z-N`, writes that value to `VERSION`, and opens or updates a `release/*` PR
4. Merging the release PR updates `main` with `VERSION`
5. `tag-release.yml` runs on that push and delegates to `mise run release:tag`
6. `release:tag` creates and pushes the matching git tag
7. `release.yml` runs on the tag push, builds the release artifacts, publishes the GitHub release, and dispatches `duckdb-embedded-release` to `amfaro/calc`

### VERSION

`VERSION` is machine-written release metadata, not a manually maintained version file.

- when `VERSION` is absent, the repo is in a pre-release state
- when a release PR is opened, `VERSION` contains the pending tag to create
- `tag-release.yml` only uses `VERSION` on the `main` push produced by merging a release PR

### Operational notes

- the source of truth for the DuckDB version is `DUCKDB_VERSION` in `mise.toml`
- release tags use the format `vX.Y.Z-N`, where `X.Y.Z` is the DuckDB version and `N` is the embedded build number
- `release.yml` does not backfill old tags automatically; if a tag existed before the workflow was fixed, you may need a fresh triggering event for publication
- if a release looks stuck, check the `prepare-release`, `tag-release`, and `release` workflow runs in that order
