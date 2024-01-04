## SETUP

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


##  Pour créer une nouvelle route

- Ecrire la route dans le fichier ```openapi.yml```
- Générer les types avec ```npm run types-generate```
- Ecrire les typed requests, typed responses, typed body, typed query dans le fichier ```interfaces.ts```
- Ecrire les schemas Zod dans le fichier ```validation.ts``` dans le dossier correspondant
- Ecrire le type retourné de la base de données dans le fichier ```/src/lib/database/interfaces.ts```
- Ajouter la route dans le controller correspondant dans le dossier ```api```
- Créer la route dans le dossier ```logic```
- Mettre à jour le fichier ```postman```
- Ecrire les tests

## Tests

Pour tester une route il y a plusieurs cas :

### Pour une route qui renvoi une liste

- tester que le retour correspond bien au type ListResponseObject
- tester que la pagination est bien fonctionnelle et cohérente avec le nombre d'items retournés
- tester que les données retournées sont bien du type GetMany{entité}