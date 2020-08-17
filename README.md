! Managing Dotfiles

Taken from [this](https://www.atlassian.com/git/tutorials/dotfiles) tutorial

!! Setup:

```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
```

So instead of using `git`, you add any file in your home directory with `dotfile add <filename>`. It won't show untracked files.

!! Use the Install script

Its titled `.dotfile-install.sh`. Run it in `$HOME`. Read below for instructions on how to do it maually.

!! Pulling To a New Computer

Clone to new computer

```bash
git clone --bare <git-repo-url> $HOME/.dotfiles
```

Define the alias in the current scope. 


```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Checkout the content from the abre repo

> :warning This might fail because it will overwrite existing dotfiles. Either back them up or just erase them

```bash
dotfiles checkout
```

Stop showing any untracked files (i.e. everything in $HOME)

```bash
dotfiles config --local status.showUntrackedFiles no
```

