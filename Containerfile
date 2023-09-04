FROM ghcr.io/aldehir/ut2/base:3369.3-release-2

ARG UT2U_VERSION=v0.1.1

COPY UT2004.ini System/UT2004.ini

RUN dnf install -y bsdtar && \
    curl -sfL -o /usr/bin/ut2u https://github.com/aldehir/ut2u/releases/download/$UT2U_VERSION/ut2u-linux-amd64 && \
    mkdir Community && \
    pushd Community && \
    curl -sfL https://ufcstorage.blob.core.windows.net/ufc-server-files/Maps1of2.zip | bsdtar -xf - && \
    curl -sfL https://ufcstorage.blob.core.windows.net/ufc-server-files/Maps2of2.zip | bsdtar -xf - && \
    rm -rf __MACOSX && \
    popd && \
    chmod +x /usr/bin/ut2u && \
    rm -f StaticMeshes/DanielsMeshes.utx && \
    ut2u package check-deps System/UT2004.ini

LABEL org.opencontainers.image.created="2023-09-01T12:00:00Z" \
      org.opencontainers.image.authors="Alde Rojas" \
      org.opencontainers.image.title="UT2004 Dedicated Server - TAM/UTComp Configuration" \
      org.opencontainers.image.description="UT2004 Dedicated Server - TAM/UTComp Configuration" \
      org.opencontainers.image.source="https://github.com/aldehir/ut2004-tam-utcomp-container"

CMD ["DM-Antalus?Game=xGame.xDeathMatch"]
