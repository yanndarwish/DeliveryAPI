/**
 * This file was auto-generated by openapi-typescript.
 * Do not make direct changes to the file.
 */


export interface paths {
  "/deliveries": {
    /** Returns a list of deliveries. */
    get: {
      parameters: {
        query: {
          offset: components["parameters"]["OffsetParam"];
          limit: components["parameters"]["LimitParam"];
          /**
           * @description Filter by driver name
           * @example Brown, Bob
           */
          driver?: string;
          /**
           * @description Filter by provider name
           * @example Amazon
           */
          provider?: string;
          /**
           * @description Filter by vehicle name
           * @example Honda Accord
           */
          vehicle?: string;
          /**
           * @description Filter by day
           * @example 1
           */
          day?: string;
          /**
           * @description Filter by month
           * @example 7
           */
          month?: string;
          /**
           * @description Filter by year
           * @example 2024
           */
          year?: string;
        };
      };
      responses: {
        /** @description A JSON array of user names */
        200: {
          content: {
            "application/json": {
              data: components["schemas"]["DeliveriesArray"];
              pagination: components["schemas"]["Pagination"];
            };
          };
        };
        /** @description Bad request - invalid parameters */
        400: {
          content: never;
        };
        /** @description Internal server error */
        500: {
          content: never;
        };
      };
    };
  };
}

export type webhooks = Record<string, never>;

export interface components {
  schemas: {
    Pagination: {
      /** @example 1 */
      currentPage?: number;
      /** @example 7 */
      totalPages?: number;
      /** @example true */
      hasNextPage?: boolean;
      /** @example false */
      hasPreviousPage?: boolean;
      /** @example 89 */
      totalItems?: number;
    };
    Delivery: {
      /** @example 4 */
      id: number;
      /** @example Arthur Dent */
      driver: string;
      /** @example Ford Prefect */
      vehicle: string;
      /** @example Amazon */
      provider: string;
      /** @example 100 */
      hotelPrice: number;
      /** @example Google */
      outsourcedTo: string;
      /**
       * @example [
       *   {
       *     "date": "2021-07-01",
       *     "entity_info": {
       *       "entity_id": 1,
       *       "entity_name": "Amazon",
       *       "address_street_number": 123,
       *       "address_street": "Main St",
       *       "address_city": "Paris",
       *       "address_postal_code": 75008,
       *       "address_country": "France",
       *       "address_comment": "Derrière le hangar",
       *       "entity_active": true,
       *       "entity_type": "Client"
       *     }
       *   }
       * ]
       */
      pickups: components["schemas"]["Pickup"][];
      /**
       * @example [
       *   {
       *     "date": "2021-07-01",
       *     "entity_info": {
       *       "entity_id": 1,
       *       "entity_name": "Amazon",
       *       "address_street_number": 123,
       *       "address_street": "Main St",
       *       "address_city": "Paris",
       *       "address_postal_code": 75008,
       *       "address_country": "France",
       *       "address_comment": "Derrière le hangar",
       *       "entity_active": true,
       *       "entity_type": "Client"
       *     }
       *   }
       * ]
       */
      dropoffs: components["schemas"]["Pickup"][];
      /** @example 1 */
      companyId: number;
    };
    DeliveriesArray: components["schemas"]["Delivery"][];
    Pickup: {
      /** @example "2021-07-01T00:00:00.000Z" */
      date?: string;
      entity_info?: {
        /** @example 1 */
        entity_id?: number;
        /** @example Amazon */
        entity_name?: string;
        /** @example 123 */
        address_street_number?: number;
        /** @example Main St */
        address_street?: string;
        /** @example Paris */
        address_city?: string;
        /** @example 75008 */
        address_postal_code?: string;
        /** @example France */
        address_country?: string;
        /** @example Derrière le hangar */
        address_comment?: string;
        /** @example true */
        entity_active?: boolean;
        /** @example Client */
        entity_type?: string;
      };
    };
  };
  responses: never;
  parameters: {
    /** @description Number of items to skip */
    OffsetParam: string;
    /** @description Number of items to return */
    LimitParam: string;
  };
  requestBodies: never;
  headers: never;
  pathItems: never;
}

export type $defs = Record<string, never>;

export type external = Record<string, never>;

export type operations = Record<string, never>;