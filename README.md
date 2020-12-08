# Northwind MySQL
MySQL version of Northwind database used in the book [SQL Practice Problems](https://www.amazon.com/SQL-Practice-Problems-learn-doing/dp/1520807635) Book.

```text
Edition: Kindle
Publication date : November 16, 2016
ASIN : B01N41VQFO
```

## Why did I create this?
The original scripts shipped with the **Kindle edition** of the book I bought off Amazon was compatible with only 
Windows/SQL Server. I reverse-engineered the scripts to make it work on my Mac/MySQL.

## Setup

1. Login to MySQL
```mysql
$ mysql -h localhost -P 3306 --protocol=tcp -u root -p
```

2. Re-create database
```mysql
mysql> drop database if exists Northwind;
```

```mysql
mysql> create database Northwind;
```

3. Import northwind.sql

```mysql
mysql> source [/path/to/]northwind.sql
```

