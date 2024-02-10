import { UpdateOneTourBodyWithId } from "./interfaces"

export const updateTourBodyMapper = (
	body: UpdateOneTourBodyWithId,
	companyId: string
) => {
	return [
		body.id,
		body.name,
		body.active,
		companyId,
		JSON.stringify(body.clientIds),
	]
}
