import { PickupCreate } from "@/api/interfaces"

export interface UpdateOneDeliveryBody {
    id: number
    companyId: number
    driverId: number
    vehicleId: number
    providerId: number
    hotelPrice?: number
    pickups: PickupCreate[]
    dropoffs: PickupCreate[]
    outsourcedTo?: number
}