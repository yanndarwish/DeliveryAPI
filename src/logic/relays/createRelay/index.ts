import { CreateRelayRequest, CreateRelayResponse } from "@/api/interfaces";

import { queryAsync } from "@/lib/database";

import { createRelayBodyMapper } from "./mapper";
import { createRelayQuery } from "./query";

export const createRelay = async (
    req: CreateRelayRequest,
    res: CreateRelayResponse
) => {
    const companyId = req.headers["company-id"] as string;

    await queryAsync(createRelayQuery, createRelayBodyMapper(req.body, companyId));

    res.status(201).send({ message: "Relais créé avec succès" });
};