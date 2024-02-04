import { UpdateOneDriverBodyWithId } from "./interfaces"

export const updateDriverBodyMapper = (body: UpdateOneDriverBodyWithId) => {
	return [
		body.id,
		body.firstName,
		body.lastName,
		body.active,
		body.email,
		body.phone,
	]
}
