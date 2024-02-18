import { z } from "zod"

export const addressSchema = z.object({
	streetNumber: z.string().min(1).nullable().optional(),
	streetName: z.string().min(1),
	city: z.string().min(1),
	postalCode: z.string().min(2).nullable().optional(),
	country: z.string().min(2),
	comment: z.string().min(1).nullable().optional(),
})

export const contactSchema = z.object({
	firstName: z.string().min(1),
	lastName: z.string().min(1),
	email: z.string().email(),
	phone: z.string().min(10),
	comment: z.string().min(1).nullable().optional(),
})

// GET MANY COMPANIES
export const getManyCompaniesQuerySchema = z.object({
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
	siret: z.string().length(14).nullable().optional(),
	email: z.string().email().nullable().optional(),
})

export type GetManyCompaniesQuery = z.infer<typeof getManyCompaniesQuerySchema>

// CREATE COMPANY
export const createCompanyBodySchema = z.object({
	name: z.string().min(1),
	siret: z.string().length(14),
	headquarters: addressSchema.nullable().optional(),
	warehouse: addressSchema.nullable().optional(),
	email: z.string().email(),
	phone: z.string().min(10),
	contacts: z.array(contactSchema),
	active: z.boolean(),
})

export type CreateCompanyBody = z.infer<typeof createCompanyBodySchema>

// GET ONE COMPANY
export const getOneCompanyParamsSchema = z.object({
	id: z
		.string({ required_error: "L'ID de l'entreprise est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de l'entreprise doit être un nombre positif",
		}),
})

export type GetOneCompanyParams = z.infer<typeof getOneCompanyParamsSchema>
