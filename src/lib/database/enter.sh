#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD"
