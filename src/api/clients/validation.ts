import { z } from "zod"

export const getManyClientsQuerySchema = z.object({
	limit: z.string(),
	offset: z.string(),
	status: z.string().nullable().optional(),
	name: z.string().nullable().optional(),
	city: z.string().nullable().optional(),
	postalCode: z.string().nullable().optional(),
	country: z.string().nullable().optional(),
})

export type GetManyClientsQuery = z.infer<typeof getManyClientsQuerySchema>
