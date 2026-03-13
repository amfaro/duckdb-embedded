# Extension manifest for our custom libduckdb static build.
# Consumed by DuckDB's CMake build system via DUCKDB_EXTENSION_CONFIGS.
#
# Out-of-tree extensions are cloned to vendor/ by `mise run build-duckdb`
# and referenced via SOURCE_DIR so builds are reproducible and offline-capable
# after the initial clone.

# evalexpr_rhai: evaluate Rhai scripting language expressions in SQL.
# Cloned by build-duckdb task to vendor/evalexpr_rhai/ at the pinned commit.
# The Rhai Rust component (duckdb_evalexpr_rhai_rust/) must be a sibling of
# the DuckDB source tree — handled by build-duckdb via symlink.
# See: https://github.com/Query-farm/evalexpr_rhai
duckdb_extension_load(evalexpr_rhai
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/vendor/evalexpr_rhai
)

# Built-in extensions to statically link (always available, no autoload needed).
duckdb_extension_load(json)
duckdb_extension_load(parquet)

# To add a first-party custom extension, use SOURCE_DIR:
#
# duckdb_extension_load(my_extension
#     SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/extensions/my_extension
# )
