import { NextFunction, Request, Response } from "express"

import { ValidationError } from "@/lib/errors"

export const Validator =
	(schema: any, property: "body" | "query" | "params" | "headers") =>
	(req: Request, res: Response, next: NextFunction) => {
		const validate = schema.safeParse(req[property])

		if (!validate.success) {
			throw new ValidationError(validate.error.message)
		}

		next()
	}
