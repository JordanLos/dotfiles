#! /bin/bash
DOTFILES="dotfiles"
git clone --bare git@github.com:JordanLos/dotfiles.git $HOME/.$DOTFILES
function dotfiles {
     /usr/bin/git --git-dir=$HOME/.$DOTFILES/ --work-tree=$HOME $@
}
mkdir -p .$DOTFILES-backup
$DOTFILES checkout
if [ $? = 0 ]; then
   echo "Checked out $DOTFILES.";
   else
     echo "Backing up pre-existing dot files.";
         $DOTFILES checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .$DOTFILES-backup/{}
fi;
$DOTFILES checkout
$DOTFILES config status.showUntrackedFiles no
