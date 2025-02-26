-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2025 at 07:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `farmease`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(255) NOT NULL,
  `admin_email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `admin_email`, `password`) VALUES
(1, 'admin@gmail.com', '$2y$10$PkNjHboSSiclj79pkqP5bO6sZTnULvv7RqYIW7ThdtwjalXvId1Ba');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(255) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(255) NOT NULL,
  `farmer_email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `farmer_name` varchar(255) NOT NULL,
  `stock` int(20) UNSIGNED NOT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `farmer_id` int(255) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `category`, `farmer_email`, `phone_number`, `farmer_name`, `stock`, `product_image`, `farmer_id`) VALUES
(27, 'tractor', 3214.00, 'Tools', 'ashik@gmail.com', '9999999999', 'ashik', 1, 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg', 1),
(29, 'tomato', 56.00, 'Vegetables', 'ashik@gmail.com', '9999999999', 'ashik', 45, 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQEBUQEBAPEBAQFRAQDw8VFRAPDw4QFxUWFxUVFRUYHSggGBolGxUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGhAQFy0lHSUtLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLSstKy0tLS0tLS0tLS0tLf/AABEIAM0A9gMBEQACEQEDEQH/', 1),
(30, 'tomato', 70.00, 'Vegetables', 'ashik@gmail.com', '9999999999', 'ashik', 50, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4t2GRCI-vxm730F6OC76aQIhTeoEVnGLYOQ&s', 1),
(31, 'apple', 80.00, 'Fruits', 'arya@gmail.com', '9999999999', 'arya', 55, 'https://hips.hearstapps.com/hmg-prod/images/ripe-apple-royalty-free-image-1659454396.jpg?crop=0.924xw:0.679xh;0.0197xw,0.212xh&resize=980:*', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id` int(255) UNSIGNED NOT NULL,
  `user_first_name` varchar(255) NOT NULL,
  `user_last_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_email`, `password`, `id`, `user_first_name`, `user_last_name`) VALUES
('ashik@gmail.com', '$2y$10$jomj9LRy1jx2ec3tgHqUY.eFx2SlN8tVqeyWLpBFqcxVBUKfM/9DC', 1, 'ashik', 'vm'),
('arya@gmail.com', '$2y$10$ufcuuXEniKc38QEZJwQ8reZ4Ifqk2ShLOj1.OsF3O46YBAxTXeske', 2, 'arya', 'santhosh'),
('ansa@gmail.com', '$2y$10$VxzGSD.egLf2hzU2sOluturIhKCUbZJd1RVSVVFHafuMh4N.wavzC', 3, 'ansa', 'george');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_farmer` (`farmer_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_farmer` FOREIGN KEY (`farmer_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
