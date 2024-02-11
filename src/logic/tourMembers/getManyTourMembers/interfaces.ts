import { GetManyTourMembersQuery } from "@/api/interfaces"

export type GetManyTourMembersQueryWithTourId = GetManyTourMembersQuery & {
	tourId: number
}
