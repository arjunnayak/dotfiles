#!/bin/bash

set -e

DOTFILES_DIR=~/.dotfiles

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

function bashrc() {
    echo ">"
    echo "> Creating ~/.bashrc"
    cat <<EOF > ~/.bashrc
#!/bin/bash

SHELL_ROOT=${DOTFILES_DIR}

for file in \$SHELL_ROOT/dotfiles.d/*; do
  . \$file
done
EOF
}

# disable homebrew, pip, nelson (container orchestrator)
# homebrew
# pip
gitconfig
# nelson
bashrc

echo ">"
echo "> Done!"

