import { z } from "zod"

// GET MANY TOURS
export const getManyToursQuerySchema = z.object({
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
})

export type GetManyToursQuery = z.infer<typeof getManyToursQuerySchema>