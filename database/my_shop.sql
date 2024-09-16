-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2024 at 05:51 PM
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
(19, 'Female colourful Jeans Waist Span', '1_Femalecol_1724393355.jpg', 'This is a sample product description', '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(20, 'Sdang Club Men\'s Span Slim Fit Soft Jeans SKD0923', '7_SdangClub_1724393670.jpg', 'This is a sample product description', '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(21, 'Women\'s Pretty Slim Blue Jeans', '194_Women\'sPr_1724393840.jpg', 'This is a sample product description', '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(22, 'Wellfurniture Monster Premium Tybo Aquatex Fabric Sofa 3-seater Home Installation', '1_Wellfurnit_1724394119.jpg', 'Sofa/Chair Material: Fabric\nInstallation support method: On-site installation\nSize: 2000 x 980 x 930mm\nColor series: Beige series\nLength: 2000mm\nCoupang product number: 5766926027 - 9785670322', '2024-08-23 15:21:59', '2024-08-23 15:21:59'),
(23, 'Crystal House Kids Dandy Check Shirt T242', '5425_CrystalHo_1724394866.jpg', 'This is a sample product description', '2024-08-23 15:34:26', '2024-08-23 15:34:26'),
(24, 'Lollytree Kids 1-Piece Jeans Shorts', '37173_Lollytree_1724395330.jpg', 'This is a sample product description', '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(25, 'Kisspo Kids City 2-Piece Pants + Armless shirt', '36746_KisspoKid_1724396501.jpg', 'This is a sample product description', '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(26, 'Petitmue Toddler Today Stripe Short Sleeve T-shirt GMECT53', '38496_PetitmueT_1724396913.jpg', 'This is a sample product description', '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(27, 'Samsung Galaxy Z Flip 6 Self-Payment', '1_SamsungGa_1724398130.png', 'This is a sample product description', '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(28, 'Unisex Adidas Shoes Running Galaxy 7', '2219_UnisexAdi_1724399439.jpg', 'This is a sample product description', '2024-08-23 16:50:39', '2024-08-23 16:50:39');

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
(23, 19, 1, 'Female colourful Jeans Waist Span', 'Series', 'Yellow Series', 21000, 4, '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(24, 20, 1, 'Size', '32(L)', 'Season of use: All seasons\nColor series: Black series\nBottom size: Men\'s 32-33 inches\nTarget audience: Men', 42300, 10, '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(25, 21, 1, 'Size', '26(L)', 'Season of use: All seasons\nColor series: Blue series\nBottom size: women\'s 26-29 inches\nTarget audience: Men', 42300, 11, '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(26, 22, 1, 'Size, Color and Material', '2000 x 980 x 930mm - Black - Fabric', 'Season of use: All seasons\nColor series: Blue series\nBottom size: women\'s 26-29 inches\nTarget audience: Men', 551000, 5, '2024-08-23 15:21:59', '2024-08-23 15:21:59'),
(27, 23, 1, 'Size, Color and Material', '150 - Gray - Fabric', 'Country of Origin: China OEM\nProduct material: 100% cotton\nRelease season: Spring/Fall\nSize (age): Long sleeve (longer than wrist)\nSize (Lake): 150/11', 551000, 12, '2024-08-23 15:34:26', '2024-08-23 15:34:26'),
(28, 24, 1, 'Size, Color and Material', '110 (4-5years) - Red - Jeans', 'Country of Origin: INDIA\nMaterial: 100% Cotton\nRelease year: 2023\nRelease season: Summer\nColor series: Beige series', 13700, 20, '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(29, 24, 0, 'Size, Color and Material', '100 (36M and Above ~) - Black - Jeans', 'Country of Origin: INDIA\nMaterial: 100% Cotton\nRelease year: 2023\nRelease season: Summer\nColor series: Beige series', 13700, 17, '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(30, 25, 1, 'Size, Color and Material', 'No 13 - Red - Soft', 'Country of Origin: Korea\nMaterial: 100% cotton\nBottom length: Above knee\nGender: Children\'s\nRelease year: 2024', 17100, 20, '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(31, 25, 0, 'Size, Color and Material', 'No 15 - Blue - Soft', 'Country of Origin: Korea\nMaterial: 100% cotton\nBottom length: Above knee\nGender: Children\'s\nRelease year: 2024', 19900, 3, '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(32, 26, 1, 'Size, Color and Material', '105 - Blue - Soft', 'Country of Origin: Bangladesh\nMaterial: See contents\nQuantity: 1\nPattern/Print: Stripes\nRelease year: 2024', 5000, 11, '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(33, 26, 0, 'Size, Color and Material', '120 - Green - Soft', 'Country of Origin: Bangladesh\nMaterial: See contents\nQuantity: 1\nPattern/Print: Stripes\nRelease year: 2024', 6500, 3, '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(34, 26, 0, 'Size, Color and Material', '120 - Yellow - Soft', 'Country of Origin: Bangladesh\r\nMaterial: See contents\r\nQuantity: 1\r\nPattern/Print: Stripes\r\nRelease year: 2024', 4500, 3, '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(35, 27, 1, 'Size, Color and OS', '5.5 - Purple - Flip-Android 14', 'Cellular carrier: Air Machine\nCore Type: Octacore\nHome Appliance Model: Galaxy Z Flip', 1500000, 33, '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(36, 28, 1, 'Size, Color', '250 - Black', 'Season of use: All seasons\nColor series: Black series', 58000, 12, '2024-08-23 16:50:39', '2024-08-23 16:50:39');

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
(44, 19, '2_1724393356.jpg', '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(45, 19, '3_1724393356.jpg', '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(46, 19, '4_1724393356.jpg', '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(47, 19, '5_1724393356.jpg', '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(48, 19, '6_1724393356.jpg', '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(49, 20, '8_1724393670.jpg', '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(50, 20, '9_1724393670.jpg', '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(51, 20, '10_1724393670.jpg', '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(52, 20, '11_1724393670.jpg', '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(53, 20, '12_1724393670.jpg', '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(54, 21, '195_1724393840.jpg', '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(55, 21, '196_1724393840.jpg', '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(56, 21, '197_1724393840.jpg', '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(57, 21, '198_1724393840.jpg', '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(58, 21, '199_1724393840.jpg', '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(59, 22, '1_1724394119.jpg', '2024-08-23 15:21:59', '2024-08-23 15:21:59'),
(60, 23, '5425_1724394866.jpg', '2024-08-23 15:34:26', '2024-08-23 15:34:26'),
(61, 24, '37172_1724395330.jpg', '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(62, 24, '37173_1724395330.jpg', '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(63, 25, '36746_1724396501.jpg', '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(64, 25, '36747_1724396501.jpg', '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(65, 25, '36748_1724396501.jpg', '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(66, 26, '38987_1724396913.jpg', '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(67, 26, '38989_1724396913.jpg', '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(68, 26, '38988_1724396913.jpg', '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(69, 26, '38496_1724396913.jpg', '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(70, 27, '2_1724398130.png', '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(71, 27, '3_1724398130.png', '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(72, 27, '4_1724398130.png', '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(73, 27, '5_1724398130.png', '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(74, 28, '59943_1724399439.jpg', '2024-08-23 16:50:39', '2024-08-23 16:50:39');

-- --------------------------------------------------------

--
-- Table structure for table `product_like`
--

CREATE TABLE `product_like` (
  `product_like_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_like`
--

INSERT INTO `product_like` (`product_like_id`, `product_id`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 26, 1, '2024-09-14 23:56:27', '2024-09-14 23:56:27');

-- --------------------------------------------------------

--
-- Table structure for table `product_shipping`
--

CREATE TABLE `product_shipping` (
  `product_shipping_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `shipping_type` enum('Free','Paid') NOT NULL DEFAULT 'Free',
  `shipping_amount` decimal(10,0) NOT NULL DEFAULT 0,
  `shipping_company` varchar(255) DEFAULT NULL,
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
(33, 4, 19, '2024-08-23 15:09:16', '2024-08-23 15:09:16'),
(34, 3, 20, '2024-08-23 15:14:30', '2024-08-23 15:14:30'),
(35, 4, 21, '2024-08-23 15:17:20', '2024-08-23 15:17:20'),
(36, 5, 22, '2024-08-23 15:21:59', '2024-08-23 15:21:59'),
(37, 23, 23, '2024-08-23 15:34:26', '2024-08-23 15:34:26'),
(38, 24, 23, '2024-08-23 15:34:26', '2024-08-23 15:34:26'),
(39, 23, 24, '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(40, 24, 24, '2024-08-23 15:42:10', '2024-08-23 15:42:10'),
(41, 23, 25, '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(42, 24, 25, '2024-08-23 16:01:41', '2024-08-23 16:01:41'),
(43, 23, 26, '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(44, 24, 26, '2024-08-23 16:08:33', '2024-08-23 16:08:33'),
(45, 1, 27, '2024-08-23 16:28:50', '2024-08-23 16:28:50'),
(46, 3, 28, '2024-08-23 16:50:39', '2024-08-23 16:50:39'),
(47, 4, 28, '2024-08-23 16:50:39', '2024-08-23 16:50:39');

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
  ADD PRIMARY KEY (`product_like_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `product_shipping`
--
ALTER TABLE `product_shipping`
  ADD PRIMARY KEY (`product_shipping_id`),
  ADD KEY `product_id` (`product_id`);

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
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `product_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `product_images_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `product_like`
--
ALTER TABLE `product_like`
  MODIFY `product_like_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_shipping`
--
ALTER TABLE `product_shipping`
  MODIFY `product_shipping_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
  MODIFY `product_sub_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

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
-- Constraints for table `product_shipping`
--
ALTER TABLE `product_shipping`
  ADD CONSTRAINT `product_shipping_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
