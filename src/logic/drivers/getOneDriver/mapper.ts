import { GetOneDriverResponseObject } from "@/api/interfaces"
import { DriverDB } from "@/lib/database/interfaces"

export const getOneDriverResponseMapper = (
	data: DriverDB
): GetOneDriverResponseObject => {
	return {
		id: data.driver_id,
		firstName: data.driver_first_name,
		lastName: data.driver_last_name,
		email: data.email,
		phone: data.phone,
		active: Boolean(data.driver_active),
	}
}
