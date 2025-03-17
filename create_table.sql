-- Create Movies table
CREATE TABLE IF NOT EXISTS Movies (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3,1) NOT NULL,
    Description TEXT
);

-- Create Users table
CREATE TABLE IF NOT EXISTS Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL
);

-- Create UserRatings table
CREATE TABLE IF NOT EXISTS UserRatings (
    RatingID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    MovieID INT,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    RatingDate DATE NOT NULL,
    UNIQUE(UserID, MovieID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
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