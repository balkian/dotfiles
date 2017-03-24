########## Variables

# change to the dotfiles directory

stow: submodules
	find . -maxdepth 0 -type d | xargs stow -v

submodules:
	git submodule update --init --recursive

docker: Dockerfile
	git clone . /tmp/dotfiles
	docker build -t balkian/devmachine /tmp/dotfiles

.PHONY: stow submodules docker
