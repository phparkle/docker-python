FROM ubuntu

# Set apt mirror
ARG UBUNTU_MIRROR
RUN sed -i s#http://archive.ubuntu.com/ubuntu/#$UBUNTU_MIRROR# /etc/apt/sources.list

# Install base packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y \
  build-essential \
  ca-certificates \
  cron \
  curl \
  git \
  less \
  locales \
  mariadb-client \
  nano \
  patch \
  pkg-config \
  rename \
  rsync \
  software-properties-common \
  ssh \
  supervisor \
  tzdata \
  unzip \
  vim \
  wget \
  zip

# Install python
RUN apt-get install -y \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv \
  python-is-python3 \
  default-libmysqlclient-dev
RUN pip install --upgrade pip

# Install node.js
# RUN mkdir -p /etc/apt/keyrings
# RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
# RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
# RUN apt-get update
# RUN apt-get install -y nodejs
# RUN npm i -g npm
# RUN npm config set -g audit false
# RUN npm config set -g fund false

# Configure git
RUN git config --global init.defaultBranch main
RUN git config --global credential.helper store
RUN git config --global pull.rebase false

# Set up root user
RUN echo 'root:root' | chpasswd
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "' >> /root/.bashrc
RUN echo 'umask 0002' >> /root/.bashrc

ENV TZ="Asia/Hong_Kong"
WORKDIR /root
ENTRYPOINT ["tail", "-f", "/dev/null"]
