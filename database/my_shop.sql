-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 09, 2024 at 07:24 PM
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
-- Database: `my_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_attributes_id` int(11) NOT NULL,
  `cart_qty` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `category_description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `category_description`, `created_at`, `updated_at`) VALUES
(11, 'Electronics', 'Contains all Electronics stuff', '2024-08-08 23:48:57', '2024-08-08 23:48:57'),
(12, 'Fashion', 'Contains all Fashion/clothes and related stuff', '2024-08-08 23:49:21', '2024-08-08 23:49:21'),
(13, 'Home & Garden', 'Contains all house and related stuff', '2024-08-08 23:50:06', '2024-08-08 23:50:06'),
(14, 'Health & Beauty', 'Contains beauty and cosmestics and related items', '2024-08-08 23:50:34', '2024-08-08 23:50:34'),
(15, 'Toys & Games', 'Contains kids, playing and related items', '2024-08-08 23:51:01', '2024-08-08 23:51:01'),
(16, 'Books & Media', NULL, '2024-08-08 23:51:18', '2024-08-08 23:51:18'),
(17, 'Sports', NULL, '2024-08-08 23:51:30', '2024-08-08 23:51:30'),
(18, 'Automotive', 'Car accessories, auto electronics and related items', '2024-08-08 23:52:32', '2024-08-08 23:52:32'),
(19, 'Jewelry & Watches', NULL, '2024-08-08 23:52:51', '2024-08-08 23:52:51'),
(20, 'Apparel Accessories', 'Fancy men and wowen Accessories', '2024-08-09 21:24:03', '2024-08-09 21:24:03'),
(21, 'Kids Clothing', 'Kids clothes', '2024-08-09 23:04:45', '2024-08-09 23:04:45');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_details_id` int(11) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_attributes_id` int(11) NOT NULL,
  `cart_qty` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `payment_details_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `provider` enum('Complete','Failed','Pending','Canceled') NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `cover` varchar(255) NOT NULL DEFAULT 'noimage.jpg',
  `product_description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `cover`, `product_description`, `created_at`, `updated_at`) VALUES
(7, 'Converse All Star Limited Edition', '7799_ConverseA_1723192134.jpg', 'This is a sample product description', '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(8, 'Stylehorn Gavin Polarized Sunglasses', '17308_Stylehorn_1723206840.jpg', 'This is a sample product description', '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(9, 'Business Men\'s Quartz Watch', '17417_BusinessM_1723207540.jpg', 'This is a sample product description', '2024-08-09 21:45:40', '2024-08-09 21:45:40'),
(10, 'Vans Unisex Old School Black', '17706_VansUnise_1723208256.jpg', 'This is a sample product description', '2024-08-09 21:57:36', '2024-08-09 21:57:36'),
(16, 'Vans Unisex Old Canvas', '17692_VansUnise_1723208870.jpg', 'This is a sample product description', '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(17, 'Men\'s Panties Drawers Square Functional Long Drawers', '17857_Men\'sPant_1723209973.jpg', 'This is a sample product description |  Season of use: All seasons', '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(18, '0-12 years twin shirt', '3813_0-12years_1723212682.jpg', 'This is a sample product description |  Season of use: All seasons', '2024-08-09 23:11:22', '2024-08-09 23:11:22');

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `product_attributes_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_attributes_default` tinyint(1) NOT NULL DEFAULT 1,
  `product_attributes_name` varchar(255) NOT NULL,
  `product_attributes_value` varchar(255) NOT NULL,
  `product_attributes_summary` text DEFAULT NULL,
  `product_attributes_price` decimal(10,0) NOT NULL,
  `product_attributes_stock_qty` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`product_attributes_id`, `product_id`, `product_attributes_default`, `product_attributes_name`, `product_attributes_value`, `product_attributes_summary`, `product_attributes_price`, `product_attributes_stock_qty`, `created_at`, `updated_at`) VALUES
(6, 7, 1, 'Size', '8', 'This is a product sample attribute description', 200000, 15, '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(7, 8, 1, 'Frame Color', 'Black', 'WARNING: Fashion Glasses. Not to be worn outside to protect the eyes against strong sunlight. Not designed or intended for use in play by children', 10000, 11, '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(8, 9, 1, 'Watch Shape', 'Round', 'Strap Material:	Zinc Alloy, PU Leather\nDial Color:	Orange\nWater Resistance:	No Waterproof\nGender:	Men\nStyle:	Casual, Simple\nType:	Wrist Watches\nBoxes Included:	No\nScale Display:	Bar Scale\nCase Material:	Zinc Alloy\nSpecular Material:	Mineral Glass\nPower Supply:	Battery Powered(Button/Coin Cell Battery)', 200000, 4, '2024-08-09 21:45:40', '2024-08-09 21:45:40'),
(9, 10, 1, 'Color', 'Black Series | All Seasons', 'Strap Material:	Zinc Alloy, PU Leather\nDial Color:	Orange\nWater Resistance:	No Waterproof\nGender:	Men\nStyle:	Casual, Simple\nType:	Wrist Watches\nBoxes Included:	No\nScale Display:	Bar Scale\nCase Material:	Zinc Alloy\nSpecular Material:	Mineral Glass\nPower Supply:	Battery Powered(Button/Coin Cell Battery)', 56000, 23, '2024-08-09 21:57:36', '2024-08-09 21:57:36'),
(18, 16, 1, 'Color', 'Red Series | All Seasons', 'This is a description for first Product', 33500, 17, '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(19, 16, 0, 'Color', 'Maron Series | All Seasons', NULL, 41000, 10, '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(20, 17, 1, 'Tape Multicolor Set', '95% Polyester, 5% Elastane', 'This is a description for first Product', 15000, 50, '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(21, 18, 1, 'Color', 'Yellow Shirt', 'This is a description for first Product attribute 1', 5000, 12, '2024-08-09 23:11:22', '2024-08-09 23:11:22'),
(22, 18, 0, 'Color', 'Black Shirt', 'Description goes here', 5200, 24, '2024-08-09 23:11:22', '2024-08-09 23:11:22');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `product_images_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `img_url` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`product_images_id`, `product_id`, `img_url`, `created_at`, `updated_at`) VALUES
(16, 7, '3594_1723192134.jpg', '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(17, 7, '3798_1723192134.jpg', '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(18, 7, '9001_1723192134.jpg', '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(19, 8, '17209_1723206841.jpg', '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(20, 8, '17210_1723206841.jpg', '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(21, 8, '17215_1723206841.jpg', '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(22, 9, '17417_1723207540.jpg', '2024-08-09 21:45:40', '2024-08-09 21:45:40'),
(23, 10, '17704_1723208256.jpg', '2024-08-09 21:57:36', '2024-08-09 21:57:36'),
(33, 16, '17695_1723208870.jpg', '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(34, 16, '17692_1723208870.jpg', '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(35, 16, '17708_1723208870.jpg', '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(36, 17, '17858_1723209973.jpg', '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(37, 17, '17859_1723209973.jpg', '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(38, 17, '17861_1723209973.jpg', '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(39, 17, '17862_1723209973.jpg', '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(40, 18, '3813_1723212682.jpg', '2024-08-09 23:11:22', '2024-08-09 23:11:22'),
(41, 18, '3814_1723212682.jpg', '2024-08-09 23:11:22', '2024-08-09 23:11:22'),
(42, 18, '3816_1723212682.jpg', '2024-08-09 23:11:22', '2024-08-09 23:11:22'),
(43, 18, '3815_1723212682.jpg', '2024-08-09 23:11:22', '2024-08-09 23:11:22');

-- --------------------------------------------------------

--
-- Table structure for table `product_like`
--

CREATE TABLE `product_like` (
  `product_like` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_sub_category`
--

CREATE TABLE `product_sub_category` (
  `product_sub_category_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_sub_category`
--

INSERT INTO `product_sub_category` (`product_sub_category_id`, `sub_category_id`, `product_id`, `created_at`, `updated_at`) VALUES
(11, 3, 7, '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(12, 4, 7, '2024-08-09 17:28:54', '2024-08-09 17:28:54'),
(13, 22, 8, '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(14, 21, 8, '2024-08-09 21:34:01', '2024-08-09 21:34:01'),
(15, 19, 9, '2024-08-09 21:45:40', '2024-08-09 21:45:40'),
(16, 3, 10, '2024-08-09 21:57:36', '2024-08-09 21:57:36'),
(17, 4, 10, '2024-08-09 21:57:36', '2024-08-09 21:57:36'),
(28, 3, 16, '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(29, 4, 16, '2024-08-09 22:07:50', '2024-08-09 22:07:50'),
(30, 3, 17, '2024-08-09 22:26:13', '2024-08-09 22:26:13'),
(31, 23, 18, '2024-08-09 23:11:22', '2024-08-09 23:11:22'),
(32, 4, 18, '2024-08-09 23:11:22', '2024-08-09 23:11:22');

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `sub_category_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `sub_category_name` varchar(255) NOT NULL,
  `sub_category_description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`sub_category_id`, `category_id`, `sub_category_name`, `sub_category_description`, `created_at`, `updated_at`) VALUES
(1, 11, 'Mobile Phones', NULL, '2024-08-09 00:10:50', '2024-08-09 00:10:50'),
(2, 11, 'Laptops & Computers', NULL, '2024-08-09 00:11:07', '2024-08-09 00:11:07'),
(3, 12, 'Men’s Clothing', NULL, '2024-08-09 00:11:20', '2024-08-09 00:11:20'),
(4, 12, 'Women’s Clothing', NULL, '2024-08-09 00:11:32', '2024-08-09 00:11:32'),
(5, 13, 'Furniture', NULL, '2024-08-09 00:12:18', '2024-08-09 00:12:18'),
(6, 13, 'Bedding', NULL, '2024-08-09 00:12:25', '2024-08-09 00:12:25'),
(7, 14, 'Skincare', NULL, '2024-08-09 00:12:35', '2024-08-09 00:12:35'),
(8, 14, 'Makeup', NULL, '2024-08-09 00:12:44', '2024-08-09 00:12:44'),
(9, 15, 'Action Figures', NULL, '2024-08-09 00:13:55', '2024-08-09 00:13:55'),
(10, 15, 'Board Games', NULL, '2024-08-09 00:14:04', '2024-08-09 00:14:04'),
(11, 16, 'Books', NULL, '2024-08-09 00:14:15', '2024-08-09 00:14:15'),
(12, 16, 'Movies', NULL, '2024-08-09 00:14:22', '2024-08-09 00:14:22'),
(13, 17, 'Fitness Equipment', NULL, '2024-08-09 00:14:34', '2024-08-09 00:14:34'),
(14, 17, 'Camping Gear', NULL, '2024-08-09 00:14:49', '2024-08-09 00:14:49'),
(15, 18, 'Car Accessories', NULL, '2024-08-09 00:15:00', '2024-08-09 00:15:00'),
(16, 18, 'Car Care', NULL, '2024-08-09 00:15:08', '2024-08-09 00:15:08'),
(17, 19, 'Fine Jewelry', NULL, '2024-08-09 00:15:20', '2024-08-09 00:15:20'),
(18, 19, 'Fashion Jewelry', NULL, '2024-08-09 00:15:29', '2024-08-09 00:15:29'),
(19, 20, 'Men Accessories', NULL, '2024-08-09 21:25:16', '2024-08-09 21:25:16'),
(20, 20, 'Women Accessories', NULL, '2024-08-09 21:25:16', '2024-08-09 21:25:16'),
(21, 20, 'Customized Accessories', NULL, '2024-08-09 21:25:35', '2024-08-09 21:25:35'),
(22, 20, 'Gender Neutral Accessories', NULL, '2024-08-09 21:26:18', '2024-08-09 21:26:18'),
(23, 21, 'Boys\' Clothing', 'boy\'s clothing', '2024-08-09 23:05:43', '2024-08-09 23:05:43'),
(24, 21, 'Girls\' Clothing', 'girls\' Clothing', '2024-08-09 23:05:43', '2024-08-09 23:05:43');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `last_name`, `phone`, `email`, `password`, `is_admin`, `profile_img`, `is_verified`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Vitu', 'Mafeni', '+265882992942', NULL, '$2y$10$zhdNbM.B1S1ufHgv8JWA8exceMEZC.vZXrxcphmCWKbz/HmoGpAdq', 0, 'noimage.jpg', 2, 1, '2022-09-17 00:51:21', '2022-09-17 00:51:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_attributes_id` (`product_attributes_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `payment_details_id` (`payment_details_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `cart_id` (`order_id`),
  ADD KEY `product_attributes_id` (`product_attributes_id`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`payment_details_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`product_attributes_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`product_images_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_like`
--
ALTER TABLE `product_like`
  ADD PRIMARY KEY (`product_like`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
  ADD PRIMARY KEY (`product_sub_category_id`),
  ADD KEY `sub_category_id` (`sub_category_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`sub_category_id`),
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
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_item`
--
ALTER TABLE `cart_item`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_details`
--
ALTER TABLE `payment_details`
  MODIFY `payment_details_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `product_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `product_images_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `product_like`
--
ALTER TABLE `product_like`
  MODIFY `product_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
  MODIFY `product_sub_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `sub_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`product_attributes_id`) REFERENCES `product_attributes` (`product_attributes_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_details_id`) REFERENCES `payment_details` (`payment_details_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_attributes_id`) REFERENCES `product_attributes` (`product_attributes_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_like`
--
ALTER TABLE `product_like`
  ADD CONSTRAINT `product_like_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_like_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
  ADD CONSTRAINT `product_sub_category_ibfk_1` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_category` (`sub_category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_sub_category_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD CONSTRAINT `sub_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
