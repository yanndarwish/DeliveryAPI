import { queryAsync } from "@/lib/database";

import {
    GetManyRelaysRequest,
    GetManyRelaysResponse,
} from "@/api/interfaces";
import {
    getManyRelaysQueryMapper,
    getManyRelaysCountQueryMapper,
    getManyRelaysResponseMapper,
} from "./mapper";
import { getManyRelaysQuery, getManyRelaysCountQuery } from "./query";
import { getPagination } from "@/utils/pagination";
import { RelaysArrayDB } from "@/lib/database/interfaces";

export const getManyRelays = async (
    req: GetManyRelaysRequest,
    res: GetManyRelaysResponse
) => {
    const companyId = req.headers["company-id"] as string;

    const totalResult = await queryAsync(
        getManyRelaysCountQuery,
        getManyRelaysCountQueryMapper(req.query, companyId)
    );

    const total = totalResult[0][0].total as number;
    const pagination = getPagination({
        offset: Number(req.query.offset),
        limit: Number(req.query.limit),
        total,
    });
    const dataResult = await queryAsync(
        getManyRelaysQuery,
        getManyRelaysQueryMapper(req.query, companyId)
    );

    const data = dataResult[0] as RelaysArrayDB;

    const response = {
        data: getManyRelaysResponseMapper(data),
        pagination,
    };

    res.send(response);
}