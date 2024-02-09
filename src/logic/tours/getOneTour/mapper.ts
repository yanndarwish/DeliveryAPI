import { GetOneTourResponseObject } from "@/api/interfaces"
import { TourDB } from "@/lib/database/interfaces"

export const getOneTourResponseMapper = (
	data: TourDB
): GetOneTourResponseObject => {
	return {
		id: data.tour_id,
		name: data.tour_name,
		active: Boolean(data.tour_active),
	}
}
