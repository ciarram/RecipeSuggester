-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2021 at 07:00 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340`
--

-- --------------------------------------------------------

--
-- Table structure for table `favorite_recipes`
--

CREATE TABLE `favorite_recipes` (
  `u_ID` int(11) NOT NULL,
  `r_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favorite_recipes`
--

INSERT INTO `favorite_recipes` (`u_ID`, `r_ID`) VALUES
(1, 1),
(1, 2),
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredient_ID` int(11) NOT NULL,
  `ingredient_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredient_ID`, `ingredient_name`) VALUES
(1, 'Garlic'),
(2, 'Apples'),
(3, 'Basil'),
(4, 'Quinoa'),
(5, 'White Rice'),
(6, 'Tomato'),
(7, 'Balsamic Vinegar');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `recipe_ID` int(11) NOT NULL,
  `recipe_name` varchar(255) NOT NULL,
  `recipe_description` text,
  `recipe_type` varchar(32) DEFAULT NULL,
  `recipe_origin` varchar(64) DEFAULT NULL,
  `prep_time` time DEFAULT NULL,
  `cook_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipe_ID`, `recipe_name`, `recipe_description`, `recipe_type`, `recipe_origin`, `prep_time`, `cook_time`) VALUES
(1, 'Stir Fry', 'Step 1: Cook the white rice for 15 - 20 minutes.\nStep 2: Heat oil in a pan on medium high heat.\nStep 3: Add garlic and cook for 30 seconds.\nStep 4: ...', 'Entree', 'http:www.example-recipe.com', '00:00:15', '00:00:20'),
(2, 'Bruschetta', 'Step 1: Roughly chop 2 - 3 large tomatoes and place in a medium bowl. \nStep 2: Take 2 - 3 tablebspoons of balsalmic vinegear, 2 cloves of garlic, 1 tablespoon fresh basil and a pinch of salt and combine in bowl with tomatoes.\nStep 3: Let the tomato mixture sit and marinate for at least 20 minutes.\nStep 4: Toast some bread, place the mixture on the toast and Enjoy!', 'Appetizer', 'http:www.example-recipe.com', '00:00:10', '00:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ingredients`
--

CREATE TABLE `recipe_ingredients` (
  `i_ID` int(11) NOT NULL,
  `r_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recipe_ingredients`
--

INSERT INTO `recipe_ingredients` (`i_ID`, `r_ID`) VALUES
(1, 1),
(1, 2),
(3, 2),
(5, 1),
(6, 2),
(7, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_ID` int(11) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `date_created` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_ID`, `user_name`, `email`, `date_created`) VALUES
(1, 'homecook27', 'johndoe@email.com', '2021-02-11'),
(2, 'janedoe97', 'janed97@email.com', '2021-02-16');

-- --------------------------------------------------------

--
-- Table structure for table `user_ingredients`
--

CREATE TABLE `user_ingredients` (
  `u_ID` int(11) NOT NULL,
  `i_ID` int(11) NOT NULL,
  `ingredient_amount` int(11) DEFAULT NULL,
  `ingredient_unit` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_ingredients`
--

INSERT INTO `user_ingredients` (`u_ID`, `i_ID`, `ingredient_amount`, `ingredient_unit`) VALUES
(1, 1, 2, 'oz'),
(1, 3, 5, 'oz'),
(1, 4, 5, 'lbs'),
(2, 2, 1, 'lbs'),
(2, 4, 3, 'lbs');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorite_recipes`
--
ALTER TABLE `favorite_recipes`
  ADD PRIMARY KEY (`u_ID`,`r_ID`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredient_ID`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipe_ID`);

--
-- Indexes for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD PRIMARY KEY (`i_ID`,`r_ID`),
  ADD KEY `r_id` (`r_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_ID`);

--
-- Indexes for table `user_ingredients`
--
ALTER TABLE `user_ingredients`
  ADD PRIMARY KEY (`u_ID`,`i_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredient_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `recipe_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD CONSTRAINT `recipe_ingredients_ibfk_1` FOREIGN KEY (`i_id`) REFERENCES `ingredients` (`ingredient_ID`),
  ADD CONSTRAINT `recipe_ingredients_ibfk_2` FOREIGN KEY (`r_id`) REFERENCES `recipes` (`recipe_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
