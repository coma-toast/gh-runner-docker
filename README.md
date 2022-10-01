# gh-runner-docker

#### A Docker image for Github Actions Runners

Have multiple repos and want to use private runners? Put all your runners in one docker-compose file to spin them all up in one shot.

Example docker-compose.yml:

```yaml
version: "3"

services:
    runner:
        build: .
        environment:
            - USERNAME=coma-toast
            - REPO=gh-runner-docker
            - TOKEN=<generate token from Settings->actions->runners>
        volumes:
            - data:/actions-runner
            - ./EntryPoint.sh:/EntryPoint.sh

volumes:
    data:
```

### Build Docker image

`docker compose build --no-cache --build-arg GHVERSION=2.297.0`
