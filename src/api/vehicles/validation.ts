import { z } from "zod"

// GET MANY VEHICLES
export const getManyVehiclesQuerySchema = z.object({
	limit: z.string().min(1),
	offset: z.string().min(1),
	status: z.string().min(2).nullable().optional(),
	brand: z.string().min(1).nullable().optional(),
	model: z.string().min(1).nullable().optional(),
	immatriculation: z.string().min(1).nullable().optional(),
})

export type GetManyVehiclesQuery = z.infer<typeof getManyVehiclesQuerySchema>

// CREATE VEHICLE
export const createVehicleBodySchema = z.object({
	brand: z.string().min(1),
	model: z.string().min(1),
	immatriculation: z.string().min(1),
	active: z.boolean(),
})

export type CreateVehicleBody = z.infer<typeof createVehicleBodySchema>

// GET ONE VEHICLE
export const getOneVehicleParamsSchema = z.object({
	id: z
		.string()
		.min(1)
		.refine((value) => Number(value) > 0),
})

export type GetOneVehicleParams = z.infer<typeof getOneVehicleParamsSchema>
