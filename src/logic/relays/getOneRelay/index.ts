import { GetOneRelayRequest, GetOneRelayResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { getOneRelayResponseMapper } from "./mapper";
import { getOneRelayByIdQuery } from "./query";

export const getOneRelayById = async (
    req: GetOneRelayRequest,
    res: GetOneRelayResponse
) => {
    const companyId = req.headers["company-id"] as string;
    const { id } = req.params;

    const result = await queryAsync(getOneRelayByIdQuery, [
        id,
        Number(companyId),
    ]);
    const response = result[0]?.[0];

    if (!response) {
        throw new NotFoundError(
            `Aucun relais n'a été trouvé avec l'identifiant: ${id}`
        );
    }

    res.send(getOneRelayResponseMapper(response));
};