import { GetOneVehicleRequest, GetOneVehicleResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { getOneVehicleResponseMapper } from "./mapper";
import { getOneVehicleByIdQuery } from "./query";

export const getOneVehicleById = async (
    req: GetOneVehicleRequest,
    res: GetOneVehicleResponse
) => {
    const companyId = req.headers["company-id"] as string;
    const { id } = req.params;

    const result = await queryAsync(getOneVehicleByIdQuery, [
        id,
        Number(companyId),
    ]);
    const response = result[0]?.[0];

    if (!response) {
        throw new NotFoundError(
            `Aucun véhicule n'a été trouvé avec l'identifiant: ${id}`
        );
    }

    res.send(getOneVehicleResponseMapper(response));
};