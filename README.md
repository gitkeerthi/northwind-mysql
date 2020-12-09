# How to setup SQL Practice Problems database on any platform - works on Mac, Windows, Linux

Credits: [SQL Practice Problems](https://www.amazon.com/SQL-Practice-Problems-learn-doing/dp/1520807635).

Based on the following publication:
```text
Title: SQL Practice Problems: 57 beginning, intermediate, and advanced challenges for you to solve using a “learn-by-doing” approach
Edition: Kindle
Publication date: November 16, 2016
ASIN: B01N41VQFO
```

## Why did I create this?
The original scripts shipped with the **Kindle edition** of the book I bought off Amazon was compatible with only 
Windows/SQL Server. I needed a way to run the scripts on my Mac. I came up with two solutions:

- **Option 1:** Port the scripts to work on MySQL.
- **Option 2:** Run Microsoft SQL Server as a Docker container.

Both the options are cross-platform!

## Option 1: Setting up on Mac and MySQL

1. Login to MySQL
```bash
$ mysql -h localhost -P 3306 --protocol=tcp -u root -p
```

2. Re-create database
```bash
mysql> drop database if exists northwind;
```

```bash
mysql> create database northwind;
```

3. Import northwind-mysql.sql

```bash
mysql> source [/path/to/]northwind-mysql.sql;
```
You'll notice the tables and column names are in snake_case per MySQL convention.

## Option 2: Setting up on Mac and Microsoft SQL Server

1. Install [Docker Desktop for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac/)

2. Start MS SQL Server as a Docker container
```bash
$ docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=@dmin!234' -p 1433:1433 --name mssql -h mssql -d mcr.microsoft.com/mssql/server
```

3. Note the credentials. User ID is `SA`. Password is `@dmin!234`.

4. Install [Azure Data Studio for Mac](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio)

5. Set up the database in MS SQL Server:
   
    - Login to Azure Data Studeo
    - Launch 'New query' and run the following command:
      ```bash
      CREATE DATABASE Northwind
      ```
    - Refresh the tree on the left to reveal Northwind.
    - Launch 'New query' and run the contents of the file northwind-ms-sql-server.sql.
    - Refresh the tree again to reveal the tables created.