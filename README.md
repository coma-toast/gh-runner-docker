# GitHub Actions Runner Docker

#### A Docker image for Github Actions Runners

Have multiple repos and want to use private runners? Put all your runners in one `docker-compose.yml` file to spin them all up in one shot.

**_Note: The token is only valid for 1 hour._**
**_Another Note: You may need to set permissions on /var/run/docker.sock_**

Example docker-compose.yml:

```yaml
version: "3.7"
services:
    gh-runner-docker:
        image: jasonsdocker2018/gh-runner-docker
        environment:
            - USERNAME=coma-toast
            - REPO=gh-runner-docker
            - TOKEN=the token
        volumes:
            - gh-runner-docker:/actions-runner
            - /var/run/docker.sock:/var/run/docker.sock
    another-repo-runner:
        image: jasonsdocker2018/gh-runner-docker
        environment:
            - USERNAME=coma-toast
            - REPO=another-repo
            - TOKEN=the token
        volumes:
            - another-repo-runner:/actions-runner
            - /var/run/docker.sock:/var/run/docker.sock
volumes:
    gh-runner-docker:
    another-repo-runner:
```

### Build Docker image

Manually:  
`docker compose build --no-cache --build-arg GHVERSION=2.299.1`  
Or just spin up the docker-compose.yml in this repo:  
`docker compose up`
