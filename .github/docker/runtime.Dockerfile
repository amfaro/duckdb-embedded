FROM debian:bookworm-slim

ARG RELEASE_TAG
ARG DUCKDB_VERSION
ARG VCS_REF

LABEL org.opencontainers.image.title="duckdb-embedded-runtime" \
      org.opencontainers.image.description="AMFARO DuckDB embedded runtime image" \
      org.opencontainers.image.source="https://github.com/amfaro/duckdb-embedded" \
      org.opencontainers.image.version="${RELEASE_TAG}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.vendor="AMFARO" \
      io.amfaro.duckdb.version="${DUCKDB_VERSION}"

COPY runtime-image/opt/amfaro/duckdb /opt/amfaro/duckdb

ENV DUCKDB_LIB_DIR=/opt/amfaro/duckdb/lib
ENV DUCKDB_INCLUDE_DIR=/opt/amfaro/duckdb/include
ENV LD_LIBRARY_PATH=/opt/amfaro/duckdb/lib
