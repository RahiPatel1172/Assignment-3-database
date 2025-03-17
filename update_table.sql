-- Add new columns to Movies table
ALTER TABLE Movies
ADD Director NVARCHAR(100),
    Runtime INT,
    Language NVARCHAR(50),
    StreamingAvailability BIT DEFAULT 0;

-- Add new columns to Users table
ALTER TABLE Users
ADD PreferredGenre NVARCHAR(100),
    LastLoginDate DATE,
    IsActive BIT DEFAULT 1;

-- Add sample user ratings
INSERT INTO UserRatings (UserID, MovieID, Rating, RatingDate)
VALUES 
    (1, 1, 5, '2024-03-01'),
    (1, 2, 4, '2024-03-02'),
    (2, 1, 5, '2024-03-01'),
    (2, 3, 5, '2024-03-02');

-- Update Movies with additional information
UPDATE Movies
SET Director = 'Frank Darabont',
    Runtime = 142,
    Language = 'English',
    StreamingAvailability = 1
WHERE MovieID = 1;

UPDATE Movies
SET Director = 'Francis Ford Coppola',
    Runtime = 175,
    Language = 'English',
    StreamingAvailability = 1
WHERE MovieID = 2;

UPDATE Movies
SET Director = 'Christopher Nolan',
    Runtime = 152,
    Language = 'English',
    StreamingAvailability = 1
WHERE MovieID = 3;

-- Update Users with preferences
UPDATE Users
SET PreferredGenre = 'Drama',
    LastLoginDate = '2024-03-02'
WHERE UserID = 1;

UPDATE Users
SET PreferredGenre = 'Action',
    LastLoginDate = '2024-03-02'
WHERE UserID = 2; 