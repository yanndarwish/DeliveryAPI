import { TourMembersArray } from "@/api/interfaces"
import { TourMembersArrayDB } from "@/lib/database/interfaces"

import { GetActiveTourMembersAtDateQueryWithTourId } from "./interfaces"

export const getActiveTourMembersAtDateQueryMapper = (
	query: GetActiveTourMembersAtDateQueryWithTourId,
	companyId: string
) => {
	return [query.tourId, companyId, query.date]
}

export const idTypeConverter = (ids: string): number[] => {
	const idsArray = JSON.parse(ids)
	return idsArray.map((id: string) => Number(id))
}

export const getActiveTourMembersAtDateResponseMapper = (
	data: TourMembersArrayDB
): TourMembersArray => {
	return data.map((tourMember) => ({
		id: tourMember.tour_member_id,
		tourId: tourMember.tour_id,
		tourName: tourMember.tour_name,
		clientId: tourMember.client_id,
		clientName: tourMember.client_name,
		streetNumber: tourMember.address_street_number,
		streetName: tourMember.address_street,
		city: tourMember.address_city,
		postalCode: tourMember.address_postal_code,
		country: tourMember.address_country,
		active: Boolean(tourMember.tour_member_active),
	}))
}
