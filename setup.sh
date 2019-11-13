#!/bin/bash

set -e

function homebrew() {
    echo ">"
    echo "> Installing Brewfile"
    brew bundle
}

function pip() {
    echo ">"
    echo "> Install python packages"
    pip3 install mkdocs
    pip3 install mkdocs-gitbook
    pip3 install --upgrade gimme-aws-creds
}

function node() {
    NODE_VERSION="12.13.0"
    echo ">"
    echo "> Install node $NODE_VERSION"
    nvm install $NODE_VERSION
}

# function nelson() {
#     echo ">"
#     echo "> Installing nelson"
#     TMP=$(mktemp -d)
#     pushd ${TMP}
#     curl -L -o nelson.tar.gz https://github.com/getnelson/cli/releases/download/0.9.93/nelson-darwin-amd64-0.9.93.tar.gz
#     tar -zxvf nelson.tar.gz
#     chmod +x nelson
#     mv nelson /usr/local/bin/
#     popd ${TMP}
#     rm -rf ${TMP}

#     echo ">"
#     echo "> Installing slipway"
#     TMP=$(mktemp -d)
#     pushd ${TMP}
#     curl -L -o slipway.tar.gz https://github.com/getnelson/slipway/releases/download/2.0.96/slipway-darwin-amd64-2.0.96.tar.gz
#     tar -zxvf slipway.tar.gz
#     chmod +x slipway
#     mv slipway /usr/local/bin/
#     popd ${TMP}
#     rm -rf ${TMP}
# }

function gitconfig() {
    echo ">"
    echo "> Setting up gitconfig"
    git config --global alias.lg 'log --graph --abbrev-commit --decorate --date=relative'
    git config --global alias.lgs 'log --graph --oneline --decorate --date=relative --all'
    git config --global alias.prb 'pull --rebase'
    git config --global alias.st 'status'
    git config --global alias.ci 'commit'
    git config --global alias.co 'checkout'

    git config --global alias.amend 'commit --amend --no-edit'

    git config --global --replace-all user.name 'Arjun Nayak'
    # git config --global --replace-all user.email '<email here>'
    git config --global commit.gpgsign false

    git config --global pull.rebase true
    git config --global rebase.autoStash true
    git config --global push.default simple
    git config --global --replace-all core.excludesfile '/Users/arjunnayak/.gitignore_global'

    git config --global commit.message "${DOTFILES_DIR}/.gitmessage"
}

function profile() {
    echo ">"
    echo "> Creating ~/.profile"
    cat <<EOF > ~/.profile
#!/bin/bash

export DOTFILES_DIR=~/.dotfiles

for file in $DOTFILES_DIR/dotfiles.d/*
do
  . $file
done
EOF
}

# disable pip, nelson (container orchestrator)
homebrew
# pip
gitconfig
# nelson
profile
node

echo ">"
echo "> Done!"

