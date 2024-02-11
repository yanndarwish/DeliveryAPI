import {
	GetManyTourMembersRequest,
	GetManyTourMembersResponse,
} from "@/api/interfaces"
import { TourMembersArrayDB } from "@/lib/database/interfaces"
import { queryAsync } from "@/lib/database"

import { getPagination } from "@/utils/pagination"

import {
	getManyTourMembersQueryMapper,
	getManyTourMembersCountQueryMapper,
	getManyTourMembersResponseMapper,
} from "./mapper"
import { getManyTourMembersQuery, getManyTourMembersCountQuery } from "./query"

export const getManyTourMembers = async (
    req: GetManyTourMembersRequest,
    res: GetManyTourMembersResponse
) => {
    const companyId = req.headers["company-id"] as string
    const tourId = req.params.tourId

    const totalResult = await queryAsync(
        getManyTourMembersCountQuery,
        getManyTourMembersCountQueryMapper(req.query, tourId, companyId)
    )

    const total = totalResult[0][0].total as number
    const pagination = getPagination({
        offset: Number(req.query.offset),
        limit: Number(req.query.limit),
        total,
    })
    const dataResult = await queryAsync(
        getManyTourMembersQuery,
        getManyTourMembersQueryMapper(req.query, tourId, companyId)
    )

    const data = dataResult[0] as TourMembersArrayDB

    const response = {
        data: getManyTourMembersResponseMapper(data),
        pagination,
    }

    res.send(response)
}
