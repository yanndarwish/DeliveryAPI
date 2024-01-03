#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Determine the environment (development or test)
if [ "$NODE_ENV" == "test" ]; then
  # Use test database configuration
  DB_NAME="$DB_DATABASE_TEST"
  DB_USER="$DB_USER_TEST"
  DB_PASSWORD="$DB_PASSWORD_TEST"
else
  DB_NAME="$DB_DATABASE"
fi

# Drop the database if it exists
echo "Dropping database $DB_NAME"
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS $DB_NAME;"

# Assuming your SQL files are in the ./migrations directory
MIGRATIONS_DIR="./migrations"
for file in $MIGRATIONS_DIR/*.sql; do
    # skip a line
    echo ""
    echo "Migrating $file"
    # Replace the placeholder with the actual database name during execution
    cat "$file" | sed "s/{DB_NAME}/$DB_NAME/g" | mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD"
    if [ $? -eq 0 ]; then
        echo "✅ Migration of $file successful"
    else
        echo "❌ Migration of $file failed"
        exit 1  # Exit the script if a migration fails
    fi
done

echo ""
echo "✅✅✅ All migrations completed successfully ✅✅✅"
