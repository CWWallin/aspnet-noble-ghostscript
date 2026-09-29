FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble AS ghostpdl

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        file \
        g++ \
        gcc \
        make \
        wget \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN wget -q -O ghostpdl.tar.xz https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10080/ghostpdl-10.08.0.tar.xz \
    && echo "94943e3c4adb7115d132b3c28b913672f2e62e6a9d802f7e754e716b1634174a  ghostpdl.tar.xz" | sha256sum -c \
    && tar -xf ghostpdl.tar.xz \
    && cd ghostpdl-10.08.0 \
    && ./configure \
        --prefix=/usr/local \
        --disable-cups \
        --disable-dbus \
        --disable-fontconfig \
        --disable-gtk \
        --without-libidn \
        --without-libpaper \
        --without-tesseract \
        --without-x \
    && make -j"$(nproc)" \
    && make install \
    && ln -s gs /usr/local/bin/ghostscript

FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble

RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghostpdl /usr/local/ /usr/local/

RUN test "$(gs --version)" = "10.08.0" \
    && gpcl6 -h 2>&1 | grep -F "Version: 10.08.0" \
    && gxps -h 2>&1 | grep -F "Version: 10.08.0"
