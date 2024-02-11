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

// ========================== DRIVERS ==========================
export type DriverDB = {
	driver_id: number
	driver_first_name: string
	driver_last_name: string
	driver_active: boolean
	email: string | null
	phone: string | null
}

export type DriversArrayDB = DriverDB[]

// ========================== VEHICLES =========================
export type VehicleDB = {
	vehicle_id: number
	vehicle_brand: string
	vehicle_model: string
	vehicle_immatriculation: string
	vehicle_active: boolean
}

export type VehiclesArrayDB = VehicleDB[]

// ========================== TOURS ============================
export type TourDB = {
	tour_id: number
	tour_name: string
	tour_active: boolean
}

export type ToursArrayDB = TourDB[]

// ===================== TOUR MEMBERS ==========================

export type TourMemberDB = {
	tour_member_id: number
	tour_id: number
	tour_name: string
	client_id: number
	client_name: string
	address_street_number: string | null
	address_street: string
	address_city: string
	address_postal_code: string | null
	address_country: string
	tour_member_active: string
}

export type TourMembersArrayDB = TourMemberDB[]