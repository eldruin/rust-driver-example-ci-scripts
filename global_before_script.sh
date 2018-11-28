set -euxo pipefail

eval git pull --rebase https://github.com/$TRAVIS_REPO_SLUG master
eval git log --pretty=oneline HEAD~5..HEAD
export PATH=$HOME/.cargo/bin:$PATH