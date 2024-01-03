import { MysqlError } from "mysql"
import { Query } from "express-serve-static-core"
import { Express } from "express"

import { paths } from "@/types/schema"

// ERRORS
export type DBError = MysqlError | null;

// HTTP
export interface TypedRequest<T extends Query, U> extends Express.Request {
	query: T
	body: U
}

export interface TypedResponse<T> extends Express.Response {
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

// METIER
export type GetManyDeliveriesQuery = paths["/deliveries"]["get"]["parameters"]["query"]
export type DeliveriesArray = paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]["data"]
type GetManyDeliveriesResponseObject = paths["/deliveries"]["get"]["responses"][200]["content"]["application/json"]

export type GetManyDeliveriesRequest = TypedRequest<GetManyDeliveriesQuery, never>
export type GetManyDeliveriesResponse = TypedResponse<GetManyDeliveriesResponseObject>