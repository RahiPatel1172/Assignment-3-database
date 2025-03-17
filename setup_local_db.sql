-- Create the database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MovieRecommendationDB')
BEGIN
    CREATE DATABASE MovieRecommendationDB;
END

-- Use the database
USE MovieRecommendationDB;
GO

-- Create Movies table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Movies]') AND type in (N'U'))
BEGIN
    CREATE TABLE Movies (
        MovieID INT PRIMARY KEY IDENTITY(1,1),
        Title NVARCHAR(200) NOT NULL,
        ReleaseYear INT NOT NULL,
        Genre NVARCHAR(100) NOT NULL,
        Rating DECIMAL(3,1) NOT NULL,
        Description NVARCHAR(MAX)
    );
END

-- Create Users table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE Users (
        UserID INT PRIMARY KEY IDENTITY(1,1),
        Username NVARCHAR(50) NOT NULL UNIQUE,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        RegistrationDate DATE NOT NULL
    );
END

-- Create UserRatings table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRatings]') AND type in (N'U'))
BEGIN
    CREATE TABLE UserRatings (
        RatingID INT PRIMARY KEY IDENTITY(1,1),
        UserID INT FOREIGN KEY REFERENCES Users(UserID),
        MovieID INT FOREIGN KEY REFERENCES Movies(MovieID),
        Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
        RatingDate DATE NOT NULL,
        UNIQUE(UserID, MovieID)
    );
END

-- Insert sample data
IF NOT EXISTS (SELECT * FROM Movies)
BEGIN
    INSERT INTO Movies (Title, ReleaseYear, Genre, Rating, Description)
    VALUES 
        ('The Shawshank Redemption', 1994, 'Drama', 9.3, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'),
        ('The Godfather', 1972, 'Crime', 9.2, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.'),
        ('The Dark Knight', 2008, 'Action', 9.0, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.');
END

IF NOT EXISTS (SELECT * FROM Users)
BEGIN
    INSERT INTO Users (Username, Email, RegistrationDate)
    VALUES 
        ('john_doe', 'john@example.com', '2024-01-01'),
        ('jane_smith', 'jane@example.com', '2024-02-01');
END 