# Movie Recommendation Database Automation

This project demonstrates database automation using Azure DevOps for a movie recommendation system.

## Database Structure

The database consists of three main tables:
1. `Movies` - Stores movie information
2. `Users` - Stores user information
3. `UserRatings` - Tracks user ratings for movies

## Setup Instructions

1. Create an Azure SQL Database
2. Set up the following pipeline variables in Azure DevOps:
   - SQL_SERVER_NAME
   - DATABASE_NAME
   - SQL_USERNAME
   - SQL_PASSWORD

## Database Automation Tools Comparison

### Azure DevOps vs. GitHub Actions

| Feature | Azure DevOps | GitHub Actions |
|---------|--------------|----------------|
| Ease of Use | High - Integrated with Azure services, intuitive UI | High - Native GitHub integration, YAML-based |
| CI/CD Integration | Excellent - Built-in Azure SQL deployment tasks | Good - Requires additional setup for SQL deployment |
| Supported Databases | Extensive - Native support for Azure SQL, SQL Server, PostgreSQL | Good - Supports multiple databases through community actions |

### Integration Strategy

1. **Version Control Integration**
   - Store SQL scripts in source control
   - Use branch policies for code review
   - Implement automated testing

2. **Pipeline Configuration**
   - Use Azure DevOps pipeline for database deployment
   - Implement rollback procedures
   - Include validation steps

3. **Security**
   - Use Azure Key Vault for credentials
   - Implement least privilege access
   - Regular security audits

## Pipeline Steps

1. **Initial Setup**
   - Creates Movies, Users, and UserRatings tables
   - Inserts sample data

2. **Schema Update**
   - Adds new columns to existing tables
   - Updates sample data with additional information

3. **Validation**
   - Runs a query to verify the schema update
   - Checks data integrity

## References

- [Azure DevOps Documentation](https://docs.microsoft.com/en-us/azure/devops/)
- [Azure SQL Database Documentation](https://docs.microsoft.com/en-us/azure/sql-database/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions) 