import { MysqlError } from "mysql"
import { Query, Params } from "express-serve-static-core"
import { IncomingHttpHeaders } from "http2"
import { Express } from "express"

import { paths, components } from "@/types/schema"

// ============================ ERRORS ============================

export type DBError = MysqlError | null

// ============================= HTTP =============================

export interface TypedRequest<T extends Query, U, V extends Params>
	extends Express.Request {
	query: T
	body: U
	params: V
	headers: IncomingHttpHeaders & {
		"company-id"?: string
	}
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
export type GetManyDeliveriesQuery =
	paths["/deliveries"]["get"]["parameters"]["query"]
export type DeliveriesArray =
	paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyDeliveriesResponseObject =
	paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyDeliveriesRequest = TypedRequest<
	GetManyDeliveriesQuery,
	never,
	never
>
export type GetManyDeliveriesResponse =
	TypedResponse<GetManyDeliveriesResponseObject>

// CREATE DELIVERY
export type CreateDeliveryBody =
	paths["/deliveries"]["post"]["requestBody"]["content"]["application/json"]
type CreateDeliveryResponseObject =
	paths["/deliveries"]["post"]["responses"][201]["content"]["application/json"]

export type CreateDeliveryRequest = TypedRequest<
	never,
	CreateDeliveryBody,
	never
>
export type CreateDeliveryResponse = TypedResponse<CreateDeliveryResponseObject>

// GET ONE DELIVERY BY ID
export type GetOneDeliveryParams =
	paths["/deliveries/{id}"]["get"]["parameters"]["path"]
export type GetOneDeliveryResponseObject =
	paths["/deliveries/{id}"]["get"]["responses"][200]["content"]["application/json"]

export type GetOneDeliveryRequest = TypedRequest<
	never,
	never,
	GetOneDeliveryParams
>
export type GetOneDeliveryResponse = TypedResponse<GetOneDeliveryResponseObject>

// UPDATE ONE DELIVERY BY ID
export type UpdateOneDeliveryParams =
	paths["/deliveries/{id}"]["put"]["parameters"]["path"]
export type UpdateOneDeliveryBody =
	paths["/deliveries/{id}"]["put"]["requestBody"]["content"]["application/json"]
type UpdateOneDeliveryResponseObject =
	paths["/deliveries/{id}"]["put"]["responses"][200]["content"]["application/json"]

export type UpdateOneDeliveryRequest = TypedRequest<
	never,
	UpdateOneDeliveryBody,
	UpdateOneDeliveryParams
>
export type UpdateOneDeliveryResponse =
	TypedResponse<UpdateOneDeliveryResponseObject>

// DELETE ONE DELIVERY BY ID
export type DeleteOneDeliveryParams =
	paths["/deliveries/{id}"]["delete"]["parameters"]["path"]
type DeleteOneDeliveryResponseObject =
	paths["/deliveries/{id}"]["delete"]["responses"][200]["content"]["application/json"]

export type DeleteOneDeliveryRequest = TypedRequest<
	never,
	never,
	DeleteOneDeliveryParams
>
export type DeleteOneDeliveryResponse =
	TypedResponse<DeleteOneDeliveryResponseObject>

// =========================== CLIENTS ============================

// GET MANY CLIENTS
export type GetManyClientsQuery =
	paths["/clients"]["get"]["parameters"]["query"]
export type ClientsArray =
	paths["/clients"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyClientsResponseObject =
	paths["/clients"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyClientsRequest = TypedRequest<
	GetManyClientsQuery,
	never,
	never
>
export type GetManyClientsResponse = TypedResponse<GetManyClientsResponseObject>

// CREATE CLIENT
export type CreateClientBody =
	paths["/clients"]["post"]["requestBody"]["content"]["application/json"]
type CreateClientResponseObject =
	paths["/clients"]["post"]["responses"][201]["content"]["application/json"]

export type CreateClientRequest = TypedRequest<never, CreateClientBody, never>
export type CreateClientResponse = TypedResponse<CreateClientResponseObject>

// GET ONE CLIENT BY ID
export type GetOneClientParams =
	paths["/clients/{id}"]["get"]["parameters"]["path"]
export type GetOneClientResponseObject =
	paths["/clients/{id}"]["get"]["responses"][200]["content"]["application/json"]

export type GetOneClientRequest = TypedRequest<never, never, GetOneClientParams>
export type GetOneClientResponse = TypedResponse<GetOneClientResponseObject>

// UPDATE ONE CLIENT BY ID
export type UpdateOneClientParams =
	paths["/clients/{id}"]["put"]["parameters"]["path"]
export type UpdateOneClientBody =
	paths["/clients/{id}"]["put"]["requestBody"]["content"]["application/json"]
type UpdateOneClientResponseObject =
	paths["/clients/{id}"]["put"]["responses"][200]["content"]["application/json"]

export type UpdateOneClientRequest = TypedRequest<
	never,
	UpdateOneClientBody,
	UpdateOneClientParams
>
export type UpdateOneClientResponse =
	TypedResponse<UpdateOneClientResponseObject>

// DELETE ONE CLIENT BY ID
export type DeleteOneClientParams =
	paths["/clients/{id}"]["delete"]["parameters"]["path"]
type DeleteOneClientResponseObject =
	paths["/clients/{id}"]["delete"]["responses"][200]["content"]["application/json"]

export type DeleteOneClientRequest = TypedRequest<
	never,
	never,
	DeleteOneClientParams
>
export type DeleteOneClientResponse =
	TypedResponse<DeleteOneClientResponseObject>

// ================================================================
// ========================== COMPONENTS ==========================
// ================================================================

export type Pickup = components["schemas"]["Pickup"]
export type PickupCreate = components["schemas"]["PickupCreate"]
