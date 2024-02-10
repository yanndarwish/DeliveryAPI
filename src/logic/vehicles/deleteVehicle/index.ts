import { DeleteOneVehicleRequest, DeleteOneVehicleResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { getOneVehicleByIdQuery } from "../getOneVehicle/query";
import { deleteOneVehicleQuery } from "./query";

export const deleteOneVehicleById = async (
    req: DeleteOneVehicleRequest,
    res: DeleteOneVehicleResponse
) => {
    const companyId = req.headers["company-id"] as string;
    const { id } = req.params;

    // check that vehicle exists
    const vehicle = await queryAsync(getOneVehicleByIdQuery, [
        id,
        Number(companyId),
    ]);

    if (!vehicle[0]?.[0]) {
        throw new NotFoundError(
            `Aucun véhicule n'a été trouvé avec l'identifiant: ${id}`
        );
    }

    await queryAsync(deleteOneVehicleQuery, [id]);

    res.send({
        message: `Le véhicule avec l'identifiant ${id} a été supprimé avec succès`,
    });
};