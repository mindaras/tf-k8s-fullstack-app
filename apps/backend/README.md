# Backend layer

## Build

```
docker build --platform linux/amd64 -t mindaras/dev-counter-backend .
```

## Run

_Database_

```
docker run --rm -d -p 6379:6379 --name counter-database redis --requirepass mysecretpassword
docker exec -it CONTAINER_ID bash
redis-cli
auth mysecretpassword
```

_Application_

```
docker run -d --restart unless-stopped -p=8000:8000 -e PORT=8000 -e CACHE_USER=default -e CACHE_PASSWORD=mysecretpassword -e CACHE_HOST=127.0.0.1 -e CACHE_PORT=6379 --name=dev-counter-backend dev-counter-backend
```
