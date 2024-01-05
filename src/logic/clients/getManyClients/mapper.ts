import { ClientsArray, GetManyClientsQuery } from "@/api/interfaces";
import { ClientsArrayDB } from "@/lib/database/interfaces";
export const getManyClientsQueryMapper = (query: GetManyClientsQuery) => {
    return [
        Number(query.offset),
        Number(query.limit),
        query.status ?? null,
        query.name ?? null,
        query.city ?? null,
        query.postalCode ?? null,
        query.country ?? null,
    ];
};

export const getManyClientsCountQueryMapper = (
    query: GetManyClientsQuery
) => {
    return [
        query.status ?? null,
        query.name ?? null,
        query.city ?? null,
        query.postalCode ?? null,
        query.country ?? null,
    ];
}

export const getManyClientsResponseMapper = (
    data: ClientsArrayDB
): ClientsArray => {
    return data.map((client) => ({
        id: client.client_id,
        name: client.client_name,
        streetNumber: client.address_street_number,
        street: client.address_street,
        city: client.address_city,
        postalCode: client.address_postal_code,
        country: client.address_country,
        comment: client.address_comment,
        active: Boolean(client.client_active),
        phone: client.phone,
        email: client.email,
    }));
};