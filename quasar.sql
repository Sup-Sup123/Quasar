DROP DATABASE IF EXISTS `quasar`;
CREATE DATABASE `quasar`;

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
    `coins` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 500,
    `head` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `face` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `neck` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `body` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `hand` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `feet` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `photo` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `flag` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
    `rank` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 CHECK (`rank` BETWEEN 1 AND 5),
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;

LOCK TABLES `penguins` WRITE;
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (100, 'Zaseth', '$2y$12$q9nZjKizopPUkUJTI.apsOuj9q0QQ8ewhTjtOSaMMHElnPSt/CAPu');
INSERT INTO `penguins` (`id`, `username`, `password`) VALUES (101, 'Test', '$2y$12$TBw5mtVoU.YBnmAepDPzDeA7MZT5CshLYq9cz8B6l1a3/YPnAHnlS');
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
INSERT INTO `inventory` VALUES (100, 550);
INSERT INTO `inventory` VALUES (100, 801);
INSERT INTO `inventory` VALUES (101, 1);
UNLOCK TABLES;

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
  INSERT INTO `inventory` (`id`, `itemId`) VALUES (NEW.id, NEW.color);

CREATE TRIGGER `insert_mail`
  AFTER INSERT ON `penguins`
  FOR EACH ROW
  INSERT INTO `mail` (`senderId`, `senderName`, `recipientId`, `type`, `date`) VALUES ('100', 'Zaseth', NEW.id, 125, UNIX_TIMESTAMP());
