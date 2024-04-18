-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- INSERTING VALUES
-- Add a new game
INSERT INTO `Games`(`title`, `release_year`, `genre`, `mode`, `price`, `rating`)
VALUES
    ('Sekiro: Shadows Die Twice', '2019', 'Action', 'Singleplayer', '59.99', 'Overwhelmingly Positive'),
    ('Monster Hunter: World', '2018', 'Action', 'Both', '29.99', 'Very Positive'),
    ('Elden Ring', '2022', 'Action', 'Both', '59.99', 'Very Positive'),
    ('Counter-Strike 2', '2023', 'Shooter', 'Multiplayer', '0', 'Very Positive');

-- Add a new company
INSERT INTO `Companies`(`name`, `location`, `year`)
VALUES
    ('FromSoftware', 'JPN', '1986'),
    ('Capcom', 'JPN', '1979'),
    ('Activision', 'USA', '1979'),
    ('Bandai Namco', 'JPN', '2006');

-- Add a new director
INSERT INTO `Directors`(`name`, `birthdate`, `nationality`, `company_id`, `title`)
VALUES ('Hidetaka Miyazaki', '1974-09-19', 'Japanese', '1', 'President');

-- Add relation between companies and games in WorksOn Table
INSERT INTO `WorksOn`(`company_id`, `game_id`, `role`)
VALUES
    ('1', '1', 'Developer'),
    ('3', '1', 'Publisher'),
    ('2', '2', 'Both'),
    ('1', '3', 'Developer');

-- Add relation between directors and games in Directs Table
INSERT INTO `Directs`(`director_id`, `game_id`)
VALUES
    ('1', '3'),
    ('1', '1');

-- Add player counts
INSERT INTO `Players`(`game_id`, `datetime`, `players`)
VALUES
    ('1', '2024-04-01 00:00:00', '4879'),
    ('1', '2024-04-01 01:00:00', '5130'),
    ('1', '2024-04-01 02:00:00', '5747'),
    ('1', '2024-04-01 03:00:00', '5980'),
    ('1', '2024-04-01 04:00:00', '7626'),
    ('1', '2024-04-01 05:00:00', '7653'),
    ('1', '2024-04-01 06:00:00', '6296'),
    ('1', '2024-04-01 07:00:00', '6458'),
    ('1', '2024-04-01 08:00:00', '8012'),
    ('1', '2024-04-01 09:00:00', '8792'),
    ('1', '2024-04-01 10:00:00', '9280'),
    ('1', '2024-04-01 11:00:00', '10383'),
    ('1', '2024-04-01 12:00:00', '12153'),
    ('1', '2024-04-01 13:00:00', '13934'),
    ('1', '2024-04-01 14:00:00', '14069'),
    ('1', '2024-04-01 15:00:00', '13140'),
    ('1', '2024-04-01 16:00:00', '9572'),
    ('1', '2024-04-01 17:00:00', '7029'),
    ('1', '2024-04-01 18:00:00', '5918'),
    ('1', '2024-04-01 19:00:00', '5466'),
    ('1', '2024-04-01 20:00:00', '5155'),
    ('1', '2024-04-01 21:00:00', '4820'),
    ('1', '2024-04-01 22:00:00', '4441'),
    ('1', '2024-04-01 23:00:00', '4112'),
    ('1', '2024-04-02 00:00:00', '4301');

-- COMMON QUERIES
-- Find games with a rating of Mostly Positive to Overwhelmingly Positive
SELECT Games.title, Games.rating
FROM Games
WHERE Games.rating IN ('Mostly Positive', 'Positive', 'Very Positive', 'Overwhelmingly Positive');

-- Find games on certain genres
SELECT Games.title, Games.genre
FROM Games
WHERE Games.genre IN ('Action', 'Adventure');

-- Find games which price is less than $50 or any value
SELECT Games.title, Games.price
FROM Games
WHERE Games.price <= 50.00
ORDER BY Games.price;

-- Find games that a company published/developed
SELECT Games.title
FROM Games
LEFT JOIN WorksOn ON WorksOn.game_id = Games.id
WHERE WorksOn.company_id IN (
    SELECT Companies.id
    FROM Companies
    WHERE Companies.name = 'FromSoftware'
);

-- Find games that a person directed
SELECT Games.title
FROM Games
JOIN Directs ON Directs.game_id = Games.id
WHERE Directs.director_id = (
    SELECT Directors.id
    FROM Directors
    WHERE Directors.name = 'Hidetaka Miyazaki'
);

-- Determine the total number of players in a year/month/day/hour.
SELECT Games.title, SUM(Players.players) AS total_players
FROM Games
LEFT JOIN Players ON Players.game_id = Games.id
WHERE Games.title = 'Sekiro: Shadows Die Twice'
AND Players.datetime BETWEEN '2024-04-01 00:00:00' AND '2024-04-02 00:00:00';

-- Determine the peak player count in a range of time.
SELECT Games.title, MAX(Players.players) AS peak_players
FROM Games
LEFT JOIN Players ON Players.game_id = Games.id
WHERE Games.title = 'Sekiro: Shadows Die Twice'
AND Players.datetime BETWEEN '2024-04-01 00:00:00' AND '2024-04-02 00:00:00';
