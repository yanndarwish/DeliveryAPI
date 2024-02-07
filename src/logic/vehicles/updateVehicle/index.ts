import { UpdateOneVehicleRequest, UpdateOneVehicleResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { updateVehicleQuery } from "./query";
import { updateVehicleBodyMapper } from "./mapper";
import { getOneVehicleByIdQuery } from "../getOneVehicle/query";

export const updateVehicle = async (
    req: UpdateOneVehicleRequest,
    res: UpdateOneVehicleResponse
) => {
    const companyId = req.headers["company-id"] as string
    const { id } = req.params

    // check that vehicle exists
    const vehicle = await queryAsync(getOneVehicleByIdQuery, [
        id,
        Number(companyId),
    ])

    if (!vehicle[0]?.[0]) {
        throw new NotFoundError(
            `Aucun véhicule n'a été trouvé avec l'identifiant: ${id}`
        )
    }

    const body = { ...req.body, id: Number(id) }

    await queryAsync(
        updateVehicleQuery,
        updateVehicleBodyMapper(body)
    )

    res
        .status(200)
        .send({ message: "Le véhicule a été mis à jour avec succès" })
}
