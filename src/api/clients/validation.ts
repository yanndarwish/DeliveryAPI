import { z } from "zod"

// GET MANY CLIENTS
export const getManyClientsQuerySchema = z.object({
	limit: z.string().min(1),
	offset: z.string().min(1),
	status: z.string().nullable().optional(),
	name: z.string().nullable().optional(),
	city: z.string().nullable().optional(),
	postalCode: z.string().nullable().optional(),
	country: z.string().nullable().optional(),
})

export type GetManyClientsQuery = z.infer<typeof getManyClientsQuerySchema>

// CREATE CLIENT
export const createClientBodySchema = z.object({
	name: z.string().min(3),
	streetNumber: z.string().nullable().optional(),
	street: z.string().min(1),
	city: z.string().min(3),
	postalCode: z.string().nullable().optional(),
	country: z.string().min(3),
	comment: z.string().nullable().optional(),
	active: z.boolean(),
	phone: z.string().nullable().optional(),
	email: z.string().email().nullable().optional(),
})

export type CreateClientBody = z.infer<typeof createClientBodySchema>