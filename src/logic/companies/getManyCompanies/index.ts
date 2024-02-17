import {
	GetManyCompaniesRequest,
	GetManyCompaniesResponse,
} from "@/api/interfaces"
import { CompaniesArrayDB } from "@/lib/database/interfaces"
import { queryAsync } from "@/lib/database"

import { getPagination } from "@/utils/pagination"

import {
	getManyCompaniesQueryMapper,
	getManyCompaniesCountQueryMapper,
	getManyCompaniesResponseMapper,
} from "./mapper"
import { getManyCompaniesQuery, getManyCompaniesCountQuery } from "./query"

export const getManyCompanies = async (
	req: GetManyCompaniesRequest,
	res: GetManyCompaniesResponse
) => {
	const totalResult = await queryAsync(
		getManyCompaniesCountQuery,
		getManyCompaniesCountQueryMapper(req.query)
	)

	const total = totalResult[0][0].total as number
	const pagination = getPagination({
		offset: Number(req.query.offset),
		limit: Number(req.query.limit),
		total,
	})

	const dataResult = await queryAsync(
		getManyCompaniesQuery,
		getManyCompaniesQueryMapper(req.query)
	)

	const data = dataResult[0] as CompaniesArrayDB

	const response = {
		data: getManyCompaniesResponseMapper(data),
		pagination,
	}

	res.send(response)
}
