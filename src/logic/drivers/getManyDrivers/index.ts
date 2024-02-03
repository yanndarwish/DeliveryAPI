import { queryAsync } from "@/lib/database"

import { GetManyDriversRequest, GetManyDriversResponse } from "@/api/interfaces"
import {
	getManyDriversQueryMapper,
	getManyDriversCountQueryMapper,
	getManyDriversResponseMapper,
} from "./mapper"
import { getManyDriversQuery, getManyDriversCountQuery } from "./query"
import { getPagination } from "@/utils/pagination"
import { DriversArrayDB } from "@/lib/database/interfaces"

export const getManyDrivers = async (
	req: GetManyDriversRequest,
	res: GetManyDriversResponse
) => {
	const companyId = req.headers["company-id"] as string

	const totalResult = await queryAsync(
		getManyDriversCountQuery,
		getManyDriversCountQueryMapper(req.query, companyId)
	)

	const total = totalResult[0][0].total as number
	const pagination = getPagination({
		offset: Number(req.query.offset),
		limit: Number(req.query.limit),
		total,
	})
	const dataResult = await queryAsync(
		getManyDriversQuery,
		getManyDriversQueryMapper(req.query, companyId)
	)

	const data = dataResult[0] as DriversArrayDB

	const response = {
		data: getManyDriversResponseMapper(data),
		pagination,
	}

	res.send(response)
}
