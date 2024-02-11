import { UpdateOneTourMemberBodyWithId } from "./interfaces";

export const updateTourMemberBodyMapper = (
    body: UpdateOneTourMemberBodyWithId
) => {
    return [
        body.id,
        body.tourId,
        body.active,
    ];
}