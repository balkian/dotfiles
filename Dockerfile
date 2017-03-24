FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y build-essential \
    cmake \
    curl \
    diffstat \
    git \
    pkg-config \
    python \
    python-dev \
    python \
    python3 \
    tmux \
    stow \
    sudo \
    vim \
    zsh && \
    apt clean

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python3
RUN pip install virtualenv virtualenvwrapper

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
RUN mkdir /home/dev/dotfiles/
RUN ls /home/dev/dotfiles
COPY . /home/dev/dotfiles
RUN sh /home/dev/dotfiles/make.sh

# Link in shared parts of the home directory
RUN ln -s /var/shared/.ssh && ln -s /usr/src/app
RUN chsh dev -s /usr/bin/zsh

RUN echo "dev    ALL = NOPASSWD: ALL" >> /etc/sudoers

USER dev
WORKDIR /home/dev/app
ENTRYPOINT ["zsh"]
