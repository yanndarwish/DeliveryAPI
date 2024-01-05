import { MysqlError } from "mysql"
import { Query, Params } from "express-serve-static-core"
import { Express } from "express"

import { paths, components } from "@/types/schema"

// ============================ ERRORS ============================

export type DBError = MysqlError | null;

// ============================= HTTP =============================

export interface TypedRequest<T extends Query, U, V extends Params> extends Express.Request {
	query: T
	body: U
    params: V
}

export interface TypedResponse<T> extends Express.Response {
    status: (code: number) => TypedResponse<T>
    send: (body: T) => TypedResponse<T>
}
// ================================================================
// ============================ COMMON ============================
// ================================================================

export interface Pagination {
	currentPage: number
	totalPages: number
	hasNextPage: boolean
    hasPreviousPage: boolean
    totalItems: number
}

export type Data = any[] | {}

export interface ListResponseObject {
    data: Data
    pagination: Pagination
}

// ================================================================
// ============================ METIER ============================
// ================================================================

// ========================== DELIVERIES ==========================

// GET MANY DELIVERIES
export type GetManyDeliveriesQuery = paths["/deliveries"]["get"]["parameters"]["query"]
export type DeliveriesArray = paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyDeliveriesResponseObject = paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyDeliveriesRequest = TypedRequest<GetManyDeliveriesQuery, never, never>
export type GetManyDeliveriesResponse = TypedResponse<GetManyDeliveriesResponseObject>

// CREATE DELIVERY
export type CreateDeliveryBody = paths["/deliveries"]["post"]["requestBody"]["content"]["application/json"]
type CreateDeliveryResponseObject = paths["/deliveries"]["post"]["responses"][201]["content"]["application/json"]

export type CreateDeliveryRequest = TypedRequest<never, CreateDeliveryBody, never>
export type CreateDeliveryResponse = TypedResponse<CreateDeliveryResponseObject>

// GET ONE DELIVERY BY ID
export type GetOneDeliveryParams = paths["/deliveries/{id}"]["get"]["parameters"]["path"]
export type GetOneDeliveryResponseObject = paths["/deliveries/{id}"]["get"]["responses"][200]["content"]["application/json"]

export type GetOneDeliveryRequest = TypedRequest<never, never, GetOneDeliveryParams>
export type GetOneDeliveryResponse = TypedResponse<GetOneDeliveryResponseObject>

// UPDATE ONE DELIVERY BY ID
export type UpdateOneDeliveryParams = paths["/deliveries/{id}"]["put"]["parameters"]["path"]
export type UpdateOneDeliveryBody = paths["/deliveries/{id}"]["put"]["requestBody"]["content"]["application/json"]
type UpdateOneDeliveryResponseObject = paths["/deliveries/{id}"]["put"]["responses"][200]["content"]["application/json"]

export type UpdateOneDeliveryRequest = TypedRequest<never, UpdateOneDeliveryBody, UpdateOneDeliveryParams>
export type UpdateOneDeliveryResponse = TypedResponse<UpdateOneDeliveryResponseObject>

// DELETE ONE DELIVERY BY ID
export type DeleteOneDeliveryParams = paths["/deliveries/{id}"]["delete"]["parameters"]["path"]
type DeleteOneDeliveryResponseObject = paths["/deliveries/{id}"]["delete"]["responses"][200]["content"]["application/json"]

export type DeleteOneDeliveryRequest = TypedRequest<never, never, DeleteOneDeliveryParams>
export type DeleteOneDeliveryResponse = TypedResponse<DeleteOneDeliveryResponseObject>

// =========================== CLIENTS ============================

// GET MANY CLIENTS
export type GetManyClientsQuery = paths["/clients"]["get"]["parameters"]["query"]
export type ClientsArray = paths["/clients"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyClientsResponseObject = paths["/clients"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyClientsRequest = TypedRequest<GetManyClientsQuery, never, never>
export type GetManyClientsResponse = TypedResponse<GetManyClientsResponseObject>

// ================================================================
// ========================== COMPONENTS ==========================
// ================================================================

export type Pickup = components["schemas"]["Pickup"]
export type PickupCreate = components["schemas"]["PickupCreate"]
