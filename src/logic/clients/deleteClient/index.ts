import { DeleteOneClientRequest, DeleteOneClientResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { deleteOneClientQuery } from "./query";
import { getOneClientByIdQuery } from "../getOneClient/query";

export const deleteOneClientById = async (
    req: DeleteOneClientRequest,
    res: DeleteOneClientResponse
) => {
    const companyId = req.headers["company-id"] as string;
    const { id } = req.params;

    // check that client exists
    const client = await queryAsync(getOneClientByIdQuery, [
        id,
        Number(companyId),
    ]);

    if (!client[0]?.[0]) {
        throw new NotFoundError(
            `Aucun client n'a été trouvé avec l'identifiant: ${id}`
        );
    }

    await queryAsync(deleteOneClientQuery, [id]);

    res.send({
        message: `Le client avec l'identifiant ${id} a été supprimé avec succès`,
    });
};