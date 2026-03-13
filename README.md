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
