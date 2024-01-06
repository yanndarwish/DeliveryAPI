import { CreateDeliveryBody } from "@/api/interfaces"


export type UpdateOneDeliveryBody = CreateDeliveryBody & {
    id: number,
}