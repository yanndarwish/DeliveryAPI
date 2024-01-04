import { NextFunction, Request, Response } from "express"
import { ValidationError } from "@/lib/errors"
import { NotFoundError } from "@/lib/errors/notFoundError"

/**
 * Middleware de gestion globale des erreurs
 *
 * @param err - L'erreur Express (peut être la notre ou une autre)
 * @param req - La requête initiale
 * @param res - L'objet de réponse
 * @param next - Permet de passer au middleware suivant si existant
 *
 * @see https://expressjs.com/en/guide/error-handling.html
 */
export const ExceptionsHandler = (
	err: any,
	req: Request,
	res: Response,
	next: NextFunction
) => {
	/**
	 * Si l'erreur est de type `ValidationError`, on retourne une 400
	 */
	if (err instanceof ValidationError) {
		console.log(err)
		return res.status(400).json({ error: JSON.parse(err.message) })
	}

	if(err instanceof NotFoundError) {
		console.log(err.message)
		return res.status(404).json({ error: err.message })
	}
	/**
	 * Voir "The default error handler" dans la doc officielle indiquée plus haut
	 */
	if (res.headersSent) {
		return next(err)
	}

	/**
	 * Si c'est le cas, on sait que c'est notre propre erreur
	 */
	if (err.status && err.error) {
		return res.status(err.status).json({ error: err.error })
	}

	/**
	 * Dans les autres cas, on retourne une 500
	 */
	console.error(err)
	return res.status(500).json({ error: "Erreur interne" })
}
