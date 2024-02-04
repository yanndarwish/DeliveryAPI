import { UpdateOneDriverRequest, UpdateOneDriverResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { updateDriverQuery } from "./query";
import { updateDriverBodyMapper } from "./mapper";
import { getOneDriverByIdQuery } from "../getOneDriver/query";

export const updateDriver = async (
    req: UpdateOneDriverRequest,
    res: UpdateOneDriverResponse
) => {
    const companyId = req.headers["company-id"] as string
    const { id } = req.params

    // check that driver exists
    const driver = await queryAsync(getOneDriverByIdQuery, [
        id,
        Number(companyId),
    ])

    if (!driver[0]?.[0]) {
        throw new NotFoundError(
            `Aucun chauffeur n'a été trouvé avec l'identifiant: ${id}`
        )
    }

    const body = { ...req.body, id: Number(id) }

    await queryAsync(
        updateDriverQuery,
        updateDriverBodyMapper(body)
    )

    res
        .status(200)
        .send({ message: "Le chauffeur a été mis à jour avec succès" })
}