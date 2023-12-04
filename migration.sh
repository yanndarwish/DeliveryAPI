#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Drop the database if it exists
echo "Dropping database $DB_DATABASE"
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS $DB_DATABASE;"

# Assuming your SQL files are in the ./migrations directory
for file in ./migrations/*.sql; do
    # skip a line
    echo ""
    echo "Migrating $file"
    cat "$file" | mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD"
    if [ $? -eq 0 ]; then
        echo "✅ Migration of $file successful"
    else
        echo "❌ Migration of $file failed"
        exit 1  # Exit the script if a migration fails
    fi
done

echo ""
echo "✅✅✅ All migrations completed successfully ✅✅✅"
