import { z } from "zod"

// GET MANY VEHICLES
export const getManyVehiclesQuerySchema = z.object({
    limit: z.string().min(1),
    offset: z.string().min(1),
    status: z.string().min(2).nullable().optional(),
    brand: z.string().min(1).nullable().optional(),
    model: z.string().min(1).nullable().optional(),
    immatriculation: z.string().min(1).nullable().optional(),
})

export type GetManyVehiclesQuery = z.infer<typeof getManyVehiclesQuerySchema>