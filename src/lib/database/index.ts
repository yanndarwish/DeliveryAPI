const mysql = require("mysql")

import { DatabaseError } from "../errors"
import { DBError } from "../../api/interfaces"

export const database = mysql.createConnection({
	host: "127.0.0.1",
	user: "root",
	password: "password",
	database: "geostar",
})

// Custom query method to promisify the database queries
export const queryAsync = (queryString: string, params: any[] = []) => {
	return new Promise<any>((resolve, reject) => {
		database.query(queryString, params, (err: DBError, result: any) => {
			if (err) reject(new DatabaseError(err.message))
			resolve(result)
		})
	})
}
