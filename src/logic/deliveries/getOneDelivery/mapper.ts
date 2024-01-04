import { GetOneDeliveryResponseObject } from "@/api/interfaces"
import { DeliveryDB } from "@/lib/database/interfaces"

export const getOneDeliveryResponseMapper = (
	data: DeliveryDB
): GetOneDeliveryResponseObject => {
	return {
		id: data.delivery_id,
		driver: data.delivery_driver,
		provider: data.delivery_provider,
		vehicle: data.delivery_vehicle,
		hotelPrice: data.delivery_hotel_price,
		outsourcedTo: data.delivery_outsourced_to,
		pickups: JSON.parse(data.pickups).map((pickup: any) => {
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
		dropoffs: JSON.parse(data.dropoffs).map((dropoff: any) => {
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
		companyId: data.company_id,
	}
}
