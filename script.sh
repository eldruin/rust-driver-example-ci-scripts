set -exo pipefail

main() {
    export CARGO_OPTIONS="$CARGO_OPTIONS --target $TARGET"

    if [ ! -z $FEATURES ]; then
       export CARGO_OPTIONS="$CARGO_OPTIONS --features $FEATURES"
    fi

    for EXAMPLE in $EXAMPLES;
    do
        cargo build $CARGO_OPTIONS --example $EXAMPLE
    done

    cargo doc $CARGO_OPTIONS

    if [ -z $DISABLE_CLIPPY ] && [[ $TRAVIS_RUST_VERSION =~ .*stable.* ]]; then
        cargo clippy
    fi
}

main
