import { DeleteOneTourMemberRequest, DeleteOneTourMemberResponse } from "@/api/interfaces";
import { NotFoundError } from "@/lib/errors/notFoundError";
import { queryAsync } from "@/lib/database";

import { getOneTourMemberQuery } from "../getOneTourMember/query";
import { deleteTourMemberQuery } from "./query";

export const deleteTourMember = async (
    req: DeleteOneTourMemberRequest,
    res: DeleteOneTourMemberResponse
) => {
    const companyId = req.headers["company-id"] as string;
    const { id, tourId } = req.params;

    // check that tour exists
    const tourMember = await queryAsync(getOneTourMemberQuery, [
        id,
        tourId,
        Number(companyId),
    ]);

    if (!tourMember[0]?.[0]) {
        throw new NotFoundError(
            `Aucun membre de la tournée ${tourId} n'a été trouvé avec l'identifiant: ${id}`
        );
    }

    await queryAsync(deleteTourMemberQuery, [id]);

    res.send({
        message: `Le membre de la tournée avec l'identifiant ${id} a été supprimé avec succès`,
    });
};