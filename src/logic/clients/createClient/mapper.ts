import { CreateClientBody } from "@/api/interfaces"

export const createClientBodyMapper = (
	body: CreateClientBody,
	companyId: string
) => {
	return [
		body.name,
		body.streetNumber ?? null,
		body.street,
		body.city,
		body.postalCode ?? null,
		body.country,
		body.comment ?? null,
		body.active,
		body.phone ?? null,
		body.email ?? null,
		Number(companyId),
	]
}
