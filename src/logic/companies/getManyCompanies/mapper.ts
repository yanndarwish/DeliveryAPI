import { CompaniesArray, GetManyCompaniesQuery } from "@/api/interfaces"
import { CompaniesArrayDB } from "@/lib/database/interfaces"

export const getManyCompaniesQueryMapper = (query: GetManyCompaniesQuery) => {
	return [
		Number(query.offset),
		Number(query.limit),
		query.status ?? null,
		query.name ?? null,
		query.siret ?? null,
		query.email ?? null,
	]
}

export const getManyCompaniesCountQueryMapper = (
	query: GetManyCompaniesQuery
) => {
	return [
		query.status ?? null,
		query.name ?? null,
		query.siret ?? null,
		query.email ?? null,
	]
}

export const getManyCompaniesResponseMapper = (
	data: CompaniesArrayDB
): CompaniesArray => {
	return data.map((company) => ({
		id: company.company_id,
		name: company.company_name,
		siret: company.company_siret,
		headquarters: {
			id: company.headquarter_address_id,
			streetNumber: company.headquarter_street_number,
			streetName: company.headquarter_street,
			city: company.headquarter_city,
			postalCode: company.headquarter_postal_code,
			country: company.headquarter_country,
		},
		warehouse: {
			id: company.warehouse_address_id,
			streetNumber: company.warehouse_street_number,
			streetName: company.warehouse_street,
			city: company.warehouse_city,
			postalCode: company.warehouse_postal_code,
			country: company.warehouse_country,
		},
		email: company.email,
		phone: company.phone,
		contacts: JSON.parse(company.contacts).map((contact: any) => {
			return {
				id: contact.id,
				firstName: contact.firstName,
				lastName: contact.lastName,
				email: contact.email,
				phone: contact.phone,
				comment: contact.comment,
			}
		}),
		active: Boolean(company.company_active),
	}))
}
