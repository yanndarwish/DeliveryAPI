export type DeliveryDB = {
    delivery_id: number;
    delivery_driver: string;
    delivery_provider: string;
    delivery_vehicle: string;
    delivery_hotel_price: number;
    delivery_outsourced_to: string;
    pickups: string;
    dropoffs: string;
    company_id: number;
}

export type DeliveriesArrayDB = DeliveryDB[]
