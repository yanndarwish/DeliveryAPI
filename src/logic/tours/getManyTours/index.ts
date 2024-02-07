import { GetManyToursRequest, GetManyToursResponse } from "@/api/interfaces";
import { ToursArrayDB } from "@/lib/database/interfaces";
import { queryAsync } from "@/lib/database";

import { getManyToursQueryMapper, getManyToursResponseMapper, getManyToursCountQueryMapper } from "./mapper";
import { getManyToursQuery, getManyToursCountQuery } from "./query";
import { getPagination } from "@/utils/pagination";

export const getManyTours = async (
    req: GetManyToursRequest,
    res: GetManyToursResponse
) => {
    const companyId = req.headers["company-id"] as string;

    const totalResult = await queryAsync(
        getManyToursCountQuery,
        getManyToursCountQueryMapper(req.query, companyId)
    );

    const total = totalResult[0][0].total as number;
    const pagination = getPagination({
        offset: Number(req.query.offset),
        limit: Number(req.query.limit),
        total,
    });
    const dataResult = await queryAsync(
        getManyToursQuery,
        getManyToursQueryMapper(req.query, companyId)
    );

    const data = dataResult[0] as ToursArrayDB;

    const response = {
        data: getManyToursResponseMapper(data),
        pagination,
    };

    res.send(response);
};