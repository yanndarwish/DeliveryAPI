import { queryAsync } from "@/lib/database";

import {
    GetManyClientsRequest,
    GetManyClientsResponse,
} from "@/api/interfaces";
import {
    getManyClientsQueryMapper,
    getManyClientsCountQueryMapper,
    getManyClientsResponseMapper,
} from "./mapper";
import { getManyClientsQuery, getManyClientsCountQuery } from "./query";
import { getPagination } from "@/utils/pagination";
import { ClientsArrayDB } from "@/lib/database/interfaces";

export const getManyClients = async (
    req: GetManyClientsRequest,
    res: GetManyClientsResponse
) => {
    const companyId = req.headers["company-id"] as string;

    const totalResult = await queryAsync(
        getManyClientsCountQuery,
        getManyClientsCountQueryMapper(req.query, companyId)
    );

    const total = totalResult[0][0].total as number;
    const pagination = getPagination({
        offset: Number(req.query.offset),
        limit: Number(req.query.limit),
        total,
    });

    const dataResult = await queryAsync(
        getManyClientsQuery,
        getManyClientsQueryMapper(req.query, companyId)
    );

    const data = dataResult[0] as ClientsArrayDB;

    const response = {
        data: getManyClientsResponseMapper(data),
        pagination,
    };

    res.send(response);
};