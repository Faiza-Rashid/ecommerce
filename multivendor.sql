-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2025 at 11:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `multivendor`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`) VALUES
(1, 'Electronics', '2025-10-05 14:48:12'),
(2, 'Clothing', '2025-10-05 14:48:12'),
(3, 'Books', '2025-10-05 14:48:12'),
(4, 'Home Appliances', '2025-10-05 15:29:10'),
(5, 'Sports', '2025-10-05 15:29:10'),
(6, 'Toys', '2025-10-05 15:29:10'),
(7, 'Beauty & Health', '2025-10-05 15:29:10');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total`, `status`, `created_at`) VALUES
(1, 3, 500.00, 'pending', '2025-10-05 14:54:25'),
(2, 4, 150.00, 'pending', '2025-10-05 15:29:10'),
(3, 5, 180.00, 'processing', '2025-10-05 15:29:10'),
(4, 3, 500.00, 'completed', '2025-10-05 15:29:10');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `image` varchar(255) DEFAULT 'placeholder.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `category` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `vendor_id`, `category_id`, `name`, `description`, `price`, `stock`, `image`, `created_at`, `category`) VALUES
(1, 2, 1, 'Smartphone', 'Latest model smartphone', 500.00, 10, 'placeholder.png', '2025-10-05 14:48:12', NULL),
(2, 2, 2, 'T-Shirt', 'Cotton t-shirt', 20.00, 50, 'placeholder.png', '2025-10-05 14:48:12', NULL),
(3, 2, 3, 'Novel Book', 'Bestselling novel', 15.00, 30, 'placeholder.png', '2025-10-05 14:48:12', NULL),
(4, 2, 4, 'Blender', 'High-speed blender for smoothies', 120.00, 15, 'placeholder.png', '2025-10-05 15:29:10', NULL),
(5, 2, 5, 'Basketball', 'Official size basketball', 30.00, 20, 'placeholder.png', '2025-10-05 15:29:10', NULL),
(6, 3, 6, 'Action Figure', 'Collectible action figure', 45.00, 25, 'placeholder.png', '2025-10-05 15:29:10', NULL),
(7, 3, 7, 'Lipstick Set', 'Assorted lipstick colors', 60.00, 10, 'placeholder.png', '2025-10-05 15:29:10', NULL),
(54, 2, NULL, 'Laptop', 'High-performance laptop for professionals and gamers.', 950.00, 0, 'images/laptop1.jpg', '2025-10-06 05:12:12', 'Electronics'),
(55, 2, NULL, 'Laptop', 'Portable laptop with latest generation processor.', 870.00, 0, 'images/laptop3.jpg', '2025-10-06 05:12:12', 'Electronics'),
(56, 2, NULL, 'Laptop', 'Ultra-slim laptop with long battery life.', 1050.00, 0, 'images/laptop4.jpg', '2025-10-06 05:12:12', 'Electronics'),
(57, 2, NULL, 'Mobile Phone', 'Latest smartphone with 5G support and AMOLED display.', 699.00, 0, 'images/mobile1.jpg', '2025-10-06 05:12:12', 'Electronics'),
(58, 2, NULL, 'Mobile Phone', 'Affordable Android phone with great camera.', 350.00, 0, 'images/mobile2.jpg', '2025-10-06 05:12:12', 'Electronics'),
(59, 2, NULL, 'Mobile Phone', 'Flagship smartphone with long-lasting battery.', 899.00, 0, 'images/mobile3.jpg', '2025-10-06 05:12:12', 'Electronics'),
(60, 2, NULL, 'Camera', 'Professional DSLR camera for photography lovers.', 1200.00, 0, 'images/camera1.jpg', '2025-10-06 05:12:12', 'Electronics'),
(61, 2, NULL, 'Camera', 'Compact digital camera with 4K video support.', 799.00, 0, 'images/camera2.jpg', '2025-10-06 05:12:12', 'Electronics'),
(62, 2, NULL, 'Camera', 'Mirrorless camera with high-resolution sensor.', 1100.00, 0, 'images/camera3.jpg', '2025-10-06 05:12:12', 'Electronics'),
(63, 2, NULL, 'Smart Watch', 'Fitness tracking smartwatch with heart-rate monitor.', 199.00, 0, 'images/smartwatch1.jpg', '2025-10-06 05:12:12', 'Wearable'),
(64, 2, NULL, 'Smart Watch', 'Stylish smartwatch with AMOLED display.', 220.00, 0, 'images/smartwatch2.jpg', '2025-10-06 05:12:12', 'Wearable'),
(65, 2, NULL, 'Bluetooth Speaker', 'Portable Bluetooth speaker with powerful bass.', 150.00, 0, 'images/speaker1.jpg', '2025-10-06 05:12:12', 'Audio'),
(66, 2, NULL, 'Bluetooth Speaker', 'Mini Bluetooth speaker with waterproof design.', 90.00, 0, 'images/speaker2.jpg', '2025-10-06 05:12:12', 'Audio'),
(67, 2, NULL, 'Headphones', 'Noise-cancelling over-ear headphones.', 180.00, 0, 'images/headphone1.jpg', '2025-10-06 05:12:12', 'Audio'),
(68, 2, NULL, 'Headphones', 'Wireless headphones with deep bass.', 160.00, 0, 'images/headphone2.jpg', '2025-10-06 05:12:12', 'Audio'),
(69, 2, NULL, 'Drone', 'Professional drone with 4K camera and GPS.', 799.00, 0, 'images/drone1.jpg', '2025-10-06 05:12:12', 'Gadgets'),
(70, 2, NULL, 'Drone', 'Mini drone with WiFi FPV and HD camera.', 399.00, 0, 'images/drone2.jpg', '2025-10-06 05:12:12', 'Gadgets'),
(71, 2, NULL, 'Gaming Chair', 'Ergonomic gaming chair with adjustable armrests.', 299.00, 0, 'images/gamingchair1.jpg', '2025-10-06 05:12:12', 'Gaming'),
(72, 2, NULL, 'Gaming Chair', 'Luxury gaming chair with lumbar support.', 350.00, 0, 'images/gamingchair2.jpg', '2025-10-06 05:12:12', 'Gaming'),
(73, 2, NULL, 'Gaming Mouse', 'High-DPI RGB gaming mouse for precision control.', 75.00, 0, 'images/gamingmouse1.jpg', '2025-10-06 05:12:12', 'Gaming'),
(74, 2, NULL, 'Gaming Mouse', 'Wireless gaming mouse with adjustable DPI.', 85.00, 0, 'images/gamingmouse2.jpg', '2025-10-06 05:12:12', 'Gaming'),
(75, 2, NULL, 'Wireless Earbuds', 'Bluetooth 5.3 earbuds with noise cancellation.', 99.00, 0, 'images/wirelessearbuds1.jpg', '2025-10-06 05:12:12', 'Audio'),
(76, 2, NULL, 'Wireless Earbuds', 'Compact earbuds with long battery life.', 79.00, 0, 'images/wirelessearbuds2.jpg', '2025-10-06 05:12:12', 'Audio'),
(77, 2, NULL, 'Laptop', 'High-performance laptop for professionals and gamers.', 950.00, 0, 'images/laptop1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(78, 2, NULL, 'Laptop', 'Portable laptop with latest generation processor.', 870.00, 0, 'images/laptop3.jpg', '2025-10-06 05:13:34', 'Electronics'),
(79, 2, NULL, 'Laptop', 'Ultra-slim laptop with long battery life.', 1050.00, 0, 'images/laptop4.jpg', '2025-10-06 05:13:34', 'Electronics'),
(80, 4, NULL, 'Mobile Phone', 'Latest smartphone with 5G support and AMOLED display.', 699.00, 0, 'images/mobile1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(81, 4, NULL, 'Mobile Phone', 'Affordable Android phone with great camera.', 350.00, 0, 'images/mobile2.jpg', '2025-10-06 05:13:34', 'Electronics'),
(82, 4, NULL, 'Mobile Phone', 'Flagship smartphone with long-lasting battery.', 899.00, 0, 'images/mobile3.jpg', '2025-10-06 05:13:34', 'Electronics'),
(83, 4, NULL, 'Camera', 'Professional DSLR camera for photography lovers.', 1200.00, 0, 'images/camera1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(84, 4, NULL, 'Camera', 'Compact digital camera with 4K video support.', 799.00, 0, 'images/camera2.jpg', '2025-10-06 05:13:34', 'Electronics'),
(85, 4, NULL, 'Camera', 'Mirrorless camera with interchangeable lenses.', 1050.00, 0, 'images/camera3.jpg', '2025-10-06 05:13:34', 'Electronics'),
(86, 5, NULL, 'Smart Watch', 'Fitness tracking smartwatch with heart-rate monitor.', 199.00, 0, 'images/smartwatch1.jpg', '2025-10-06 05:13:34', 'Wearable'),
(87, 5, NULL, 'Smart Watch', 'Smartwatch with GPS and sleep tracking.', 249.00, 0, 'images/smartwatch2.jpg', '2025-10-06 05:13:34', 'Wearable'),
(88, 5, NULL, 'Smart Watch', 'Luxury smartwatch with OLED display.', 399.00, 0, 'images/smartwatch3.jpg', '2025-10-06 05:13:34', 'Wearable'),
(89, 2, NULL, 'Bluetooth Speaker', 'Portable Bluetooth speaker with deep bass.', 120.00, 0, 'images/speaker1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(90, 2, NULL, 'Bluetooth Speaker', 'Waterproof outdoor speaker.', 150.00, 0, 'images/speaker2.jpg', '2025-10-06 05:13:34', 'Electronics'),
(91, 2, NULL, 'Bluetooth Speaker', 'Mini wireless speaker for travel.', 80.00, 0, 'images/speaker3.jpg', '2025-10-06 05:13:34', 'Electronics'),
(92, 2, NULL, 'Headphones', 'Over-ear headphones with noise cancellation.', 199.00, 0, 'images/headphone1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(93, 2, NULL, 'Headphones', 'Wireless in-ear headphones with great sound.', 129.00, 0, 'images/headphone2.jpg', '2025-10-06 05:13:34', 'Electronics'),
(94, 2, NULL, 'Headphones', 'Gaming headset with microphone.', 149.00, 0, 'images/headphone3.jpg', '2025-10-06 05:13:34', 'Electronics'),
(95, 4, NULL, 'Drone', 'High-end drone with 4K camera.', 1200.00, 0, 'images/drone1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(96, 4, NULL, 'Drone', 'Compact drone for beginners.', 450.00, 0, 'images/drone2.jpg', '2025-10-06 05:13:34', 'Electronics'),
(97, 4, NULL, 'Drone', 'Racing drone with fast speed.', 800.00, 0, 'images/drone3.jpg', '2025-10-06 05:13:34', 'Electronics'),
(98, 5, NULL, 'Gaming Chair', 'Ergonomic gaming chair with lumbar support.', 350.00, 0, 'images/gamingchair1.jpg', '2025-10-06 05:13:34', 'Furniture'),
(99, 5, NULL, 'Gaming Chair', 'Comfortable swivel chair for long gaming sessions.', 400.00, 0, 'images/gamingchair2.jpg', '2025-10-06 05:13:34', 'Furniture'),
(100, 2, NULL, 'Gaming Mouse', 'High-precision RGB gaming mouse.', 60.00, 0, 'images/gamingmouse1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(101, 2, NULL, 'Gaming Mouse', 'Wireless gaming mouse with adjustable DPI.', 75.00, 0, 'images/gamingmouse2.jpg', '2025-10-06 05:13:34', 'Electronics'),
(102, 4, NULL, 'Wireless Earbuds', 'True wireless earbuds with noise cancellation.', 120.00, 0, 'images/wirelessearbuds1.jpg', '2025-10-06 05:13:34', 'Electronics'),
(103, 4, NULL, 'Wireless Earbuds', 'Compact earbuds with long battery life.', 80.00, 0, 'images/wirelessearbuds2.jpg', '2025-10-06 05:13:34', 'Electronics');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','vendor','admin') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Admin User', 'admin@example.com', '0192023a7bbd73250516f069df18b500', 'admin', '2025-10-05 14:48:12'),
(2, 'Vendor One', 'vendor@example.com', '6c6e1464695ec20feb0b2a633f9cf27b', 'vendor', '2025-10-05 14:48:12'),
(3, 'Customer One', 'customer@example.com', 'f4ad231214cb99a985dff0f056a36242', 'customer', '2025-10-05 14:48:12'),
(4, 'Vendor Two', 'vendor2@example.com', '6c6e1464695ec20feb0b2a633f9cf27b', 'vendor', '2025-10-05 15:29:10'),
(5, 'Vendor Three', 'vendor3@example.com', '6c6e1464695ec20feb0b2a633f9cf27b', 'vendor', '2025-10-05 15:29:10'),
(6, 'Customer Two', 'customer2@example.com', 'f4ad231214cb99a985dff0f056a36242', 'customer', '2025-10-05 15:29:10'),
(7, 'Customer Three', 'customer3@example.com', 'f4ad231214cb99a985dff0f056a36242', 'customer', '2025-10-05 15:29:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
