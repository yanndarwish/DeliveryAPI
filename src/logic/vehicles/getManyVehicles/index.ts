import { GetManyVehiclesRequest, GetManyVehiclesResponse } from "@/api/interfaces";
import { VehiclesArrayDB } from "@/lib/database/interfaces";
import { queryAsync } from "@/lib/database";

import { getManyVehiclesQueryMapper, getManyVehiclesResponseMapper, getManyVehiclesCountQueryMapper } from "./mapper";
import { getManyVehiclesQuery, getManyVehiclesCountQuery } from "./query";
import { getPagination } from "@/utils/pagination";

export const getManyVehicles = async (
    req: GetManyVehiclesRequest,
    res: GetManyVehiclesResponse
) => {
    const companyId = req.headers["company-id"] as string;

    const totalResult = await queryAsync(
        getManyVehiclesCountQuery,
        getManyVehiclesCountQueryMapper(req.query, companyId)
    );

    const total = totalResult[0][0].total as number;
    const pagination = getPagination({
        offset: Number(req.query.offset),
        limit: Number(req.query.limit),
        total,
    });
    const dataResult = await queryAsync(
        getManyVehiclesQuery,
        getManyVehiclesQueryMapper(req.query, companyId)
    );

    const data = dataResult[0] as VehiclesArrayDB;

    const response = {
        data: getManyVehiclesResponseMapper(data),
        pagination,
    };

    res.send(response);
};