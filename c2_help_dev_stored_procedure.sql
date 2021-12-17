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
USE `rolli3oh_c2_help`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_delete_child_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_delete_child_menu` (IN `article_child_id` VARCHAR(200))  NO SQL
BEGIN
	DELETE
	FROM
		tbl_C2_help_article_menu 
	WHERE 
        C2_help_child_article_id = article_child_id;
        
	DELETE
	FROM
		tbl_C2_help_article 
	WHERE 
        C2_help_article_id = article_child_id;
	
    DELETE
	FROM
		tbl_C2_help_article_component 
	WHERE 
        C2_help_article_id = article_child_id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_content`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_delete_content` (IN `article_component_id` VARCHAR(200))  NO SQL
BEGIN
	DELETE FROM
		tbl_C2_help_article_component
	WHERE 
        C2_help_article_component_id = article_component_id;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_parent_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_delete_parent_menu` (IN `article_parent_id` VARCHAR(200))  NO SQL
BEGIN
	DELETE
	FROM
		tbl_C2_help_article_menu 
	WHERE 
        C2_help_parent_article_id = article_parent_id;
        
	DELETE
	FROM
		tbl_C2_help_article 
	WHERE 
        C2_help_article_id = article_parent_id;
	
    DELETE
	FROM
		tbl_C2_help_article_component 
	WHERE 
        C2_help_article_id = article_parent_id;
END$$

DROP PROCEDURE IF EXISTS `sp_get_article_details`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_get_article_details` (IN `article_id` VARCHAR(200))  NO SQL
BEGIN
	SELECT
		tbl_C2_help_article_component.C2_help_article_id AS articleId,
        tbl_C2_help_article_component.C2_help_article_component_order AS articleComponentOrder,
        tbl_C2_help_article_component.C2_help_article_component_id AS articleComponentId,
        tbl_C2_help_article_component.C2_help_article_component_type AS articleComponentType,
        tbl_C2_help_article_component.C2_help_article_component_content AS articleComponentContent
	FROM
		tbl_C2_help_article_component
	WHERE
		tbl_C2_help_article_component.C2_help_article_id = article_id
	ORDER BY
		tbl_C2_help_article_component.C2_help_article_component_order ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_get_article_search`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_get_article_search` (IN `search_key` VARCHAR(200))  NO SQL
BEGIN
	SELECT
		tbl_C2_help_article_component.C2_help_article_id AS articleId,
        tbl_C2_help_article_component.C2_help_article_component_type AS articleComponentType,
        tbl_C2_help_article_component.C2_help_article_component_content AS articleComponentContent,
        tbl_C2_help_article.C2_help_article_title AS articleTitle
	FROM
		tbl_C2_help_article_component
	LEFT JOIN
		tbl_C2_help_article
	ON
		tbl_C2_help_article_component.C2_help_article_id = tbl_C2_help_article.C2_help_article_id
	WHERE
		MATCH (tbl_C2_help_article_component.C2_help_article_component_content)
		AGAINST (search_key IN BOOLEAN MODE);
END$$

DROP PROCEDURE IF EXISTS `sp_get_child_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_get_child_menu` (IN `article_parent_id` VARCHAR(200))  NO SQL
BEGIN
	SELECT
		DISTINCT tbl_C2_help_article_menu.C2_help_child_article_id AS articleId,
        tbl_C2_help_article_menu.C2_help_child_menu_order AS childMenuOrder,
        tbl_C2_help_article.C2_help_article_title AS articleTitle
	FROM
		tbl_C2_help_article_menu
	LEFT JOIN
		tbl_C2_help_article
	ON
		tbl_C2_help_article_menu.C2_help_child_article_id = tbl_C2_help_article.C2_help_article_id
	WHERE
		tbl_C2_help_article_menu.C2_help_parent_article_id = article_parent_id
	AND
		tbl_C2_help_article_menu.C2_help_child_article_id != ''
	ORDER BY
		tbl_C2_help_article_menu.C2_help_child_menu_order ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_get_parent_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_get_parent_menu` ()  NO SQL
BEGIN
	SELECT
		DISTINCT tbl_C2_help_article_menu.C2_help_parent_article_id AS articleParentId,
        tbl_C2_help_article.C2_help_article_title AS articleTitle,
        tbl_C2_help_article_menu.C2_help_parent_menu_order AS parentMenuOrder
	FROM
		tbl_C2_help_article_menu
	LEFT JOIN
		tbl_C2_help_article
	ON
		tbl_C2_help_article_menu.C2_help_parent_article_id = tbl_C2_help_article.C2_help_article_id
	ORDER BY
		tbl_C2_help_article_menu.C2_help_parent_menu_order ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_get_settings`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_get_settings` ()  NO SQL
BEGIN
	SELECT
		tbl_C2_help_settings.C2_help_app_name AS appName,
        tbl_C2_help_settings.C2_help_sign_up_url AS signUpUrl,
        tbl_C2_help_settings.C2_help_support_email AS supportEmail
	FROM
		tbl_C2_help_settings;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_article`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_insert_article` (IN `article_id` VARCHAR(200), IN `article_title` VARCHAR(1000))  NO SQL
