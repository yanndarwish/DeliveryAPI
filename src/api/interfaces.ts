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

// =========================== RELAYS =============================

// GET MANY RELAYS
export type GetManyRelaysQuery = paths["/relays"]["get"]["parameters"]["query"]
export type RelaysArray =
	paths["/relays"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyRelaysResponseObject =
	paths["/relays"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyRelaysRequest = TypedRequest<
	GetManyRelaysQuery,
	never,
	never
>
export type GetManyRelaysResponse = TypedResponse<GetManyRelaysResponseObject>

// CREATE RELAY
export type CreateRelayBody =
	paths["/relays"]["post"]["requestBody"]["content"]["application/json"]
type CreateRelayResponseObject =
	paths["/relays"]["post"]["responses"][201]["content"]["application/json"]

export type CreateRelayRequest = TypedRequest<never, CreateRelayBody, never>
export type CreateRelayResponse = TypedResponse<CreateRelayResponseObject>

// GET ONE RELAY BY ID
export type GetOneRelayParams =
	paths["/relays/{id}"]["get"]["parameters"]["path"]
export type GetOneRelayResponseObject =
	paths["/relays/{id}"]["get"]["responses"][200]["content"]["application/json"]

export type GetOneRelayRequest = TypedRequest<never, never, GetOneRelayParams>
export type GetOneRelayResponse = TypedResponse<GetOneRelayResponseObject>

// UPDATE ONE RELAY BY ID
export type UpdateOneRelayParams =
	paths["/relays/{id}"]["put"]["parameters"]["path"]
export type UpdateOneRelayBody =
	paths["/relays/{id}"]["put"]["requestBody"]["content"]["application/json"]
type UpdateOneRelayResponseObject =
	paths["/relays/{id}"]["put"]["responses"][200]["content"]["application/json"]

export type UpdateOneRelayRequest = TypedRequest<
	never,
	UpdateOneRelayBody,
	UpdateOneRelayParams
>
export type UpdateOneRelayResponse = TypedResponse<UpdateOneRelayResponseObject>

// DELETE ONE RELAY BY ID
export type DeleteOneRelayParams =
	paths["/relays/{id}"]["delete"]["parameters"]["path"]
type DeleteOneRelayResponseObject =
	paths["/relays/{id}"]["delete"]["responses"][200]["content"]["application/json"]

export type DeleteOneRelayRequest = TypedRequest<
	never,
	never,
	DeleteOneRelayParams
>
export type DeleteOneRelayResponse = TypedResponse<DeleteOneRelayResponseObject>

// =========================== DRIVERS ============================

// GET MANY DRIVERS
export type GetManyDriversQuery =
	paths["/drivers"]["get"]["parameters"]["query"]
export type DriversArray =
	paths["/drivers"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyDriversResponseObject =
	paths["/drivers"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyDriversRequest = TypedRequest<
	GetManyDriversQuery,
	never,
	never
>
export type GetManyDriversResponse = TypedResponse<GetManyDriversResponseObject>

// CREATE DRIVER
export type CreateDriverBody =
	paths["/drivers"]["post"]["requestBody"]["content"]["application/json"]
type CreateDriverResponseObject =
	paths["/drivers"]["post"]["responses"][201]["content"]["application/json"]

export type CreateDriverRequest = TypedRequest<never, CreateDriverBody, never>
export type CreateDriverResponse = TypedResponse<CreateDriverResponseObject>

// GET ONE DRIVER BY ID
export type GetOneDriverParams =
	paths["/drivers/{id}"]["get"]["parameters"]["path"]
export type GetOneDriverResponseObject =
	paths["/drivers/{id}"]["get"]["responses"][200]["content"]["application/json"]

export type GetOneDriverRequest = TypedRequest<never, never, GetOneDriverParams>
export type GetOneDriverResponse = TypedResponse<GetOneDriverResponseObject>

// UPDATE ONE DRIVER BY ID
export type UpdateOneDriverParams =
	paths["/drivers/{id}"]["put"]["parameters"]["path"]
export type UpdateOneDriverBody =
	paths["/drivers/{id}"]["put"]["requestBody"]["content"]["application/json"]
type UpdateOneDriverResponseObject =
	paths["/drivers/{id}"]["put"]["responses"][200]["content"]["application/json"]

export type UpdateOneDriverRequest = TypedRequest<
	never,
	UpdateOneDriverBody,
	UpdateOneDriverParams
>
export type UpdateOneDriverResponse =
	TypedResponse<UpdateOneDriverResponseObject>

// DELETE ONE DRIVER BY ID
export type DeleteOneDriverParams =
	paths["/drivers/{id}"]["delete"]["parameters"]["path"]
type DeleteOneDriverResponseObject =
	paths["/drivers/{id}"]["delete"]["responses"][200]["content"]["application/json"]

export type DeleteOneDriverRequest = TypedRequest<
	never,
	never,
	DeleteOneDriverParams
>
export type DeleteOneDriverResponse =
	TypedResponse<DeleteOneDriverResponseObject>

// =========================== VEHICLES ===========================

// GET MANY VEHICLES
export type GetManyVehiclesQuery =
	paths["/vehicles"]["get"]["parameters"]["query"]
export type VehiclesArray =
	paths["/vehicles"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyVehiclesResponseObject =
	paths["/vehicles"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyVehiclesRequest = TypedRequest<
	GetManyVehiclesQuery,
	never,
	never
>
export type GetManyVehiclesResponse =
	TypedResponse<GetManyVehiclesResponseObject>

// CREATE VEHICLE
export type CreateVehicleBody =
	paths["/vehicles"]["post"]["requestBody"]["content"]["application/json"]
type CreateVehicleResponseObject =
	paths["/vehicles"]["post"]["responses"][201]["content"]["application/json"]

export type CreateVehicleRequest = TypedRequest<never, CreateVehicleBody, never>
export type CreateVehicleResponse = TypedResponse<CreateVehicleResponseObject>

// GET ONE VEHICLE BY ID
export type GetOneVehicleParams =
	paths["/vehicles/{id}"]["get"]["parameters"]["path"]
export type GetOneVehicleResponseObject =
	paths["/vehicles/{id}"]["get"]["responses"][200]["content"]["application/json"]

export type GetOneVehicleRequest = TypedRequest<
	never,
	never,
	GetOneVehicleParams
>
export type GetOneVehicleResponse = TypedResponse<GetOneVehicleResponseObject>

// UPDATE ONE VEHICLE BY ID
export type UpdateOneVehicleParams =
	paths["/vehicles/{id}"]["put"]["parameters"]["path"]
export type UpdateOneVehicleBody =
	paths["/vehicles/{id}"]["put"]["requestBody"]["content"]["application/json"]
type UpdateOneVehicleResponseObject =
	paths["/vehicles/{id}"]["put"]["responses"][200]["content"]["application/json"]

export type UpdateOneVehicleRequest = TypedRequest<
	never,
	UpdateOneVehicleBody,
	UpdateOneVehicleParams
>
export type UpdateOneVehicleResponse =
	TypedResponse<UpdateOneVehicleResponseObject>

// ================================================================
// ========================== COMPONENTS ==========================
// ================================================================

export type Pickup = components["schemas"]["Pickup"]
export type PickupCreate = components["schemas"]["PickupCreate"]
