.PHONY=all dependencies configuration

all: dependencies configuration

dependencies:
	brew bundle
configuration:
	stow . --target="${HOME}"
