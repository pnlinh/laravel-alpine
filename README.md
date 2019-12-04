# Usage

Run a development container.

```
docker run -p 8080:80 -v `pwd`:/app selmonal/laravel-alpine:7.3
```

Run a production container:

On producation environment it will cache configs, views and routes automatically and enable opcache.

```
docker run -p 8080:80 -v `pwd`:/app -e APP_ENV=production selmonal/laravel-alpine:7.3
```

Run a Lumen application

```
docker run -p 8080:80 -v `pwd`:/app -e LARAVEL_TYPE=lumen selmonal/laravel-alpine:7.3
```

Run Laravel Horizon

```
docker run -v `pwd`:/app -e CONTAINER_ROLE=queue selmonal/laravel-alpine:7.3
```

Run Laravel Scheduler

```
docker run -v `pwd`:/app -e CONTAINER_ROLE=scheduler selmonal/laravel-alpine:7.3
```

Run with specific user and group

```
docker run -p 8080:80 -v `pwd`:/app -e APP_USER=1000 -e APP_USER_GROUP=1000 selmonal/laravel-alpine:7.3
```
