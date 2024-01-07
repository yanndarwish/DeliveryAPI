import { UpdateOneClientBodyWithId } from "./interfaces"

export const updateClientBodyMapper = (body: UpdateOneClientBodyWithId) => {
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
		body.phone,
		body.email,
	]
}
