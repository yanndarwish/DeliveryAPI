import { GetOneCompanyResponseObject } from "@/api/interfaces"
import { CompanyDB } from "@/lib/database/interfaces"

export const getOneCompanyResponseMapper = (
	data: CompanyDB
): GetOneCompanyResponseObject => {
	return {
		id: data.company_id,
		name: data.company_name,
		siret: data.company_siret,
		headquarters: {
			id: data.headquarter_address_id,
			streetNumber: data.headquarter_street_number,
			streetName: data.headquarter_street,
			city: data.headquarter_city,
			postalCode: data.headquarter_postal_code,
			country: data.headquarter_country,
		},
		warehouse: {
			id: data.warehouse_address_id,
			streetNumber: data.warehouse_street_number,
			streetName: data.warehouse_street,
			city: data.warehouse_city,
			postalCode: data.warehouse_postal_code,
			country: data.warehouse_country,
		},
		email: data.email,
		phone: data.phone,
		contacts: JSON.parse(data.contacts).map((contact: any) => {
			return {
				id: contact.id,
				firstName: contact.firstName,
				lastName: contact.lastName,
				email: contact.email,
				phone: contact.phone,
				comment: contact.comment,
			}
		}),
		active: Boolean(data.company_active),
	}
}
