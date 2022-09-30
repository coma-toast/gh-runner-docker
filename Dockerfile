FROM alpine:latest

ARG VERSION
ARG USERNAME
ARG REPO
ARG TOKEN

RUN apk add --no-cache curl tar bash
RUN mkdir actions-runner
RUN cd actions-runner; curl -o actions-runner-linux-x64-$VERSION.tar.gz -L https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz
RUN cd actions-runner; tar xzf ./actions-runner-linux-x64-$VERSION.tar.gz
# RUN cd actions-runner; ./config.sh --url https://github.com/$USERNAME/$REPO --token $TOKEN

ENTRYPOINT [ "/EntryPoint.sh" ]
