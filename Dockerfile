FROM --platform=linux/amd64 ubuntu:20.04 

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y curl tar bash sudo
RUN apt-get -y install tzdata
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN mkdir actions-runner
RUN useradd -r runner
RUN adduser runner sudo
RUN chmod 777 actions-runner

RUN mkdir -p /etc/sudoers.d \
        && echo "runner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/runner \
        && chmod 0440 /etc/sudoers.d/runner

RUN cd actions-runner; curl -o actions-runner-linux-x64-$VERSION.tar.gz -L https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz
RUN cd actions-runner; curl -o dotnet-install.sh -L https://dot.net/v1/dotnet-install.sh; chmod +x dotnet-install.sh
RUN cd actions-runner; tar xzf ./actions-runner-linux-x64-$VERSION.tar.gz
RUN cd actions-runner; ./bin/installdependencies.sh

USER runner

ENTRYPOINT [ "/EntryPoint.sh" ]
