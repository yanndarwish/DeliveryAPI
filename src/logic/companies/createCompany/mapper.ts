import { CreateCompanyBody } from "@/api/interfaces"

export const createCompanyBodyMapper = (body: CreateCompanyBody) => {
	return [
		body.name,
		body.active,
		body.siret,
		body.email,
		body.phone,
        JSON.stringify(body.contacts),
		body.headquarters?.streetNumber ?? null,
		body.headquarters?.streetName ?? null,
		body.headquarters?.city ?? null,
		body.headquarters?.postalCode ?? null,
		body.headquarters?.country ?? null,
		body.headquarters?.comment ?? null,
		body.warehouse?.streetNumber ?? null,
		body.warehouse?.streetName ?? null,
		body.warehouse?.city ?? null,
		body.warehouse?.postalCode ?? null,
		body.warehouse?.country,
		body.warehouse?.comment ?? null,
	]
}
