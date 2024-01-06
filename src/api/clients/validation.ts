import { z } from "zod"

// GET MANY CLIENTS
export const getManyClientsQuerySchema = z.object({
	limit: z.string().min(1),
	offset: z.string().min(1),
	status: z.string().min(2).nullable().optional(),
	name: z.string().min(1).nullable().optional(),
	city: z.string().min(1).nullable().optional(),
	postalCode: z.string().min(2).nullable().optional(),
	country: z.string().min(2).nullable().optional(),
})

export type GetManyClientsQuery = z.infer<typeof getManyClientsQuerySchema>

// CREATE CLIENT
export const createClientBodySchema = z.object({
	name: z.string().min(3),
	streetNumber: z.string().min(1).nullable().optional(),
	street: z.string().min(1),
	city: z.string().min(3),
	postalCode: z.string().nullable().optional(),
	country: z.string().min(3),
	comment: z.string().nullable().optional(),
	active: z.boolean(),
	phone: z.string().min(10).nullable().optional(),
	email: z.string().email().nullable().optional(),
})

export type CreateClientBody = z.infer<typeof createClientBodySchema>

// GET ONE CLIENT BY ID
export const getOneClientParamsSchema = z.object({
	id: z.string().refine((value) => Number(value) > 0),
})

export type GetOneClientParams = z.infer<typeof getOneClientParamsSchema>