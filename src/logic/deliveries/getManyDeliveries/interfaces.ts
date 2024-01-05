import { GetManyDeliveriesQuery } from "@/api/interfaces"

// extend GetManyDeliveriesQuery with companyId
export type GetManyDeliveriesQueryRaw = GetManyDeliveriesQuery & {
	companyId: string | undefined
}