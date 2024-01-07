import { GetOneRelayResponseObject } from "@/api/interfaces"
import { RelayDB } from "@/lib/database/interfaces"

export const getOneRelayResponseMapper = (
	data: RelayDB
): GetOneRelayResponseObject => {
	return {
		id: data.relay_id,
		name: data.relay_name,
		streetNumber: data.address_street_number,
		street: data.address_street,
		city: data.address_city,
		postalCode: data.address_postal_code,
		country: data.address_country,
		comment: data.address_comment,
		active: Boolean(data.relay_active),
	}
}
