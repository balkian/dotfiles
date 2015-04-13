FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y curl
RUN apt-get install -y diffstat
RUN apt-get install -y git
RUN apt-get install -y pkg-config
RUN apt-get install -y python
RUN apt-get install -y python-dev
RUN apt-get install -y python3
RUN apt-get install -y tmux
RUN apt-get install -y vim
RUN apt-get install -y zsh

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python2
RUN pip install virtualenv
RUN pip install virtualenvwrapper

# Setup home environment
RUN useradd dev
RUN mkdir /home/dev && chown -R dev: /home/dev
ENV PATH /home/dev/bin:$PATH

# Create a shared data volume
# We need to create an empty file, otherwise the volume will
# belong to root.
# This is probably a Docker bug.
RUN mkdir /var/shared/
RUN touch /var/shared/placeholder
RUN chown -R dev:dev /var/shared
RUN mkdir -p /usr/src/app/
RUN touch /usr/src/app/nocode
RUN chown -R dev:dev /usr/src/app

VOLUME /usr/src/app

WORKDIR /home/dev
ENV HOME /home/dev
RUN git clone https://github.com/balkian/dotfiles /home/dev/dotfiles
RUN sh /home/dev/dotfiles/make.sh

# Link in shared parts of the home directory
RUN ln -s /var/shared/.ssh
RUN ln -s /usr/src/app
RUN chsh dev -s /usr/bin/zsh

RUN chown -R dev: /home/dev
RUN chown -R dev: /usr/local/

RUN echo "dev    ALL = NOPASSWD: ALL" >> /etc/sudoers

USER dev
WORKDIR /home/dev/app
ENTRYPOINT ["zsh"]
