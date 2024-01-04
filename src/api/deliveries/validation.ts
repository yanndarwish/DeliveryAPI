import { z } from "zod"

// COMMON
const pickupSchema = z.object({
    date: z.string(),
    entityId: z.number(),
	entityType: z.enum(["CLIENT", "RELAY"]),
})

// GET MANY DELIVERIES
export const getManyDeliveriesQuerySchema = z.object({
	limit: z.string(),
	offset: z.string(),
	driver: z.string().nullable().optional(),
	provider: z.string().nullable().optional(),
	vehicle: z.string().nullable().optional(),
	day: z.string().nullable().optional(),
	month: z.string().nullable().optional(),
	year: z.string().nullable().optional(),
})

export type GetManyDeliveriesQuery = z.infer<
	typeof getManyDeliveriesQuerySchema
>

// CREATE DELIVERY
export const createDeliveryBodySchema = z.object({
	companyId: z.number(),
	driverId: z.number(),
	vehicleId: z.number(),
	providerId: z.number(),
	hotelPrice: z.number().nullable().optional(),
	pickups: pickupSchema.array(),
	dropoffs: pickupSchema.array(),
    outsourcedTo: z.string().nullable().optional(),
})

export type CreateDeliveryBody = z.infer<typeof createDeliveryBodySchema>

// GET ONE DELIVERY BY ID
export const getOneDeliveryParamsSchema = z.object({
	// id must be a string because it comes from the url but should be a positive integer
	id: z.string().refine((value) => Number(value) > 0),
})

export type GetOneDeliveryParams = z.infer<typeof getOneDeliveryParamsSchema>