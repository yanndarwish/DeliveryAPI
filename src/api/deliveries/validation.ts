import { z } from "zod";

export const getManyDeliveriesQuerySchema = z.object({
    limit: z.string(),
    offset: z.string(),
    driver: z.string().nullable().optional(),
    provider: z.string().nullable().optional(),
    vehicle: z.string().nullable().optional(),
    day: z.string().nullable().optional(),
    month: z.string().nullable().optional(),
    year: z.string().nullable().optional(),
});

export type GetManyDeliveriesQuery = z.infer<typeof getManyDeliveriesQuerySchema>;
