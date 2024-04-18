-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- TABLE
-- Represents the games on steam.
CREATE TABLE `Games` (
    `id` INT AUTO_INCREMENT,
    `title` VARCHAR(32) NOT NULL,
    `release_year` YEAR NOT NULL,
    `genre` VARCHAR(64) NOT NULL,
    `mode` ENUM('Singleplayer', 'Multiplayer', 'Both') NOT NULL,
    `price` DECIMAL(6, 2) UNSIGNED NOT NULL,
    `rating` ENUM('Overwhelmingly Positive', 'Very Positive', 'Positive', 'Mostly Positive', 'Mixed', 'Mostly Negative', 'Negative', 'Very Negative', 'Overwhelmingly Negative'),
    PRIMARY KEY (`id`)
);

-- Represents the different video game companies.
CREATE TABLE `Companies` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `location` CHAR(3) NOT NULL,
    `year` YEAR,
    PRIMARY KEY (`id`)
);

-- Represents the relationship between company and game.
CREATE TABLE `WorksOn` (
    `company_id` INT,
    `game_id` INT,
    `role` ENUM('Publisher', 'Developer', 'Both') NOT NULL,
    FOREIGN KEY (`company_id`) REFERENCES `Companies`(`id`),
    FOREIGN KEY (`game_id`) REFERENCES `Games`(`id`)
);

-- Represents the game directors.
CREATE TABLE `Directors` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `birthdate` DATE,
    `nationality` VARCHAR(8),
    `company_id` INT,
    `title` VARCHAR(16),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`company_id`) REFERENCES `Companies`(`id`)
);

-- Represents the relationship between director and game.
CREATE TABLE `Directs` (
    `director_id` INT,
    `game_id` INT,
    FOREIGN KEY (`director_id`) REFERENCES `Directors`(`id`),
    FOREIGN KEY (`game_id`) REFERENCES `Games`(`id`)
);

-- Represents the awards of the games.
CREATE TABLE `Awards` (
    `game_id` INT,
    `name` VARCHAR(32) NOT NULL,
    `category` VARCHAR(32),
    `year` YEAR NOT NULL,
    FOREIGN KEY (`game_id`) REFERENCES `Games`(`id`)
);

-- Represent the playcount of the games.
CREATE TABLE `Players` (
    `game_id` INT,
    `datetime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `players` INT NOT NULL,
    FOREIGN KEY (`game_id`) REFERENCES `Games`(`id`)
);

-- INDEX
-- Create index to optimize searches
CREATE INDEX `IndexGamesTitle`
ON `Games`(`title`);

CREATE INDEX `IndexGamesGenre`
ON `Games`(`genre`);

CREATE INDEX `IndexGamesPrice`
ON `Games`(`price`);

CREATE INDEX `IndexGamesYear`
ON `Games`(`release_year`);

CREATE INDEX `IndexCompaniesName`
ON `Companies`(`name`);

CREATE INDEX `IndexDirectorsName`
ON `Directors`(`name`);

CREATE INDEX `IndexPlayersDatetime`
ON `Players`(`datetime`);
