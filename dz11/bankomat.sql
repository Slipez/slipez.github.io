-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 31 2019 г., 19:51
-- Версия сервера: 10.3.13-MariaDB
-- Версия PHP: 7.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bankomat`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `balanse` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `user_id`, `balanse`, `currency_id`) VALUES
(1, 1, 3000, 1),
(2, 1, 2500, 2),
(3, 2, 1560, 3),
(4, 2, 6420, 2),
(5, 2, 8420, 1),
(6, 3, 4700, 1),
(7, 3, 1250, 2),
(8, 3, 650, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `amounts`
--

CREATE TABLE `amounts` (
  `id` int(11) NOT NULL,
  `cashbox_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `amounts`
--

INSERT INTO `amounts` (`id`, `cashbox_id`, `value`, `quantity`) VALUES
(1, 1, 10, 100),
(2, 1, 50, 100),
(3, 1, 100, 50),
(4, 2, 10, 20),
(5, 2, 50, 20),
(6, 3, 100, 20),
(7, 3, 10, 100),
(8, 2, 100, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `cashboxes`
--

CREATE TABLE `cashboxes` (
  `id` int(11) NOT NULL,
  `city` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `currency_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `cashboxes`
--

INSERT INTO `cashboxes` (`id`, `city`, `model`, `currency_id`) VALUES
(1, 'Poltava', 'dol', 1),
(2, 'sumi', 'gruiv', 2),
(3, 'odesa', 'euro', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `currencies`
--

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL,
  `sign` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `currencies`
--

INSERT INTO `currencies` (`id`, `sign`, `name`) VALUES
(1, '$', 'dollar'),
(2, 'UAH', 'grivna'),
(3, 'EUR', 'euro');

-- --------------------------------------------------------

--
-- Структура таблицы `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `cashbox_id` int(11) NOT NULL,
  `acount_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `logs`
--

INSERT INTO `logs` (`id`, `date`, `cashbox_id`, `acount_id`, `amount`) VALUES
(1, '2019-07-01 07:30:00', 1, 1, 150),
(2, '2019-07-02 12:23:12', 2, 2, 500),
(3, '2019-07-02 15:41:12', 2, 2, 250),
(4, '2019-07-03 08:23:12', 1, 3, 100),
(5, '2019-07-02 16:23:12', 2, 4, 100),
(6, '2019-07-03 10:26:12', 3, 5, 50),
(7, '2019-07-22 16:38:15', 1, 6, 200),
(8, '2019-07-23 16:20:00', 2, 7, 300),
(9, '2019-07-29 00:00:00', 3, 8, 400),
(10, '2019-07-30 18:33:00', 1, 6, 100);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `age`) VALUES
(1, 'Vova', 25),
(2, 'Alla', 35),
(3, 'Stepan', 45);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `currency_id` (`currency_id`);

--
-- Индексы таблицы `amounts`
--
ALTER TABLE `amounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `cashbox_id` (`cashbox_id`);

--
-- Индексы таблицы `cashboxes`
--
ALTER TABLE `cashboxes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `currency_id` (`currency_id`);

--
-- Индексы таблицы `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `cashbox_id` (`cashbox_id`,`acount_id`),
  ADD KEY `acount_id` (`acount_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`);

--
-- Ограничения внешнего ключа таблицы `amounts`
--
ALTER TABLE `amounts`
  ADD CONSTRAINT `amounts_ibfk_1` FOREIGN KEY (`cashbox_id`) REFERENCES `cashboxes` (`id`);

--
-- Ограничения внешнего ключа таблицы `cashboxes`
--
ALTER TABLE `cashboxes`
  ADD CONSTRAINT `cashboxes_ibfk_1` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`);

--
-- Ограничения внешнего ключа таблицы `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`cashbox_id`) REFERENCES `cashboxes` (`id`),
  ADD CONSTRAINT `logs_ibfk_2` FOREIGN KEY (`acount_id`) REFERENCES `accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
