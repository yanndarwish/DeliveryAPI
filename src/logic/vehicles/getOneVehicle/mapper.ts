import { GetOneVehicleResponseObject } from "@/api/interfaces";
import { VehicleDB } from "@/lib/database/interfaces";

export const getOneVehicleResponseMapper = (
    data: VehicleDB
): GetOneVehicleResponseObject => {
    return {
        id: data.vehicle_id,
        brand: data.vehicle_brand,
        model: data.vehicle_model,
        immatriculation: data.vehicle_immatriculation,
        active: Boolean(data.vehicle_active),
    };
};