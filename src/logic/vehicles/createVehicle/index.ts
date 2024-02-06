import { CreateVehicleRequest, CreateVehicleResponse } from "@/api/interfaces";

import { queryAsync } from "@/lib/database";

import { createVehicleQuery } from "./query";
import { createVehicleBodyMapper } from "./mapper";

export const createVehicle = async (
    req: CreateVehicleRequest,
    res: CreateVehicleResponse
) => {
    const companyId = req.headers["company-id"] as string;

    await queryAsync(
        createVehicleQuery,
        createVehicleBodyMapper(req.body, companyId)
    );

    res.status(201).send({ message: "Véhicule créé avec succès" });
};