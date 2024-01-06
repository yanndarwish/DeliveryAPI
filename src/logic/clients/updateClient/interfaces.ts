import { CreateClientBody } from "@/api/interfaces";

export type UpdateOneClientBody = CreateClientBody & {
    id: number,
}