import { GetOneClientResponseObject } from "@/api/interfaces"
import { ClientDB } from "@/lib/database/interfaces"

export const getOneClientResponseMapper = (
	data: ClientDB
): GetOneClientResponseObject => {
	return {
		id: data.client_id,
		name: data.client_name,
		streetNumber: data.address_street_number,
		street: data.address_street,
		city: data.address_city,
		postalCode: data.address_postal_code,
		country: data.address_country,
		comment: data.address_comment,
		active: Boolean(data.client_active),
		phone: data.phone,
		email: data.email,
	}
}
