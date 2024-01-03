import cors from "cors"
import express from "express"
import "express-async-errors"
import { config } from "@/config"
import { ExceptionsHandler } from "@/middlewares/exceptions.handler"
import { UnknownRoutesHandler } from "@/middlewares/unknownRoutes.handler"
import { deliveriesController } from "@/api/deliveries/controller"
import { database } from "@/lib/database"
import { logRequest } from "@/middlewares/requestLog"

const app = express()
app.use(logRequest)
database.connect((err: any) => {
	if (err) {
		console.error(err)
		process.exit(1)
	}
	console.log("Connected to database")
})

app.use(express.json())

app.use(cors())

app.use("/deliveries", deliveriesController)

/**
 * Homepage (uniquement necessaire pour cette demo)
 */
app.get("/", (req, res) => res.send("🏠"))

/**
 * Pour toutes les autres routes non définies, on retourne une erreur
 */
app.all("*", UnknownRoutesHandler)

/**
 * Gestion des erreurs
 * /!\ Cela doit être le dernier `app.use`
 */
app.use(ExceptionsHandler)

/**
 * On demande à Express d'ecouter les requêtes sur le port défini dans la config
 */
app.listen(config.API_PORT, () => console.log("Silence, ça tourne."))
