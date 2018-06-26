# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

# Collection of sources required to build m4Builder
sources = [
    "http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz" =>
    "3ce725133ee552b8b4baca7837fb772940b25e81b2a9dc92537aeaf733538c9e",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd m4-1.4.17/
./configure --prefix=$prefix --host=$target
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, :glibc),
    Linux(:x86_64, :glibc),
    Linux(:aarch64, :glibc),
    Linux(:armv7l, :glibc, :eabihf),
    Linux(:powerpc64le, :glibc),
    Linux(:i686, :musl),
    Linux(:x86_64, :musl),
    Linux(:aarch64, :musl),
    Linux(:armv7l, :musl, :eabihf),
    MacOS(:x86_64),
    FreeBSD(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "", :m4)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "m4Builder", sources, script, platforms, products, dependencies)

