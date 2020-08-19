DROP DATABASE IF EXISTS `CPOasis`;
CREATE DATABASE `CPOasis`;
USE `CPOasis`;

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Penguin id',
    `username` VARCHAR(12) NOT NULL,
    `password` CHAR(255) NOT NULL,
    `created` INT(8) NOT NULL DEFAULT DATE_FORMAT(CURDATE(), '%Y%m%d'),
    `loginkey` VARCHAR(30) NOT NULL DEFAULT '',
    `moderator` BOOLEAN NOT NULL DEFAULT 0 CHECK (`moderator` BETWEEN 0 AND 1),
    `muted` BOOLEAN NOT NULL DEFAULT 0 CHECK (`muted` BETWEEN 0 AND 1),
    `ban` BOOLEAN NOT NULL DEFAULT 0 CHECK (`ban` BETWEEN 0 AND 1),
    `color` TINYINT(3) UNSIGNED NOT NULL DEFAULT 1,
    `coins` MEDIUMINT(7) UNSIGNED NOT NULL DEFAULT 500 CHECK (`coins` BETWEEN 0 AND 1000000),
    `head` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `face` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `neck` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `body` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `hand` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `feet` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `photo` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `flag` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `rank` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 CHECK (`rank` BETWEEN 1 AND 5),
    `nameglow` VARCHAR(8) NOT NULL,
    `namecolor` VARCHAR(8) NOT NULL,
    `speed` TINYINT(3) UNSIGNED NOT NULL DEFAULT 4 CHECK (`speed` BETWEEN 0 AND 100),
    `walls` BOOLEAN NOT NULL DEFAULT 0 CHECK (`walls` BETWEEN 0 AND 1),
    `bubblecolor` VARCHAR(8) NOT NULL,
    `bubbletext` VARCHAR(8) NOT NULL,
    `mood` TINYTEXT NOT NULL DEFAULT 'Welcome to CP Oasis.',
    `bubbleglow` VARCHAR(8) NOT NULL,
    `moodglow` VARCHAR(8) NOT NULL DEFAULT '0x0000FF',
    `moodcolor` VARCHAR(8) NOT NULL DEFAULT '0xFFFFFF',
    `size` TINYINT(3) UNSIGNED NOT NULL DEFAULT 100 CHECK (`size` BETWEEN 0 AND 200),
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;

LOCK TABLES `penguins` WRITE;
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (100, 'ZWrld', 'ZWrld999');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (101, 'Sup_Sup123', 'ZWrld999');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (102, 'ZWrlddd', 'ZWrld999');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (103, 'SupSup123', 'ZWrld999');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (104, 'Sup Sup123', 'ZWrld999');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (105, 'Z', 'ZWrld999');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (106, 'Zach', 'ZWrld999');
UNLOCK TABLES;

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
    `id` INT(10) UNSIGNED NOT NULL COMMENT 'Penguin id',
    `itemId` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`, `itemId`),
    CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`id`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `inventory` WRITE;
INSERT INTO `inventory` VALUES (100, 1);
INSERT INTO `inventory` VALUES (100, 801);
INSERT INTO `inventory` VALUES (100, 550);
INSERT INTO `inventory` VALUES (101, 1);
INSERT INTO `inventory` VALUES (101, 801);
INSERT INTO `inventory` VALUES (101, 550);
UNLOCK TABLES;

DROP TABLE IF EXISTS `stamps`;
CREATE TABLE `stamps` (
    `id` INT(10) UNSIGNED NOT NULL COMMENT 'Penguin id',
    `stampId` SMALLINT(5) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`, `stampId`),
    CONSTRAINT `stamps_ibfk_1` FOREIGN KEY (`id`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Postcard id',
    `senderId` INT(10) UNSIGNED NOT NULL,
    `senderName` VARCHAR(12) NOT NULL,
    `recipientId` INT(10) UNSIGNED NOT NULL,
    `type` SMALLINT(5) UNSIGNED NOT NULL,
    `date` INT(10) UNSIGNED NOT NULL,
    `read` BOOLEAN NOT NULL DEFAULT 0 CHECK (`read` BETWEEN 0 AND 1),
    PRIMARY KEY (`id`),
    CONSTRAINT `mail_ibfk_1` FOREIGN KEY (`senderId`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mail_ibfk_2` FOREIGN KEY (`senderName`) REFERENCES `penguins` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `mail_ibfk_3` FOREIGN KEY (`recipientId`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `ignore`;
CREATE TABLE `ignore` (
    `id` INT(10) UNSIGNED NOT NULL COMMENT 'Penguin id',
    `ignoreId` INT(10) UNSIGNED NOT NULL,
    `ignoreUsername` VARCHAR(12) NOT NULL,
    PRIMARY KEY (`id`, `ignoreId`, `ignoreUsername`),
    CONSTRAINT `ignore_ibfk_1` FOREIGN KEY (`id`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `ignore_ibfk_2` FOREIGN KEY (`IgnoreId`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `ignore_ibfk_3` FOREIGN KEY (`ignoreUsername`) REFERENCES `penguins` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `buddy`;
CREATE TABLE `buddy` (
    `id` INT(10) UNSIGNED NOT NULL COMMENT 'Penguin id',
    `buddyId` INT(10) UNSIGNED NOT NULL,
    `buddyUsername` VARCHAR(12) NOT NULL,
    PRIMARY KEY (`id`, `buddyId`, `buddyUsername`),
    CONSTRAINT `buddy_ibfk_1` FOREIGN KEY (`id`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `buddy_ibfk_2` FOREIGN KEY (`buddyId`) REFERENCES `penguins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `buddy_ibfk_3` FOREIGN KEY (`buddyUsername`) REFERENCES `penguins` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TRIGGER `insert_color`
  AFTER INSERT ON `penguins`
  FOR EACH ROW
  INSERT INTO `inventory` VALUES (NEW.id, NEW.color);