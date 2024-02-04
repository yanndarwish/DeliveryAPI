import { z } from "zod"

// GET MANY DRIVERS
export const getManyDriversQuerySchema = z.object({
    limit: z.string().min(1),
    offset: z.string().min(1),
    status: z.string().min(2).nullable().optional(),
    firstName: z.string().min(1).nullable().optional(),
    lastName: z.string().min(1).nullable().optional(),
    email: z.string().email().nullable().optional(),
    phone: z.string().min(1).nullable().optional(),
})

export type GetManyDriversQuery = z.infer<typeof getManyDriversQuerySchema>

// CREATE DRIVER
export const createDriverBodySchema = z.object({
    firstName: z.string().min(1),
    lastName: z.string().min(1),
    active: z.boolean(),
    email: z.string().email().nullable(),
    phone: z.string().min(1).nullable(),
})

export type CreateDriverBody = z.infer<typeof createDriverBodySchema>

// GET ONE DRIVER BY ID
export const getOneDriverParamsSchema = z.object({
    id: z.string().refine((value) => Number(value) > 0),
})

export type GetOneDriverParams = z.infer<typeof getOneDriverParamsSchema>

// UPDATE ONE DRIVER BY ID
export const updateOneDriverParamsSchema = z.object({
    id: z.string().refine((value) => Number(value) > 0),
})

export const updateOneDriverBodySchema = z.object({
    firstName: z.string().min(1),
    lastName: z.string().min(1),
    active: z.boolean(),
    email: z.string().email().nullable(),
    phone: z.string().min(1).nullable(),
})

export type UpdateOneDriverParams = z.infer<typeof updateOneDriverParamsSchema>
export type UpdateOneDriverBody = z.infer<typeof updateOneDriverBodySchema>

// DELETE ONE DRIVER BY ID
export const deleteOneDriverParamsSchema = z.object({
    id: z.string().refine((value) => Number(value) > 0),
})

export type DeleteOneDriverParams = z.infer<typeof deleteOneDriverParamsSchema>