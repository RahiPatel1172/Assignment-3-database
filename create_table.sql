-- Create Movies table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre NVARCHAR(100) NOT NULL,
    Rating DECIMAL(3,1) NOT NULL,
    Description NVARCHAR(MAX)
);

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL
);

-- Create UserRatings table for tracking user ratings
CREATE TABLE UserRatings (
    RatingID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    MovieID INT FOREIGN KEY REFERENCES Movies(MovieID),
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    RatingDate DATE NOT NULL,
    UNIQUE(UserID, MovieID)
);

-- Insert sample data
INSERT INTO Movies (Title, ReleaseYear, Genre, Rating, Description)
VALUES 
    ('The Shawshank Redemption', 1994, 'Drama', 9.3, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'),
    ('The Godfather', 1972, 'Crime', 9.2, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.'),
    ('The Dark Knight', 2008, 'Action', 9.0, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.');

INSERT INTO Users (Username, Email, RegistrationDate)
VALUES 
    ('john_doe', 'john@example.com', '2024-01-01'),
    ('jane_smith', 'jane@example.com', '2024-02-01'); 