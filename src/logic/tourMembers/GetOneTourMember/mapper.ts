import { GetOneTourMemberResponseObject } from "@/api/interfaces"
import { TourMemberDB } from "@/lib/database/interfaces"

export const getOneTourMemberResponseMapper = (
	data: TourMemberDB
): GetOneTourMemberResponseObject => {
	return {
		id: data.tour_member_id,
		tourId: data.tour_id,
		tourName: data.tour_name,
		clientId: data.client_id,
		clientName: data.client_name,
		streetNumber: data.address_street_number,
		streetName: data.address_street,
		city: data.address_city,
		postalCode: data.address_postal_code,
		country: data.address_country,
		active: Boolean(data.tour_member_active),
	}
}
