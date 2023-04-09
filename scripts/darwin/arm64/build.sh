#!/bin/sh -e

export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export LIBSSH2_PATH=$(brew info libssh2 | grep -oE "^/opt/[^/]+(/[a-zA-Z0-9_.-]+)*/*" | head -1)

autoreconf -i

autoconf configure.ac

autoconf -i

./configure --enable-static \
        --disable-shared \
        --enable-metalink \
        --enable-bittorrent \
        --disable-nls \
        --with-appletls \
        --with-libgmp \
        --with-sqlite3 \
        --with-libz \
        --with-libssh2="$LIBSSH2_PATH" \
        --with-libexpat \
        --with-libcares \
        --without-libuv \
        --without-gnutls \
        --without-openssl \
        --without-libnettle \
        --without-libxml2 \
        ARIA2_STATIC=yes

make -j$(sysctl -n hw.ncpu) check

make -j$(sysctl -n hw.ncpu)