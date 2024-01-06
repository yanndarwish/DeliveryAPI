import { UpdateOneClientRequest, UpdateOneClientResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { updateClientQuery } from "./query";
import { updateClientBodyMapper } from "./mapper";
import { getOneClientByIdQuery } from "../getOneClient/query";

export const updateClient = async (
    req: UpdateOneClientRequest,
    res: UpdateOneClientResponse
) => {
    const companyId = req.headers["company-id"] as string
    const { id } = req.params

    // check that client exists
    const client = await queryAsync(getOneClientByIdQuery, [
        id,
        Number(companyId),
    ])

    if (!client[0]?.[0]) {
        throw new NotFoundError(
            `Aucun client n'a été trouvé avec l'identifiant: ${id}`
        )
    }

    const body = { ...req.body, id: Number(id) }

    await queryAsync(
        updateClientQuery,
        updateClientBodyMapper(body)
    )

    res
        .status(200)
        .send({ message: "Le client a été mis à jour avec succès" })
}