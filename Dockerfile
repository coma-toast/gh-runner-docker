FROM --platform=linux/amd64 ubuntu:20.04 

# VERSION conflicts with the docker install script
ARG GHVERSION

# So the tzdata install doesn't stop to prompt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl tar bash sudo apt-utils
RUN apt-get -y install tzdata

# Install docker so we can build docker images in the pipeline
RUN curl -sSL https://get.docker.com/ | sh

RUN mkdir actions-runner
RUN useradd -r runner
RUN adduser runner sudo
RUN chmod 777 actions-runner

RUN mkdir -p /etc/sudoers.d \
        && echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/runner \
        && chmod 0440 /etc/sudoers.d/runner

RUN cd actions-runner; curl -o actions-runner-linux-x64-$GHVERSION.tar.gz -L https://github.com/actions/runner/releases/download/v${GHVERSION}/actions-runner-linux-x64-${GHVERSION}.tar.gz
RUN cd actions-runner; curl -o dotnet-install.sh -L https://dot.net/v1/dotnet-install.sh; chmod +x dotnet-install.sh
RUN cd actions-runner; tar xzf ./actions-runner-linux-x64-$GHVERSION.tar.gz
RUN cd actions-runner; ./bin/installdependencies.sh

USER runner

ENTRYPOINT [ "/EntryPoint.sh" ]
