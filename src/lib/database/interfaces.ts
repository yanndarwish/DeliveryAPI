// ======================== DELIVERIES =========================
export type DeliveryDB = {
	delivery_id: number
	delivery_driver: string
	delivery_provider: string
	delivery_vehicle: string
	delivery_hotel_price: number
	delivery_outsourced_to: string
	pickups: string
	dropoffs: string
	company_id: number
}

export type DeliveriesArrayDB = DeliveryDB[]

// ========================== CLIENTS ==========================
export type ClientDB = {
	client_id: number
	client_name: string
	address_street_number: string
	address_street: string
	address_city: string
	address_postal_code: string
	address_country: string
	address_comment: string
	client_active: boolean
	phone: string
	email: string
}

export type ClientsArrayDB = ClientDB[]