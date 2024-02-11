import { UpdateOneTourMemberBody } from "@/api/interfaces";

export type UpdateOneTourMemberBodyWithId = UpdateOneTourMemberBody & { tourId: number, id: number }
