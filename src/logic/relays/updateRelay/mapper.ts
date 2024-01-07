import { UpdateOneRelayBodyWithId } from "./interfaces"

export const updateRelayBodyMapper = (body: UpdateOneRelayBodyWithId) => {
	return [
		body.id,
		body.name,
		body.streetNumber,
		body.street,
		body.city,
		body.postalCode,
		body.country,
		body.comment,
		body.active,
	]
}
