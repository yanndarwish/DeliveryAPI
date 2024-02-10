import { UpdateOneVehicleBodyWithId } from "./interfaces"

export const updateVehicleBodyMapper = (body: UpdateOneVehicleBodyWithId) => {
	return [body.id, body.brand, body.model, body.immatriculation, body.active]
}
