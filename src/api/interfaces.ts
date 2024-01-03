import { MysqlError } from "mysql"
import { Query } from "express-serve-static-core"
import { Express } from "express"

import { paths, components } from "@/types/schema"

// ERRORS
export type DBError = MysqlError | null;

// HTTP
export interface TypedRequest<T extends Query, U> extends Express.Request {
	query: T
	body: U
}

export interface TypedResponse<T> extends Express.Response {
    status: (code: number) => TypedResponse<T>
    send: (body: T) => TypedResponse<T>
}

// COMMON
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

// ============================ METIER ============================

// GET MANY DELIVERIES
export type GetManyDeliveriesQuery = paths["/deliveries"]["get"]["parameters"]["query"]
export type DeliveriesArray = paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyDeliveriesResponseObject = paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyDeliveriesRequest = TypedRequest<GetManyDeliveriesQuery, never>
export type GetManyDeliveriesResponse = TypedResponse<GetManyDeliveriesResponseObject>

// CREATE DELIVERY
export type CreateDeliveryBody = paths["/deliveries"]["post"]["requestBody"]["content"]["application/json"]
type CreateDeliveryResponseObject = paths["/deliveries"]["post"]["responses"][201]["content"]["application/json"]

export type CreateDeliveryRequest = TypedRequest<never, CreateDeliveryBody>
export type CreateDeliveryResponse = TypedResponse<CreateDeliveryResponseObject>

// ========================== COMPONENTS ==========================

export type Pickup = components["schemas"]["Pickup"]
