import { CreateTourRequest, CreateTourResponse } from "@/api/interfaces";

import { queryAsync } from "@/lib/database";

import { createTourQuery } from "./query";
import { createTourBodyMapper } from "./mapper";

export const createTour = async (
    req: CreateTourRequest,
    res: CreateTourResponse
) => {
    const companyId = req.headers["company-id"] as string;

    console.log(req.body);

    await queryAsync(
        createTourQuery,
        createTourBodyMapper(req.body, companyId)
    );

    res.status(201).send({ message: "Tournée créée avec succès" });
};