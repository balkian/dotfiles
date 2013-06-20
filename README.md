# Balkian's dotfiles

## Usage

### Download
The Git Way:
```bash
git clone https://github.com/balkian/dotfiles.git
```
The fast way:
```bash
curl -#L https://github.com/balkian/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md}
```
### Install

Just run:
```bash
git submodule update --init --recursive
source make.sh
```

## How it works
So far, this is the simplest way of keeping your dotfiles in a repository. The installation script will just back-up your files in a folder in your ~/ with the timestamp, so running it twice won't destroy your original files.
