FROM ubuntu

# Set apt mirror
ARG UBUNTU_MIRROR
RUN sed -i s#http://archive.ubuntu.com/ubuntu/#$UBUNTU_MIRROR# /etc/apt/sources.list

# Install base packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y \
  # build-essential \
  # ca-certificates \
  curl wget \
  direnv \
  git \
  # locales \
  # nano \
  # rename \
  # rsync \
  software-properties-common \
  # ssh \
  vim \
  zip unzip

# Install python
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y \
  python3.12 \
  python3.12-dev \
  python3.12-venv \
  python3.12-distutils

# Configure git
RUN git config --global init.defaultBranch main
RUN git config --global credential.helper store
RUN git config --global pull.rebase false

# Set up root user
RUN echo 'root:root' | chpasswd
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "' >> /root/.bashrc
RUN echo 'umask 0002' >> /root/.bashrc
RUN echo 'eval "$(direnv hook bash)"' >> /root/.bashrc
RUN echo 'export DIRENV_LOG_FORMAT=""' >> /root/.bashrc

ENV TZ="Asia/Hong_Kong"
WORKDIR /root
ENTRYPOINT ["tail", "-f", "/dev/null"]
