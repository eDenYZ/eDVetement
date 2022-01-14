SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `user_vetement` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL DEFAULT 'Nom tenue non attribué',
  `contenu` longtext,
  `type` varchar(100) NOT NULL DEFAULT 'Vetement'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `user_vetement`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `user_vetement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;