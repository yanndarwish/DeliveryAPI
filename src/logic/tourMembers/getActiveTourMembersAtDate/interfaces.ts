import { GetActiveTourMembersAtDateQuery } from "@/api/interfaces";

export type GetActiveTourMembersAtDateQueryWithTourId = GetActiveTourMembersAtDateQuery & {
    tourId: number
}