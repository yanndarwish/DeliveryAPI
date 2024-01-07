// ======================== DELIVERIES =========================
export type DeliveryDB = {
	delivery_id: number
	delivery_driver: string
	delivery_provider: string
	delivery_vehicle: string
	delivery_hotel_price: number | null
	delivery_outsourced_to: string | null
	pickups: string
	dropoffs: string
	company_id: number
}

export type DeliveriesArrayDB = DeliveryDB[]

// ========================== CLIENTS ==========================
export type ClientDB = {
	client_id: number
	client_name: string
	address_street_number: string | null
	address_street: string
	address_city: string
	address_postal_code: string | null
	address_country: string
	address_comment: string | null
	client_active: boolean
	phone: string | null
	email: string | null
}

export type ClientsArrayDB = ClientDB[]

// ========================== RELAYS ===========================
export type RelayDB = {
	relay_id: number
	relay_name: string
	address_street_number: string | null
	address_street: string
	address_city: string
	address_postal_code: string | null
	address_country: string
	address_comment: string | null
	relay_active: boolean
}

export type RelaysArrayDB = RelayDB[]