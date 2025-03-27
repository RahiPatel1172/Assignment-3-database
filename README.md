# PROG8850 - Database Automation Assignment 4

This repository contains the implementation of database automation using Ansible and Flyway for managing a MySQL database of subscribers and their email addresses.

## Project Structure

```
Assignment-4-database/
├── ansible/
│   ├── up.yaml             - Starts MySQL, initializes the database, and applies migrations
│   └── down.yaml           - Creates a migration and stops the database
├── migrations/
│   ├── V1__create_subscribers.sql       - Creates the subscribers table
│   ├── V2__Add_Subscription_Date.sql    - Adds the subscription_date column
│   ├── V3__Seed_Initial_Data.sql        - Seeds initial subscriber data
│   └── V*__Seed_New_Subscribers.sql     - Auto-generated migrations for new subscribers
├── tests/
│   └── dbtests.py          - Tests for validating the schema structure
├── dbtests.py              - Main test file for database validation
└── README.md
```

## Prerequisites

1. Install MySQL Server:
   ```bash
   # For Ubuntu/Debian
   sudo apt-get install mysql-server -y
   
   # For macOS
   brew install mysql
   brew services start mysql
   ```

2. Install Ansible:
   ```bash
   # For Ubuntu/Debian
   sudo apt-get install ansible -y
   
   # For macOS
   brew install ansible
   
   # Install required collection
   ansible-galaxy collection install community.mysql
   ```

3. Install Flyway:
   ```bash
   # For Ubuntu/Debian
   wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/9.8.1/flyway-commandline-9.8.1-linux-x64.tar.gz | tar xvz && sudo ln -s $(pwd)/flyway-9.8.1/flyway /usr/local/bin
   
   # For macOS
   brew install flyway
   ```

4. Install Python dependencies:
   ```bash
   pip install mysql-connector-python pytest
   ```

5. Configure MySQL:
   ```bash
   sudo mysql -u root -p
   # Inside MySQL prompt
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mysql@123';
   FLUSH PRIVILEGES;
   exit;
   ```

## Usage Instructions

### 1. Start Database and Apply Migrations

Run the `up.yaml` playbook to start the MySQL database, initialize it, and apply migrations:

```bash
cd ansible
ansible-playbook up.yaml
```

This script is idempotent - it can be run multiple times without changing the result beyond the initial application.

### 2. Test the Database Schema

Run the tests to validate that the schema is correctly set up:

```bash
python3 dbtests.py
```

Or using pytest:

```bash
python3 -m pytest dbtests.py -v
```

### 3. Add New Subscribers

Connect to the database and add new subscribers:

```bash
mysql -u root -p -e "USE subscribers_db; INSERT INTO subscribers (email) VALUES ('new_user@example.com');"
```

### 4. Create Migration and Stop Database

When you are done with the database, run the `down.yaml` playbook to create a migration that seeds any new data and stops the database:

```bash
cd ansible
ansible-playbook down.yaml
```

This will:
1. Create a new migration file with any new subscribers that were added
2. Baseline the database for the next migration
3. Stop the MySQL service

### 5. Commit Changes

After running the `down.yaml` playbook, commit your changes to preserve the new migration file:

```bash
git add .
git commit -m "Added new subscribers"
git push
```

## Implementation Details

- **up.yaml**: Starts MySQL, initializes the database for use with Flyway, and runs Flyway to apply migrations.
- **down.yaml**: Creates a migration to seed the database with any data added since the last commit and stops the database.
- **Migrations**: Define the schema and changes to be applied to the database.
- **dbtests.py**: Tests the schema to ensure it contains the required structure.

## Notes

- The MySQL root password is set to "mysql@123" in this implementation. For a production environment, use a secure password and consider using environment variables or a secret management tool.
- The `up.yaml` script is designed to be idempotent, so you can run it multiple times without adverse effects.
- The `down.yaml` script will only create a new migration file if new subscribers have been added.

