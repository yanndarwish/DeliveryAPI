import { DriversArray, GetManyDriversQuery } from "@/api/interfaces"
import { DriversArrayDB } from "@/lib/database/interfaces"

export const getManyDriversQueryMapper = (
	query: GetManyDriversQuery,
	companyId: string
) => {
	return [
		Number(query.offset),
		Number(query.limit),
		query.status ?? null,
		query.firstName ?? null,
		query.lastName ?? null,
		query.email ?? null,
		query.phone ?? null,
		companyId,
	]
}

export const getManyDriversCountQueryMapper = (
	query: GetManyDriversQuery,
	companyId: string
) => {
	return [
		query.status ?? null,
		query.firstName ?? null,
		query.lastName ?? null,
		query.email ?? null,
		query.phone ?? null,
		companyId,
	]
}

export const getManyDriversResponseMapper = (
	data: DriversArrayDB
): DriversArray => {
	return data.map((driver) => ({
		id: driver.driver_id,
		firstName: driver.driver_first_name,
		lastName: driver.driver_last_name,
		phone: driver.phone,
		email: driver.email,
		active: Boolean(driver.driver_active),
	}))
}
