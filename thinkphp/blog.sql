-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2018-08-03 04:06:09
-- 服务器版本： 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- 表的结构 `blog_about_blog`
--

CREATE TABLE `blog_about_blog` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '关于博客自增id',
  `b_title` varchar(500) NOT NULL COMMENT '博客介绍标题',
  `b_content` text NOT NULL COMMENT '博客介绍内容',
  `b_name` varchar(255) NOT NULL COMMENT '博客名字',
  `b_img` varchar(500) NOT NULL COMMENT '博客图片'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_about_tony`
--

CREATE TABLE `blog_about_tony` (
  `id` int(11) UNSIGNED NOT NULL,
  `about_info` text NOT NULL COMMENT '作者信息',
  `about_content` text NOT NULL COMMENT '作者介绍',
  `about_avatar` varchar(500) NOT NULL COMMENT '作者头像'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_article`
--

CREATE TABLE `blog_article` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '文章 自增id',
  `article_img` varchar(100) NOT NULL DEFAULT '/public/img/article_img' COMMENT '文章图片',
  `article_title` varchar(250) NOT NULL COMMENT '文章标题',
  `article_content` text NOT NULL COMMENT '文章内容',
  `article_add_time` int(11) NOT NULL COMMENT '文章添加时间',
  `article_comment` int(11) NOT NULL COMMENT '文章评论',
  `article_view` int(11) NOT NULL COMMENT '浏览量',
  `article_category` mediumint(9) NOT NULL COMMENT '文章分类',
  `article_uid` int(10) UNSIGNED NOT NULL COMMENT '文章作者'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `blog_article`
--

INSERT INTO `blog_article` (`id`, `article_img`, `article_title`, `article_content`, `article_add_time`, `article_comment`, `article_view`, `article_category`, `article_uid`) VALUES
(1, '', '第一篇文章', '第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章第一篇文章', 0, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `blog_comment`
--

CREATE TABLE `blog_comment` (
  `id` int(10) UNSIGNED NOT NULL,
  `comment_uid` int(10) UNSIGNED NOT NULL COMMENT '评论用户',
  `comment_aid` int(10) UNSIGNED NOT NULL COMMENT '评论文章',
  `comment_content` text NOT NULL COMMENT '评论内容',
  `comment_time` int(10) UNSIGNED NOT NULL COMMENT '评论时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_friendlink`
--

CREATE TABLE `blog_friendlink` (
  `id` int(10) UNSIGNED NOT NULL,
  `link_name` varchar(500) NOT NULL COMMENT '友情链接名字',
  `link_url` varchar(500) NOT NULL COMMENT '友情链接地址',
  `link_logo` varchar(500) NOT NULL COMMENT '友情链接logo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_message`
--

CREATE TABLE `blog_message` (
  `id` int(11) UNSIGNED NOT NULL,
  `message_uid` int(11) NOT NULL COMMENT '留言者id',
  `message_content` text NOT NULL COMMENT '留言内容',
  `message_time` int(11) NOT NULL COMMENT '留言时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_relationship`
--

CREATE TABLE `blog_relationship` (
  `id` int(10) UNSIGNED NOT NULL,
  `cid` int(10) UNSIGNED NOT NULL COMMENT '评论id',
  `aid` int(10) UNSIGNED NOT NULL COMMENT '文章id',
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_resource`
--

CREATE TABLE `blog_resource` (
  `id` int(11) UNSIGNED NOT NULL,
  `resource_img` varchar(500) NOT NULL COMMENT '资源图片',
  `resource_title` varchar(250) NOT NULL COMMENT '资源标题',
  `resource_url` varchar(500) NOT NULL COMMENT '资源下载地址',
  `resource_category` mediumint(8) UNSIGNED NOT NULL COMMENT '资源分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `blog_user`
--

CREATE TABLE `blog_user` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增id',
  `user_mail` varchar(100) NOT NULL COMMENT '用户邮箱',
  `user_pass` varchar(90) NOT NULL COMMENT '用户密码',
  `user_nickname` varchar(90) NOT NULL COMMENT '用户昵称',
  `user_reg_time` int(11) NOT NULL COMMENT '用户注册时间',
  `user_avatar` varchar(255) NOT NULL DEFAULT '/public/img/avatar' COMMENT '用户头像',
  `user_sex` varchar(10) NOT NULL COMMENT '用户性别',
  `user_place` varchar(500) NOT NULL COMMENT '用户所在城市',
  `user_phone` int(20) UNSIGNED NOT NULL COMMENT '用户手机号',
  `user_lock` int(11) UNSIGNED NOT NULL COMMENT '用户锁定 0:不锁定，1:锁定',
  `user_freeze` int(11) NOT NULL COMMENT '0:不冻结，1:冻结'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `blog_user`
--

INSERT INTO `blog_user` (`id`, `user_mail`, `user_pass`, `user_nickname`, `user_reg_time`, `user_avatar`, `user_sex`, `user_place`, `user_phone`, `user_lock`, `user_freeze`) VALUES
(1, 'admin@126.com', 'e10adc3949ba59abbe56e057f20f883e', 'admin', 0, '', '', '', 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blog_about_blog`
--
ALTER TABLE `blog_about_blog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_about_tony`
--
ALTER TABLE `blog_about_tony`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_article`
--
ALTER TABLE `blog_article`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_friendlink`
--
ALTER TABLE `blog_friendlink`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_message`
--
ALTER TABLE `blog_message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_relationship`
--
ALTER TABLE `blog_relationship`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_resource`
--
ALTER TABLE `blog_resource`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_user`
--
ALTER TABLE `blog_user`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `blog_about_blog`
--
ALTER TABLE `blog_about_blog`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '关于博客自增id';
--
-- 使用表AUTO_INCREMENT `blog_about_tony`
--
ALTER TABLE `blog_about_tony`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `blog_article`
--
ALTER TABLE `blog_article`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章 自增id', AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `blog_comment`
--
ALTER TABLE `blog_comment`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `blog_friendlink`
--
ALTER TABLE `blog_friendlink`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `blog_message`
--
ALTER TABLE `blog_message`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `blog_relationship`
--
ALTER TABLE `blog_relationship`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `blog_resource`
--
ALTER TABLE `blog_resource`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `blog_user`
--
ALTER TABLE `blog_user`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id', AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
