set -euxo pipefail

# Travis can't cache files that are not readable by "others"
chmod -R a+r $HOME/.cargo
rm -rf /home/travis/.cargo/registry
