import { VehiclesArray, GetManyVehiclesQuery } from "@/api/interfaces"
import { VehiclesArrayDB } from "@/lib/database/interfaces"

export const getManyVehiclesQueryMapper = (
	query: GetManyVehiclesQuery,
	companyId: string
) => {
	return [
		Number(query.offset),
		Number(query.limit),
		query.status ?? null,
		query.brand ?? null,
		query.model ?? null,
		query.immatriculation ?? null,
		companyId,
	]
}

export const getManyVehiclesResponseMapper = (
	data: VehiclesArrayDB
): VehiclesArray => {
	return data.map((vehicle) => ({
		id: vehicle.vehicle_id,
		brand: vehicle.vehicle_brand,
		model: vehicle.vehicle_model,
		immatriculation: vehicle.vehicle_immatriculation,
		active: vehicle.vehicle_active,
	}))
}

export const getManyVehiclesCountQueryMapper = (
    query: GetManyVehiclesQuery,
    companyId: string
) => {
    return [
        query.status ?? null,
        query.brand ?? null,
        query.model ?? null,
        query.immatriculation ?? null,
        companyId,
    ]
}