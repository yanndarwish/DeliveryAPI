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
npm run database:reload
```
