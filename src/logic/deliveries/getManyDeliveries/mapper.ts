import { DeliveriesArray, GetManyDeliveriesQuery } from "@/api/interfaces"
import { DeliveriesArrayDB } from "@/lib/database/interfaces"

export const getManyDeliveriesQueryMapper = (
	query: GetManyDeliveriesQuery,
	companyId: string
) => {
	return [
		Number(query.offset),
		Number(query.limit),
		Number(companyId),
		query.driver ?? null,
		query.provider ?? null,
		query.vehicle ?? null,
		query.day ?? null,
		query.month ?? null,
		query.year ?? null,
	]
}

export const getManyDeliveriesCountQueryMapper = (
	query: GetManyDeliveriesQuery,
	companyId: string
) => {
	return [
		Number(companyId),
		query.driver ?? null,
		query.provider ?? null,
		query.vehicle ?? null,
		query.day ?? null,
		query.month ?? null,
		query.year ?? null,
	]
}

export const getManyDeliveriesResponseMapper = (
	data: DeliveriesArrayDB
): DeliveriesArray => {
	return data.map((delivery) => ({
		id: delivery.delivery_id,
		driver: delivery.delivery_driver,
		provider: delivery.delivery_provider,
		vehicle: delivery.delivery_vehicle,
		hotelPrice: delivery.delivery_hotel_price,
		outsourcedTo: delivery.delivery_outsourced_to,
		pickups: JSON.parse(delivery.pickups).map((pickup: any) => {
			console.log(pickup)
			return {
				date: pickup.date,
				infos: {
					id: pickup.entity_info.entity_id,
					name: pickup.entity_info.entity_name,
					streetNumber: pickup.entity_info.address_street_number,
					street: pickup.entity_info.address_street,
					city: pickup.entity_info.address_city,
					postalCode: pickup.entity_info.address_postal_code,
					country: pickup.entity_info.address_country,
					comment: pickup.entity_info.address_comment,
					active: Boolean(pickup.entity_info.entity_active),
					type: pickup.entity_info.entity_type,
				},
			}
		}),
		dropoffs: JSON.parse(delivery.dropoffs).map((dropoff: any) => {
			return {
				date: dropoff.date,
				infos: {
					id: dropoff.entity_info.entity_id,
					name: dropoff.entity_info.entity_name,
					streetNumber: dropoff.entity_info.address_street_number,
					street: dropoff.entity_info.address_street,
					city: dropoff.entity_info.address_city,
					postalCode: dropoff.entity_info.address_postal_code,
					country: dropoff.entity_info.address_country,
					comment: dropoff.entity_info.address_comment,
					active: Boolean(dropoff.entity_info.entity_active),
					type: dropoff.entity_info.entity_type,
				},
			}
		}),
		companyId: delivery.company_id,
	}))
}
