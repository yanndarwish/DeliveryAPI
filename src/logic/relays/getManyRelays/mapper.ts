import { RelaysArray, GetManyRelaysQuery } from "@/api/interfaces";
import { RelaysArrayDB } from "@/lib/database/interfaces";

export const getManyRelaysQueryMapper = (
    query: GetManyRelaysQuery,
    companyId: string
) => {
    return [
        Number(query.offset),
        Number(query.limit),
        query.status ?? null,
        query.name ?? null,
        query.city ?? null,
        query.postalCode ?? null,
        query.country ?? null,
        companyId,
    ];
};

export const getManyRelaysCountQueryMapper = (
    query: GetManyRelaysQuery,
    companyId: string
) => {
    return [
        query.status ?? null,
        query.name ?? null,
        query.city ?? null,
        query.postalCode ?? null,
        query.country ?? null,
        companyId,
    ];
};

export const getManyRelaysResponseMapper = (
    data: RelaysArrayDB
): RelaysArray => {
    return data.map((relay) => ({
        id: relay.relay_id,
        name: relay.relay_name,
        streetNumber: relay.address_street_number,
        street: relay.address_street,
        city: relay.address_city,
        postalCode: relay.address_postal_code,
        country: relay.address_country,
        comment: relay.address_comment,
        active: Boolean(relay.relay_active)
    }));
}
