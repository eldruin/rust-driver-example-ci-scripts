set -exo pipefail

main() {
    rustup component add rust-src
    SYSROOT=$(rustc --print sysroot)
    if [[ ! "$SYSROOT" =~ "$TARGET" ]]; then
        rustup target add $TARGET
    else
        echo "Target $TARGET is already installed"
    fi

    if [ -z $DISABLE_CLIPPY ] && [[ $TRAVIS_RUST_VERSION =~ .*stable.* ]]; then
        rustup component add clippy-preview
    fi
}

main
