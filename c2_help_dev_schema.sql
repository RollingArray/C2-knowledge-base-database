-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 17, 2021 at 02:04 PM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `rolli3oh_c2_help`
--
CREATE DATABASE IF NOT EXISTS `rolli3oh_c2_help` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `rolli3oh_c2_help`;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_C2_help_article`
--

DROP TABLE IF EXISTS `tbl_C2_help_article`;
CREATE TABLE IF NOT EXISTS `tbl_C2_help_article` (
  `C2_help_article_id` varchar(200) NOT NULL DEFAULT '',
  `C2_help_article_title` varchar(1000) DEFAULT NULL,
  `C2_help_article_created_on` datetime DEFAULT NULL,
  `C2_help_article_updated_on` datetime DEFAULT NULL,
  `C2_help_article_feedback_delightful` int(11) DEFAULT '0',
  `C2_help_article_feedback_neutral` int(11) DEFAULT '0',
  `C2_help_article_feedback_sad` int(11) DEFAULT '0',
  PRIMARY KEY (`C2_help_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_C2_help_article_component`
--

DROP TABLE IF EXISTS `tbl_C2_help_article_component`;
CREATE TABLE IF NOT EXISTS `tbl_C2_help_article_component` (
  `C2_help_article_id` varchar(200) NOT NULL DEFAULT '',
  `C2_help_article_component_order` int(10) NOT NULL,
  `C2_help_article_component_id` varchar(200) NOT NULL DEFAULT '',
  `C2_help_article_component_type` varchar(200) DEFAULT NULL,
  `C2_help_article_component_content` varchar(1000) DEFAULT NULL,
  KEY `tbl_C2_help_article_component_fk_1` (`C2_help_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_C2_help_article_menu`
--

DROP TABLE IF EXISTS `tbl_C2_help_article_menu`;
CREATE TABLE IF NOT EXISTS `tbl_C2_help_article_menu` (
  `C2_help_parent_article_id` varchar(200) NOT NULL DEFAULT '',
  `C2_help_child_article_id` varchar(200) NOT NULL DEFAULT '',
  `C2_help_sub_child_article_id` varchar(200) DEFAULT NULL,
  `C2_help_parent_menu_order` int(10) NOT NULL,
  `C2_help_child_menu_order` int(10) NOT NULL DEFAULT '0',
  `C2_help_sub_child_menu_order` int(200) DEFAULT '0',
  KEY `tbl_C2_activity_comment_fk_1` (`C2_help_parent_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_C2_help_settings`
--

DROP TABLE IF EXISTS `tbl_C2_help_settings`;
CREATE TABLE IF NOT EXISTS `tbl_C2_help_settings` (
  `C2_help_app_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `C2_help_sign_up_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `C2_help_support_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`C2_help_app_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_C2_help_article_component`
--
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_content` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_2` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_3` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_4` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_5` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_6` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_7` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_8` (`C2_help_article_component_content`);
ALTER TABLE `tbl_C2_help_article_component` ADD FULLTEXT KEY `C2_help_article_component_cont_9` (`C2_help_article_component_content`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_C2_help_article_menu`
--
ALTER TABLE `tbl_C2_help_article_menu`
  ADD CONSTRAINT `tbl_C2_help_article_menu_fk_2` FOREIGN KEY (`C2_help_parent_article_id`) REFERENCES `tbl_C2_help_article` (`C2_help_article_id`);
