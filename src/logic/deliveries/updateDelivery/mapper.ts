import { UpdateOneDeliveryBody } from "./interface"

export const updateDeliveryBodyMapper = (body: UpdateOneDeliveryBody) => {
    const pickups = body.pickups.map((pickup) => {
        return {
            date: pickup.date,
            entity_id: pickup.entityId,
            entity_type: pickup.entityType,
        }
    })

    const dropoffs = body.dropoffs.map((dropoff) => {
        return {
            date: dropoff.date,
            entity_id: dropoff.entityId,
            entity_type: dropoff.entityType,
        }
    })

    return [
        body.id,
        body.companyId,
        body.driverId,
        body.vehicleId,
        body.providerId,
        body.hotelPrice,
        JSON.stringify(pickups),
        JSON.stringify(dropoffs),
        body.outsourcedTo,
    ]
}