import { z } from "zod"

// COMMON
const pickupSchema = z.object({
	date: z.string().min(1),
	entityId: z.number(),
	entityType: z.enum(["CLIENT", "RELAY"]),
})

// GET MANY DELIVERIES
export const getManyDeliveriesQuerySchema = z.object({
	limit: z.string().min(1),
	offset: z.string().min(1),
	driver: z.string().min(3).nullable().optional(),
	provider: z.string().min(3).nullable().optional(),
	vehicle: z.string().min(3).nullable().optional(),
	day: z.string().nullable().optional(),
	month: z.string().nullable().optional(),
	year: z.string().nullable().optional(),
})

export type GetManyDeliveriesQuery = z.infer<
	typeof getManyDeliveriesQuerySchema
>

// CREATE DELIVERY
export const createDeliveryBodySchema = z.object({
	driverId: z.number(),
	vehicleId: z.number(),
	providerId: z.number(),
	hotelPrice: z.number().nullable().optional(),
	pickups: pickupSchema.array().min(1),
	dropoffs: pickupSchema.array().min(1),
	outsourcedTo: z.number().nullable().optional(),
})

export type CreateDeliveryBody = z.infer<typeof createDeliveryBodySchema>

// GET ONE DELIVERY BY ID
export const getOneDeliveryParamsSchema = z.object({
	// id must be a string because it comes from the url but should be a positive integer
	id: z.string().refine((value) => Number(value) > 0),
})

export type GetOneDeliveryParams = z.infer<typeof getOneDeliveryParamsSchema>

// UPDATE ONE DELIVERY BY ID
export const updateOneDeliveryParamsSchema = z.object({
	// id must be a string because it comes from the url but should be a positive integer
	id: z.string().refine((value) => Number(value) > 0),
})

export const updateOneDeliveryBodySchema = z.object({
	driverId: z.number(),
	vehicleId: z.number(),
	providerId: z.number(),
	hotelPrice: z.number().nullable(),
	pickups: pickupSchema.array().min(1),
	dropoffs: pickupSchema.array().min(1),
	outsourcedTo: z.number().nullable(),
})

export type UpdateOneDeliveryParams = z.infer<
	typeof updateOneDeliveryParamsSchema
>
export type UpdateOneDeliveryBody = z.infer<typeof updateOneDeliveryBodySchema>

// DELETE ONE DELIVERY BY ID
export const deleteOneDeliveryParamsSchema = z.object({
	// id must be a string because it comes from the url but should be a positive integer
	id: z.string().refine((value) => Number(value) > 0),
})

export type DeleteOneDeliveryParams = z.infer<
	typeof deleteOneDeliveryParamsSchema
>
