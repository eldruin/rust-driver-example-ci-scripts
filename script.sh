set -exo pipefail

main() {
    if [ ! -z "$SUBFOLDER" ]; then
        cd "$SUBFOLDER"
    fi

    if [ ! -z "$GIT_DRIVERS" ]; then
        for DRIVER in $GIT_DRIVERS;
        do
            sed -i "s/$DRIVER\s*=\s*\"[0-9|.]*\"/$DRIVER = \{ git = \"https:\/\/github.com\/eldruin\/$DRIVER-rs\" \}/g" Cargo.toml
        done
    fi

    export CARGO_OPTIONS="$CARGO_OPTIONS --target $TARGET"

    if [ ! -z $FEATURES ]; then
       export CARGO_OPTIONS="$CARGO_OPTIONS --features $FEATURES"
    fi

    if [ ! -z "$EXAMPLES" ]; then
        for EXAMPLE in $EXAMPLES;
        do
            cargo build $CARGO_OPTIONS --example $EXAMPLE
        done
    else
        cargo build $CARGO_OPTIONS --examples
    fi

    cargo doc $CARGO_OPTIONS

    if [ -z $DISABLE_CLIPPY ] && [[ $TRAVIS_RUST_VERSION =~ .*stable.* ]]; then
        cargo clippy
    fi
}

main
