import { queryAsync } from "@/lib/database"

import {
	GetManyDeliveriesRequest,
	GetManyDeliveriesResponse,
} from "@/api/interfaces"
import {
	getManyDeliveriesQueryMapper,
	getManyDeliveriesCountQueryMapper,
	getManyDeliveriesResponseMapper,
} from "./mapper"
import { getManyDeliveriesQuery, getManyDeliveriesCountQuery } from "./query"
import { getPagination } from "@/utils/pagination"
import { DeliveriesArrayDB } from "@/lib/database/interfaces"

export const getManyDeliveries = async (
	req: GetManyDeliveriesRequest,
	res: GetManyDeliveriesResponse,
) => {
	const totalResult = await queryAsync(
		getManyDeliveriesCountQuery,
		getManyDeliveriesCountQueryMapper(req.query)
	)

	const total = totalResult[0][0].total as number
	const pagination = getPagination({
		offset: Number(req.query.offset),
		limit: Number(req.query.limit),
		total,
	})

	const dataResult = await queryAsync(
		getManyDeliveriesQuery,
		getManyDeliveriesQueryMapper(req.query)
	)

	const data = dataResult[0] as DeliveriesArrayDB

	const response = {
		data: getManyDeliveriesResponseMapper(data),
		pagination,
	}

	res.send(response)
}
