import { z } from "zod"

export const headerSchema = z.object({
	"company-id": z.string().min(1),
})
