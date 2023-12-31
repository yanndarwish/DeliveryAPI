import { z } from "zod";

// GET MANY RELAYS
export const getManyRelaysQuerySchema = z.object({
    limit: z.string().min(1),
    offset: z.string().min(1),
    status: z.string().min(2).nullable().optional(),
    name: z.string().min(1).nullable().optional(),
    city: z.string().min(1).nullable().optional(),
    postalCode: z.string().min(2).nullable().optional(),
    country: z.string().min(2).nullable().optional(),
})

export type GetManyRelaysQuery = z.infer<typeof getManyRelaysQuerySchema>

// CREATE RELAY
export const createRelayBodySchema = z.object({
	name: z.string().min(1),
	streetNumber: z.string().min(1).nullable().optional(),
	street: z.string().min(1),
	city: z.string().min(1),
	postalCode: z.string().min(2).nullable().optional(),
	country: z.string().min(2),
	comment: z.string().min(1).nullable().optional(),
	active: z.boolean(),
})

export type CreateRelayBody = z.infer<typeof createRelayBodySchema>

// GET ONE RELAY BY ID
export const getOneRelayParamsSchema = z.object({
	id: z.string().refine((value) => Number(value) > 0),
})

export type GetOneRelayParams = z.infer<typeof getOneRelayParamsSchema>

// UPDATE ONE RELAY BY ID
export const updateOneRelayParamsSchema = z.object({
	id: z.string().refine((value) => Number(value) > 0),
})

export const updateOneRelayBodySchema = z.object({
	name: z.string().min(3),
	streetNumber: z.string().min(1).nullable(),
	street: z.string().min(1),
	city: z.string().min(3),
	postalCode: z.string().min(2).nullable(),
	country: z.string().min(3),
	comment: z.string().nullable(),
	active: z.boolean(),
})

export type UpdateOneRelayParams = z.infer<typeof updateOneRelayParamsSchema>
export type UpdateOneRelayBody = z.infer<typeof updateOneRelayBodySchema>

// DELETE ONE RELAY BY ID
export const deleteOneRelayParamsSchema = z.object({
	id: z.string().refine((value) => Number(value) > 0),
})

export type DeleteOneRelayParams = z.infer<typeof deleteOneRelayParamsSchema>