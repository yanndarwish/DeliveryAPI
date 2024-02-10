import { DeleteOneTourRequest, DeleteOneTourResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { getOneTourQuery } from "../getOneTour/query";
import { softDeleteTourQuery } from "./query"

export const deleteTour = async (
    req: DeleteOneTourRequest,
    res: DeleteOneTourResponse
) => {
    const companyId = req.headers["company-id"] as string;
    const { id } = req.params;

    // check that tour exists
    const tour = await queryAsync(getOneTourQuery, [
        id,
        Number(companyId),
    ]);

    if (!tour[0]?.[0]) {
        throw new NotFoundError(
            `Aucune tournée n'a été trouvée avec l'identifiant: ${id}`
        );
    }

    await queryAsync(softDeleteTourQuery, [id]);

    res.send({
        message: `La tournée avec l'identifiant ${id} a été supprimé avec succès`,
    });
};