import { CreateDriverBody } from "@/api/interfaces";

export const createDriverBodyMapper = (body: CreateDriverBody, companyId: string) => {
    return [
        body.lastName,
        body.firstName,
        body.active,
        body.email ?? null,
        body.phone ?? null,
        companyId
    ];
};