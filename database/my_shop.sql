-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2022 at 05:57 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `my_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `created_at`, `updated_at`) VALUES
(2, 'Laptops', '2022-08-17 10:56:14', '2022-08-17 10:56:14'),
(4, 'Desktops', '2022-08-17 10:56:34', '2022-08-17 10:56:34'),
(5, 'Phone Accessories', '2022-08-17 10:56:54', '2022-08-17 10:56:54'),
(6, 'Laptop Accessories', '2022-08-17 10:57:01', '2022-08-17 10:57:01'),
(7, 'Games', '2022-08-17 10:57:16', '2022-08-17 10:57:16'),
(9, 'Cellphone', '2022-08-31 14:08:46', '2022-08-31 14:08:46');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `img_url` varchar(255) NOT NULL DEFAULT 'noimage.jpg',
  `product_description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `category_id`, `product_name`, `qty`, `price`, `img_url`, `product_description`, `created_at`, `updated_at`) VALUES
(3, 2, 'HP Laptop - 17z-cp000', 5, '55000', 'WIN_20220831_02_29_12_Pro_1661880571.jpg', 'Windows 11 Home\nAMD Athlon™ Gold 3150U (2.4 GHz, up to 3.3 GHz, 4 MB L3 cache, 2 cores) + AMD Radeon™ Graphics\n8 GB DDR4-2400 SDRAM (1 x 8 GB)\n128 GB PCIe® NVMe™ TLC M.2 SSD', '2022-08-31 02:29:32', '2022-08-31 02:29:32'),
(4, 9, 'IPhone X', 3, '130000', 'iphone_1661922669.png', 'Apple iPhone X is the latest iPhone to mark Apple\'s 10th anniversary. It is powered by Apple\'s latest A11 Bionic chip. It comes with 5.8 inch SuperRetina Display,Dolby vision and HRD10 and Dual 12MP rear cameras one wide-angle with f/1.8 aperture. Dual core Neural engine for face ID', '2022-08-31 14:11:09', '2022-08-31 14:11:09'),
(5, 2, 'Macbook Air 2020', 7, '1300000', 'macbook_1661922760.png', 'Apple bundles each MacBook with the OS X operating system. On each computer there\'s a dual-core processor from Intel’s Intel Core brand, with Turbo Boost technology for increased performance. Each MacBook Air gets a mid-range Intel Core i5, with a processing speed of 1.7 or 1.8 GHz. The 13-inch MacBook Pro has a 2.5- or 2.9-GHz chip, while the one on the 15-inch MacBook Pro is a more powerful but slower 2.3 GHz quad-core Intel Core i7. Peak installed memory on the MacBook Air is 8GB, with 1600MHz DDR3 architecture.', '2022-08-31 14:12:41', '2022-08-31 14:12:41');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` int(11) NOT NULL DEFAULT 0 COMMENT '1 = person is admin, 0 is not',
  `profile_img` varchar(255) DEFAULT 'noimage.jpg',
  `is_verified` int(11) NOT NULL DEFAULT 0 COMMENT '1 = person is email/phone verified, 0 is not',
  `is_active` int(11) NOT NULL DEFAULT 1 COMMENT '1 = person is active, 0 is not',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `last_name`, `phone`, `email`, `password`, `is_admin`, `profile_img`, `is_verified`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Vitu', 'Mafeni', '+265882992942', NULL, '$2y$10$zhdNbM.B1S1ufHgv8JWA8exceMEZC.vZXrxcphmCWKbz/HmoGpAdq', 0, 'noimage.jpg', 2, 1, '2022-09-17 00:51:21', '2022-09-17 00:51:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
