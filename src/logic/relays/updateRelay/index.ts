import { UpdateOneRelayRequest, UpdateOneRelayResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { updateRelayQuery } from "./query";
import { updateRelayBodyMapper } from "./mapper";
import { getOneRelayByIdQuery } from "../getOneRelay/query";

export const updateRelay = async (
    req: UpdateOneRelayRequest,
    res: UpdateOneRelayResponse
) => {
    const companyId = req.headers["company-id"] as string
    const { id } = req.params

    // check that relay exists
    const relay = await queryAsync(getOneRelayByIdQuery, [
        id,
        Number(companyId),
    ])

    if (!relay[0]?.[0]) {
        throw new NotFoundError(
            `Aucun relais n'a été trouvé avec l'identifiant: ${id}`
        )
    }

    const body = { ...req.body, id: Number(id) }

    await queryAsync(
        updateRelayQuery,
        updateRelayBodyMapper(body)
    )

    res
        .status(200)
        .send({ message: "Le relais a été mis à jour avec succès" })
}