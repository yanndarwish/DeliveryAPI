import { ToursArray, GetManyToursQuery } from "@/api/interfaces";
import { ToursArrayDB } from "@/lib/database/interfaces";

export const getManyToursQueryMapper = (
    query: GetManyToursQuery,
    companyId: string
) => {
    return [
        Number(query.offset),
        Number(query.limit),
        query.status ?? null,
        query.name ?? null,
        companyId,
    ]
}

export const getManyToursCountQueryMapper = (
    query: GetManyToursQuery,
    companyId: string
) => {
    return [
        query.status ?? null,
        query.name ?? null,
        companyId,
    ]
}

export const getManyToursResponseMapper = (
    data: ToursArrayDB
): ToursArray => {
    return data.map((tour) => ({
        id: tour.tour_id,
        name: tour.tour_name,
        active: Boolean(tour.tour_active),
    }))
}