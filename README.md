This is my ~/.vim dir.

# Installation
clone the repogitory: `git clone --recursive https://github.com/homedm/vimfiles ~/.vim`

# update all plugin
	git submodule foreach git pull
	git commit -am "update: Update all vim plugin"

# add plugin
	git subomdele add "github repogitory" ./pack/mypack/start/repository.vim
	または
	git subomdele add "github repogitory" ./pack/mypack/opt/repository.vim
	git commit -a "add: Add RepositoryName.vim plugin"

# delete plugin
	git submodule deinit -f name
	git rm -f name

# Compile Option
This vimrc files don't use "python, pytho3, lua, ruby, perl option"
