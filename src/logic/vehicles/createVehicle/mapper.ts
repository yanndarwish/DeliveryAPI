import { CreateVehicleBody } from "@/api/interfaces";

export const createVehicleBodyMapper = (body: CreateVehicleBody, companyId: string) => {
    return [
        body.brand,
        body.model,
        body.immatriculation,
        body.active,
        companyId
    ];
};
