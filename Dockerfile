ARG FLUTTER_VERSION=3.41.9

FROM --platform=$BUILDPLATFORM ghcr.io/cirruslabs/flutter:${FLUTTER_VERSION} AS web
WORKDIR /src
COPY packages ./packages
COPY pubspec.yaml pubspec.lock l10n.yaml analysis_options.yaml ./
COPY lib ./lib
COPY assets ./assets
COPY web ./web
RUN flutter pub get
RUN flutter build web --wasm --release --no-web-resources-cdn --pwa-strategy=none

FROM dart:3.11 AS server
WORKDIR /src/server
COPY packages /src/packages
COPY server/pubspec.yaml server/pubspec.lock ./
RUN dart pub get
COPY server ./
RUN mkdir -p /out /data && chown 1000:1000 /data && dart compile exe bin/server.dart -o /out/gymmane-server

FROM scratch
COPY --from=server /runtime/ /
COPY --from=server /out/gymmane-server /app/gymmane-server
COPY --from=web /src/build/web /app/web
COPY --from=server --chown=1000:1000 /data /data
ENV GYMMANE_DATA=/data \
    GYMMANE_WEB=/app/web \
    GYMMANE_PORT=8080
USER 1000:1000
VOLUME /data
EXPOSE 8080
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s CMD ["/app/gymmane-server", "--health"]
ENTRYPOINT ["/app/gymmane-server"]
