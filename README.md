# jupyterhub-in-docker
Example setup of jupyterhub in a docker

## Runbook

- build example worker image:
```
docker build -f example.Dockerfile --tag=jupyter-worker .
```

- build jupyterhub image
```
docker build --tag=jupyterhub .
```
- run jupyterhub
```
docker run --rm -p 8010:8010 -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/jupyterhub jupyterhub
```

### Setup bind volumes folder on host
```
addgroup --gid 1024 jupyter
```

### Setup persistent folders for users

```
chown ubuntu:jupyter /jupyterhub/<user>
chmod 775 /jupyterhub/<user>
chmod g+s /jupyterhub/<user>
```
