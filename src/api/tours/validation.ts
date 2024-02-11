import { z } from "zod"
import { idSchema } from "../validation"

// GET MANY TOURS
export const getManyToursQuerySchema = z.object({
	limit: z
		.string({ required_error: "La limite est requise" })
		.min(1)
		.refine((value) => Number(value) >= 10, {
			message: "La limite doit être un nombre supérieur ou égal à 10",
		}),
	offset: z
		.string({ required_error: "L'offset est requis" })
		.min(1)
		.refine((value) => Number(value) >= 0, {
			message: "L'offset doit être un nombre supérieur ou égal à 0",
		}),
	status: z.string().min(2).nullable().optional(),
	name: z.string().min(1).nullable().optional(),
})

export type GetManyToursQuery = z.infer<typeof getManyToursQuerySchema>

// CREATE TOUR
export const createTourBodySchema = z.object({
	name: z.string({ required_error: "Le nom de la tournée est requis" }).min(3, {
		message: "Le nom de la tournée doit contenir au moins 3 caractères",
	}),
	active: z.boolean({
		required_error: "Le champ active est requis",
		invalid_type_error: "Le champ active doit être un booléen",
	}),
	clientIds: idSchema
		.array()
		.min(1, { message: "Un client minimum est requis" }), // array of client ids
})

export type CreateTourBody = z.infer<typeof createTourBodySchema>

// GET ONE TOUR
export const getOneTourParamsSchema = z.object({
	id: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
})

export type GetOneTourParams = z.infer<typeof getOneTourParamsSchema>

// UPDATE TOUR
export const updateTourParamsSchema = z.object({
	id: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
})

export const updateTourBodySchema = z.object({
	name: z
		.string({ required_error: "Le nom de la tournée est requis" })
		.min(3, {
			message: "Le nom de la tournée doit contenir au moins 3 caractères",
		}),
	active: z.boolean({
		required_error: "Le champ active est requis",
		invalid_type_error: "Le champ active doit être un booléen",
	}),
	clientIds: idSchema
		.array()
		.min(1, { message: "Un client minimum est requis" }), // array of client ids
})

export type UpdateTourParams = z.infer<typeof updateTourParamsSchema>
export type UpdateTourBody = z.infer<typeof updateTourBodySchema>

// DELETE TOUR
export const deleteTourParamsSchema = z.object({
	id: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
})

export type DeleteTourParams = z.infer<typeof deleteTourParamsSchema>

// ==================================================================
// ======================== TOUR MEMBERS ============================
// ==================================================================

// GET MANY TOUR MEMBERS

export const getManyTourMembersParamsSchema = z.object({
	tourId: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
})

export const getManyTourMembersQuerySchema = z.object({
	limit: z
		.string({ required_error: "La limite est requise" })
		.min(1)
		.refine((value) => Number(value) >= 10, {
			message: "La limite doit être un nombre supérieur ou égal à 10",
		}),
	offset: z
		.string({ required_error: "L'offset est requis" })
		.min(1)
		.refine((value) => Number(value) >= 0, {
			message: "L'offset doit être un nombre supérieur ou égal à 0",
		}),
	status: z.string().min(2).nullable().optional(),
})

export type GetManyTourMembersParams = z.infer<
	typeof getManyTourMembersParamsSchema
>
export type getManyTourMembersQuery = z.infer<
	typeof getManyTourMembersQuerySchema
>

// GET ACTIVE TOUR MEMBERS AT SPECIFIC DATE

export const getActiveTourMembersAtDateParamsSchema = z.object({
	tourId: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
})

export const getActiveTourMembersAtDateQuerySchema = z.object({
	// string but must be a valid date
	date: z
		.string({ required_error: "La date est requise" })
		.refine((value) => !isNaN(Date.parse(value)), {
			message: "Format de date invalide: AAAA-MM-DD",
		}),
})

export type GetActiveTourMembersAtDateParams = z.infer<
	typeof getActiveTourMembersAtDateParamsSchema
>
export type GetActiveTourMembersAtDateQuery = z.infer<
	typeof getActiveTourMembersAtDateQuerySchema
>

// GET ONE TOUR MEMBER

export const getOneTourMemberParamsSchema = z.object({
	tourId: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
	id: z
		.string({ required_error: "L'ID du membre de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID du membre de la tournée doit être un nombre positif",
		}),
})

export type GetOneTourMemberParams = z.infer<
	typeof getOneTourMemberParamsSchema
>

// UPDATE TOUR MEMBER STATUS

export const updateTourMemberStatusParamsSchema = z.object({
	tourId: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
	id: z
		.string({ required_error: "L'ID du membre de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID du membre de la tournée doit être un nombre positif",
		}),
})

export const updateTourMemberStatusBodySchema = z.object({
	active: z.boolean({
		required_error: "Le champ active est requis",
		invalid_type_error: "Le champ active doit être un booléen",
	}),
})

export type UpdateTourMemberStatusParams = z.infer<
	typeof updateTourMemberStatusParamsSchema
>
export type UpdateTourMemberStatusBody = z.infer<
	typeof updateTourMemberStatusBodySchema
>

// DELETE TOUR MEMBER
export const deleteTourMemberParamsSchema = z.object({
	tourId: z
		.string({ required_error: "L'ID de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID de la tournée doit être un nombre positif",
		}),
	id: z
		.string({ required_error: "L'ID du membre de la tournée est requis" })
		.min(1)
		.refine((value) => Number(value) > 0, {
			message: "L'ID du membre de la tournée doit être un nombre positif",
		}),
})

export type DeleteTourMemberParams = z.infer<
	typeof deleteTourMemberParamsSchema
>
