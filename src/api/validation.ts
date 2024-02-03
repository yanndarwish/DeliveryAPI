import { z } from "zod"

export const headerSchema = z.object({
	"company-id": z
		.string()
		.min(1)
		.refine((value) => /^[0-9]+$/.test(value), {
			message: "company-id must only contain numeric characters",
		}),
})
