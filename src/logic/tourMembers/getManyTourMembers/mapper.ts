import { TourMembersArray, GetManyTourMembersQuery } from "@/api/interfaces";
import { TourMembersArrayDB } from "@/lib/database/interfaces";

export const getManyTourMembersQueryMapper = (
    query: GetManyTourMembersQuery,
    tourId: string,
    companyId: string
) => {
    return [
        query.status ?? null,
        tourId,
        companyId,
        Number(query.offset),
        Number(query.limit),
    ]
}

export const getManyTourMembersCountQueryMapper = (
    query: GetManyTourMembersQuery,
    tourId: string,
    companyId: string
) => {
    return [
        query.status ?? null,
        tourId,
        companyId,
    ]
}

export const getManyTourMembersResponseMapper = (
    data: TourMembersArrayDB
): TourMembersArray => {
    return data.map((tourMember) => ({
        id: tourMember.tour_member_id,
        tourId: tourMember.tour_id,
        tourName: tourMember.tour_name,
        clientId: tourMember.client_id,
        clientName: tourMember.client_name,
        streetNumber: tourMember.address_street_number,
        streetName: tourMember.address_street,
        city: tourMember.address_city,
        postalCode: tourMember.address_postal_code,
        country: tourMember.address_country,
        active: Boolean(tourMember.tour_member_active),
    }))
}