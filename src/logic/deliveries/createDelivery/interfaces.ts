import { CreateDeliveryBody } from "@/api/interfaces"

export type CreateDeliveryBodyRaw = CreateDeliveryBody & {
	companyId: string | undefined
}
