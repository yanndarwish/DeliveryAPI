import { UpdateOneClientBody } from "@/api/interfaces"

export type UpdateOneClientBodyWithId = UpdateOneClientBody & { id: number }
