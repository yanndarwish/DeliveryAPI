import {
	GetActiveTourMembersAtDateRequest,
	GetActiveTourMembersAtDateResponse,
} from "@/api/interfaces"
import { TourMembersArrayDB } from "@/lib/database/interfaces"
import { queryAsync } from "@/lib/database"

import { getOneTourMemberQuery } from "../getOneTourMember/query"

import {
	getActiveTourMembersAtDateQueryMapper,
	getActiveTourMembersAtDateResponseMapper,
	idTypeConverter,
} from "./mapper"
import { getActiveTourMembersAtDateQuery } from "./query"

export const getActiveTourMembersAtDate = async (
	req: GetActiveTourMembersAtDateRequest,
	res: GetActiveTourMembersAtDateResponse
) => {
	const companyId = req.headers["company-id"] as string
	const tourId = req.params.tourId

	const query = { ...req.query, tourId: Number(tourId) }

	// get ids of tour members that are active at the given date
	const idsData = await queryAsync(
		getActiveTourMembersAtDateQuery,
		getActiveTourMembersAtDateQueryMapper(query, companyId)
	)

	const activeIds = idTypeConverter(idsData[1][0]["@active_tour_members"])

	// loop over the active ids and get the tour members data
	const activeMembers: TourMembersArrayDB = []

    // for loop supports async/await
	for (const id of activeIds) {
		const data = await queryAsync(getOneTourMemberQuery, [
			id,
			tourId,
			companyId,
		])
		activeMembers.push(data[0][0])
	}

	const response = {
		data: getActiveTourMembersAtDateResponseMapper(activeMembers),
	}

	res.send(response)
}
