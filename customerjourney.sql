-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2025 at 09:32 AM
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
-- Database: `customerjourney`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `email`) VALUES
(101, 'Karen Maia', 'karenmaia@example.com'),
(102, 'Ellen Chou', 'ellenchouh@example.com'),
(103, 'Robert Brown', 'robertbrown@example.com'),
(104, 'Emily Davis', 'emilydavis@example.com'),
(105, 'Michael Johnson', 'michaeljohnson@example.com'),
(106, 'Sophia Lee', 'sophialee@example.com'),
(107, 'Lucas Taylor', 'lucastaylor@example.com'),
(108, 'Olivia King', 'oliviaking@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `customer_events`
--

CREATE TABLE `customer_events` (
  `event_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `event_type` varchar(50) DEFAULT NULL,
  `event_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_events`
--

INSERT INTO `customer_events` (`event_id`, `customer_id`, `event_type`, `event_date`) VALUES
(1, 105, 'registration', '2024-01-01'),
(2, 106, 'registration', '2024-01-02'),
(3, 107, 'first_purchase', '2024-01-10'),
(4, 108, 'registration', '2024-01-03'),
(5, 105, 'first_purchase', '2024-01-05'),
(6, 106, 'subsequent_purchase', '2024-01-15'),
(7, 107, 'subsequent_purchase', '2024-01-20'),
(8, 108, 'first_purchase', '2024-01-08'),
(9, 105, 'subsequent_purchase', '2024-01-12'),
(10, 107, 'subsequent_purchase', '2024-01-22');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `order_value` decimal(10,2) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `product_id`, `order_value`, `order_date`, `region`) VALUES
(1, 105, 1, 1100.00, '2024-01-15', 'Tangerang Selatan'),
(2, 105, 3, 600.00, '2024-01-17', 'Jakarta Utara'),
(3, 106, 4, 250.00, '2024-01-16', 'Jakarta Barat'),
(4, 106, 5, 900.00, '2024-01-18', 'Jakarta Timur'),
(5, 107, 2, 350.00, '2024-01-20', 'Jakarta Selatan'),
(6, 107, 1, 1300.00, '2024-01-22', 'Jakarta Pusat'),
(7, 108, 1, 1500.00, '2024-01-10', 'Tangerang Selatan'),
(8, 108, 3, 350.00, '2024-01-15', 'Jakarta Barat'),
(9, 105, 5, 700.00, '2024-01-05', 'Jakarta Utara'),
(10, 105, 4, 400.00, '2024-01-12', 'Jakarta Selatan'),
(11, 106, 1, 900.00, '2024-01-15', 'Jakarta Timur'),
(12, 106, 3, 650.00, '2024-01-16', 'Jakarta Pusat');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`) VALUES
(1, 'Super Laptop', 'Electronics'),
(2, 'Premium Smartphone', 'Electronics'),
(3, 'Smartwatch', 'Electronics'),
(4, 'Office Chair', 'Furniture'),
(5, 'Gaming Monitor', 'Electronics');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_events`
--
ALTER TABLE `customer_events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    o.order_id,
    o.order_value,
    o.order_date
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_date = (
        SELECT MAX(order_date)
        FROM orders 
        WHERE customer_id = c.customer_id
    );
