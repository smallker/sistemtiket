-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 12, 2020 at 11:42 PM
-- Server version: 5.7.31-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistemtiket`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `email` text NOT NULL,
  `dokter` text NOT NULL,
  `waktu` bigint(20) DEFAULT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `email`, `dokter`, `waktu`, `harga`) VALUES
(66, 'wahyu.smallker@gmail.com', 'Dr. Handoyo', 1597248358701, 100000),
(67, 'wahyu.smallker@gmail.com', 'Dr. Handoyo', 1597251958701, 100000);

-- --------------------------------------------------------

--
-- Table structure for table `polijantung`
--

CREATE TABLE `polijantung` (
  `id` int(11) NOT NULL,
  `dokter` text NOT NULL,
  `harga` int(11) NOT NULL,
  `kuota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `polijantung`
--

INSERT INTO `polijantung` (`id`, `dokter`, `harga`, `kuota`) VALUES
(1, 'Dr. Ilham', 150000, 99),
(2, 'Dr. Dewi', 200000, 95);

-- --------------------------------------------------------

--
-- Table structure for table `poliparu`
--

CREATE TABLE `poliparu` (
  `id` int(11) NOT NULL,
  `dokter` text NOT NULL,
  `harga` int(11) NOT NULL,
  `kuota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `poliparu`
--

INSERT INTO `poliparu` (`id`, `dokter`, `harga`, `kuota`) VALUES
(1, 'Dr. Sulistiyani', 180000, 19),
(2, 'Dr. Hardiyansyah', 130000, 26);

-- --------------------------------------------------------

--
-- Table structure for table `poliumum`
--

CREATE TABLE `poliumum` (
  `id` int(11) NOT NULL,
  `dokter` text NOT NULL,
  `harga` int(11) NOT NULL,
  `kuota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `poliumum`
--

INSERT INTO `poliumum` (`id`, `dokter`, `harga`, `kuota`) VALUES
(1, 'Dr. Handoyo', 100000, 983),
(2, 'Dr. Suryono', 50000, 99),
(3, 'Dr. Tes kuota 0', 100000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` text NOT NULL,
  `telepon` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `tiket` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `telepon`, `email`, `password`, `tiket`) VALUES
(1, 'Wahyu', '08555', 'wahyu.smallker@gmail.com', 'kenari123', 67),
(6, 'Wahyu', '0876382993', 'akuntrial@gmail.com', '12345678', 0),
(7, 'Trial', '0872984', 'trial@mail.com', '11111111', 41),
(8, 'mutmainah', '081285533122', 'mutmainah1984@gmail.com', 'amar1912', 0),
(9, 'Muhammad Farhan', '', 'farhan180808@gmail.com', 'farhan1609', 51),
(10, 'Dhani Wahyuningtias Hafsha', '081987569523', 'tiashafsha@gmail.com', 'namikaze', 44),
(11, 'Farhan', '0879562445', 'farhanbdm@ymail.com ', 'farhan1609', 52),
(12, 'Muhammad Farhan', '0877852698753', 'farhan160899@gmail.com', 'farhan1609', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `polijantung`
--
ALTER TABLE `polijantung`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `poliparu`
--
ALTER TABLE `poliparu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `poliumum`
--
ALTER TABLE `poliumum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `polijantung`
--
ALTER TABLE `polijantung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `poliparu`
--
ALTER TABLE `poliparu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `poliumum`
--
ALTER TABLE `poliumum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
