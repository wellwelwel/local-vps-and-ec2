# Local Ubuntu VPS and EC2 ☘️

A Docker image based on VPS and EC2 and a totally no-cost option to develop and test using a local server.

---

## Pull

```sh
docker pull wellwelwel/vps:latest
```

- Also: `18.04`, `20.04`, `22.04`, and `24.04`.

---

## Run

```sh
docker run --privileged -p 22:22 --restart always wellwelwel/vps:latest
```

- Default root password is `root`
- Default port is `22`
- `--privileged` option is required to use `sudo` commands

---

## Compose

```yml
version: '3.9'
services:
  vps:
    image: 'wellwelwel/vps:latest'
    privileged: true
    restart: always
    ports:
      - '22:22'
```

- Default root password is `root`
- Default port is `22`

---

### Accessing

```sh
ssh root@127.0.0.1
```

- Default root password is `root`

---

## Customizing

### You can personalize the port and password:

```yml
version: '3.9'
services:
  vps:
    image: 'wellwelwel/vps:latest'
    privileged: true
    restart: always
    ports:
      - '2222:2222'
    environment:
      PASSWORD: password
      PORT: 2222
```

You can also set a password using a file:

```yml
version: '3.9'
services:
  vps:
    image: 'wellwelwel/vps:latest'
    privileged: true
    restart: always
    ports:
      - '22:22'
    volumes:
      - ./.secret:/root/.secret:ro
```

- Securely set the password in a volume to file `/root/.secret` with `sudo chmod 0400`

---

> It's an image created for [**SVPS Project**](https://github.com/wellwelwel/svps) 🧙🏻
