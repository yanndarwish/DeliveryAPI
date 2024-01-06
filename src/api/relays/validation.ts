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