BEGIN
	INSERT INTO 
    tbl_C2_help_article 
        (
			C2_help_article_id, 
            C2_help_article_title, 
            C2_help_article_created_on
        ) 
    values 
        (
            article_id, 
            article_title,
            now()
        );
END$$

DROP PROCEDURE IF EXISTS `sp_insert_content`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_insert_content` (IN `article_id` VARCHAR(200), IN `article_component_order` INT(10), IN `article_component_id` VARCHAR(200), IN `article_component_type` VARCHAR(200), IN `article_component_content` VARCHAR(1000))  NO SQL
BEGIN
	INSERT INTO 
    tbl_C2_help_article_component 
        (
			C2_help_article_id, 
            C2_help_article_component_order, 
            C2_help_article_component_id,
            C2_help_article_component_type, 
            C2_help_article_component_content
        ) 
    values 
        (
            article_id, 
            article_component_order,
            article_component_id,
            article_component_type,
            article_component_content
        );
END$$

DROP PROCEDURE IF EXISTS `sp_insert_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_insert_menu` (IN `article_parent_id` VARCHAR(200), IN `article_child_id` VARCHAR(200), IN `parent_menu_order` INT(10), IN `child_menu_order` INT(10))  NO SQL
BEGIN
	INSERT INTO 
    tbl_C2_help_article_menu 
        (
			C2_help_parent_article_id, 
            C2_help_child_article_id,
            C2_help_parent_menu_order,
            C2_help_child_menu_order
        ) 
    values 
        (
            article_parent_id, 
            article_child_id,
            parent_menu_order,
            child_menu_order
        );
END$$

DROP PROCEDURE IF EXISTS `sp_insert_settings`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_insert_settings` (IN `app_name` VARCHAR(45), IN `sign_up_url` VARCHAR(100), IN `support_email` VARCHAR(45))  NO SQL
BEGIN

	DELETE FROM tbl_C2_help_settings;
    
	INSERT INTO 
    tbl_C2_help_settings 
        (
			C2_help_app_name, 
            C2_help_sign_up_url, 
            C2_help_support_email
        ) 
    values 
        (
            app_name, 
            sign_up_url,
            support_email
        );
END$$

DROP PROCEDURE IF EXISTS `sp_update_article`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_update_article` (IN `article_id` VARCHAR(200), IN `article_title` VARCHAR(1000))  NO SQL
BEGIN
	UPDATE
		tbl_C2_help_article 
	SET 
        C2_help_article_title = article_title
	WHERE 
        C2_help_article_id = article_id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_article_feedback`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_update_article_feedback` (IN `article_id` VARCHAR(200), IN `feedback_type` VARCHAR(100))  NO SQL
BEGIN
	
    CASE feedback_type
		WHEN  'delightful' THEN
		   UPDATE
				tbl_C2_help_article 
			SET 
				tbl_C2_help_article.C2_help_article_feedback_delightful = tbl_C2_help_article.C2_help_article_feedback_delightful + 1
			WHERE 
				tbl_C2_help_article.C2_help_article_id = article_id;
		WHEN 'neutral' THEN
		   UPDATE
				tbl_C2_help_article 
			SET 
				tbl_C2_help_article.C2_help_article_feedback_neutral = tbl_C2_help_article.C2_help_article_feedback_neutral + 1
			WHERE 
				tbl_C2_help_article.C2_help_article_id = article_id;
		ELSE
		   UPDATE
				tbl_C2_help_article 
			SET 
				tbl_C2_help_article.C2_help_article_feedback_sad = tbl_C2_help_article.C2_help_article_feedback_sad + 1
			WHERE 
				tbl_C2_help_article.C2_help_article_id = article_id;
	END CASE;
		
    
END$$

DROP PROCEDURE IF EXISTS `sp_update_child_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_update_child_menu` (IN `article_parent_id` VARCHAR(200), IN `article_child_id` VARCHAR(200), IN `parent_menu_order` INT(10), IN `child_menu_order` INT(10))  NO SQL
BEGIN
	UPDATE
		tbl_C2_help_article_menu 
	SET 
        C2_help_parent_menu_order = parent_menu_order,
        C2_help_child_menu_order = child_menu_order
	WHERE 
        C2_help_parent_article_id = article_parent_id
	AND
		C2_help_child_article_id = article_child_id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_content`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_update_content` (IN `article_id` VARCHAR(200), IN `article_component_order` INT(10), IN `article_component_id` VARCHAR(200), IN `article_component_type` VARCHAR(200), IN `article_component_content` VARCHAR(1000))  NO SQL
BEGIN
	UPDATE
		tbl_C2_help_article_component 
	SET
		C2_help_article_component_order = article_component_order, 
		C2_help_article_component_type = article_component_type, 
        C2_help_article_component_content = article_component_content
	WHERE 
        C2_help_article_component_id = article_component_id;
END$$

DROP PROCEDURE IF EXISTS `sp_update_parent_menu`$$
CREATE DEFINER=`rolli3oh`@`localhost` PROCEDURE `sp_update_parent_menu` (IN `article_parent_id` VARCHAR(200), IN `parent_menu_order` INT(10))  NO SQL
BEGIN
	UPDATE
		tbl_C2_help_article_menu 
	SET 
        C2_help_parent_menu_order = parent_menu_order
	WHERE 
        C2_help_parent_article_id = article_parent_id;
END$$

DELIMITER ;
