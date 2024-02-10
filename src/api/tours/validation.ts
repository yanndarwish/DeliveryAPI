import { z } from "zod"
import { idSchema } from "../validation"

// GET MANY TOURS
export const getManyToursQuerySchema = z.object({
	limit: z
		.string()
		.min(1)
		.refine((value) => Number(value) >= 0),
	offset: z
		.string()
		.min(1)
		.refine((value) => Number(value) >= 0),
	status: z.string().min(2).nullable().optional(),
	name: z.string().min(1).nullable().optional(),
})

export type GetManyToursQuery = z.infer<typeof getManyToursQuerySchema>

// CREATE TOUR
export const createTourBodySchema = z.object({
	name: z.string().min(3),
	active: z.boolean(),
	clientIds: idSchema.array().min(1), // array of client ids
})

export type CreateTourBody = z.infer<typeof createTourBodySchema>

// GET ONE TOUR
export const getOneTourParamsSchema = z.object({
	id: z
		.string()
		.min(1)
		.refine((value) => Number(value) > 0),
})

export type GetOneTourParams = z.infer<typeof getOneTourParamsSchema>

// UPDATE TOUR
export const updateTourParamsSchema = z.object({
	id: z
		.string()
		.min(1)
		.refine((value) => Number(value) > 0),
})

export const updateTourBodySchema = z.object({
	name: z.string().min(3),
	active: z.boolean(),
	clientIds: idSchema.array().min(1), // array of client ids
})

export type UpdateTourParams = z.infer<typeof updateTourParamsSchema>
export type UpdateTourBody = z.infer<typeof updateTourBodySchema>