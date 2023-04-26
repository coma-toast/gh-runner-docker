FROM --platform=linux/amd64 ubuntu:20.04 

# VERSION conflicts with the docker install script
ARG GHVERSION

# So the tzdata install doesn't stop to prompt
ENV DEBIAN_FRONTEND=noninteractive

# Copy EntryPoint
COPY ./EntryPoint.sh /EntryPoint.sh

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl tar bash sudo apt-utils
RUN apt-get -y install tzdata rsync openssh-client git

# Install docker so we can build docker images in the pipeline
RUN curl -sSL https://get.docker.com/ | sh

# Set up destination folder and user
RUN mkdir actions-runner
RUN useradd -r runner
RUN adduser runner sudo
RUN chmod 777 actions-runner
RUN mkdir /home/runner
RUN chown runner:docker /home/runner

# Add the runner user to sudoers
RUN mkdir -p /etc/sudoers.d \
        && echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/runner \
        && chmod 0440 /etc/sudoers.d/runner

# Move to the destination folder
WORKDIR /actions-runner

# Get the files and 
RUN curl -o actions-runner-linux-x64-$GHVERSION.tar.gz -L https://github.com/actions/runner/releases/download/v${GHVERSION}/actions-runner-linux-x64-${GHVERSION}.tar.gz
RUN curl -o dotnet-install.sh -L https://dot.net/v1/dotnet-install.sh
RUN chmod +x dotnet-install.sh
RUN tar xzf ./actions-runner-linux-x64-$GHVERSION.tar.gz
RUN ./bin/installdependencies.sh

# RUN service docker start

USER runner

ENTRYPOINT [ "/EntryPoint.sh" ]
