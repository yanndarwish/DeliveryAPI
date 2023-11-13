## SETUP

---

Init Mariadb container

```bash
# in project root
cd docker
docker-compose up
```

Setup and populate databases (only with base data)

```bash
# in project root
npm run database:up
```

Delete databases (This removes all additionnal data added after the setup)

```bash
# in project root
npm run database:down
```
