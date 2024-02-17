import "express-async-errors"
import express from "express"
import cors from "cors"

import { config } from "@/config"

import { database } from "@/lib/database"

import { UnknownRoutesHandler } from "@/middlewares/unknownRoutes.handler"
import { ExceptionsHandler } from "@/middlewares/exceptions.handler"
import { logRequest } from "@/middlewares/requestLog"

import { deliveriesController } from "@/api/deliveries/controller"
import { clientsController } from "@/api/clients/controller"
import { relaysController } from "@/api/relays/controller"
import { driversController } from "@/api/drivers/controller"
import { vehiclesController } from "@/api/vehicles/controller"
import { toursController } from "@/api/tours/controller"
import { companiesController } from "@/api/companies/controller"

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
app.use("/clients", clientsController)
app.use("/relays", relaysController)
app.use("/drivers", driversController)
app.use("/vehicles", vehiclesController)
app.use("/tours", toursController)
app.use("/companies", companiesController)

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

app.listen(config.API_PORT, () => console.log("Silence, ça tourne."))
