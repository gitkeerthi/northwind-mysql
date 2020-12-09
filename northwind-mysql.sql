USE northwind;

CREATE TABLE category
(
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(30)  NOT NULL,
    description   VARCHAR(100) NOT NULL
);

CREATE TABLE customer_group_threshold
(
    customer_group_name VARCHAR(20)    NULL,
    range_bottom        DECIMAL(20, 4) NULL,
    range_top           DECIMAL(20, 4) NULL
);

CREATE TABLE customer
(
    customer_id   VARCHAR(5)  NOT NULL PRIMARY KEY,
    company_name  VARCHAR(40) NOT NULL,
    contact_name  VARCHAR(30) NULL,
    contact_title VARCHAR(30) NULL,
    address       VARCHAR(60) NULL,
    city          VARCHAR(15) NULL,
    region        VARCHAR(15) NULL,
    postal_code   VARCHAR(10) NULL,
    country       VARCHAR(15) NULL,
    phone         VARCHAR(24) NULL,
    fax           VARCHAR(24) NULL
);

CREATE TABLE employee
(
    employee_id       INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    last_name         VARCHAR(20)  NOT NULL,
    first_name        VARCHAR(10)  NOT NULL,
    title             VARCHAR(30)  NULL,
    title_of_courtesy VARCHAR(25)  NULL,
    birth_date        DATETIME     NULL,
    hire_date         DATETIME     NULL,
    address           VARCHAR(60)  NULL,
    city              VARCHAR(15)  NULL,
    region            VARCHAR(15)  NULL,
    postal_code       VARCHAR(10)  NULL,
    country           VARCHAR(15)  NULL,
    home_phone        VARCHAR(24)  NULL,
    extension         VARCHAR(4)   NULL,
    photo             VARCHAR(0)   NULL,
    notes             TEXT         NULL,
    reports_to        INT          NULL,
    photo_path        VARCHAR(255) NULL
);

create table order_detail
(
    order_id   INT            NOT NULL,
    product_id INT            NOT NULL,
    unit_price DECIMAL(20, 4) NOT NULL,
    quantity   SMALLINT       NOT NULL,
    discount   DECIMAL(20, 4) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE `order`
(
    order_id         INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id      VARCHAR(5)     NOT NULL,
    employee_id      INT            NULL,
    order_date       DATETIME       NULL,
    required_date    DATETIME       NULL,
    shipped_date     DATETIME       NULL,
    ship_via         INT            NULL,
    freight          DECIMAL(20, 4) NULL,
    ship_name        VARCHAR(40)    NULL,
    ship_address     VARCHAR(60)    NULL,
    ship_city        VARCHAR(15)    NULL,
    ship_region      VARCHAR(15)    NULL,
    ship_postal_code VARCHAR(10)    NULL,
    ship_country     VARCHAR(15)    NULL
);

CREATE TABLE product
(
    product_id        INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_name      VARCHAR(40)    NOT NULL,
    supplier_id       INT            NULL,
    category_id       INT            NULL,
    quantity_per_unit VARCHAR(20)    NULL,
    unit_price        DECIMAL(20, 4) NULL,
    unit_in_stock     SMALLINT       NULL,
    units_on_order    SMALLINT       NULL,
    reorder_level     TINYINT        NULL,
    discontinued      TINYINT        NULL
);

CREATE TABLE shipper
(
    shipper_id   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(40) NOT NULL,
    phone        VARCHAR(24) NULL
);

CREATE TABLE supplier
(
    supplier_id   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name  VARCHAR(40)  NULL,
    contact_name  VARCHAR(30)  NULL,
    contact_title VARCHAR(30)  NULL,
    address       VARCHAR(60)  NULL,
    city          VARCHAR(15)  NULL,
    region        VARCHAR(15)  NULL,
    postal_code   VARCHAR(10)  NULL,
    country       VARCHAR(15)  NULL,
    phone         VARCHAR(24)  NULL,
    Fax           VARCHAR(24)  NULL,
    home_page     VARCHAR(100) NULL
);

ALTER TABLE employee
    ADD CONSTRAINT fk_employees_employees FOREIGN KEY (reports_to)
        REFERENCES employee (employee_id);

ALTER TABLE order_detail
    ADD CONSTRAINT fk_order_details_orders FOREIGN KEY (order_id)
        REFERENCES `order` (order_id);

ALTER TABLE order_detail
    ADD CONSTRAINT fk_order_details_products FOREIGN KEY (product_id)
        REFERENCES product (product_id);

ALTER TABLE `order`
    ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id);

ALTER TABLE `order`
    ADD CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id)
        REFERENCES employee (employee_id);

ALTER TABLE `order`
    ADD CONSTRAINT fk_orders_shippers FOREIGN KEY (ship_via)
        REFERENCES shipper (shipper_id);


ALTER TABLE product
    ADD CONSTRAINT fk_products_categories FOREIGN KEY (category_id)
        REFERENCES category (category_id);

ALTER TABLE product
    ADD CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id)
        REFERENCES supplier (supplier_id);


INSERT INTO category (category_id, category_name, description)
VALUES (1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales');
INSERT INTO category (category_id, category_name, description)
VALUES (2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings');
INSERT INTO category (category_id, category_name, description)
VALUES (3, N'Confections', N'Desserts, candies, and sweet breads');
INSERT INTO category (category_id, category_name, description)
VALUES (4, N'Dairy Products', N'Cheeses');
INSERT INTO category (category_id, category_name, description)
VALUES (5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal');
INSERT INTO category (category_id, category_name, description)
VALUES (6, N'Meat/Poultry', N'Prepared meats');
INSERT INTO category (category_id, category_name, description)
VALUES (7, N'Produce', N'Dried fruit and bean curd');
INSERT INTO category (category_id, category_name, description)
VALUES (8, N'Seafood', N'Seaweed and fish');

INSERT INTO customer_group_threshold (customer_group_name, range_bottom, range_top)
VALUES (N'Low', 0.0000, 999.9999);
INSERT INTO customer_group_threshold (customer_group_name, range_bottom, range_top)
VALUES (N'Medium', 1000.0000, 4999.9999);
INSERT INTO customer_group_threshold (customer_group_name, range_bottom, range_top)
VALUES (N'High', 5000.0000, 9999.9999);
INSERT INTO customer_group_threshold (customer_group_name, range_bottom, range_top)
VALUES (N'Very High', 10000.0000, 922337203685477.5807);

INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'ALFKI', N'Alfreds Futterkiste', N'Maria Anders', N'Sales Representative', N'Obere Str. 57', N'Berlin', null,
        N'12209', N'Germany', N'030-0074321', N'030-0076545');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'ANATR', N'Ana Trujillo Emparedados y helados', N'Ana Trujillo', N'Owner', N'Avda. de la Constitución 2222',
        N'México D.F.', null, N'05021', N'Mexico', N'(5) 555-4729', N'(5) 555-3745');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'ANTON', N'Antonio Moreno Taquería', N'Antonio Moreno', N'Owner', N'Mataderos  2312', N'México D.F.', null,
        N'05023', N'Mexico', N'(5) 555-3932', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'AROUT', N'Around the Horn', N'Thomas Hardy', N'Sales Representative', N'120 Hanover Sq.', N'London', null,
        N'WA1 1DP', N'UK', N'(171) 555-7788', N'(171) 555-6750');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BERGS', N'Berglunds snabbköp', N'Christina Berglund', N'Order Administrator', N'Berguvsvägen  8', N'Luleå',
        null, N'S-958 22', N'Sweden', N'0921-12 34 65', N'0921-12 34 67');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BLAUS', N'Blauer See Delikatessen', N'Hanna Moos', N'Sales Representative', N'Forsterstr. 57', N'Mannheim',
        null, N'68306', N'Germany', N'0621-08460', N'0621-08924');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BLONP', N'Blondesddsl père et fils', N'Frédérique Citeaux', N'Marketing Manager', N'24, place Kléber',
        N'Strasbourg', null, N'67000', N'France', N'88.60.15.31', N'88.60.15.32');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BOLID', N'Bólido Comidas preparadas', N'Martín Sommer', N'Owner', N'C/ Araquil, 67', N'Madrid', null,
        N'28023', N'Spain', N'(91) 555 22 82', N'(91) 555 91 99');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BONAP', N'Bon app''', N'Laurence Lebihan', N'Owner', N'12, rue des Bouchers', N'Marseille', null, N'13008',
        N'France', N'91.24.45.40', N'91.24.45.41');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BOTTM', N'Bottom-Dollar Markets', N'Elizabeth Lincoln', N'Accounting Manager', N'23 Tsawassen Blvd.',
        N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', N'(604) 555-4729', N'(604) 555-3745');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'BSBEV', N'B''s Beverages', N'Victoria Ashworth', N'Sales Representative', N'Fauntleroy Circus', N'London',
        null, N'EC2 5NT', N'UK', N'(171) 555-1212', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'CACTU', N'Cactus Comidas para llevar', N'Patricio Simpson', N'Sales Agent', N'Cerrito 333', N'Buenos Aires',
        null, N'1010', N'Argentina', N'(1) 135-5555', N'(1) 135-4892');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'CENTC', N'Centro comercial Moctezuma', N'Francisco Chang', N'Marketing Manager', N'Sierras de Granada 9993',
        N'México D.F.', null, N'05022', N'Mexico', N'(5) 555-3392', N'(5) 555-7293');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'CHOPS', N'Chop-suey Chinese', N'Yang Wang', N'Owner', N'Hauptstr. 29', N'Bern', null, N'3012', N'Switzerland',
        N'0452-076545', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'COMMI', N'Comércio Mineiro', N'Pedro Afonso', N'Sales Associate', N'Av. dos Lusíadas, 23', N'Sao Paulo',
        N'SP', N'05432-043', N'Brazil', N'(11) 555-7647', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'CONSH', N'Consolidated Holdings', N'Elizabeth Brown', N'Sales Representative',
        N'Berkeley Gardens 12  Brewery', N'London', null, N'WX1 6LT', N'UK', N'(171) 555-2282', N'(171) 555-9199');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'DRACD', N'Drachenblut Delikatessen', N'Sven Ottlieb', N'Order Administrator', N'Walserweg 21', N'Aachen',
        null, N'52066', N'Germany', N'0241-039123', N'0241-059428');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'DUMON', N'Du monde entier', N'Janine Labrune', N'Owner', N'67, rue des Cinquante Otages', N'Nantes', null,
        N'44000', N'France', N'40.67.88.88', N'40.67.89.89');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'EASTC', N'Eastern Connection', N'Ann Devon', N'Sales Agent', N'35 King George', N'London', null, N'WX3 6FW',
        N'UK', N'(171) 555-0297', N'(171) 555-3373');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'ERNSH', N'Ernst Handel', N'Roland Mendel', N'Sales Manager', N'Kirchgasse 6', N'Graz', null, N'8010',
        N'Austria', N'7675-3425', N'7675-3426');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FAMIA', N'Familia Arquibaldo', N'Aria Cruz', N'Marketing Assistant', N'Rua Orós, 92', N'Sao Paulo', N'SP',
        N'05442-030', N'Brazil', N'(11) 555-9857', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FISSA', N'FISSA Fabrica Inter. Salchichas S.A.', N'Diego Roel', N'Accounting Manager', N'C/ Moralzarzal, 86',
        N'Madrid', null, N'28034', N'Spain', N'(91) 555 94 44', N'(91) 555 55 93');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FOLIG', N'Folies gourmandes', N'Martine Rancé', N'Assistant Sales Agent', N'184, chaussée de Tournai',
        N'Lille', null, N'59000', N'France', N'20.16.10.16', N'20.16.10.17');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FOLKO', N'Folk och fä HB', N'Maria Larsson', N'Owner', N'Åkergatan 24', N'Bräcke', null, N'S-844 67',
        N'Sweden', N'0695-34 67 21', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FRANK', N'Frankenversand', N'Peter Franken', N'Marketing Manager', N'Berliner Platz 43', N'München', null,
        N'80805', N'Germany', N'089-0877310', N'089-0877451');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FRANR', N'France restauration', N'Carine Schmitt', N'Marketing Manager', N'54, rue Royale', N'Nantes', null,
        N'44000', N'France', N'40.32.21.21', N'40.32.21.20');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FRANS', N'Franchi S.p.A.', N'Paolo Accorti', N'Sales Representative', N'Via Monte Bianco 34', N'Torino', null,
        N'10100', N'Italy', N'011-4988260', N'011-4988261');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'FURIB', N'Furia Bacalhau e Frutos do Mar', N'Lino Rodriguez', N'Sales Manager', N'Jardim das rosas n. 32',
        N'Lisboa', null, N'1675', N'Portugal', N'(1) 354-2534', N'(1) 354-2535');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'GALED', N'Galería del gastrónomo', N'Eduardo Saavedra', N'Marketing Manager', N'Rambla de Cataluña, 23',
        N'Barcelona', null, N'08022', N'Spain', N'(93) 203 4560', N'(93) 203 4561');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'GODOS', N'Godos Cocina Típica', N'José Pedro Freyre', N'Sales Manager', N'C/ Romero, 33', N'Sevilla', null,
        N'41101', N'Spain', N'(95) 555 82 82', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'GOURL', N'Gourmet Lanchonetes', N'André Fonseca', N'Sales Associate', N'Av. Brasil, 442', N'Campinas', N'SP',
        N'04876-786', N'Brazil', N'(11) 555-9482', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'GREAL', N'Great Lakes Food Market', N'Howard Snyder', N'Marketing Manager', N'2732 Baker Blvd.', N'Eugene',
        N'OR', N'97403', N'USA', N'(503) 555-7555', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'GROSR', N'GROSELLA-Restaurante', N'Manuel Pereira', N'Owner', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF',
        N'1081', N'Venezuela', N'(2) 283-2951', N'(2) 283-3397');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'HANAR', N'Hanari Carnes', N'Mario Pontes', N'Accounting Manager', N'Rua do Paço, 67', N'Rio de Janeiro',
        N'RJ', N'05454-876', N'Brazil', N'(21) 555-0091', N'(21) 555-8765');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'HILAA', N'HILARION-Abastos', N'Carlos Hernández', N'Sales Representative',
        N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela',
        N'(5) 555-1340', N'(5) 555-1948');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'HUNGC', N'Hungry Coyote Import Store', N'Yoshi Latimer', N'Sales Representative',
        N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', N'(503) 555-6874', N'(503) 555-2376');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'HUNGO', N'Hungry Owl All-Night Grocers', N'Patricia McKenna', N'Sales Associate', N'8 Johnstown Road',
        N'Cork', N'Co. Cork', null, N'Ireland', N'2967 542', N'2967 3333');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'ISLAT', N'Island Trading', N'Helen Bennett', N'Marketing Manager', N'Garden House Crowther Way', N'Cowes',
        N'Isle of Wight', N'PO31 7PJ', N'UK', N'(198) 555-8888', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'KOENE', N'Königlich Essen', N'Philip Cramer', N'Sales Associate', N'Maubelstr. 90', N'Brandenburg', null,
        N'14776', N'Germany', N'0555-09876', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LACOR', N'La corne d''abondance', N'Daniel Tonini', N'Sales Representative', N'67, avenue de l''Europe',
        N'Versailles', null, N'78000', N'France', N'30.59.84.10', N'30.59.85.11');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LAMAI', N'La maison d''Asie', N'Annette Roulet', N'Sales Manager', N'1 rue Alsace-Lorraine', N'Toulouse',
        null, N'31000', N'France', N'61.77.61.10', N'61.77.61.11');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LAUGB', N'Laughing Bacchus Wine Cellars', N'Yoshi Tannamuri', N'Marketing Assistant', N'1900 Oak St.',
        N'Vancouver', N'BC', N'V3F 2K1', N'Canada', N'(604) 555-3392', N'(604) 555-7293');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LAZYK', N'Lazy K Kountry Store', N'John Steel', N'Marketing Manager', N'12 Orchestra Terrace', N'Walla Walla',
        N'WA', N'99362', N'USA', N'(509) 555-7969', N'(509) 555-6221');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LEHMS', N'Lehmanns Marktstand', N'Renate Messner', N'Sales Representative', N'Magazinweg 7',
        N'Frankfurt a.M.', null, N'60528', N'Germany', N'069-0245984', N'069-0245874');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LETSS', N'Let''s Stop N Shop', N'Jaime Yorres', N'Owner', N'87 Polk St. Suite 5', N'San Francisco', N'CA',
        N'94117', N'USA', N'(415) 555-5938', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LILAS', N'LILA-Supermercado', N'Carlos González', N'Accounting Manager',
        N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela',
        N'(9) 331-6954', N'(9) 331-7256');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LINOD', N'LINO-Delicateses', N'Felipe Izquierdo', N'Owner', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita',
        N'Nueva Esparta', N'4980', N'Venezuela', N'(8) 34-56-12', N'(8) 34-93-93');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'LONEP', N'Lonesome Pine Restaurant', N'Fran Wilson', N'Sales Manager', N'89 Chiaroscuro Rd.', N'Portland',
        N'OR', N'97219', N'USA', N'(503) 555-9573', N'(503) 555-9646');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'MAGAA', N'Magazzini Alimentari Riuniti', N'Giovanni Rovelli', N'Marketing Manager',
        N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy', N'035-640230', N'035-640231');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'MAISD', N'Maison Dewey', N'Catherine Dewey', N'Sales Agent', N'Rue Joseph-Bens 532', N'Bruxelles', null,
        N'B-1180', N'Belgium', N'(02) 201 24 67', N'(02) 201 24 68');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'MEREP', N'Mère Paillarde', N'Jean Fresnière', N'Marketing Assistant', N'43 rue St. Laurent', N'Montréal',
        N'Québec', N'H1J 1C3', N'Canada', N'(514) 555-8054', N'(514) 555-8055');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'MORGK', N'Morgenstern Gesundkost', N'Alexander Feuer', N'Marketing Assistant', N'Heerstr. 22', N'Leipzig',
        null, N'04179', N'Germany', N'0342-023176', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'NORTS', N'North/South', N'Simon Crowther', N'Sales Associate', N'South House 300 Queensbridge', N'London',
        null, N'SW7 1RZ', N'UK', N'(171) 555-7733', N'(171) 555-2530');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'OCEAN', N'Océano Atlántico Ltda.', N'Yvonne Moncada', N'Sales Agent', N'Ing. Gustavo Moncada 8585 Piso 20-A',
        N'Buenos Aires', null, N'1010', N'Argentina', N'(1) 135-5333', N'(1) 135-5535');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'OLDWO', N'Old World Delicatessen', N'Rene Phillips', N'Sales Representative', N'2743 Bering St.',
        N'Anchorage', N'AK', N'99508', N'USA', N'(907) 555-7584', N'(907) 555-2880');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'OTTIK', N'Ottilies Käseladen', N'Henriette Pfalzheim', N'Owner', N'Mehrheimerstr. 369', N'Köln', null,
        N'50739', N'Germany', N'0221-0644327', N'0221-0765721');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'PARIS', N'Paris spécialités', N'Marie Bertrand', N'Owner', N'265, boulevard Charonne', N'Paris', null,
        N'75012', N'France', N'(1) 42.34.22.66', N'(1) 42.34.22.77');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'PERIC', N'Pericles Comidas clásicas', N'Guillermo Fernández', N'Sales Representative',
        N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico', N'(5) 552-3745', N'(5) 545-3745');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'PICCO', N'Piccolo und mehr', N'Georg Pipps', N'Sales Manager', N'Geislweg 14', N'Salzburg', null, N'5020',
        N'Austria', N'6562-9722', N'6562-9723');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'PRINI', N'Princesa Isabel Vinhos', N'Isabel de Castro', N'Sales Representative', N'Estrada da saúde n. 58',
        N'Lisboa', null, N'1756', N'Portugal', N'(1) 356-5634', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'QUEDE', N'Que Delícia', N'Bernardo Batista', N'Accounting Manager', N'Rua da Panificadora, 12',
        N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', N'(21) 555-4252', N'(21) 555-4545');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'QUEEN', N'Queen Cozinha', N'Lúcia Carvalho', N'Marketing Assistant', N'Alameda dos Canàrios, 891',
        N'Sao Paulo', N'SP', N'05487-020', N'Brazil', N'(11) 555-1189', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'QUICK', N'QUICK-Stop', N'Horst Kloss', N'Accounting Manager', N'Taucherstraße 10', N'Cunewalde', null,
        N'01307', N'Germany', N'0372-035188', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'RANCH', N'Rancho grande', N'Sergio Gutiérrez', N'Sales Representative', N'Av. del Libertador 900',
        N'Buenos Aires', null, N'1010', N'Argentina', N'(1) 123-5555', N'(1) 123-5556');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'RATTC', N'Rattlesnake Canyon Grocery', N'Paula Wilson', N'Assistant Sales Representative', N'2817 Milton Dr.',
        N'Albuquerque', N'NM', N'87110', N'USA', N'(505) 555-5939', N'(505) 555-3620');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'REGGC', N'Reggiani Caseifici', N'Maurizio Moroni', N'Sales Associate', N'Strada Provinciale 124',
        N'Reggio Emilia', null, N'42100', N'Italy', N'0522-556721', N'0522-556722');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'RICAR', N'Ricardo Adocicados', N'Janete Limeira', N'Assistant Sales Agent', N'Av. Copacabana, 267',
        N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', N'(21) 555-3412', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'RICSU', N'Richter Supermarkt', N'Michael Holz', N'Sales Manager', N'Grenzacherweg 237', N'Genève', null,
        N'1203', N'Switzerland', N'0897-034214', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'ROMEY', N'Romero y tomillo', N'Alejandra Camino', N'Accounting Manager', N'Gran Vía, 1', N'Madrid', null,
        N'28001', N'Spain', N'(91) 745 6200', N'(91) 745 6210');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SANTG', N'Santé Gourmet', N'Jonas Bergulfsen', N'Owner', N'Erling Skakkes gate 78', N'Stavern', null, N'4110',
        N'Norway', N'07-98 92 35', N'07-98 92 47');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SAVEA', N'Save-a-lot Markets', N'Jose Pavarotti', N'Sales Representative', N'187 Suffolk Ln.', N'Boise',
        N'ID', N'83720', N'USA', N'(208) 555-8097', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SEVES', N'Seven Seas Imports', N'Hari Kumar', N'Sales Manager', N'90 Wadhurst Rd.', N'London', null,
        N'OX15 4NB', N'UK', N'(171) 555-1717', N'(171) 555-5646');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SIMOB', N'Simons bistro', N'Jytte Petersen', N'Owner', N'Vinbæltet 34', N'Kobenhavn', null, N'1734',
        N'Denmark', N'31 12 34 56', N'31 13 35 57');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SPECD', N'Spécialités du monde', N'Dominique Perrier', N'Marketing Manager', N'25, rue Lauriston', N'Paris',
        null, N'75016', N'France', N'(1) 47.55.60.10', N'(1) 47.55.60.20');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SPLIR', N'Split Rail Beer & Ale', N'Art Braunschweiger', N'Sales Manager', N'P.O. Box 555', N'Lander', N'WY',
        N'82520', N'USA', N'(307) 555-4680', N'(307) 555-6525');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'SUPRD', N'Suprêmes délices', N'Pascale Cartrain', N'Accounting Manager', N'Boulevard Tirou, 255',
        N'Charleroi', null, N'B-6000', N'Belgium', N'(071) 23 67 22 20', N'(071) 23 67 22 21');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'THEBI', N'The Big Cheese', N'Liz Nixon', N'Marketing Manager', N'89 Jefferson Way Suite 2', N'Portland',
        N'OR', N'97201', N'USA', N'(503) 555-3612', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'THECR', N'The Cracker Box', N'Liu Wong', N'Marketing Assistant', N'55 Grizzly Peak Rd.', N'Butte', N'MT',
        N'59801', N'USA', N'(406) 555-5834', N'(406) 555-8083');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'TOMSP', N'Toms Spezialitäten', N'Karin Josephs', N'Marketing Manager', N'Luisenstr. 48', N'Münster', null,
        N'44087', N'Germany', N'0251-031259', N'0251-035695');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'TORTU', N'Tortuga Restaurante', N'Miguel Angel Paolino', N'Owner', N'Avda. Azteca 123', N'México D.F.', null,
        N'05033', N'Mexico', N'(5) 555-2933', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'TRADH', N'Tradição Hipermercados', N'Anabela Domingues', N'Sales Representative', N'Av. Inês de Castro, 414',
        N'Sao Paulo', N'SP', N'05634-030', N'Brazil', N'(11) 555-2167', N'(11) 555-2168');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'TRAIH', N'Trail''s Head Gourmet Provisioners', N'Helvetius Nagy', N'Sales Associate', N'722 DaVinci Blvd.',
        N'Kirkland', N'WA', N'98034', N'USA', N'(206) 555-8257', N'(206) 555-2174');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'VAFFE', N'Vaffeljernet', N'Palle Ibsen', N'Sales Manager', N'Smagsloget 45', N'Århus', null, N'8200',
        N'Denmark', N'86 21 32 43', N'86 22 33 44');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'VICTE', N'Victuailles en stock', N'Mary Saveley', N'Sales Agent', N'2, rue du Commerce', N'Lyon', null,
        N'69004', N'France', N'78.32.54.86', N'78.32.54.87');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'VINET', N'Vins et alcools Chevalier', N'Paul Henriot', N'Accounting Manager', N'59 rue de l''Abbaye',
        N'Reims', null, N'51100', N'France', N'26.47.15.10', N'26.47.15.11');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'WANDK', N'Die Wandernde Kuh', N'Rita Müller', N'Sales Representative', N'Adenauerallee 900', N'Stuttgart',
        null, N'70563', N'Germany', N'0711-020361', N'0711-035428');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'WARTH', N'Wartian Herkku', N'Pirkko Koskitalo', N'Accounting Manager', N'Torikatu 38', N'Oulu', null,
        N'90110', N'Finland', N'981-443655', N'981-443655');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'WELLI', N'Wellington Importadora', N'Paula Parente', N'Sales Manager', N'Rua do Mercado, 12', N'Resende',
        N'SP', N'08737-363', N'Brazil', N'(14) 555-8122', null);
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'WHITC', N'White Clover Markets', N'Karl Jablonski', N'Owner', N'305 - 14th Ave. S. Suite 3B', N'Seattle',
        N'WA', N'98128', N'USA', N'(206) 555-4112', N'(206) 555-4115');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'WILMK', N'Wilman Kala', N'Matti Karttunen', N'Owner/Marketing Assistant', N'Keskuskatu 45', N'Helsinki', null,
        N'21240', N'Finland', N'90-224 8858', N'90-224 8858');
INSERT INTO customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, fax)
VALUES (N'WOLZA', N'Wolski  Zajazd', N'Zbyszek Piestrzeniewicz', N'Owner', N'ul. Filtrowa 68', N'Warszawa', null,
        N'01-012', N'Poland', N'(26) 642-7012', N'(26) 642-7012');

INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (2, N'Fuller', N'Andrew', N'Vice President, Sales', N'Dr.', N'1970-02-19 00:00:00.000',
        N'2010-08-14 00:00:00.000', N'908 W. Capital Way', N'Tacoma', N'WA', N'98401', N'USA', N'(206) 555-9482',
        N'3457',
        N'Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.',
        null, N'http://accweb/emmployees/fuller.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (1, N'Davolio', N'Nancy', N'Sales Representative', N'Ms.', N'1966-12-08 00:00:00.000',
        N'2010-05-01 00:00:00.000', N'507 - 20th Ave. E.
Apt. 2A', N'Seattle', N'WA', N'98122', N'USA', N'(206) 555-9857', N'5467',
        N'Education includes a BA in psychology from Colorado State University in 1970.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.',
        2, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (3, N'Leverling', N'Janet', N'Sales Representative', N'Ms.', N'1981-08-30 00:00:00.000',
        N'2010-04-01 00:00:00.000', N'722 Moss Bay Blvd.', N'Kirkland', N'WA', N'98033', N'USA', N'(206) 555-3412',
        N'3355',
        N'Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.',
        2, N'http://accweb/emmployees/leverling.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (4, N'Peacock', N'Margaret', N'Sales Representative', N'Mrs.', N'1955-09-19 00:00:00.000',
        N'2011-05-03 00:00:00.000', N'4110 Old Redmond Rd.', N'Redmond', N'WA', N'98052', N'USA', N'(206) 555-8122',
        N'5176',
        N'Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.',
        2, N'http://accweb/emmployees/peacock.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (5, N'Buchanan', N'Steven', N'Sales Manager', N'Mr.', N'1973-03-04 00:00:00.000', N'2011-10-17 00:00:00.000',
        N'14 Garrett Hill', N'London', null, N'SW1 8JR', N'UK', N'(71) 555-4848', N'3453',
        N'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management."  He is fluent in French.',
        2, N'http://accweb/emmployees/buchanan.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (6, N'Suyama', N'Michael', N'Sales Representative', N'Mr.', N'1981-07-02 00:00:00.000',
        N'2011-10-17 00:00:00.000', N'Coventry House
Miner Rd.', N'London', null, N'EC2 7JR', N'UK', N'(71) 555-7773', N'428',
        N'Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional."  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.',
        5, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (7, N'King', N'Robert', N'Sales Representative', N'Mr.', N'1978-05-29 00:00:00.000', N'2012-01-02 00:00:00.000', N'Edgeham Hollow
Winchester Way', N'London', null, N'RG1 9SP', N'UK', N'(71) 555-5598', N'465',
        N'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course entitled "Selling in Europe," he was transferred to the London office in March 1993.',
        5, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (8, N'Callahan', N'Laura', N'Inside Sales Coordinator', N'Ms.', N'1976-01-09 00:00:00.000',
        N'2012-03-05 00:00:00.000', N'4726 - 11th Ave. N.E.', N'Seattle', N'WA', N'98105', N'USA', N'(206) 555-1189',
        N'2344',
        N'Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.',
        2, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO employee (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address,
                      city,
                      region, postal_code, country, home_phone, extension, notes, reports_to, photo_path)
VALUES (9, N'Dodsworth', N'Anne', N'Sales Representative', N'Ms.', N'1984-01-27 00:00:00.000',
        N'2012-11-15 00:00:00.000', N'7 Houndstooth Rd.', N'London', null, N'WG2 7LT', N'UK', N'(71) 555-4444', N'452',
        N'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5,
        N'http://accweb/emmployees/davolio.bmp');

INSERT INTO shipper (shipper_id, company_name, phone)
VALUES (1, N'Speedy Express', N'(503) 555-9831');
INSERT INTO shipper (shipper_id, company_name, phone)
VALUES (2, N'United Package', N'(503) 555-3199');
INSERT INTO shipper (shipper_id, company_name, phone)
VALUES (3, N'Federal Shipping', N'(503) 555-9931');

INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (1, N'Exotic Liquids', N'Charlotte Cooper', N'Purchasing Manager', N'49 Gilbert St.', N'London', null,
        N'EC1 4SD', N'UK', N'(171) 555-2222', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (2, N'New Orleans Cajun Delights', N'Shelley Burke', N'Order Administrator', N'P.O. Box 78934', N'New Orleans',
        N'LA', N'70117', N'USA', N'(100) 555-4822', null, N'#CAJUN.HTM#');
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (3, N'Grandma Kelly''s Homestead', N'Regina Murphy', N'Sales Representative', N'707 Oxford Rd.', N'Ann Arbor',
        N'MI', N'48104', N'USA', N'(313) 555-5735', N'(313) 555-3349', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (4, N'Tokyo Traders', N'Yoshi Nagase', N'Marketing Manager', N'9-8 Sekimai Musashino-shi', N'Tokyo', null,
        N'100', N'Japan', N'(03) 3555-5011', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (5, N'Cooperativa de Quesos ''Las Cabras''', N'Antonio del Valle Saavedra', N'Export Administrator',
        N'Calle del Rosal 4', N'Oviedo', N'Asturias', N'33007', N'Spain', N'(98) 598 76 54', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (6, N'Mayumi''s', N'Mayumi Ohno', N'Marketing Representative', N'92 Setsuko Chuo-ku', N'Osaka', null, N'545',
        N'Japan', N'(06) 431-7877', null,
        N'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#');
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (7, N'Pavlova, Ltd.', N'Ian Devling', N'Marketing Manager', N'74 Rose St. Moonie Ponds', N'Melbourne',
        N'Victoria', N'3058', N'Australia', N'(03) 444-2343', N'(03) 444-6588', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (8, N'Specialty Biscuits, Ltd.', N'Peter Wilson', N'Sales Representative', N'29 King''s Way', N'Manchester',
        null, N'M14 GSD', N'UK', N'(161) 555-4448', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (9, N'PB Knäckebröd AB', N'Lars Peterson', N'Sales Agent', N'Kaloadagatan 13', N'Göteborg', null, N'S-345 67',
        N'Sweden', N'031-987 65 43', N'031-987 65 91', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (10, N'Refrescos Americanas LTDA', N'Carlos Diaz', N'Marketing Manager', N'Av. das Americanas 12.890',
        N'Sao Paulo', null, N'5442', N'Brazil', N'(11) 555 4640', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (11, N'Heli Süßwaren GmbH & Co. KG', N'Petra Winkler', N'Sales Manager', N'Tiergartenstraße 5', N'Berlin', null,
        N'10785', N'Germany', N'(010) 9984510', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (12, N'Plutzer Lebensmittelgroßmärkte AG', N'Martin Bein', N'International Marketing Mgr.', N'Bogenallee 51',
        N'Frankfurt', null, N'60439', N'Germany', N'(069) 992755', null,
        N'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#');
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (13, N'Nord-Ost-Fisch Handelsgesellschaft mbH', N'Sven Petersen', N'Coordinator Foreign Markets',
        N'Frahmredder 112a', N'Cuxhaven', null, N'27478', N'Germany', N'(04721) 8713', N'(04721) 8714', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (14, N'Formaggi Fortini s.r.l.', N'Elio Rossi', N'Sales Representative', N'Viale Dante, 75', N'Ravenna', null,
        N'48100', N'Italy', N'(0544) 60323', N'(0544) 60603', N'#FORMAGGI.HTM#');
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (15, N'Norske Meierier', N'Beate Vileid', N'Marketing Manager', N'Hatlevegen 5', N'Sandvika', null, N'1320',
        N'Norway', N'(0)2-953010', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (16, N'Bigfoot Breweries', N'Cheryl Saylor', N'Regional Account Rep.', N'3400 - 8th Avenue Suite 210', N'Bend',
        N'OR', N'97101', N'USA', N'(503) 555-9931', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (17, N'Svensk Sjöföda AB', N'Michael Björn', N'Sales Representative', N'Brovallavägen 231', N'Stockholm', null,
        N'S-123 45', N'Sweden', N'08-123 45 67', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (18, N'Aux joyeux ecclésiastiques', N'Guylène Nodier', N'Sales Manager', N'203, Rue des Francs-Bourgeois',
        N'Paris', null, N'75004', N'France', N'(1) 03.83.00.68', N'(1) 03.83.00.62', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (19, N'New England Seafood Cannery', N'Robb Merchant', N'Wholesale Account Agent',
        N'Order Processing Dept. 2100 Paul Revere Blvd.', N'Boston', N'MA', N'02134', N'USA', N'(617) 555-3267',
        N'(617) 555-3389', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (20, N'Leka Trading', N'Chandra Leka', N'Owner', N'471 Serangoon Loop, Suite #402', N'Singapore', null, N'0512',
        N'Singapore', N'555-8787', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (21, N'Lyngbysild', N'Niels Petersen', N'Sales Manager', N'Lyngbysild Fiskebakken 10', N'Lyngby', null, N'2800',
        N'Denmark', N'43844108', N'43844115', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (22, N'Zaanse Snoepfabriek', N'Dirk Luchte', N'Accounting Manager', N'Verkoop Rijnweg 22', N'Zaandam', null,
        N'9999 ZZ', N'Netherlands', N'(12345) 1212', N'(12345) 1210', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (23, N'Karkki Oy', N'Anne Heikkonen', N'Product Manager', N'Valtakatu 12', N'Lappeenranta', null, N'53120',
        N'Finland', N'(953) 10956', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (24, N'G''day, Mate', N'Wendy Mackenzie', N'Sales Representative', N'170 Prince Edward Parade Hunter''s Hill',
        N'Sydney', N'NSW', N'2042', N'Australia', N'(02) 555-5914', N'(02) 555-4873',
        N'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#');
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (25, N'Ma Maison', N'Jean-Guy Lauzon', N'Marketing Manager', N'2960 Rue St. Laurent', N'Montréal', N'Québec',
        N'H1J 1C3', N'Canada', N'(514) 555-9022', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (26, N'Pasta Buttini s.r.l.', N'Giovanni Giudici', N'Order Administrator', N'Via dei Gelsomini, 153', N'Salerno',
        null, N'84100', N'Italy', N'(089) 6547665', N'(089) 6547667', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (27, N'Escargots Nouveaux', N'Marie Delamare', N'Sales Manager', N'22, rue H. Voiron', N'Montceau', null,
        N'71300', N'France', N'85.57.00.07', null, null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (28, N'Gai pâturage', N'Eliane Noz', N'Sales Representative', N'Bat. B 3, rue des Alpes', N'Annecy', null,
        N'74000', N'France', N'38.76.98.06', N'38.76.98.58', null);
INSERT INTO supplier (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code,
                      country,
                      phone, Fax, home_page)
VALUES (29, N'Forêts d''érables', N'Chantal Goulet', N'Accounting Manager', N'148 rue Chasseur', N'Ste-Hyacinthe',
        N'Québec', N'J2S 7S8', N'Canada', N'(514) 555-2955', N'(514) 555-2921', null);

INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (1, N'Chai', 1, 1, N'10 boxes x 20 bags', 18.0000, 39, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (2, N'Chang', 1, 1, N'24 - 12 oz bottles', 19.0000, 17, 40, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (3, N'Aniseed Syrup', 1, 2, N'12 - 550 ml bottles', 10.0000, 13, 70, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (4, N'Chef Anton''s Cajun Seasoning', 2, 2, N'48 - 6 oz jars', 22.0000, 53, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (5, N'Chef Anton''s Gumbo Mix', 2, 2, N'36 boxes', 21.3500, 0, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (6, N'Grandma''s Boysenberry Spread', 3, 2, N'12 - 8 oz jars', 25.0000, 120, 0, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (7, N'Uncle Bob''s Organic Dried Pears', 3, 7, N'12 - 1 lb pkgs.', 30.0000, 15, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (8, N'Northwoods Cranberry Sauce', 3, 2, N'12 - 12 oz jars', 40.0000, 6, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (9, N'Mishi Kobe Niku', 4, 6, N'18 - 500 g pkgs.', 97.0000, 29, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (10, N'Ikura', 4, 8, N'12 - 200 ml jars', 31.0000, 31, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (11, N'Queso Cabrales', 5, 4, N'1 kg pkg.', 21.0000, 22, 30, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (12, N'Queso Manchego La Pastora', 5, 4, N'10 - 500 g pkgs.', 38.0000, 86, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (13, N'Konbu', 6, 8, N'2 kg box', 6.0000, 24, 0, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (14, N'Tofu', 6, 7, N'40 - 100 g pkgs.', 23.2500, 35, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (15, N'Genen Shouyu', 6, 2, N'24 - 250 ml bottles', 15.5000, 39, 0, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (16, N'Pavlova', 7, 3, N'32 - 500 g boxes', 17.4500, 29, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (17, N'Alice Mutton', 7, 6, N'20 - 1 kg tins', 39.0000, 0, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (18, N'Carnarvon Tigers', 7, 8, N'16 kg pkg.', 62.5000, 42, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (19, N'Teatime Chocolate Biscuits', 8, 3, N'10 boxes x 12 pieces', 9.2000, 25, 0, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (20, N'Sir Rodney''s Marmalade', 8, 3, N'30 gift boxes', 81.0000, 40, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (21, N'Sir Rodney''s Scones', 8, 3, N'24 pkgs. x 4 pieces', 10.0000, 3, 40, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (22, N'Gustaf''s Knäckebröd', 9, 5, N'24 - 500 g pkgs.', 21.0000, 104, 0, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (23, N'Tunnbröd', 9, 5, N'12 - 250 g pkgs.', 9.0000, 61, 0, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (24, N'Guaraná Fantástica', 10, 1, N'12 - 355 ml cans', 4.5000, 20, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (25, N'NuNuCa Nuß-Nougat-Creme', 11, 3, N'20 - 450 g glasses', 14.0000, 76, 0, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (26, N'Gumbär Gummibärchen', 11, 3, N'100 - 250 g bags', 31.2300, 15, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (27, N'Schoggi Schokolade', 11, 3, N'100 - 100 g pieces', 43.9000, 49, 0, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (28, N'Rössle Sauerkraut', 12, 7, N'25 - 825 g cans', 45.6000, 26, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (29, N'Thüringer Rostbratwurst', 12, 6, N'50 bags x 30 sausgs.', 123.7900, 0, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (30, N'Nord-Ost Matjeshering', 13, 8, N'10 - 200 g glasses', 25.8900, 10, 0, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (31, N'Gorgonzola Telino', 14, 4, N'12 - 100 g pkgs', 12.5000, 0, 70, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (32, N'Mascarpone Fabioli', 14, 4, N'24 - 200 g pkgs.', 32.0000, 9, 40, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (33, N'Geitost', 15, 4, N'500 g', 2.5000, 112, 0, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (34, N'Sasquatch Ale', 16, 1, N'24 - 12 oz bottles', 14.0000, 111, 0, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (35, N'Steeleye Stout', 16, 1, N'24 - 12 oz bottles', 18.0000, 20, 0, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (36, N'Inlagd Sill', 17, 8, N'24 - 250 g  jars', 19.0000, 112, 0, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (37, N'Gravad lax', 17, 8, N'12 - 500 g pkgs.', 26.0000, 11, 50, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (38, N'Côte de Blaye', 18, 1, N'12 - 75 cl bottles', 263.5000, 17, 0, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (39, N'Chartreuse verte', 18, 1, N'750 cc per bottle', 18.0000, 69, 0, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (40, N'Boston Crab Meat', 19, 8, N'24 - 4 oz tins', 18.4000, 123, 0, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (41, N'Jack''s New England Clam Chowder', 19, 8, N'12 - 12 oz cans', 9.6500, 85, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (42, N'Singaporean Hokkien Fried Mee', 20, 5, N'32 - 1 kg pkgs.', 14.0000, 26, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (43, N'Ipoh Coffee', 20, 1, N'16 - 500 g tins', 46.0000, 17, 10, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (44, N'Gula Malacca', 20, 2, N'20 - 2 kg bags', 19.4500, 27, 0, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (45, N'Rogede sild', 21, 8, N'1k pkg.', 9.5000, 5, 70, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (46, N'Spegesild', 21, 8, N'4 - 450 g glasses', 12.0000, 95, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (47, N'Zaanse koeken', 22, 3, N'10 - 4 oz boxes', 9.5000, 36, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (48, N'Chocolade', 22, 3, N'10 pkgs.', 12.7500, 15, 70, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (49, N'Maxilaku', 23, 3, N'24 - 50 g pkgs.', 20.0000, 10, 60, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (50, N'Valkoinen suklaa', 23, 3, N'12 - 100 g bars', 16.2500, 65, 0, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (51, N'Manjimup Dried Apples', 24, 7, N'50 - 300 g pkgs.', 53.0000, 20, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (52, N'Filo Mix', 24, 5, N'16 - 2 kg boxes', 7.0000, 38, 0, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (53, N'Perth Pasties', 24, 6, N'48 pieces', 32.8000, 0, 0, 0, 1);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (54, N'Tourtière', 25, 6, N'16 pies', 7.4500, 21, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (55, N'Pâté chinois', 25, 6, N'24 boxes x 2 pies', 24.0000, 115, 0, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (56, N'Gnocchi di nonna Alice', 26, 5, N'24 - 250 g pkgs.', 38.0000, 21, 10, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (57, N'Ravioli Angelo', 26, 5, N'24 - 250 g pkgs.', 19.5000, 36, 0, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (58, N'Escargots de Bourgogne', 27, 8, N'24 pieces', 13.2500, 62, 0, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (59, N'Raclette Courdavault', 28, 4, N'5 kg pkg.', 55.0000, 79, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (60, N'Camembert Pierrot', 28, 4, N'15 - 300 g rounds', 34.0000, 19, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (61, N'Sirop d''érable', 29, 2, N'24 - 500 ml bottles', 28.5000, 113, 0, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (62, N'Tarte au sucre', 29, 3, N'48 pies', 49.3000, 17, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (63, N'Vegie-spread', 7, 2, N'15 - 625 g jars', 43.9000, 24, 0, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (64, N'Wimmers gute Semmelknödel', 12, 5, N'20 bags x 4 pieces', 33.2500, 22, 80, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (65, N'Louisiana Fiery Hot Pepper Sauce', 2, 2, N'32 - 8 oz bottles', 21.0500, 76, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (66, N'Louisiana Hot Spiced Okra', 2, 2, N'24 - 8 oz jars', 17.0000, 4, 100, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (67, N'Laughing Lumberjack Lager', 16, 1, N'24 - 12 oz bottles', 14.0000, 52, 0, 10, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (68, N'Scottish Longbreads', 8, 3, N'10 boxes x 8 pieces', 12.5000, 6, 10, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (69, N'Gudbrandsdalsost', 15, 4, N'10 kg pkg.', 36.0000, 26, 0, 15, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (70, N'Outback Lager', 7, 1, N'24 - 355 ml bottles', 15.0000, 15, 10, 30, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (71, N'Flotemysost', 15, 4, N'10 - 500 g pkgs.', 21.5000, 26, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (72, N'Mozzarella di Giovanni', 14, 4, N'24 - 200 g pkgs.', 34.8000, 14, 0, 0, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (73, N'Röd Kaviar', 17, 8, N'24 - 150 g jars', 15.0000, 101, 0, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (74, N'Longlife Tofu', 4, 7, N'5 kg pkg.', 10.0000, 4, 20, 5, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (75, N'Rhönbräu Klosterbier', 12, 1, N'24 - 0.5 l bottles', 7.7500, 125, 0, 25, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (76, N'Lakkalikööri', 23, 1, N'500 ml', 18.0000, 57, 0, 20, 0);
INSERT INTO product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock,
                     units_on_order, reorder_level, discontinued)
VALUES (77, N'Original Frankfurter grüne Soße', 12, 2, N'12 boxes', 13.0000, 32, 0, 15, 0);

INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10248, N'VINET', 5, N'2014-07-04 08:00:00.000', N'2014-08-01 00:00:00.000', N'2014-07-16 00:00:00.000', 3,
        32.3800, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', null, N'51100', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10249, N'TOMSP', 6, N'2014-07-05 04:00:00.000', N'2014-08-16 00:00:00.000', N'2014-07-10 00:00:00.000', 1,
        11.6100, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', null, N'44087', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10250, N'HANAR', 4, N'2014-07-08 15:00:00.000', N'2014-08-05 00:00:00.000', N'2014-07-12 00:00:00.000', 2,
        65.8300, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10251, N'VICTE', 3, N'2014-07-08 14:00:00.000', N'2014-08-05 00:00:00.000', N'2014-07-15 00:00:00.000', 1,
        41.3400, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10252, N'SUPRD', 4, N'2014-07-09 01:00:00.000', N'2014-08-06 00:00:00.000', N'2014-07-11 00:00:00.000', 2,
        51.3000, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10253, N'HANAR', 3, N'2014-07-10 08:00:00.000', N'2014-07-24 00:00:00.000', N'2014-07-16 00:00:00.000', 2,
        58.1700, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10254, N'CHOPS', 5, N'2014-07-11 02:00:00.000', N'2014-08-08 00:00:00.000', N'2014-07-23 00:00:00.000', 2,
        22.9800, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10255, N'RICSU', 9, N'2014-07-12 20:00:00.000', N'2014-08-09 00:00:00.000', N'2014-07-15 00:00:00.000', 3,
        148.3300, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10256, N'WELLI', 3, N'2014-07-15 22:00:00.000', N'2014-08-12 00:00:00.000', N'2014-07-17 00:00:00.000', 2,
        13.9700, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10257, N'HILAA', 4, N'2014-07-16 15:00:00.000', N'2014-08-13 00:00:00.000', N'2014-07-22 00:00:00.000', 3,
        81.9100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10258, N'ERNSH', 1, N'2014-07-17 00:00:00.000', N'2014-08-14 00:00:00.000', N'2014-07-23 00:00:00.000', 1,
        140.5100, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10259, N'CENTC', 4, N'2014-07-18 16:00:00.000', N'2014-08-15 00:00:00.000', N'2014-07-25 00:00:00.000', 3,
        3.2500, N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'México D.F.', null, N'05022', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10260, N'OTTIK', 4, N'2014-07-19 09:00:00.000', N'2014-08-16 00:00:00.000', N'2014-07-29 00:00:00.000', 1,
        55.0900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10261, N'QUEDE', 4, N'2014-07-19 13:00:00.000', N'2014-08-16 00:00:00.000', N'2014-07-30 00:00:00.000', 2,
        3.0500, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10262, N'RATTC', 8, N'2014-07-22 19:00:00.000', N'2014-08-19 00:00:00.000', N'2014-07-25 00:00:00.000', 3,
        48.2900, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10263, N'ERNSH', 9, N'2014-07-23 10:00:00.000', N'2014-08-20 00:00:00.000', N'2014-07-31 00:00:00.000', 3,
        146.0600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10264, N'FOLKO', 6, N'2014-07-24 22:00:00.000', N'2014-08-21 00:00:00.000', N'2014-08-23 00:00:00.000', 3,
        3.6700, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10265, N'BLONP', 2, N'2014-07-25 21:00:00.000', N'2014-08-22 00:00:00.000', N'2014-08-12 00:00:00.000', 1,
        55.2800, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10266, N'WARTH', 3, N'2014-07-26 14:00:00.000', N'2014-09-06 00:00:00.000', N'2014-07-31 00:00:00.000', 3,
        25.7300, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10267, N'FRANK', 4, N'2014-07-29 14:00:00.000', N'2014-08-26 00:00:00.000', N'2014-08-06 00:00:00.000', 1,
        208.5800, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10268, N'GROSR', 8, N'2014-07-30 15:00:00.000', N'2014-08-27 00:00:00.000', N'2014-08-02 00:00:00.000', 3,
        66.2900, N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10269, N'WHITC', 5, N'2014-07-31 00:00:00.000', N'2014-08-14 00:00:00.000', N'2014-08-09 00:00:00.000', 1,
        4.5600, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10270, N'WARTH', 1, N'2014-08-01 19:00:00.000', N'2014-08-29 00:00:00.000', N'2014-08-02 00:00:00.000', 1,
        136.5400, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10271, N'SPLIR', 6, N'2014-08-01 05:00:00.000', N'2014-08-29 00:00:00.000', N'2014-08-30 00:00:00.000', 2,
        4.5400, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10272, N'RATTC', 6, N'2014-08-02 03:00:00.000', N'2014-08-30 00:00:00.000', N'2014-08-06 00:00:00.000', 2,
        98.0300, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10273, N'QUICK', 3, N'2014-08-05 13:00:00.000', N'2014-09-02 00:00:00.000', N'2014-08-12 00:00:00.000', 3,
        76.0700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10274, N'VINET', 6, N'2014-08-06 12:00:00.000', N'2014-09-03 00:00:00.000', N'2014-08-16 00:00:00.000', 1,
        6.0100, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', null, N'51100', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10275, N'MAGAA', 1, N'2014-08-07 06:00:00.000', N'2014-09-04 00:00:00.000', N'2014-08-09 00:00:00.000', 1,
        26.9300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10276, N'TORTU', 8, N'2014-08-08 18:00:00.000', N'2014-08-22 00:00:00.000', N'2014-08-14 00:00:00.000', 3,
        13.8400, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10277, N'MORGK', 2, N'2014-08-09 11:00:00.000', N'2014-09-06 00:00:00.000', N'2014-08-13 00:00:00.000', 3,
        125.7700, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', null, N'04179', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10278, N'BERGS', 8, N'2014-08-12 14:00:00.000', N'2014-09-09 00:00:00.000', N'2014-08-16 00:00:00.000', 2,
        92.6900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10279, N'LEHMS', 8, N'2014-08-13 15:00:00.000', N'2014-09-10 00:00:00.000', N'2014-08-16 00:00:00.000', 2,
        25.8300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10280, N'BERGS', 2, N'2014-08-14 10:00:00.000', N'2014-09-11 00:00:00.000', N'2014-09-12 00:00:00.000', 1,
        8.9800, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10281, N'ROMEY', 4, N'2014-08-14 14:00:00.000', N'2014-08-28 00:00:00.000', N'2014-08-21 00:00:00.000', 1,
        2.9400, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', null, N'28001', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10282, N'ROMEY', 4, N'2014-08-15 00:00:00.000', N'2014-09-12 00:00:00.000', N'2014-08-21 00:00:00.000', 1,
        12.6900, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', null, N'28001', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10283, N'LILAS', 3, N'2014-08-16 17:00:00.000', N'2014-09-13 00:00:00.000', N'2014-08-23 00:00:00.000', 3,
        84.8100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10284, N'LEHMS', 4, N'2014-08-19 00:00:00.000', N'2014-09-16 00:00:00.000', N'2014-08-27 00:00:00.000', 1,
        76.5600, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10285, N'QUICK', 1, N'2014-08-20 02:00:00.000', N'2014-09-17 00:00:00.000', N'2014-08-26 00:00:00.000', 2,
        76.8300, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10286, N'QUICK', 8, N'2014-08-21 01:00:00.000', N'2014-09-18 00:00:00.000', N'2014-08-30 00:00:00.000', 3,
        229.2400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10287, N'RICAR', 8, N'2014-08-22 07:00:00.000', N'2014-09-19 00:00:00.000', N'2014-08-28 00:00:00.000', 3,
        12.7600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10288, N'REGGC', 4, N'2014-08-23 16:00:00.000', N'2014-09-20 00:00:00.000', N'2014-09-03 00:00:00.000', 1,
        7.4500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10289, N'BSBEV', 7, N'2014-08-26 11:00:00.000', N'2014-09-23 00:00:00.000', N'2014-08-28 00:00:00.000', 3,
        22.7700, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10290, N'COMMI', 8, N'2014-08-27 09:00:00.000', N'2014-09-24 00:00:00.000', N'2014-09-03 00:00:00.000', 1,
        79.7000, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10291, N'QUEDE', 6, N'2014-08-27 19:00:00.000', N'2014-09-24 00:00:00.000', N'2014-09-04 00:00:00.000', 2,
        6.4000, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10292, N'TRADH', 1, N'2014-08-28 20:00:00.000', N'2014-09-25 00:00:00.000', N'2014-09-02 00:00:00.000', 2,
        1.3500, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10293, N'TORTU', 1, N'2014-08-29 15:00:00.000', N'2014-09-26 00:00:00.000', N'2014-09-11 00:00:00.000', 3,
        21.1800, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10294, N'RATTC', 4, N'2014-08-30 05:00:00.000', N'2014-09-27 00:00:00.000', N'2014-09-05 00:00:00.000', 2,
        147.2600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10295, N'VINET', 2, N'2014-09-02 08:00:00.000', N'2014-09-30 00:00:00.000', N'2014-09-10 00:00:00.000', 2,
        1.1500, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', null, N'51100', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10296, N'LILAS', 6, N'2014-09-03 00:00:00.000', N'2014-10-01 00:00:00.000', N'2014-09-11 00:00:00.000', 1,
        0.1200, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10297, N'BLONP', 5, N'2014-09-04 21:00:00.000', N'2014-10-16 00:00:00.000', N'2014-09-10 00:00:00.000', 2,
        5.7400, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10298, N'HUNGO', 6, N'2014-09-05 16:00:00.000', N'2014-10-03 00:00:00.000', N'2014-09-11 00:00:00.000', 2,
        168.2200, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10299, N'RICAR', 4, N'2014-09-06 01:00:00.000', N'2014-10-04 00:00:00.000', N'2014-09-13 00:00:00.000', 2,
        29.7600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10300, N'MAGAA', 2, N'2014-09-09 11:00:00.000', N'2014-10-07 00:00:00.000', N'2014-09-18 00:00:00.000', 2,
        17.6800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10301, N'WANDK', 8, N'2014-09-09 15:00:00.000', N'2014-10-07 00:00:00.000', N'2014-09-17 00:00:00.000', 2,
        45.0800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10302, N'SUPRD', 4, N'2014-09-10 17:00:00.000', N'2014-10-08 00:00:00.000', N'2014-10-09 00:00:00.000', 2,
        6.2700, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10303, N'GODOS', 7, N'2014-09-11 03:00:00.000', N'2014-10-09 00:00:00.000', N'2014-09-18 00:00:00.000', 2,
        107.8300, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10304, N'TORTU', 1, N'2014-09-12 06:00:00.000', N'2014-10-10 00:00:00.000', N'2014-09-17 00:00:00.000', 2,
        63.7900, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10305, N'OLDWO', 8, N'2014-09-13 20:00:00.000', N'2014-10-11 00:00:00.000', N'2014-10-09 00:00:00.000', 3,
        257.6200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10306, N'ROMEY', 1, N'2014-09-16 09:00:00.000', N'2014-10-14 00:00:00.000', N'2014-09-23 00:00:00.000', 3,
        7.5600, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', null, N'28001', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10307, N'LONEP', 2, N'2014-09-17 06:00:00.000', N'2014-10-15 00:00:00.000', N'2014-09-25 00:00:00.000', 2,
        0.5600, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10308, N'ANATR', 7, N'2014-09-18 14:00:00.000', N'2014-10-16 00:00:00.000', N'2014-09-24 00:00:00.000', 3,
        1.6100, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', null, N'05021',
        N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10309, N'HUNGO', 3, N'2014-09-19 14:00:00.000', N'2014-10-17 00:00:00.000', N'2014-10-23 00:00:00.000', 1,
        47.3000, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10310, N'THEBI', 8, N'2014-09-20 05:00:00.000', N'2014-10-18 00:00:00.000', N'2014-09-27 00:00:00.000', 2,
        17.5200, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10311, N'DUMON', 1, N'2014-09-20 08:00:00.000', N'2014-10-04 00:00:00.000', N'2014-09-26 00:00:00.000', 3,
        24.6900, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10312, N'WANDK', 2, N'2014-09-23 01:00:00.000', N'2014-10-21 00:00:00.000', N'2014-10-03 00:00:00.000', 2,
        40.2600, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10313, N'QUICK', 2, N'2014-09-24 22:00:00.000', N'2014-10-22 00:00:00.000', N'2014-10-04 00:00:00.000', 2,
        1.9600, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10314, N'RATTC', 1, N'2014-09-25 13:00:00.000', N'2014-10-23 00:00:00.000', N'2014-10-04 00:00:00.000', 2,
        74.1600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10315, N'ISLAT', 4, N'2014-09-26 11:00:00.000', N'2014-10-24 00:00:00.000', N'2014-10-03 00:00:00.000', 2,
        41.7600, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10316, N'RATTC', 1, N'2014-09-27 02:00:00.000', N'2014-10-25 00:00:00.000', N'2014-10-08 00:00:00.000', 3,
        150.1500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10317, N'LONEP', 6, N'2014-09-30 00:00:00.000', N'2014-10-28 00:00:00.000', N'2014-10-10 00:00:00.000', 1,
        12.6900, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10318, N'ISLAT', 8, N'2014-10-01 00:00:00.000', N'2014-10-29 00:00:00.000', N'2014-10-04 00:00:00.000', 2,
        4.7300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10319, N'TORTU', 7, N'2014-10-02 20:00:00.000', N'2014-10-30 00:00:00.000', N'2014-10-11 00:00:00.000', 3,
        64.5000, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10320, N'WARTH', 5, N'2014-10-03 12:00:00.000', N'2014-10-19 00:00:00.000', N'2014-10-18 00:00:00.000', 3,
        34.5700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10321, N'ISLAT', 3, N'2014-10-03 11:00:00.000', N'2014-10-31 00:00:00.000', N'2014-10-11 00:00:00.000', 2,
        3.4300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10322, N'PERIC', 7, N'2014-10-04 01:00:00.000', N'2014-11-01 00:00:00.000', N'2014-10-23 00:00:00.000', 3,
        0.4000, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10323, N'KOENE', 4, N'2014-10-07 06:00:00.000', N'2014-11-04 00:00:00.000', N'2014-10-14 00:00:00.000', 1,
        4.8800, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10324, N'SAVEA', 9, N'2014-10-08 17:00:00.000', N'2014-11-05 00:00:00.000', N'2014-10-10 00:00:00.000', 1,
        214.2700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10325, N'KOENE', 1, N'2014-10-09 11:00:00.000', N'2014-10-23 00:00:00.000', N'2014-10-14 00:00:00.000', 3,
        64.8600, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10326, N'BOLID', 4, N'2014-10-10 06:00:00.000', N'2014-11-07 00:00:00.000', N'2014-10-14 00:00:00.000', 2,
        77.9200, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', null, N'28023', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10327, N'FOLKO', 2, N'2014-10-11 12:00:00.000', N'2014-11-08 00:00:00.000', N'2014-10-14 00:00:00.000', 1,
        63.3600, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10328, N'FURIB', 4, N'2014-10-14 03:00:00.000', N'2014-11-11 00:00:00.000', N'2014-10-17 00:00:00.000', 3,
        87.0300, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10329, N'SPLIR', 4, N'2014-10-15 11:00:00.000', N'2014-11-26 00:00:00.000', N'2014-10-23 00:00:00.000', 2,
        191.6700, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10330, N'LILAS', 3, N'2014-10-16 01:00:00.000', N'2014-11-13 00:00:00.000', N'2014-10-28 00:00:00.000', 1,
        12.7500, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10331, N'BONAP', 9, N'2014-10-16 17:00:00.000', N'2014-11-27 00:00:00.000', N'2014-10-21 00:00:00.000', 1,
        10.1900, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10332, N'MEREP', 3, N'2014-10-17 01:00:00.000', N'2014-11-28 00:00:00.000', N'2014-10-21 00:00:00.000', 2,
        52.8400, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10333, N'WARTH', 5, N'2014-10-18 18:00:00.000', N'2014-11-15 00:00:00.000', N'2014-10-25 00:00:00.000', 3,
        0.5900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10334, N'VICTE', 8, N'2014-10-21 14:00:00.000', N'2014-11-18 00:00:00.000', N'2014-10-28 00:00:00.000', 2,
        8.5600, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10335, N'HUNGO', 7, N'2014-10-22 06:00:00.000', N'2014-11-19 00:00:00.000', N'2014-10-24 00:00:00.000', 2,
        42.1100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10336, N'PRINI', 7, N'2014-10-23 05:00:00.000', N'2014-11-20 00:00:00.000', N'2014-10-25 00:00:00.000', 2,
        15.5100, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', null, N'1756', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10337, N'FRANK', 4, N'2014-10-24 14:00:00.000', N'2014-11-21 00:00:00.000', N'2014-10-29 00:00:00.000', 3,
        108.2600, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10338, N'OLDWO', 4, N'2014-10-25 01:00:00.000', N'2014-11-22 00:00:00.000', N'2014-10-29 00:00:00.000', 3,
        84.2100, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10339, N'MEREP', 2, N'2014-10-28 22:00:00.000', N'2014-11-25 00:00:00.000', N'2014-11-04 00:00:00.000', 2,
        15.6600, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10340, N'BONAP', 1, N'2014-10-29 16:00:00.000', N'2014-11-26 00:00:00.000', N'2014-11-08 00:00:00.000', 3,
        166.3100, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10341, N'SIMOB', 7, N'2014-10-29 03:00:00.000', N'2014-11-26 00:00:00.000', N'2014-11-05 00:00:00.000', 3,
        26.7800, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10342, N'FRANK', 4, N'2014-10-30 17:00:00.000', N'2014-11-13 00:00:00.000', N'2014-11-04 00:00:00.000', 2,
        54.8300, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10343, N'LEHMS', 4, N'2014-10-31 00:00:00.000', N'2014-11-28 00:00:00.000', N'2014-11-06 00:00:00.000', 1,
        110.3700, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10344, N'WHITC', 4, N'2014-11-01 16:00:00.000', N'2014-11-29 00:00:00.000', N'2014-11-05 00:00:00.000', 2,
        23.2900, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10345, N'QUICK', 2, N'2014-11-04 10:00:00.000', N'2014-12-02 00:00:00.000', N'2014-11-11 00:00:00.000', 2,
        249.0600, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10346, N'RATTC', 3, N'2014-11-05 13:00:00.000', N'2014-12-17 00:00:00.000', N'2014-11-08 00:00:00.000', 3,
        142.0800, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10347, N'FAMIA', 4, N'2014-11-06 12:00:00.000', N'2014-12-04 00:00:00.000', N'2014-11-08 00:00:00.000', 3,
        3.1000, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10348, N'WANDK', 4, N'2014-11-07 10:00:00.000', N'2014-12-05 00:00:00.000', N'2014-11-15 00:00:00.000', 2,
        0.7800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10349, N'SPLIR', 7, N'2014-11-08 20:00:00.000', N'2014-12-06 00:00:00.000', N'2014-11-15 00:00:00.000', 1,
        8.6300, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10350, N'LAMAI', 6, N'2014-11-11 03:00:00.000', N'2014-12-09 00:00:00.000', N'2014-12-03 00:00:00.000', 2,
        64.1900, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10351, N'ERNSH', 1, N'2014-11-11 06:00:00.000', N'2014-12-09 00:00:00.000', N'2014-11-20 00:00:00.000', 1,
        162.3300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10352, N'FURIB', 3, N'2014-11-12 03:00:00.000', N'2014-11-26 00:00:00.000', N'2014-11-18 00:00:00.000', 3,
        1.3000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10353, N'PICCO', 7, N'2014-11-13 12:00:00.000', N'2014-12-11 00:00:00.000', N'2014-11-25 00:00:00.000', 3,
        360.6300, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10354, N'PERIC', 8, N'2014-11-14 03:00:00.000', N'2014-12-12 00:00:00.000', N'2014-11-20 00:00:00.000', 3,
        53.8000, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10355, N'AROUT', 6, N'2014-11-15 21:00:00.000', N'2014-12-13 00:00:00.000', N'2014-11-20 00:00:00.000', 1,
        41.9500, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10356, N'WANDK', 6, N'2014-11-18 01:00:00.000', N'2014-12-16 00:00:00.000', N'2014-11-27 00:00:00.000', 2,
        36.7100, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10357, N'LILAS', 1, N'2014-11-19 08:00:00.000', N'2014-12-17 00:00:00.000', N'2014-12-02 00:00:00.000', 3,
        34.8800, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10358, N'LAMAI', 5, N'2014-11-20 05:00:00.000', N'2014-12-18 00:00:00.000', N'2014-11-27 00:00:00.000', 1,
        19.6400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10359, N'SEVES', 5, N'2014-11-21 14:00:00.000', N'2014-12-19 00:00:00.000', N'2014-11-26 00:00:00.000', 3,
        288.4300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10360, N'BLONP', 4, N'2014-11-22 20:00:00.000', N'2014-12-20 00:00:00.000', N'2014-12-02 00:00:00.000', 3,
        131.7000, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10361, N'QUICK', 1, N'2014-11-22 07:00:00.000', N'2014-12-20 00:00:00.000', N'2014-12-03 00:00:00.000', 2,
        183.1700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10362, N'BONAP', 3, N'2014-11-25 16:00:00.000', N'2014-12-23 00:00:00.000', N'2014-11-28 00:00:00.000', 1,
        96.0400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10363, N'DRACD', 4, N'2014-11-26 05:00:00.000', N'2014-12-24 00:00:00.000', N'2014-12-04 00:00:00.000', 3,
        30.5400, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', null, N'52066', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10364, N'EASTC', 1, N'2014-11-26 07:00:00.000', N'2015-01-07 00:00:00.000', N'2014-12-04 00:00:00.000', 1,
        71.9700, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10365, N'ANTON', 3, N'2014-11-27 00:00:00.000', N'2014-12-25 00:00:00.000', N'2014-12-02 00:00:00.000', 2,
        22.0000, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10366, N'GALED', 8, N'2014-11-28 05:00:00.000', N'2015-01-09 00:00:00.000', N'2014-12-30 00:00:00.000', 2,
        10.1400, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', null, N'8022', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10367, N'VAFFE', 7, N'2014-11-28 21:00:00.000', N'2014-12-26 00:00:00.000', N'2014-12-02 00:00:00.000', 3,
        13.5500, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10368, N'ERNSH', 2, N'2014-11-29 19:00:00.000', N'2014-12-27 00:00:00.000', N'2014-12-02 00:00:00.000', 2,
        101.9500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10369, N'SPLIR', 8, N'2014-12-02 02:00:00.000', N'2014-12-30 00:00:00.000', N'2014-12-09 00:00:00.000', 2,
        195.6800, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10370, N'CHOPS', 6, N'2014-12-03 17:00:00.000', N'2014-12-31 00:00:00.000', N'2014-12-27 00:00:00.000', 2,
        1.1700, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10371, N'LAMAI', 1, N'2014-12-03 17:00:00.000', N'2014-12-31 00:00:00.000', N'2014-12-24 00:00:00.000', 1,
        0.4500, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10372, N'QUEEN', 5, N'2014-12-04 10:00:00.000', N'2015-01-01 00:00:00.000', N'2014-12-09 00:00:00.000', 2,
        890.7800, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10373, N'HUNGO', 4, N'2014-12-05 16:00:00.000', N'2015-01-02 00:00:00.000', N'2014-12-11 00:00:00.000', 3,
        124.1200, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10374, N'WOLZA', 1, N'2014-12-05 10:00:00.000', N'2015-01-02 00:00:00.000', N'2014-12-09 00:00:00.000', 3,
        3.9400, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10375, N'HUNGC', 3, N'2014-12-06 13:00:00.000', N'2015-01-03 00:00:00.000', N'2014-12-09 00:00:00.000', 2,
        20.1200, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10376, N'MEREP', 1, N'2014-12-09 14:00:00.000', N'2015-01-06 00:00:00.000', N'2014-12-13 00:00:00.000', 2,
        20.3900, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10377, N'SEVES', 1, N'2014-12-09 20:00:00.000', N'2015-01-06 00:00:00.000', N'2014-12-13 00:00:00.000', 3,
        22.2100, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10378, N'FOLKO', 5, N'2014-12-10 00:00:00.000', N'2015-01-07 00:00:00.000', N'2014-12-19 00:00:00.000', 3,
        5.4400, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10379, N'QUEDE', 2, N'2014-12-11 06:00:00.000', N'2015-01-08 00:00:00.000', N'2014-12-13 00:00:00.000', 1,
        45.0300, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10380, N'HUNGO', 8, N'2014-12-12 19:00:00.000', N'2015-01-09 00:00:00.000', N'2015-01-16 00:00:00.000', 3,
        35.0300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10381, N'LILAS', 3, N'2014-12-12 15:00:00.000', N'2015-01-09 00:00:00.000', N'2014-12-13 00:00:00.000', 3,
        7.9900, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10382, N'ERNSH', 4, N'2014-12-13 09:00:00.000', N'2015-01-10 00:00:00.000', N'2014-12-16 00:00:00.000', 1,
        94.7700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10383, N'AROUT', 8, N'2014-12-16 22:00:00.000', N'2015-01-13 00:00:00.000', N'2014-12-18 00:00:00.000', 3,
        34.2400, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10384, N'BERGS', 3, N'2014-12-16 10:00:00.000', N'2015-01-13 00:00:00.000', N'2014-12-20 00:00:00.000', 3,
        168.6400, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10385, N'SPLIR', 1, N'2014-12-17 19:00:00.000', N'2015-01-14 00:00:00.000', N'2014-12-23 00:00:00.000', 2,
        30.9600, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10386, N'FAMIA', 9, N'2014-12-18 11:00:00.000', N'2015-01-01 00:00:00.000', N'2014-12-25 00:00:00.000', 3,
        13.9900, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10387, N'SANTG', 1, N'2014-12-18 14:00:00.000', N'2015-01-15 00:00:00.000', N'2014-12-20 00:00:00.000', 2,
        93.6300, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', null, N'4110', N'Norway');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10388, N'SEVES', 2, N'2014-12-19 02:00:00.000', N'2015-01-16 00:00:00.000', N'2014-12-20 00:00:00.000', 1,
        34.8600, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10389, N'BOTTM', 4, N'2014-12-20 18:00:00.000', N'2015-01-17 00:00:00.000', N'2014-12-24 00:00:00.000', 2,
        47.4200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10390, N'ERNSH', 6, N'2014-12-23 05:00:00.000', N'2015-01-20 00:00:00.000', N'2014-12-26 00:00:00.000', 1,
        126.3800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10391, N'DRACD', 3, N'2014-12-23 02:00:00.000', N'2015-01-20 00:00:00.000', N'2014-12-31 00:00:00.000', 3,
        5.4500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', null, N'52066', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10392, N'PICCO', 2, N'2014-12-24 04:00:00.000', N'2015-01-21 00:00:00.000', N'2015-01-01 00:00:00.000', 3,
        122.4600, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10393, N'SAVEA', 1, N'2014-12-25 15:00:00.000', N'2015-01-22 00:00:00.000', N'2015-01-03 00:00:00.000', 3,
        126.5600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10394, N'HUNGC', 1, N'2014-12-25 12:00:00.000', N'2015-01-22 00:00:00.000', N'2015-01-03 00:00:00.000', 3,
        30.3400, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10395, N'HILAA', 6, N'2014-12-26 16:00:00.000', N'2015-01-23 00:00:00.000', N'2015-01-03 00:00:00.000', 1,
        184.4100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10396, N'FRANK', 1, N'2014-12-27 00:00:00.000', N'2015-01-10 00:00:00.000', N'2015-01-06 00:00:00.000', 3,
        135.3500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10397, N'PRINI', 5, N'2014-12-27 17:00:00.000', N'2015-01-24 00:00:00.000', N'2015-01-02 00:00:00.000', 1,
        60.2600, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', null, N'1756', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10398, N'SAVEA', 2, N'2014-12-30 13:00:00.000', N'2015-01-27 00:00:00.000', N'2015-01-09 00:00:00.000', 3,
        89.1600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10399, N'VAFFE', 8, N'2014-12-31 00:00:00.000', N'2015-01-14 00:00:00.000', N'2015-01-08 00:00:00.000', 3,
        27.3600, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10400, N'EASTC', 1, N'2015-01-01 21:00:00.000', N'2015-01-29 00:00:00.000', N'2015-01-16 00:00:00.000', 3,
        83.9300, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10401, N'RATTC', 1, N'2015-01-01 15:00:00.000', N'2015-01-29 00:00:00.000', N'2015-01-10 00:00:00.000', 1,
        12.5100, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10402, N'ERNSH', 8, N'2015-01-02 18:00:00.000', N'2015-02-13 00:00:00.000', N'2015-01-10 00:00:00.000', 2,
        67.8800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10403, N'ERNSH', 4, N'2015-01-03 01:00:00.000', N'2015-01-31 00:00:00.000', N'2015-01-09 00:00:00.000', 3,
        73.7900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10404, N'MAGAA', 2, N'2015-01-03 21:00:00.000', N'2015-01-31 00:00:00.000', N'2015-01-08 00:00:00.000', 1,
        155.9700, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10405, N'LINOD', 1, N'2015-01-06 01:00:00.000', N'2015-02-03 00:00:00.000', N'2015-01-22 00:00:00.000', 1,
        34.8200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10406, N'QUEEN', 7, N'2015-01-07 18:00:00.000', N'2015-02-18 00:00:00.000', N'2015-01-13 00:00:00.000', 1,
        108.0400, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10407, N'OTTIK', 2, N'2015-01-07 21:00:00.000', N'2015-02-04 00:00:00.000', N'2015-01-30 00:00:00.000', 2,
        91.4800, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10408, N'FOLIG', 8, N'2015-01-08 18:00:00.000', N'2015-02-05 00:00:00.000', N'2015-01-14 00:00:00.000', 1,
        11.2600, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', null, N'59000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10409, N'OCEAN', 3, N'2015-01-09 08:00:00.000', N'2015-02-06 00:00:00.000', N'2015-01-14 00:00:00.000', 1,
        29.8300, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', null, N'1010',
        N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10410, N'BOTTM', 3, N'2015-01-10 18:00:00.000', N'2015-02-07 00:00:00.000', N'2015-01-15 00:00:00.000', 3,
        2.4000, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10411, N'BOTTM', 9, N'2015-01-10 21:00:00.000', N'2015-02-07 00:00:00.000', N'2015-01-21 00:00:00.000', 3,
        23.6500, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10412, N'WARTH', 8, N'2015-01-13 20:00:00.000', N'2015-02-10 00:00:00.000', N'2015-01-15 00:00:00.000', 2,
        3.7700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10413, N'LAMAI', 3, N'2015-01-14 22:00:00.000', N'2015-02-11 00:00:00.000', N'2015-01-16 00:00:00.000', 2,
        95.6600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10414, N'FAMIA', 2, N'2015-01-14 22:00:00.000', N'2015-02-11 00:00:00.000', N'2015-01-17 00:00:00.000', 3,
        21.4800, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10415, N'HUNGC', 3, N'2015-01-15 22:00:00.000', N'2015-02-12 00:00:00.000', N'2015-01-24 00:00:00.000', 1,
        0.2000, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10416, N'WARTH', 8, N'2015-01-16 11:00:00.000', N'2015-02-13 00:00:00.000', N'2015-01-27 00:00:00.000', 3,
        22.7200, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10417, N'SIMOB', 4, N'2015-01-16 07:00:00.000', N'2015-02-13 00:00:00.000', N'2015-01-28 00:00:00.000', 3,
        70.2900, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10418, N'QUICK', 4, N'2015-01-17 16:00:00.000', N'2015-02-14 00:00:00.000', N'2015-01-24 00:00:00.000', 1,
        17.5500, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10419, N'RICSU', 4, N'2015-01-20 18:00:00.000', N'2015-02-17 00:00:00.000', N'2015-01-30 00:00:00.000', 2,
        137.3500, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10420, N'WELLI', 3, N'2015-01-21 08:00:00.000', N'2015-02-18 00:00:00.000', N'2015-01-27 00:00:00.000', 1,
        44.1200, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10421, N'QUEDE', 8, N'2015-01-21 20:00:00.000', N'2015-03-04 00:00:00.000', N'2015-01-27 00:00:00.000', 1,
        99.2300, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10422, N'FRANS', 2, N'2015-01-22 05:00:00.000', N'2015-02-19 00:00:00.000', N'2015-01-31 00:00:00.000', 1,
        3.0200, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', null, N'10100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10423, N'GOURL', 6, N'2015-01-23 01:00:00.000', N'2015-02-06 00:00:00.000', N'2015-02-24 00:00:00.000', 3,
        24.5000, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10424, N'MEREP', 7, N'2015-01-23 20:00:00.000', N'2015-02-20 00:00:00.000', N'2015-01-27 00:00:00.000', 2,
        370.6100, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10425, N'LAMAI', 6, N'2015-01-24 12:00:00.000', N'2015-02-21 00:00:00.000', N'2015-02-14 00:00:00.000', 2,
        7.9300, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10426, N'GALED', 4, N'2015-01-27 08:00:00.000', N'2015-02-24 00:00:00.000', N'2015-02-06 00:00:00.000', 1,
        18.6900, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', null, N'8022', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10427, N'PICCO', 4, N'2015-01-27 06:00:00.000', N'2015-02-24 00:00:00.000', N'2015-03-03 00:00:00.000', 2,
        31.2900, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10428, N'REGGC', 7, N'2015-01-28 08:00:00.000', N'2015-02-25 00:00:00.000', N'2015-02-04 00:00:00.000', 1,
        11.0900, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10429, N'HUNGO', 3, N'2015-01-29 00:00:00.000', N'2015-03-12 00:00:00.000', N'2015-02-07 00:00:00.000', 2,
        56.6300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10430, N'ERNSH', 4, N'2015-01-30 09:00:00.000', N'2015-02-13 00:00:00.000', N'2015-02-03 00:00:00.000', 1,
        458.7800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10431, N'BOTTM', 4, N'2015-01-30 12:00:00.000', N'2015-02-13 00:00:00.000', N'2015-02-07 00:00:00.000', 2,
        44.1700, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10432, N'SPLIR', 3, N'2015-01-31 00:00:00.000', N'2015-02-14 00:00:00.000', N'2015-02-07 00:00:00.000', 2,
        4.3400, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10433, N'PRINI', 3, N'2015-02-03 09:00:00.000', N'2015-03-03 00:00:00.000', N'2015-03-04 00:00:00.000', 3,
        73.8300, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', null, N'1756', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10434, N'FOLKO', 3, N'2015-02-03 21:00:00.000', N'2015-03-03 00:00:00.000', N'2015-02-13 00:00:00.000', 2,
        17.9200, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10435, N'CONSH', 8, N'2015-02-04 20:00:00.000', N'2015-03-18 00:00:00.000', N'2015-02-07 00:00:00.000', 2,
        9.2100, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', null, N'WX1 6LT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10436, N'BLONP', 3, N'2015-02-05 19:00:00.000', N'2015-03-05 00:00:00.000', N'2015-02-11 00:00:00.000', 2,
        156.6600, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10437, N'WARTH', 8, N'2015-02-05 14:00:00.000', N'2015-03-05 00:00:00.000', N'2015-02-12 00:00:00.000', 1,
        19.9700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10438, N'TOMSP', 3, N'2015-02-06 21:00:00.000', N'2015-03-06 00:00:00.000', N'2015-02-14 00:00:00.000', 2,
        8.2400, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', null, N'44087', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10439, N'MEREP', 6, N'2015-02-07 10:00:00.000', N'2015-03-07 00:00:00.000', N'2015-02-10 00:00:00.000', 3,
        4.0700, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10440, N'SAVEA', 4, N'2015-02-10 15:00:00.000', N'2015-03-10 00:00:00.000', N'2015-02-28 00:00:00.000', 2,
        86.5300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10441, N'OLDWO', 3, N'2015-02-10 16:00:00.000', N'2015-03-24 00:00:00.000', N'2015-03-14 00:00:00.000', 2,
        73.0200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10442, N'ERNSH', 3, N'2015-02-11 03:00:00.000', N'2015-03-11 00:00:00.000', N'2015-02-18 00:00:00.000', 2,
        47.9400, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10443, N'REGGC', 8, N'2015-02-12 01:00:00.000', N'2015-03-12 00:00:00.000', N'2015-02-14 00:00:00.000', 1,
        13.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10444, N'BERGS', 3, N'2015-02-12 11:00:00.000', N'2015-03-12 00:00:00.000', N'2015-02-21 00:00:00.000', 3,
        3.5000, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10445, N'BERGS', 3, N'2015-02-13 20:00:00.000', N'2015-03-13 00:00:00.000', N'2015-02-20 00:00:00.000', 1,
        9.3000, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10446, N'TOMSP', 6, N'2015-02-14 00:00:00.000', N'2015-03-14 00:00:00.000', N'2015-02-19 00:00:00.000', 1,
        14.6800, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', null, N'44087', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10447, N'RICAR', 4, N'2015-02-14 07:00:00.000', N'2015-03-14 00:00:00.000', N'2015-03-07 00:00:00.000', 2,
        68.6600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10448, N'RANCH', 4, N'2015-02-17 10:00:00.000', N'2015-03-17 00:00:00.000', N'2015-02-24 00:00:00.000', 2,
        38.8200, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10449, N'BLONP', 3, N'2015-02-18 13:00:00.000', N'2015-03-18 00:00:00.000', N'2015-02-27 00:00:00.000', 2,
        53.3000, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10450, N'VICTE', 8, N'2015-02-19 20:00:00.000', N'2015-03-19 00:00:00.000', N'2015-03-11 00:00:00.000', 2,
        7.2300, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10451, N'QUICK', 4, N'2015-02-19 08:00:00.000', N'2015-03-05 00:00:00.000', N'2015-03-12 00:00:00.000', 3,
        189.0900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10452, N'SAVEA', 8, N'2015-02-20 13:00:00.000', N'2015-03-20 00:00:00.000', N'2015-02-26 00:00:00.000', 1,
        140.2600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10453, N'AROUT', 1, N'2015-02-21 17:00:00.000', N'2015-03-21 00:00:00.000', N'2015-02-26 00:00:00.000', 2,
        25.3600, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10454, N'LAMAI', 4, N'2015-02-21 21:00:00.000', N'2015-03-21 00:00:00.000', N'2015-02-25 00:00:00.000', 3,
        2.7400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10455, N'WARTH', 8, N'2015-02-24 11:00:00.000', N'2015-04-07 00:00:00.000', N'2015-03-03 00:00:00.000', 2,
        180.4500, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10456, N'KOENE', 8, N'2015-02-25 18:00:00.000', N'2015-04-08 00:00:00.000', N'2015-02-28 00:00:00.000', 2,
        8.1200, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10457, N'KOENE', 2, N'2015-02-25 19:00:00.000', N'2015-03-25 00:00:00.000', N'2015-03-03 00:00:00.000', 1,
        11.5700, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10458, N'SUPRD', 7, N'2015-02-26 00:00:00.000', N'2015-03-26 00:00:00.000', N'2015-03-04 00:00:00.000', 3,
        147.0600, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10459, N'VICTE', 4, N'2015-02-27 13:00:00.000', N'2015-03-27 00:00:00.000', N'2015-02-28 00:00:00.000', 2,
        25.0900, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10460, N'FOLKO', 8, N'2015-02-28 00:00:00.000', N'2015-03-28 00:00:00.000', N'2015-03-03 00:00:00.000', 1,
        16.2700, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10461, N'LILAS', 1, N'2015-02-28 00:00:00.000', N'2015-03-28 00:00:00.000', N'2015-03-05 00:00:00.000', 3,
        148.6100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10462, N'CONSH', 2, N'2015-03-03 08:00:00.000', N'2015-03-31 00:00:00.000', N'2015-03-18 00:00:00.000', 1,
        6.1700, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', null, N'WX1 6LT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10463, N'SUPRD', 5, N'2015-03-04 13:00:00.000', N'2015-04-01 00:00:00.000', N'2015-03-06 00:00:00.000', 3,
        14.7800, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10464, N'FURIB', 4, N'2015-03-04 15:00:00.000', N'2015-04-01 00:00:00.000', N'2015-03-14 00:00:00.000', 2,
        89.0000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10465, N'VAFFE', 1, N'2015-03-05 08:00:00.000', N'2015-04-02 00:00:00.000', N'2015-03-14 00:00:00.000', 3,
        145.0400, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10466, N'COMMI', 4, N'2015-03-06 01:00:00.000', N'2015-04-03 00:00:00.000', N'2015-03-13 00:00:00.000', 1,
        11.9300, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10467, N'MAGAA', 8, N'2015-03-06 01:00:00.000', N'2015-04-03 00:00:00.000', N'2015-03-11 00:00:00.000', 2,
        4.9300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10468, N'KOENE', 3, N'2015-03-07 03:00:00.000', N'2015-04-04 00:00:00.000', N'2015-03-12 00:00:00.000', 3,
        44.1200, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10469, N'WHITC', 1, N'2015-03-10 20:00:00.000', N'2015-04-07 00:00:00.000', N'2015-03-14 00:00:00.000', 1,
        60.1800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10470, N'BONAP', 4, N'2015-03-11 02:00:00.000', N'2015-04-08 00:00:00.000', N'2015-03-14 00:00:00.000', 2,
        64.5600, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10471, N'BSBEV', 2, N'2015-03-11 06:00:00.000', N'2015-04-08 00:00:00.000', N'2015-03-18 00:00:00.000', 3,
        45.5900, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10472, N'SEVES', 8, N'2015-03-12 01:00:00.000', N'2015-04-09 00:00:00.000', N'2015-03-19 00:00:00.000', 1,
        4.2000, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10473, N'ISLAT', 1, N'2015-03-13 06:00:00.000', N'2015-03-27 00:00:00.000', N'2015-03-21 00:00:00.000', 3,
        16.3700, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10474, N'PERIC', 5, N'2015-03-13 16:00:00.000', N'2015-04-10 00:00:00.000', N'2015-03-21 00:00:00.000', 2,
        83.4900, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10475, N'SUPRD', 9, N'2015-03-14 11:00:00.000', N'2015-04-11 00:00:00.000', N'2015-04-04 00:00:00.000', 1,
        68.5200, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10476, N'HILAA', 8, N'2015-03-17 00:00:00.000', N'2015-04-14 00:00:00.000', N'2015-03-24 00:00:00.000', 3,
        4.4100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10477, N'PRINI', 5, N'2015-03-17 02:00:00.000', N'2015-04-14 00:00:00.000', N'2015-03-25 00:00:00.000', 2,
        13.0200, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', null, N'1756', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10478, N'VICTE', 2, N'2015-03-18 20:00:00.000', N'2015-04-01 00:00:00.000', N'2015-03-26 00:00:00.000', 3,
        4.8100, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10479, N'RATTC', 3, N'2015-03-19 01:00:00.000', N'2015-04-16 00:00:00.000', N'2015-03-21 00:00:00.000', 3,
        708.9500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10480, N'FOLIG', 6, N'2015-03-20 11:00:00.000', N'2015-04-17 00:00:00.000', N'2015-03-24 00:00:00.000', 2,
        1.3500, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', null, N'59000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10481, N'RICAR', 8, N'2015-03-20 17:00:00.000', N'2015-04-17 00:00:00.000', N'2015-03-25 00:00:00.000', 2,
        64.3300, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10482, N'LAZYK', 1, N'2015-03-21 02:00:00.000', N'2015-04-18 00:00:00.000', N'2015-04-10 00:00:00.000', 3,
        7.4800, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10483, N'WHITC', 7, N'2015-03-24 07:00:00.000', N'2015-04-21 00:00:00.000', N'2015-04-25 00:00:00.000', 2,
        15.2800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10484, N'BSBEV', 3, N'2015-03-24 17:00:00.000', N'2015-04-21 00:00:00.000', N'2015-04-01 00:00:00.000', 3,
        6.8800, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10485, N'LINOD', 4, N'2015-03-25 17:00:00.000', N'2015-04-08 00:00:00.000', N'2015-03-31 00:00:00.000', 2,
        64.4500, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10486, N'HILAA', 1, N'2015-03-26 17:00:00.000', N'2015-04-23 00:00:00.000', N'2015-04-02 00:00:00.000', 2,
        30.5300, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10487, N'QUEEN', 2, N'2015-03-26 21:00:00.000', N'2015-04-23 00:00:00.000', N'2015-03-28 00:00:00.000', 2,
        71.0700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10488, N'FRANK', 8, N'2015-03-27 01:00:00.000', N'2015-04-24 00:00:00.000', N'2015-04-02 00:00:00.000', 2,
        4.9300, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10489, N'PICCO', 6, N'2015-03-28 06:00:00.000', N'2015-04-25 00:00:00.000', N'2015-04-09 00:00:00.000', 2,
        5.2900, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10490, N'HILAA', 7, N'2015-03-31 00:00:00.000', N'2015-04-28 00:00:00.000', N'2015-04-03 00:00:00.000', 2,
        210.1900, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10491, N'FURIB', 8, N'2015-03-31 00:00:00.000', N'2015-04-28 00:00:00.000', N'2015-04-08 00:00:00.000', 3,
        16.9600, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10492, N'BOTTM', 3, N'2015-04-01 07:00:00.000', N'2015-04-29 00:00:00.000', N'2015-04-11 00:00:00.000', 1,
        62.8900, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10493, N'LAMAI', 4, N'2015-04-02 22:00:00.000', N'2015-04-30 00:00:00.000', N'2015-04-10 00:00:00.000', 3,
        10.6400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10494, N'COMMI', 4, N'2015-04-02 05:00:00.000', N'2015-04-30 00:00:00.000', N'2015-04-09 00:00:00.000', 2,
        65.9900, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10495, N'LAUGB', 3, N'2015-04-03 01:00:00.000', N'2015-05-01 00:00:00.000', N'2015-04-11 00:00:00.000', 3,
        4.6500, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10496, N'TRADH', 7, N'2015-04-04 03:00:00.000', N'2015-05-02 00:00:00.000', N'2015-04-07 00:00:00.000', 2,
        46.7700, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10497, N'LEHMS', 7, N'2015-04-04 22:00:00.000', N'2015-05-02 00:00:00.000', N'2015-04-07 00:00:00.000', 1,
        36.2100, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10498, N'HILAA', 8, N'2015-04-07 00:00:00.000', N'2015-05-05 00:00:00.000', N'2015-04-11 00:00:00.000', 2,
        29.7500, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10499, N'LILAS', 4, N'2015-04-08 11:00:00.000', N'2015-05-06 00:00:00.000', N'2015-04-16 00:00:00.000', 2,
        102.0200, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10500, N'LAMAI', 6, N'2015-04-09 21:00:00.000', N'2015-05-07 00:00:00.000', N'2015-04-17 00:00:00.000', 1,
        42.6800, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10501, N'BLAUS', 9, N'2015-04-09 19:00:00.000', N'2015-05-07 00:00:00.000', N'2015-04-16 00:00:00.000', 3,
        8.8500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10502, N'PERIC', 2, N'2015-04-10 10:00:00.000', N'2015-05-08 00:00:00.000', N'2015-04-29 00:00:00.000', 1,
        69.3200, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10503, N'HUNGO', 6, N'2015-04-11 21:00:00.000', N'2015-05-09 00:00:00.000', N'2015-04-16 00:00:00.000', 2,
        16.7400, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10504, N'WHITC', 4, N'2015-04-11 00:00:00.000', N'2015-05-09 00:00:00.000', N'2015-04-18 00:00:00.000', 3,
        59.1300, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10505, N'MEREP', 3, N'2015-04-14 11:00:00.000', N'2015-05-12 00:00:00.000', N'2015-04-21 00:00:00.000', 3,
        7.1300, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10506, N'KOENE', 9, N'2015-04-15 06:00:00.000', N'2015-05-13 00:00:00.000', N'2015-05-02 00:00:00.000', 2,
        21.1900, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10507, N'ANTON', 7, N'2015-04-15 05:00:00.000', N'2015-05-13 00:00:00.000', N'2015-04-22 00:00:00.000', 1,
        47.4500, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10508, N'OTTIK', 1, N'2015-04-16 18:00:00.000', N'2015-05-14 00:00:00.000', N'2015-05-13 00:00:00.000', 2,
        4.9900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10509, N'BLAUS', 4, N'2015-04-17 22:00:00.000', N'2015-05-15 00:00:00.000', N'2015-04-29 00:00:00.000', 1,
        0.1500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10510, N'SAVEA', 6, N'2015-04-18 22:00:00.000', N'2015-05-16 00:00:00.000', N'2015-04-28 00:00:00.000', 3,
        367.6300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10511, N'BONAP', 4, N'2015-04-18 01:00:00.000', N'2015-05-16 00:00:00.000', N'2015-04-21 00:00:00.000', 3,
        350.6400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10512, N'FAMIA', 7, N'2015-04-21 08:00:00.000', N'2015-05-19 00:00:00.000', N'2015-04-24 00:00:00.000', 2,
        3.5300, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10513, N'WANDK', 7, N'2015-04-22 05:00:00.000', N'2015-06-03 00:00:00.000', N'2015-04-28 00:00:00.000', 1,
        105.6500, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10514, N'ERNSH', 3, N'2015-04-22 08:00:00.000', N'2015-05-20 00:00:00.000', N'2015-05-16 00:00:00.000', 2,
        789.9500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10515, N'QUICK', 2, N'2015-04-23 17:00:00.000', N'2015-05-07 00:00:00.000', N'2015-05-23 00:00:00.000', 1,
        204.4700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10516, N'HUNGO', 2, N'2015-04-24 06:00:00.000', N'2015-05-22 00:00:00.000', N'2015-05-01 00:00:00.000', 3,
        62.7800, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10517, N'NORTS', 3, N'2015-04-24 08:00:00.000', N'2015-05-22 00:00:00.000', N'2015-04-29 00:00:00.000', 3,
        32.0700, N'North/South', N'South House 300 Queensbridge', N'London', null, N'SW7 1RZ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10518, N'TORTU', 4, N'2015-04-25 13:00:00.000', N'2015-05-09 00:00:00.000', N'2015-05-05 00:00:00.000', 2,
        218.1500, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10519, N'CHOPS', 6, N'2015-04-28 06:00:00.000', N'2015-05-26 00:00:00.000', N'2015-05-01 00:00:00.000', 3,
        91.7600, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10520, N'SANTG', 7, N'2015-04-29 08:00:00.000', N'2015-05-27 00:00:00.000', N'2015-05-01 00:00:00.000', 1,
        13.3700, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', null, N'4110', N'Norway');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10521, N'CACTU', 8, N'2015-04-29 17:00:00.000', N'2015-05-27 00:00:00.000', N'2015-05-02 00:00:00.000', 2,
        17.2200, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10522, N'LEHMS', 4, N'2015-04-30 00:00:00.000', N'2015-05-28 00:00:00.000', N'2015-05-06 00:00:00.000', 1,
        45.3300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10523, N'SEVES', 7, N'2015-05-01 13:00:00.000', N'2015-05-29 00:00:00.000', N'2015-05-30 00:00:00.000', 2,
        77.6300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10524, N'BERGS', 1, N'2015-05-01 15:00:00.000', N'2015-05-29 00:00:00.000', N'2015-05-07 00:00:00.000', 2,
        244.7900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10525, N'BONAP', 1, N'2015-05-02 01:00:00.000', N'2015-05-30 00:00:00.000', N'2015-05-23 00:00:00.000', 2,
        11.0600, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10526, N'WARTH', 4, N'2015-05-05 02:00:00.000', N'2015-06-02 00:00:00.000', N'2015-05-15 00:00:00.000', 2,
        58.5900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10527, N'QUICK', 7, N'2015-05-05 08:00:00.000', N'2015-06-02 00:00:00.000', N'2015-05-07 00:00:00.000', 1,
        41.9000, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10528, N'GREAL', 6, N'2015-05-06 12:00:00.000', N'2015-05-20 00:00:00.000', N'2015-05-09 00:00:00.000', 2,
        3.3500, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10529, N'MAISD', 5, N'2015-05-07 01:00:00.000', N'2015-06-04 00:00:00.000', N'2015-05-09 00:00:00.000', 2,
        66.6900, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10530, N'PICCO', 3, N'2015-05-08 19:00:00.000', N'2015-06-05 00:00:00.000', N'2015-05-12 00:00:00.000', 2,
        339.2200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10531, N'OCEAN', 7, N'2015-05-08 01:00:00.000', N'2015-06-05 00:00:00.000', N'2015-05-19 00:00:00.000', 1,
        8.1200, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', null, N'1010',
        N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10532, N'EASTC', 7, N'2015-05-09 04:00:00.000', N'2015-06-06 00:00:00.000', N'2015-05-12 00:00:00.000', 3,
        74.4600, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10533, N'FOLKO', 8, N'2015-05-12 22:00:00.000', N'2015-06-09 00:00:00.000', N'2015-05-22 00:00:00.000', 1,
        188.0400, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10534, N'LEHMS', 8, N'2015-05-12 06:00:00.000', N'2015-06-09 00:00:00.000', N'2015-05-14 00:00:00.000', 2,
        27.9400, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10535, N'ANTON', 4, N'2015-05-13 07:00:00.000', N'2015-06-10 00:00:00.000', N'2015-05-21 00:00:00.000', 1,
        15.6400, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10536, N'LEHMS', 3, N'2015-05-14 10:00:00.000', N'2015-06-11 00:00:00.000', N'2015-06-06 00:00:00.000', 2,
        58.8800, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10537, N'RICSU', 1, N'2015-05-14 02:00:00.000', N'2015-05-28 00:00:00.000', N'2015-05-19 00:00:00.000', 1,
        78.8500, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10538, N'BSBEV', 9, N'2015-05-15 10:00:00.000', N'2015-06-12 00:00:00.000', N'2015-05-16 00:00:00.000', 3,
        4.8700, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10539, N'BSBEV', 6, N'2015-05-16 18:00:00.000', N'2015-06-13 00:00:00.000', N'2015-05-23 00:00:00.000', 3,
        12.3600, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10540, N'QUICK', 3, N'2015-05-19 05:00:00.000', N'2015-06-16 00:00:00.000', N'2015-06-13 00:00:00.000', 3,
        1007.6400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10541, N'HANAR', 2, N'2015-05-19 13:00:00.000', N'2015-06-16 00:00:00.000', N'2015-05-29 00:00:00.000', 1,
        68.6500, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10542, N'KOENE', 1, N'2015-05-20 20:00:00.000', N'2015-06-17 00:00:00.000', N'2015-05-26 00:00:00.000', 3,
        10.9500, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10543, N'LILAS', 8, N'2015-05-21 03:00:00.000', N'2015-06-18 00:00:00.000', N'2015-05-23 00:00:00.000', 2,
        48.1700, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10544, N'LONEP', 4, N'2015-05-21 04:00:00.000', N'2015-06-18 00:00:00.000', N'2015-05-30 00:00:00.000', 1,
        24.9100, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10545, N'LAZYK', 8, N'2015-05-22 14:00:00.000', N'2015-06-19 00:00:00.000', N'2015-06-26 00:00:00.000', 2,
        11.9200, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10546, N'VICTE', 1, N'2015-05-23 00:00:00.000', N'2015-06-20 00:00:00.000', N'2015-05-27 00:00:00.000', 3,
        194.7200, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10547, N'SEVES', 3, N'2015-05-23 16:00:00.000', N'2015-06-20 00:00:00.000', N'2015-06-02 00:00:00.000', 2,
        178.4300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10548, N'TOMSP', 3, N'2015-05-26 11:00:00.000', N'2015-06-23 00:00:00.000', N'2015-06-02 00:00:00.000', 2,
        1.4300, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', null, N'44087', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10549, N'QUICK', 5, N'2015-05-27 03:00:00.000', N'2015-06-10 00:00:00.000', N'2015-05-30 00:00:00.000', 1,
        171.2400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10550, N'GODOS', 7, N'2015-05-28 18:00:00.000', N'2015-06-25 00:00:00.000', N'2015-06-06 00:00:00.000', 3,
        4.3200, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10551, N'FURIB', 4, N'2015-05-28 06:00:00.000', N'2015-07-09 00:00:00.000', N'2015-06-06 00:00:00.000', 3,
        72.9500, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10552, N'HILAA', 2, N'2015-05-29 08:00:00.000', N'2015-06-26 00:00:00.000', N'2015-06-05 00:00:00.000', 1,
        83.2200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10553, N'WARTH', 2, N'2015-05-30 03:00:00.000', N'2015-06-27 00:00:00.000', N'2015-06-03 00:00:00.000', 2,
        149.4900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10554, N'OTTIK', 4, N'2015-05-30 21:00:00.000', N'2015-06-27 00:00:00.000', N'2015-06-05 00:00:00.000', 3,
        120.9700, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10555, N'SAVEA', 6, N'2015-06-02 22:00:00.000', N'2015-06-30 00:00:00.000', N'2015-06-04 00:00:00.000', 3,
        252.4900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10556, N'SIMOB', 2, N'2015-06-03 14:00:00.000', N'2015-07-15 00:00:00.000', N'2015-06-13 00:00:00.000', 1,
        9.8000, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10557, N'LEHMS', 9, N'2015-06-03 22:00:00.000', N'2015-06-17 00:00:00.000', N'2015-06-06 00:00:00.000', 2,
        96.7200, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10558, N'AROUT', 1, N'2015-06-04 14:00:00.000', N'2015-07-02 00:00:00.000', N'2015-06-10 00:00:00.000', 2,
        72.9700, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10559, N'BLONP', 6, N'2015-06-05 04:00:00.000', N'2015-07-03 00:00:00.000', N'2015-06-13 00:00:00.000', 1,
        8.0500, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10560, N'FRANK', 8, N'2015-06-06 12:00:00.000', N'2015-07-04 00:00:00.000', N'2015-06-09 00:00:00.000', 1,
        36.6500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10561, N'FOLKO', 2, N'2015-06-06 21:00:00.000', N'2015-07-04 00:00:00.000', N'2015-06-09 00:00:00.000', 2,
        242.2100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10562, N'REGGC', 1, N'2015-06-09 19:00:00.000', N'2015-07-07 00:00:00.000', N'2015-06-12 00:00:00.000', 1,
        22.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10563, N'RICAR', 2, N'2015-06-10 22:00:00.000', N'2015-07-22 00:00:00.000', N'2015-06-24 00:00:00.000', 2,
        60.4300, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10564, N'RATTC', 4, N'2015-06-10 00:00:00.000', N'2015-07-08 00:00:00.000', N'2015-06-16 00:00:00.000', 3,
        13.7500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10565, N'MEREP', 8, N'2015-06-11 22:00:00.000', N'2015-07-09 00:00:00.000', N'2015-06-18 00:00:00.000', 2,
        7.1500, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10566, N'BLONP', 9, N'2015-06-12 18:00:00.000', N'2015-07-10 00:00:00.000', N'2015-06-18 00:00:00.000', 1,
        88.4000, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10567, N'HUNGO', 1, N'2015-06-12 19:00:00.000', N'2015-07-10 00:00:00.000', N'2015-06-17 00:00:00.000', 1,
        33.9700, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10568, N'GALED', 3, N'2015-06-13 18:00:00.000', N'2015-07-11 00:00:00.000', N'2015-07-09 00:00:00.000', 3,
        6.5400, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', null, N'8022', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10569, N'RATTC', 5, N'2015-06-16 15:00:00.000', N'2015-07-14 00:00:00.000', N'2015-07-11 00:00:00.000', 1,
        58.9800, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10570, N'MEREP', 3, N'2015-06-17 11:00:00.000', N'2015-07-15 00:00:00.000', N'2015-06-19 00:00:00.000', 3,
        188.9900, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10571, N'ERNSH', 8, N'2015-06-17 15:00:00.000', N'2015-07-29 00:00:00.000', N'2015-07-04 00:00:00.000', 3,
        26.0600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10572, N'BERGS', 3, N'2015-06-18 05:00:00.000', N'2015-07-16 00:00:00.000', N'2015-06-25 00:00:00.000', 2,
        116.4300, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10573, N'ANTON', 7, N'2015-06-19 02:00:00.000', N'2015-07-17 00:00:00.000', N'2015-06-20 00:00:00.000', 3,
        84.8400, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10574, N'TRAIH', 4, N'2015-06-19 14:00:00.000', N'2015-07-17 00:00:00.000', N'2015-06-30 00:00:00.000', 2,
        37.6000, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10575, N'MORGK', 5, N'2015-06-20 22:00:00.000', N'2015-07-04 00:00:00.000', N'2015-06-30 00:00:00.000', 1,
        127.3400, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', null, N'04179', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10576, N'TORTU', 3, N'2015-06-23 13:00:00.000', N'2015-07-07 00:00:00.000', N'2015-06-30 00:00:00.000', 3,
        18.5600, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10577, N'TRAIH', 9, N'2015-06-23 19:00:00.000', N'2015-08-04 00:00:00.000', N'2015-06-30 00:00:00.000', 2,
        25.4100, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10578, N'BSBEV', 4, N'2015-06-24 15:00:00.000', N'2015-07-22 00:00:00.000', N'2015-07-25 00:00:00.000', 3,
        29.6000, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10579, N'LETSS', 1, N'2015-06-25 19:00:00.000', N'2015-07-23 00:00:00.000', N'2015-07-04 00:00:00.000', 2,
        13.7300, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10580, N'OTTIK', 4, N'2015-06-26 19:00:00.000', N'2015-07-24 00:00:00.000', N'2015-07-01 00:00:00.000', 3,
        75.8900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10581, N'FAMIA', 3, N'2015-06-26 11:00:00.000', N'2015-07-24 00:00:00.000', N'2015-07-02 00:00:00.000', 1,
        3.0100, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10582, N'BLAUS', 3, N'2015-06-27 22:00:00.000', N'2015-07-25 00:00:00.000', N'2015-07-14 00:00:00.000', 2,
        27.7100, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10583, N'WARTH', 2, N'2015-06-30 00:00:00.000', N'2015-07-28 00:00:00.000', N'2015-07-04 00:00:00.000', 2,
        7.2800, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10584, N'BLONP', 4, N'2015-06-30 00:00:00.000', N'2015-07-28 00:00:00.000', N'2015-07-04 00:00:00.000', 1,
        59.1400, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10585, N'WELLI', 7, N'2015-07-01 13:00:00.000', N'2015-07-29 00:00:00.000', N'2015-07-10 00:00:00.000', 1,
        13.4100, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10586, N'REGGC', 9, N'2015-07-02 10:00:00.000', N'2015-07-30 00:00:00.000', N'2015-07-09 00:00:00.000', 1,
        0.4800, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10587, N'QUEDE', 1, N'2015-07-02 03:00:00.000', N'2015-07-30 00:00:00.000', N'2015-07-09 00:00:00.000', 1,
        62.5200, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10588, N'QUICK', 2, N'2015-07-03 17:00:00.000', N'2015-07-31 00:00:00.000', N'2015-07-10 00:00:00.000', 3,
        194.6700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10589, N'GREAL', 8, N'2015-07-04 17:00:00.000', N'2015-08-01 00:00:00.000', N'2015-07-14 00:00:00.000', 2,
        4.4200, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10590, N'MEREP', 4, N'2015-07-07 09:00:00.000', N'2015-08-04 00:00:00.000', N'2015-07-14 00:00:00.000', 3,
        44.7700, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10591, N'VAFFE', 1, N'2015-07-07 13:00:00.000', N'2015-07-21 00:00:00.000', N'2015-07-16 00:00:00.000', 1,
        55.9200, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10592, N'LEHMS', 3, N'2015-07-08 20:00:00.000', N'2015-08-05 00:00:00.000', N'2015-07-16 00:00:00.000', 1,
        32.1000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10593, N'LEHMS', 7, N'2015-07-09 10:00:00.000', N'2015-08-06 00:00:00.000', N'2015-08-13 00:00:00.000', 2,
        174.2000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10594, N'OLDWO', 3, N'2015-07-09 17:00:00.000', N'2015-08-06 00:00:00.000', N'2015-07-16 00:00:00.000', 2,
        5.2400, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10595, N'ERNSH', 2, N'2015-07-10 17:00:00.000', N'2015-08-07 00:00:00.000', N'2015-07-14 00:00:00.000', 1,
        96.7800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10596, N'WHITC', 8, N'2015-07-11 06:00:00.000', N'2015-08-08 00:00:00.000', N'2015-08-12 00:00:00.000', 1,
        16.3400, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10597, N'PICCO', 7, N'2015-07-11 07:00:00.000', N'2015-08-08 00:00:00.000', N'2015-07-18 00:00:00.000', 3,
        35.1200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10598, N'RATTC', 1, N'2015-07-14 05:00:00.000', N'2015-08-11 00:00:00.000', N'2015-07-18 00:00:00.000', 3,
        44.4200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10599, N'BSBEV', 6, N'2015-07-15 06:00:00.000', N'2015-08-26 00:00:00.000', N'2015-07-21 00:00:00.000', 3,
        29.9800, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10600, N'HUNGC', 4, N'2015-07-16 10:00:00.000', N'2015-08-13 00:00:00.000', N'2015-07-21 00:00:00.000', 1,
        45.1300, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10601, N'HILAA', 7, N'2015-07-16 11:00:00.000', N'2015-08-27 00:00:00.000', N'2015-07-22 00:00:00.000', 1,
        58.3000, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10602, N'VAFFE', 8, N'2015-07-17 21:00:00.000', N'2015-08-14 00:00:00.000', N'2015-07-22 00:00:00.000', 2,
        2.9200, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10603, N'SAVEA', 8, N'2015-07-18 09:00:00.000', N'2015-08-15 00:00:00.000', N'2015-08-08 00:00:00.000', 2,
        48.7700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10604, N'FURIB', 1, N'2015-07-18 07:00:00.000', N'2015-08-15 00:00:00.000', N'2015-07-29 00:00:00.000', 1,
        7.4600, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10605, N'MEREP', 1, N'2015-07-21 22:00:00.000', N'2015-08-18 00:00:00.000', N'2015-07-29 00:00:00.000', 2,
        379.1300, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10606, N'TRADH', 4, N'2015-07-22 00:00:00.000', N'2015-08-19 00:00:00.000', N'2015-07-31 00:00:00.000', 3,
        79.4000, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10607, N'SAVEA', 5, N'2015-07-22 09:00:00.000', N'2015-08-19 00:00:00.000', N'2015-07-25 00:00:00.000', 1,
        200.2400, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10608, N'TOMSP', 4, N'2015-07-23 10:00:00.000', N'2015-08-20 00:00:00.000', N'2015-08-01 00:00:00.000', 2,
        27.7900, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', null, N'44087', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10609, N'DUMON', 7, N'2015-07-24 11:00:00.000', N'2015-08-21 00:00:00.000', N'2015-07-30 00:00:00.000', 2,
        1.8500, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10610, N'LAMAI', 8, N'2015-07-25 16:00:00.000', N'2015-08-22 00:00:00.000', N'2015-08-06 00:00:00.000', 1,
        26.7800, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10611, N'WOLZA', 6, N'2015-07-25 06:00:00.000', N'2015-08-22 00:00:00.000', N'2015-08-01 00:00:00.000', 2,
        80.6500, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10612, N'SAVEA', 1, N'2015-07-28 18:00:00.000', N'2015-08-25 00:00:00.000', N'2015-08-01 00:00:00.000', 2,
        544.0800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10613, N'HILAA', 4, N'2015-07-29 05:00:00.000', N'2015-08-26 00:00:00.000', N'2015-08-01 00:00:00.000', 2,
        8.1100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10614, N'BLAUS', 8, N'2015-07-29 09:00:00.000', N'2015-08-26 00:00:00.000', N'2015-08-01 00:00:00.000', 3,
        1.9300, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10615, N'WILMK', 2, N'2015-07-30 16:00:00.000', N'2015-08-27 00:00:00.000', N'2015-08-06 00:00:00.000', 3,
        0.7500, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10616, N'GREAL', 1, N'2015-07-31 00:00:00.000', N'2015-08-28 00:00:00.000', N'2015-08-05 00:00:00.000', 2,
        116.5300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10617, N'GREAL', 4, N'2015-07-31 00:00:00.000', N'2015-08-28 00:00:00.000', N'2015-08-04 00:00:00.000', 2,
        18.5300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10618, N'MEREP', 1, N'2015-08-01 04:00:00.000', N'2015-09-12 00:00:00.000', N'2015-08-08 00:00:00.000', 1,
        154.6800, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10619, N'MEREP', 3, N'2015-08-04 04:00:00.000', N'2015-09-01 00:00:00.000', N'2015-08-07 00:00:00.000', 3,
        91.0500, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10620, N'LAUGB', 2, N'2015-08-05 07:00:00.000', N'2015-09-02 00:00:00.000', N'2015-08-14 00:00:00.000', 3,
        0.9400, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10621, N'ISLAT', 4, N'2015-08-05 16:00:00.000', N'2015-09-02 00:00:00.000', N'2015-08-11 00:00:00.000', 2,
        23.7300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10622, N'RICAR', 4, N'2015-08-06 06:00:00.000', N'2015-09-03 00:00:00.000', N'2015-08-11 00:00:00.000', 3,
        50.9700, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10623, N'FRANK', 8, N'2015-08-07 02:00:00.000', N'2015-09-04 00:00:00.000', N'2015-08-12 00:00:00.000', 2,
        97.1800, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10624, N'THECR', 4, N'2015-08-07 05:00:00.000', N'2015-09-04 00:00:00.000', N'2015-08-19 00:00:00.000', 2,
        94.8000, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10625, N'ANATR', 3, N'2015-08-08 15:00:00.000', N'2015-09-05 00:00:00.000', N'2015-08-14 00:00:00.000', 1,
        43.9000, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', null,
        N'05021', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10626, N'BERGS', 1, N'2015-08-11 06:00:00.000', N'2015-09-08 00:00:00.000', N'2015-08-20 00:00:00.000', 2,
        138.6900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10627, N'SAVEA', 8, N'2015-08-11 15:00:00.000', N'2015-09-22 00:00:00.000', N'2015-08-21 00:00:00.000', 3,
        107.4600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10628, N'BLONP', 4, N'2015-08-12 15:00:00.000', N'2015-09-09 00:00:00.000', N'2015-08-20 00:00:00.000', 3,
        30.3600, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10629, N'GODOS', 4, N'2015-08-12 15:00:00.000', N'2015-09-09 00:00:00.000', N'2015-08-20 00:00:00.000', 3,
        85.4600, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10630, N'KOENE', 1, N'2015-08-13 10:00:00.000', N'2015-09-10 00:00:00.000', N'2015-08-19 00:00:00.000', 2,
        32.3500, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10631, N'LAMAI', 8, N'2015-08-14 01:00:00.000', N'2015-09-11 00:00:00.000', N'2015-08-15 00:00:00.000', 1,
        0.8700, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10632, N'WANDK', 8, N'2015-08-14 03:00:00.000', N'2015-09-11 00:00:00.000', N'2015-08-19 00:00:00.000', 1,
        41.3800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10633, N'ERNSH', 7, N'2015-08-15 06:00:00.000', N'2015-09-12 00:00:00.000', N'2015-08-18 00:00:00.000', 3,
        477.9000, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10634, N'FOLIG', 4, N'2015-08-15 13:00:00.000', N'2015-09-12 00:00:00.000', N'2015-08-21 00:00:00.000', 3,
        487.3800, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', null, N'59000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10635, N'MAGAA', 8, N'2015-08-18 13:00:00.000', N'2015-09-15 00:00:00.000', N'2015-08-21 00:00:00.000', 3,
        47.4600, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10636, N'WARTH', 4, N'2015-08-19 15:00:00.000', N'2015-09-16 00:00:00.000', N'2015-08-26 00:00:00.000', 1,
        1.1500, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10637, N'QUEEN', 6, N'2015-08-19 16:00:00.000', N'2015-09-16 00:00:00.000', N'2015-08-26 00:00:00.000', 1,
        201.2900, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10638, N'LINOD', 3, N'2015-08-20 16:00:00.000', N'2015-09-17 00:00:00.000', N'2015-09-01 00:00:00.000', 1,
        158.4400, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10639, N'SANTG', 7, N'2015-08-20 06:00:00.000', N'2015-09-17 00:00:00.000', N'2015-08-27 00:00:00.000', 3,
        38.6400, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', null, N'4110', N'Norway');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10640, N'WANDK', 4, N'2015-08-21 07:00:00.000', N'2015-09-18 00:00:00.000', N'2015-08-28 00:00:00.000', 1,
        23.5500, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10641, N'HILAA', 4, N'2015-08-22 04:00:00.000', N'2015-09-19 00:00:00.000', N'2015-08-26 00:00:00.000', 2,
        179.6100, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10642, N'SIMOB', 7, N'2015-08-22 00:00:00.000', N'2015-09-19 00:00:00.000', N'2015-09-05 00:00:00.000', 3,
        41.8900, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10643, N'ALFKI', 6, N'2015-08-25 19:00:00.000', N'2015-09-22 00:00:00.000', N'2015-09-02 00:00:00.000', 1,
        29.4600, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlin', null, N'12209', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10644, N'WELLI', 3, N'2015-08-25 07:00:00.000', N'2015-09-22 00:00:00.000', N'2015-09-01 00:00:00.000', 2,
        0.1400, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10645, N'HANAR', 4, N'2015-08-26 03:00:00.000', N'2015-09-23 00:00:00.000', N'2015-09-02 00:00:00.000', 1,
        12.4100, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10646, N'HUNGO', 9, N'2015-08-27 00:00:00.000', N'2015-10-08 00:00:00.000', N'2015-09-03 00:00:00.000', 3,
        142.3300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10647, N'QUEDE', 4, N'2015-08-27 04:00:00.000', N'2015-09-10 00:00:00.000', N'2015-09-03 00:00:00.000', 2,
        45.5400, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10648, N'RICAR', 5, N'2015-08-28 22:00:00.000', N'2015-10-09 00:00:00.000', N'2015-09-09 00:00:00.000', 2,
        14.2500, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10649, N'MAISD', 5, N'2015-08-28 00:00:00.000', N'2015-09-25 00:00:00.000', N'2015-08-29 00:00:00.000', 3,
        6.2000, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10650, N'FAMIA', 5, N'2015-08-29 06:00:00.000', N'2015-09-26 00:00:00.000', N'2015-09-03 00:00:00.000', 3,
        176.8100, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10651, N'WANDK', 8, N'2015-09-01 05:00:00.000', N'2015-09-29 00:00:00.000', N'2015-09-11 00:00:00.000', 2,
        20.6000, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10652, N'GOURL', 4, N'2015-09-01 20:00:00.000', N'2015-09-29 00:00:00.000', N'2015-09-08 00:00:00.000', 2,
        7.1400, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10653, N'FRANK', 1, N'2015-09-02 09:00:00.000', N'2015-09-30 00:00:00.000', N'2015-09-19 00:00:00.000', 1,
        93.2500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10654, N'BERGS', 5, N'2015-09-02 07:00:00.000', N'2015-09-30 00:00:00.000', N'2015-09-11 00:00:00.000', 1,
        55.2600, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10655, N'REGGC', 1, N'2015-09-03 00:00:00.000', N'2015-10-01 00:00:00.000', N'2015-09-11 00:00:00.000', 2,
        4.4100, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10656, N'GREAL', 6, N'2015-09-04 11:00:00.000', N'2015-10-02 00:00:00.000', N'2015-09-10 00:00:00.000', 1,
        57.1500, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10657, N'SAVEA', 2, N'2015-09-04 11:00:00.000', N'2015-10-02 00:00:00.000', N'2015-09-15 00:00:00.000', 2,
        352.6900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10658, N'QUICK', 4, N'2015-09-05 02:00:00.000', N'2015-10-03 00:00:00.000', N'2015-09-08 00:00:00.000', 1,
        364.1500, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10659, N'QUEEN', 7, N'2015-09-05 02:00:00.000', N'2015-10-03 00:00:00.000', N'2015-09-10 00:00:00.000', 2,
        105.8100, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10660, N'HUNGC', 8, N'2015-09-08 03:00:00.000', N'2015-10-06 00:00:00.000', N'2015-10-15 00:00:00.000', 1,
        111.2900, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10661, N'HUNGO', 7, N'2015-09-09 14:00:00.000', N'2015-10-07 00:00:00.000', N'2015-09-15 00:00:00.000', 3,
        17.5500, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10662, N'LONEP', 3, N'2015-09-09 22:00:00.000', N'2015-10-07 00:00:00.000', N'2015-09-18 00:00:00.000', 2,
        1.2800, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10663, N'BONAP', 2, N'2015-09-10 12:00:00.000', N'2015-09-24 00:00:00.000', N'2015-10-03 00:00:00.000', 2,
        113.1500, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10664, N'FURIB', 1, N'2015-09-10 12:00:00.000', N'2015-10-08 00:00:00.000', N'2015-09-19 00:00:00.000', 3,
        1.2700, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10665, N'LONEP', 1, N'2015-09-11 06:00:00.000', N'2015-10-09 00:00:00.000', N'2015-09-17 00:00:00.000', 2,
        26.3100, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10666, N'RICSU', 7, N'2015-09-12 12:00:00.000', N'2015-10-10 00:00:00.000', N'2015-09-22 00:00:00.000', 2,
        232.4200, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10667, N'ERNSH', 7, N'2015-09-12 21:00:00.000', N'2015-10-10 00:00:00.000', N'2015-09-19 00:00:00.000', 1,
        78.0900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10668, N'WANDK', 1, N'2015-09-15 14:00:00.000', N'2015-10-13 00:00:00.000', N'2015-09-23 00:00:00.000', 2,
        47.2200, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10669, N'SIMOB', 2, N'2015-09-15 22:00:00.000', N'2015-10-13 00:00:00.000', N'2015-09-22 00:00:00.000', 1,
        24.3900, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10670, N'FRANK', 4, N'2015-09-16 09:00:00.000', N'2015-10-14 00:00:00.000', N'2015-09-18 00:00:00.000', 1,
        203.4800, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10671, N'FRANR', 1, N'2015-09-17 06:00:00.000', N'2015-10-15 00:00:00.000', N'2015-09-24 00:00:00.000', 1,
        30.3400, N'France restauration', N'54, rue Royale', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10672, N'BERGS', 9, N'2015-09-17 13:00:00.000', N'2015-10-01 00:00:00.000', N'2015-09-26 00:00:00.000', 2,
        95.7500, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10673, N'WILMK', 2, N'2015-09-18 08:00:00.000', N'2015-10-16 00:00:00.000', N'2015-09-19 00:00:00.000', 1,
        22.7600, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10674, N'ISLAT', 4, N'2015-09-18 17:00:00.000', N'2015-10-16 00:00:00.000', N'2015-09-30 00:00:00.000', 2,
        0.9000, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10675, N'FRANK', 5, N'2015-09-19 06:00:00.000', N'2015-10-17 00:00:00.000', N'2015-09-23 00:00:00.000', 2,
        31.8500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10676, N'TORTU', 2, N'2015-09-22 10:00:00.000', N'2015-10-20 00:00:00.000', N'2015-09-29 00:00:00.000', 2,
        2.0100, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10677, N'ANTON', 1, N'2015-09-22 20:00:00.000', N'2015-10-20 00:00:00.000', N'2015-09-26 00:00:00.000', 3,
        4.0300, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10678, N'SAVEA', 7, N'2015-09-23 20:00:00.000', N'2015-10-21 00:00:00.000', N'2015-10-16 00:00:00.000', 3,
        388.9800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10679, N'BLONP', 8, N'2015-09-23 19:00:00.000', N'2015-10-21 00:00:00.000', N'2015-09-30 00:00:00.000', 3,
        27.9400, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10680, N'OLDWO', 1, N'2015-09-24 16:00:00.000', N'2015-10-22 00:00:00.000', N'2015-09-26 00:00:00.000', 1,
        26.6100, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10681, N'GREAL', 3, N'2015-09-25 00:00:00.000', N'2015-10-23 00:00:00.000', N'2015-09-30 00:00:00.000', 3,
        76.1300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10682, N'ANTON', 3, N'2015-09-25 04:00:00.000', N'2015-10-23 00:00:00.000', N'2015-10-01 00:00:00.000', 2,
        36.1300, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10683, N'DUMON', 2, N'2015-09-26 18:00:00.000', N'2015-10-24 00:00:00.000', N'2015-10-01 00:00:00.000', 1,
        4.4000, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10684, N'OTTIK', 3, N'2015-09-26 01:00:00.000', N'2015-10-24 00:00:00.000', N'2015-09-30 00:00:00.000', 1,
        145.6300, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10685, N'GOURL', 4, N'2015-09-29 00:00:00.000', N'2015-10-13 00:00:00.000', N'2015-10-03 00:00:00.000', 2,
        33.7500, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10686, N'PICCO', 2, N'2015-09-30 00:00:00.000', N'2015-10-28 00:00:00.000', N'2015-10-08 00:00:00.000', 1,
        96.5000, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10687, N'HUNGO', 9, N'2015-09-30 00:00:00.000', N'2015-10-28 00:00:00.000', N'2015-10-30 00:00:00.000', 2,
        296.4300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10688, N'VAFFE', 4, N'2015-10-01 10:00:00.000', N'2015-10-15 00:00:00.000', N'2015-10-07 00:00:00.000', 2,
        299.0900, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10689, N'BERGS', 1, N'2015-10-01 06:00:00.000', N'2015-10-29 00:00:00.000', N'2015-10-07 00:00:00.000', 2,
        13.4200, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10690, N'HANAR', 1, N'2015-10-02 04:00:00.000', N'2015-10-30 00:00:00.000', N'2015-10-03 00:00:00.000', 1,
        15.8000, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10691, N'QUICK', 2, N'2015-10-03 14:00:00.000', N'2015-11-14 00:00:00.000', N'2015-10-22 00:00:00.000', 2,
        810.0500, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10692, N'ALFKI', 4, N'2015-10-03 05:00:00.000', N'2015-10-31 00:00:00.000', N'2015-10-13 00:00:00.000', 2,
        61.0200, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', null, N'12209', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10693, N'WHITC', 3, N'2015-10-06 05:00:00.000', N'2015-10-20 00:00:00.000', N'2015-10-10 00:00:00.000', 3,
        139.3400, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10694, N'QUICK', 8, N'2015-10-06 10:00:00.000', N'2015-11-03 00:00:00.000', N'2015-10-09 00:00:00.000', 3,
        398.3600, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10695, N'WILMK', 7, N'2015-10-07 08:00:00.000', N'2015-11-18 00:00:00.000', N'2015-10-14 00:00:00.000', 1,
        16.7200, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10696, N'WHITC', 8, N'2015-10-08 00:00:00.000', N'2015-11-19 00:00:00.000', N'2015-10-14 00:00:00.000', 3,
        102.5500, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10697, N'LINOD', 3, N'2015-10-08 04:00:00.000', N'2015-11-05 00:00:00.000', N'2015-10-14 00:00:00.000', 1,
        45.5200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10698, N'ERNSH', 4, N'2015-10-09 14:00:00.000', N'2015-11-06 00:00:00.000', N'2015-10-17 00:00:00.000', 1,
        272.4700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10699, N'MORGK', 3, N'2015-10-09 05:00:00.000', N'2015-11-06 00:00:00.000', N'2015-10-13 00:00:00.000', 3,
        0.5800, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', null, N'04179', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10700, N'SAVEA', 3, N'2015-10-10 19:00:00.000', N'2015-11-07 00:00:00.000', N'2015-10-16 00:00:00.000', 1,
        65.1000, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10701, N'HUNGO', 6, N'2015-10-13 00:00:00.000', N'2015-10-27 00:00:00.000', N'2015-10-15 00:00:00.000', 3,
        220.3100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10702, N'ALFKI', 4, N'2015-10-13 19:00:00.000', N'2015-11-24 00:00:00.000', N'2015-10-21 00:00:00.000', 1,
        23.9400, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', null, N'12209', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10703, N'FOLKO', 6, N'2015-10-14 16:00:00.000', N'2015-11-11 00:00:00.000', N'2015-10-20 00:00:00.000', 2,
        152.3000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10704, N'QUEEN', 6, N'2015-10-14 18:00:00.000', N'2015-11-11 00:00:00.000', N'2015-11-07 00:00:00.000', 1,
        4.7800, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10705, N'HILAA', 9, N'2015-10-15 19:00:00.000', N'2015-11-12 00:00:00.000', N'2015-11-18 00:00:00.000', 2,
        3.5200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10706, N'OLDWO', 8, N'2015-10-16 15:00:00.000', N'2015-11-13 00:00:00.000', N'2015-10-21 00:00:00.000', 3,
        135.6300, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10707, N'AROUT', 4, N'2015-10-16 06:00:00.000', N'2015-10-30 00:00:00.000', N'2015-10-23 00:00:00.000', 3,
        21.7400, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10708, N'THEBI', 6, N'2015-10-17 11:00:00.000', N'2015-11-28 00:00:00.000', N'2015-11-05 00:00:00.000', 2,
        2.9600, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10709, N'GOURL', 1, N'2015-10-17 13:00:00.000', N'2015-11-14 00:00:00.000', N'2015-11-20 00:00:00.000', 3,
        210.8000, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10710, N'FRANS', 1, N'2015-10-20 10:00:00.000', N'2015-11-17 00:00:00.000', N'2015-10-23 00:00:00.000', 1,
        4.9800, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', null, N'10100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10711, N'SAVEA', 5, N'2015-10-21 03:00:00.000', N'2015-12-02 00:00:00.000', N'2015-10-29 00:00:00.000', 2,
        52.4100, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10712, N'HUNGO', 3, N'2015-10-21 10:00:00.000', N'2015-11-18 00:00:00.000', N'2015-10-31 00:00:00.000', 1,
        89.9300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10713, N'SAVEA', 1, N'2015-10-22 00:00:00.000', N'2015-11-19 00:00:00.000', N'2015-10-24 00:00:00.000', 1,
        167.0500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10714, N'SAVEA', 5, N'2015-10-22 03:00:00.000', N'2015-11-19 00:00:00.000', N'2015-10-27 00:00:00.000', 3,
        24.4900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10715, N'BONAP', 3, N'2015-10-23 14:00:00.000', N'2015-11-06 00:00:00.000', N'2015-10-29 00:00:00.000', 1,
        63.2000, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10716, N'RANCH', 4, N'2015-10-24 05:00:00.000', N'2015-11-21 00:00:00.000', N'2015-10-27 00:00:00.000', 2,
        22.5700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10717, N'FRANK', 1, N'2015-10-24 04:00:00.000', N'2015-11-21 00:00:00.000', N'2015-10-29 00:00:00.000', 2,
        59.2500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10718, N'KOENE', 1, N'2015-10-27 10:00:00.000', N'2015-11-24 00:00:00.000', N'2015-10-29 00:00:00.000', 3,
        170.8800, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10719, N'LETSS', 8, N'2015-10-27 17:00:00.000', N'2015-11-24 00:00:00.000', N'2015-11-05 00:00:00.000', 2,
        51.4400, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10720, N'QUEDE', 8, N'2015-10-28 17:00:00.000', N'2015-11-11 00:00:00.000', N'2015-11-05 00:00:00.000', 2,
        9.5300, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10721, N'QUICK', 5, N'2015-10-29 08:00:00.000', N'2015-11-26 00:00:00.000', N'2015-10-31 00:00:00.000', 3,
        48.9200, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10722, N'SAVEA', 8, N'2015-10-29 03:00:00.000', N'2015-12-10 00:00:00.000', N'2015-11-04 00:00:00.000', 1,
        74.5800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10723, N'WHITC', 3, N'2015-10-30 22:00:00.000', N'2015-11-27 00:00:00.000', N'2015-11-25 00:00:00.000', 1,
        21.7200, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10724, N'MEREP', 8, N'2015-10-30 05:00:00.000', N'2015-12-11 00:00:00.000', N'2015-11-05 00:00:00.000', 2,
        57.7500, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10725, N'FAMIA', 4, N'2015-10-31 00:00:00.000', N'2015-11-28 00:00:00.000', N'2015-11-05 00:00:00.000', 3,
        10.8300, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10726, N'EASTC', 4, N'2015-11-03 05:00:00.000', N'2015-11-17 00:00:00.000', N'2015-12-05 00:00:00.000', 1,
        16.5600, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10727, N'REGGC', 2, N'2015-11-03 20:00:00.000', N'2015-12-01 00:00:00.000', N'2015-12-05 00:00:00.000', 1,
        89.9000, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10728, N'QUEEN', 4, N'2015-11-04 16:00:00.000', N'2015-12-02 00:00:00.000', N'2015-11-11 00:00:00.000', 2,
        58.3300, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10729, N'LINOD', 8, N'2015-11-04 20:00:00.000', N'2015-12-16 00:00:00.000', N'2015-11-14 00:00:00.000', 3,
        141.0600, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10730, N'BONAP', 5, N'2015-11-05 07:00:00.000', N'2015-12-03 00:00:00.000', N'2015-11-14 00:00:00.000', 1,
        20.1200, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10731, N'CHOPS', 7, N'2015-11-06 13:00:00.000', N'2015-12-04 00:00:00.000', N'2015-11-14 00:00:00.000', 1,
        96.6500, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10732, N'BONAP', 3, N'2015-11-06 15:00:00.000', N'2015-12-04 00:00:00.000', N'2015-11-07 00:00:00.000', 1,
        16.9700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10733, N'BERGS', 1, N'2015-11-07 02:00:00.000', N'2015-12-05 00:00:00.000', N'2015-11-10 00:00:00.000', 3,
        110.1100, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10734, N'GOURL', 2, N'2015-11-07 05:00:00.000', N'2015-12-05 00:00:00.000', N'2015-11-12 00:00:00.000', 3,
        1.6300, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10735, N'LETSS', 6, N'2015-11-10 20:00:00.000', N'2015-12-08 00:00:00.000', N'2015-11-21 00:00:00.000', 2,
        45.9700, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10736, N'HUNGO', 9, N'2015-11-11 05:00:00.000', N'2015-12-09 00:00:00.000', N'2015-11-21 00:00:00.000', 2,
        44.1000, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10737, N'VINET', 2, N'2015-11-11 13:00:00.000', N'2015-12-09 00:00:00.000', N'2015-11-18 00:00:00.000', 2,
        7.7900, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', null, N'51100', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10738, N'SPECD', 2, N'2015-11-12 03:00:00.000', N'2015-12-10 00:00:00.000', N'2015-11-18 00:00:00.000', 1,
        2.9100, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', null, N'75016', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10739, N'VINET', 3, N'2015-11-12 10:00:00.000', N'2015-12-10 00:00:00.000', N'2015-11-17 00:00:00.000', 3,
        11.0800, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', null, N'51100', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10740, N'WHITC', 4, N'2015-11-13 16:00:00.000', N'2015-12-11 00:00:00.000', N'2015-11-25 00:00:00.000', 2,
        81.8800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10741, N'AROUT', 4, N'2015-11-14 10:00:00.000', N'2015-11-28 00:00:00.000', N'2015-11-18 00:00:00.000', 3,
        10.9600, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10742, N'BOTTM', 3, N'2015-11-14 12:00:00.000', N'2015-12-12 00:00:00.000', N'2015-11-18 00:00:00.000', 3,
        243.7300, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10743, N'AROUT', 1, N'2015-11-17 18:00:00.000', N'2015-12-15 00:00:00.000', N'2015-11-21 00:00:00.000', 2,
        23.7200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10744, N'VAFFE', 6, N'2015-11-17 08:00:00.000', N'2015-12-15 00:00:00.000', N'2015-11-24 00:00:00.000', 1,
        69.1900, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10745, N'QUICK', 9, N'2015-11-18 08:00:00.000', N'2015-12-16 00:00:00.000', N'2015-11-27 00:00:00.000', 1,
        3.5200, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10746, N'CHOPS', 1, N'2015-11-19 10:00:00.000', N'2015-12-17 00:00:00.000', N'2015-11-21 00:00:00.000', 3,
        31.4300, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10747, N'PICCO', 6, N'2015-11-19 12:00:00.000', N'2015-12-17 00:00:00.000', N'2015-11-26 00:00:00.000', 1,
        117.3300, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10748, N'SAVEA', 3, N'2015-11-20 14:00:00.000', N'2015-12-18 00:00:00.000', N'2015-11-28 00:00:00.000', 1,
        232.5500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10749, N'ISLAT', 4, N'2015-11-20 00:00:00.000', N'2015-12-18 00:00:00.000', N'2015-12-19 00:00:00.000', 2,
        61.5300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10750, N'WARTH', 9, N'2015-11-21 16:00:00.000', N'2015-12-19 00:00:00.000', N'2015-11-24 00:00:00.000', 1,
        79.3000, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10751, N'RICSU', 3, N'2015-11-24 03:00:00.000', N'2015-12-22 00:00:00.000', N'2015-12-03 00:00:00.000', 3,
        130.7900, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10752, N'NORTS', 2, N'2015-11-24 22:00:00.000', N'2015-12-22 00:00:00.000', N'2015-11-28 00:00:00.000', 3,
        1.3900, N'North/South', N'South House 300 Queensbridge', N'London', null, N'SW7 1RZ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10753, N'FRANS', 3, N'2015-11-25 07:00:00.000', N'2015-12-23 00:00:00.000', N'2015-11-27 00:00:00.000', 1,
        7.7000, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', null, N'10100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10754, N'MAGAA', 6, N'2015-11-25 03:00:00.000', N'2015-12-23 00:00:00.000', N'2015-11-27 00:00:00.000', 3,
        2.3800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10755, N'BONAP', 4, N'2015-11-26 03:00:00.000', N'2015-12-24 00:00:00.000', N'2015-11-28 00:00:00.000', 2,
        16.7100, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10756, N'SPLIR', 8, N'2015-11-27 20:00:00.000', N'2015-12-25 00:00:00.000', N'2015-12-02 00:00:00.000', 2,
        73.2100, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10757, N'SAVEA', 6, N'2015-11-27 02:00:00.000', N'2015-12-25 00:00:00.000', N'2015-12-15 00:00:00.000', 1,
        8.1900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10758, N'RICSU', 3, N'2015-11-28 11:00:00.000', N'2015-12-26 00:00:00.000', N'2015-12-04 00:00:00.000', 3,
        138.1700, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10759, N'ANATR', 3, N'2015-11-28 06:00:00.000', N'2015-12-26 00:00:00.000', N'2015-12-12 00:00:00.000', 3,
        11.9900, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', null,
        N'05021', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10760, N'MAISD', 4, N'2015-12-01 17:00:00.000', N'2015-12-29 00:00:00.000', N'2015-12-10 00:00:00.000', 1,
        155.6400, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10761, N'RATTC', 5, N'2015-12-02 08:00:00.000', N'2015-12-30 00:00:00.000', N'2015-12-08 00:00:00.000', 2,
        18.6600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10762, N'FOLKO', 3, N'2015-12-02 00:00:00.000', N'2015-12-30 00:00:00.000', N'2015-12-09 00:00:00.000', 1,
        328.7400, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10763, N'FOLIG', 3, N'2015-12-03 05:00:00.000', N'2015-12-31 00:00:00.000', N'2015-12-08 00:00:00.000', 3,
        37.3500, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', null, N'59000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10764, N'ERNSH', 6, N'2015-12-03 12:00:00.000', N'2015-12-31 00:00:00.000', N'2015-12-08 00:00:00.000', 3,
        145.4500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10765, N'QUICK', 3, N'2015-12-04 10:00:00.000', N'2016-01-01 00:00:00.000', N'2015-12-09 00:00:00.000', 3,
        42.7400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10766, N'OTTIK', 4, N'2015-12-05 02:00:00.000', N'2016-01-02 00:00:00.000', N'2015-12-09 00:00:00.000', 1,
        157.5500, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10767, N'SUPRD', 4, N'2015-12-05 22:00:00.000', N'2016-01-02 00:00:00.000', N'2015-12-15 00:00:00.000', 3,
        1.5900, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10768, N'AROUT', 3, N'2015-12-08 20:00:00.000', N'2016-01-05 00:00:00.000', N'2015-12-15 00:00:00.000', 2,
        146.3200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10769, N'VAFFE', 3, N'2015-12-08 19:00:00.000', N'2016-01-05 00:00:00.000', N'2015-12-12 00:00:00.000', 1,
        65.0600, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10770, N'HANAR', 8, N'2015-12-09 03:00:00.000', N'2016-01-06 00:00:00.000', N'2015-12-17 00:00:00.000', 3,
        5.3200, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10771, N'ERNSH', 9, N'2015-12-10 12:00:00.000', N'2016-01-07 00:00:00.000', N'2016-01-02 00:00:00.000', 2,
        11.1900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10772, N'LEHMS', 3, N'2015-12-10 12:00:00.000', N'2016-01-07 00:00:00.000', N'2015-12-19 00:00:00.000', 2,
        91.2800, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10773, N'ERNSH', 1, N'2015-12-11 05:00:00.000', N'2016-01-08 00:00:00.000', N'2015-12-16 00:00:00.000', 3,
        96.4300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10774, N'FOLKO', 4, N'2015-12-11 11:00:00.000', N'2015-12-25 00:00:00.000', N'2015-12-12 00:00:00.000', 1,
        48.2000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10775, N'THECR', 7, N'2015-12-12 13:00:00.000', N'2016-01-09 00:00:00.000', N'2015-12-26 00:00:00.000', 1,
        20.2500, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10776, N'ERNSH', 1, N'2015-12-15 19:00:00.000', N'2016-01-12 00:00:00.000', N'2015-12-18 00:00:00.000', 3,
        351.5300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10777, N'GOURL', 7, N'2015-12-15 08:00:00.000', N'2015-12-29 00:00:00.000', N'2016-01-21 00:00:00.000', 2,
        3.0100, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10778, N'BERGS', 3, N'2015-12-16 07:00:00.000', N'2016-01-13 00:00:00.000', N'2015-12-24 00:00:00.000', 1,
        6.7900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10779, N'MORGK', 3, N'2015-12-16 04:00:00.000', N'2016-01-13 00:00:00.000', N'2016-01-14 00:00:00.000', 2,
        58.1300, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', null, N'04179', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10780, N'LILAS', 2, N'2015-12-16 22:00:00.000', N'2015-12-30 00:00:00.000', N'2015-12-25 00:00:00.000', 1,
        42.1300, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10781, N'WARTH', 2, N'2015-12-17 02:00:00.000', N'2016-01-14 00:00:00.000', N'2015-12-19 00:00:00.000', 3,
        73.1600, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10782, N'CACTU', 9, N'2015-12-17 13:00:00.000', N'2016-01-14 00:00:00.000', N'2015-12-22 00:00:00.000', 3,
        1.1000, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10783, N'HANAR', 4, N'2015-12-18 15:00:00.000', N'2016-01-15 00:00:00.000', N'2015-12-19 00:00:00.000', 2,
        124.9800, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10784, N'MAGAA', 4, N'2015-12-18 04:00:00.000', N'2016-01-15 00:00:00.000', N'2015-12-22 00:00:00.000', 3,
        70.0900, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10785, N'GROSR', 1, N'2015-12-18 11:00:00.000', N'2016-01-15 00:00:00.000', N'2015-12-24 00:00:00.000', 3,
        1.5100, N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10786, N'QUEEN', 8, N'2015-12-19 16:00:00.000', N'2016-01-16 00:00:00.000', N'2015-12-23 00:00:00.000', 1,
        110.8700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10787, N'LAMAI', 2, N'2015-12-19 07:00:00.000', N'2016-01-02 00:00:00.000', N'2015-12-26 00:00:00.000', 1,
        249.9300, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10788, N'QUICK', 1, N'2015-12-22 01:00:00.000', N'2016-01-19 00:00:00.000', N'2016-01-19 00:00:00.000', 2,
        42.7000, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10789, N'FOLIG', 1, N'2015-12-22 21:00:00.000', N'2016-01-19 00:00:00.000', N'2015-12-31 00:00:00.000', 2,
        100.6000, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', null, N'59000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10790, N'GOURL', 6, N'2015-12-22 17:00:00.000', N'2016-01-19 00:00:00.000', N'2015-12-26 00:00:00.000', 1,
        28.2300, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10791, N'FRANK', 6, N'2015-12-23 12:00:00.000', N'2016-01-20 00:00:00.000', N'2016-01-01 00:00:00.000', 2,
        16.8500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10792, N'WOLZA', 1, N'2015-12-23 11:00:00.000', N'2016-01-20 00:00:00.000', N'2015-12-31 00:00:00.000', 3,
        23.7900, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10793, N'AROUT', 3, N'2015-12-24 21:00:00.000', N'2016-01-21 00:00:00.000', N'2016-01-08 00:00:00.000', 3,
        4.5200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10794, N'QUEDE', 6, N'2015-12-24 03:00:00.000', N'2016-01-21 00:00:00.000', N'2016-01-02 00:00:00.000', 1,
        21.4900, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10795, N'ERNSH', 8, N'2015-12-24 11:00:00.000', N'2016-01-21 00:00:00.000', N'2016-01-20 00:00:00.000', 2,
        126.6600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10796, N'HILAA', 3, N'2015-12-25 16:00:00.000', N'2016-01-22 00:00:00.000', N'2016-01-14 00:00:00.000', 1,
        26.5200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10797, N'DRACD', 7, N'2015-12-25 14:00:00.000', N'2016-01-22 00:00:00.000', N'2016-01-05 00:00:00.000', 2,
        33.3500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', null, N'52066', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10798, N'ISLAT', 2, N'2015-12-26 12:00:00.000', N'2016-01-23 00:00:00.000', N'2016-01-05 00:00:00.000', 1,
        2.3300, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10799, N'KOENE', 9, N'2015-12-26 14:00:00.000', N'2016-02-06 00:00:00.000', N'2016-01-05 00:00:00.000', 3,
        30.7600, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10800, N'SEVES', 1, N'2015-12-26 13:00:00.000', N'2016-01-23 00:00:00.000', N'2016-01-05 00:00:00.000', 3,
        137.4400, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10801, N'BOLID', 4, N'2015-12-29 14:00:00.000', N'2016-01-26 00:00:00.000', N'2015-12-31 00:00:00.000', 2,
        97.0900, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', null, N'28023', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10802, N'SIMOB', 4, N'2015-12-29 10:00:00.000', N'2016-01-26 00:00:00.000', N'2016-01-02 00:00:00.000', 2,
        257.2600, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10803, N'WELLI', 4, N'2015-12-30 04:00:00.000', N'2016-01-27 00:00:00.000', N'2016-01-06 00:00:00.000', 1,
        55.2300, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10804, N'SEVES', 6, N'2015-12-30 20:00:00.000', N'2016-01-27 00:00:00.000', N'2016-01-07 00:00:00.000', 2,
        27.3300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10805, N'THEBI', 2, N'2015-12-30 17:00:00.000', N'2016-01-27 00:00:00.000', N'2016-01-09 00:00:00.000', 3,
        237.3400, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10806, N'VICTE', 3, N'2015-12-31 11:00:00.000', N'2016-01-28 00:00:00.000', N'2016-01-05 00:00:00.000', 2,
        2000.0000, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10807, N'FRANS', 4, N'2015-12-31 11:00:00.000', N'2016-01-28 00:00:00.000', N'2016-01-30 00:00:00.000', 1,
        1.3600, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', null, N'10100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10808, N'OLDWO', 2, N'2016-01-01 03:00:00.000', N'2016-01-29 00:00:00.000', N'2016-01-09 00:00:00.000', 3,
        45.5300, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10809, N'WELLI', 7, N'2016-01-01 20:00:00.000', N'2016-01-29 00:00:00.000', N'2016-01-07 00:00:00.000', 1,
        4.8700, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10810, N'LAUGB', 2, N'2016-01-01 17:00:00.000', N'2016-01-29 00:00:00.000', N'2016-01-07 00:00:00.000', 3,
        4.3300, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10811, N'LINOD', 8, N'2016-01-02 20:00:00.000', N'2016-01-30 00:00:00.000', N'2016-01-08 00:00:00.000', 1,
        31.2200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10812, N'REGGC', 5, N'2016-01-02 02:00:00.000', N'2016-01-30 00:00:00.000', N'2016-01-12 00:00:00.000', 1,
        59.7800, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10813, N'RICAR', 1, N'2016-01-05 01:00:00.000', N'2016-02-02 00:00:00.000', N'2016-01-09 00:00:00.000', 1,
        47.3800, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10814, N'VICTE', 3, N'2016-01-05 18:00:00.000', N'2016-02-02 00:00:00.000', N'2016-01-14 00:00:00.000', 3,
        130.9400, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10815, N'SAVEA', 2, N'2016-01-05 04:00:00.000', N'2016-02-02 00:00:00.000', N'2016-01-14 00:00:00.000', 3,
        14.6200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10816, N'GREAL', 4, N'2016-01-06 22:00:00.000', N'2016-02-03 00:00:00.000', N'2016-02-04 00:00:00.000', 2,
        719.7800, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10817, N'KOENE', 3, N'2016-01-06 21:00:00.000', N'2016-01-20 00:00:00.000', N'2016-01-13 00:00:00.000', 2,
        306.0700, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10818, N'MAGAA', 7, N'2016-01-07 17:00:00.000', N'2016-02-04 00:00:00.000', N'2016-01-12 00:00:00.000', 3,
        65.4800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10819, N'CACTU', 2, N'2016-01-07 06:00:00.000', N'2016-02-04 00:00:00.000', N'2016-01-16 00:00:00.000', 3,
        19.7600, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10820, N'RATTC', 3, N'2016-01-07 02:00:00.000', N'2016-02-04 00:00:00.000', N'2016-01-13 00:00:00.000', 2,
        37.5200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10821, N'SPLIR', 1, N'2016-01-08 15:00:00.000', N'2016-02-05 00:00:00.000', N'2016-01-15 00:00:00.000', 1,
        36.6800, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10822, N'TRAIH', 6, N'2016-01-08 08:00:00.000', N'2016-02-05 00:00:00.000', N'2016-01-16 00:00:00.000', 3,
        7.0000, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10823, N'LILAS', 5, N'2016-01-09 17:00:00.000', N'2016-02-06 00:00:00.000', N'2016-01-13 00:00:00.000', 2,
        163.9700, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10824, N'FOLKO', 8, N'2016-01-09 04:00:00.000', N'2016-02-06 00:00:00.000', N'2016-01-30 00:00:00.000', 1,
        1.2300, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10825, N'DRACD', 1, N'2016-01-09 01:00:00.000', N'2016-02-06 00:00:00.000', N'2016-01-14 00:00:00.000', 1,
        79.2500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', null, N'52066', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10826, N'BLONP', 6, N'2016-01-12 03:00:00.000', N'2016-02-09 00:00:00.000', N'2016-02-06 00:00:00.000', 1,
        7.0900, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', null, N'67000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10827, N'BONAP', 1, N'2016-01-12 19:00:00.000', N'2016-01-26 00:00:00.000', N'2016-02-06 00:00:00.000', 2,
        63.5400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10828, N'RANCH', 9, N'2016-01-13 04:00:00.000', N'2016-01-27 00:00:00.000', N'2016-02-04 00:00:00.000', 1,
        90.8500, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10829, N'ISLAT', 9, N'2016-01-13 17:00:00.000', N'2016-02-10 00:00:00.000', N'2016-01-23 00:00:00.000', 1,
        154.7200, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10830, N'TRADH', 4, N'2016-01-13 22:00:00.000', N'2016-02-24 00:00:00.000', N'2016-01-21 00:00:00.000', 2,
        81.8300, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10831, N'SANTG', 3, N'2016-01-14 09:00:00.000', N'2016-02-11 00:00:00.000', N'2016-01-23 00:00:00.000', 2,
        72.1900, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', null, N'4110', N'Norway');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10832, N'LAMAI', 2, N'2016-01-14 13:00:00.000', N'2016-02-11 00:00:00.000', N'2016-01-19 00:00:00.000', 2,
        43.2600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10833, N'OTTIK', 6, N'2016-01-15 14:00:00.000', N'2016-02-12 00:00:00.000', N'2016-01-23 00:00:00.000', 2,
        71.4900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10834, N'TRADH', 1, N'2016-01-15 14:00:00.000', N'2016-02-12 00:00:00.000', N'2016-01-19 00:00:00.000', 3,
        29.7800, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10835, N'ALFKI', 1, N'2016-01-15 20:00:00.000', N'2016-02-12 00:00:00.000', N'2016-01-21 00:00:00.000', 3,
        69.5300, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', null, N'12209', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10836, N'ERNSH', 7, N'2016-01-16 16:00:00.000', N'2016-02-13 00:00:00.000', N'2016-01-21 00:00:00.000', 1,
        411.8800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10837, N'BERGS', 9, N'2016-01-16 08:00:00.000', N'2016-02-13 00:00:00.000', N'2016-01-23 00:00:00.000', 3,
        13.3200, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10838, N'LINOD', 3, N'2016-01-19 03:00:00.000', N'2016-02-16 00:00:00.000', N'2016-01-23 00:00:00.000', 3,
        59.2800, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10839, N'TRADH', 3, N'2016-01-19 08:00:00.000', N'2016-02-16 00:00:00.000', N'2016-01-22 00:00:00.000', 3,
        35.4300, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10840, N'LINOD', 4, N'2016-01-19 12:00:00.000', N'2016-03-02 00:00:00.000', N'2016-02-16 00:00:00.000', 2,
        2.7100, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10841, N'SUPRD', 5, N'2016-01-20 21:00:00.000', N'2016-02-17 00:00:00.000', N'2016-01-29 00:00:00.000', 2,
        424.3000, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10842, N'TORTU', 1, N'2016-01-20 21:00:00.000', N'2016-02-17 00:00:00.000', N'2016-01-29 00:00:00.000', 3,
        54.4200, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10843, N'VICTE', 4, N'2016-01-21 09:00:00.000', N'2016-02-18 00:00:00.000', N'2016-01-26 00:00:00.000', 2,
        9.2600, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10844, N'PICCO', 8, N'2016-01-21 00:00:00.000', N'2016-02-18 00:00:00.000', N'2016-01-26 00:00:00.000', 2,
        25.2200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10845, N'QUICK', 8, N'2016-01-21 16:00:00.000', N'2016-02-04 00:00:00.000', N'2016-01-30 00:00:00.000', 1,
        212.9800, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10846, N'SUPRD', 2, N'2016-01-22 08:00:00.000', N'2016-03-05 00:00:00.000', N'2016-01-23 00:00:00.000', 3,
        56.4600, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10847, N'SAVEA', 4, N'2016-01-22 08:00:00.000', N'2016-02-05 00:00:00.000', N'2016-02-10 00:00:00.000', 3,
        487.5700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10848, N'CONSH', 7, N'2016-01-23 16:00:00.000', N'2016-02-20 00:00:00.000', N'2016-01-29 00:00:00.000', 2,
        38.2400, N'Consolidated Holdings', N'Berkeley Gardens 12  Brewery', N'London', null, N'WX1 6LT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10849, N'KOENE', 9, N'2016-01-23 10:00:00.000', N'2016-02-20 00:00:00.000', N'2016-01-30 00:00:00.000', 2,
        0.5600, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10850, N'VICTE', 1, N'2016-01-23 22:00:00.000', N'2016-03-06 00:00:00.000', N'2016-01-30 00:00:00.000', 1,
        49.1900, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', null, N'69004', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10851, N'RICAR', 5, N'2016-01-26 00:00:00.000', N'2016-02-23 00:00:00.000', N'2016-02-02 00:00:00.000', 1,
        160.5500, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10852, N'RATTC', 8, N'2016-01-26 10:00:00.000', N'2016-02-09 00:00:00.000', N'2016-01-30 00:00:00.000', 1,
        174.0500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10853, N'BLAUS', 9, N'2016-01-27 03:00:00.000', N'2016-02-24 00:00:00.000', N'2016-02-03 00:00:00.000', 2,
        53.8300, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10854, N'ERNSH', 3, N'2016-01-27 01:00:00.000', N'2016-02-24 00:00:00.000', N'2016-02-05 00:00:00.000', 2,
        100.2200, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10855, N'OLDWO', 3, N'2016-01-27 17:00:00.000', N'2016-02-24 00:00:00.000', N'2016-02-04 00:00:00.000', 1,
        170.9700, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10856, N'ANTON', 3, N'2016-01-28 04:00:00.000', N'2016-02-25 00:00:00.000', N'2016-02-10 00:00:00.000', 2,
        58.4300, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', null, N'05023', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10857, N'BERGS', 8, N'2016-01-28 05:00:00.000', N'2016-02-25 00:00:00.000', N'2016-02-06 00:00:00.000', 2,
        188.8500, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10858, N'LACOR', 2, N'2016-01-29 17:00:00.000', N'2016-02-26 00:00:00.000', N'2016-02-03 00:00:00.000', 1,
        52.5100, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', null, N'78000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10859, N'FRANK', 1, N'2016-01-29 11:00:00.000', N'2016-02-26 00:00:00.000', N'2016-02-02 00:00:00.000', 2,
        76.1000, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10860, N'FRANR', 3, N'2016-01-29 21:00:00.000', N'2016-02-26 00:00:00.000', N'2016-02-04 00:00:00.000', 3,
        19.2600, N'France restauration', N'54, rue Royale', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10861, N'WHITC', 4, N'2016-01-30 02:00:00.000', N'2016-02-27 00:00:00.000', N'2016-02-17 00:00:00.000', 2,
        14.9300, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10862, N'LEHMS', 8, N'2016-01-30 22:00:00.000', N'2016-03-13 00:00:00.000', N'2016-02-02 00:00:00.000', 2,
        53.2300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10863, N'HILAA', 4, N'2016-02-02 00:00:00.000', N'2016-03-02 00:00:00.000', N'2016-02-17 00:00:00.000', 2,
        30.2600, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10864, N'AROUT', 4, N'2016-02-02 17:00:00.000', N'2016-03-02 00:00:00.000', N'2016-02-09 00:00:00.000', 2,
        3.0400, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10865, N'QUICK', 2, N'2016-02-02 04:00:00.000', N'2016-02-16 00:00:00.000', N'2016-02-12 00:00:00.000', 1,
        348.1400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10866, N'BERGS', 5, N'2016-02-03 01:00:00.000', N'2016-03-03 00:00:00.000', N'2016-02-12 00:00:00.000', 1,
        109.1100, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10867, N'LONEP', 6, N'2016-02-03 09:00:00.000', N'2016-03-17 00:00:00.000', N'2016-02-11 00:00:00.000', 1,
        1.9300, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10868, N'QUEEN', 7, N'2016-02-04 16:00:00.000', N'2016-03-04 00:00:00.000', N'2016-02-23 00:00:00.000', 2,
        191.2700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10869, N'SEVES', 5, N'2016-02-04 09:00:00.000', N'2016-03-04 00:00:00.000', N'2016-02-09 00:00:00.000', 1,
        143.2800, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', null, N'OX15 4NB', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10870, N'WOLZA', 5, N'2016-02-04 12:00:00.000', N'2016-03-04 00:00:00.000', N'2016-02-13 00:00:00.000', 3,
        12.0400, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10871, N'BONAP', 9, N'2016-02-05 19:00:00.000', N'2016-03-05 00:00:00.000', N'2016-02-10 00:00:00.000', 2,
        112.2700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10872, N'GODOS', 5, N'2016-02-05 06:00:00.000', N'2016-03-05 00:00:00.000', N'2016-02-09 00:00:00.000', 2,
        175.3200, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10873, N'WILMK', 4, N'2016-02-06 02:00:00.000', N'2016-03-06 00:00:00.000', N'2016-02-09 00:00:00.000', 1,
        0.8200, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10874, N'GODOS', 5, N'2016-02-06 14:00:00.000', N'2016-03-06 00:00:00.000', N'2016-02-11 00:00:00.000', 2,
        19.5800, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10875, N'BERGS', 4, N'2016-02-06 21:00:00.000', N'2016-03-06 00:00:00.000', N'2016-03-03 00:00:00.000', 2,
        32.3700, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10876, N'BONAP', 7, N'2016-02-09 17:00:00.000', N'2016-03-09 00:00:00.000', N'2016-02-12 00:00:00.000', 3,
        60.4200, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10877, N'RICAR', 1, N'2016-02-09 15:00:00.000', N'2016-03-09 00:00:00.000', N'2016-02-19 00:00:00.000', 1,
        38.0600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10878, N'QUICK', 4, N'2016-02-10 12:00:00.000', N'2016-03-10 00:00:00.000', N'2016-02-12 00:00:00.000', 1,
        46.6900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10879, N'WILMK', 3, N'2016-02-10 06:00:00.000', N'2016-03-10 00:00:00.000', N'2016-02-12 00:00:00.000', 3,
        8.5000, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10880, N'FOLKO', 7, N'2016-02-10 07:00:00.000', N'2016-03-24 00:00:00.000', N'2016-02-18 00:00:00.000', 1,
        88.0100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10881, N'CACTU', 4, N'2016-02-11 07:00:00.000', N'2016-03-11 00:00:00.000', N'2016-02-18 00:00:00.000', 1,
        2.8400, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10882, N'SAVEA', 4, N'2016-02-11 09:00:00.000', N'2016-03-11 00:00:00.000', N'2016-02-20 00:00:00.000', 3,
        23.1000, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10883, N'LONEP', 8, N'2016-02-12 01:00:00.000', N'2016-03-12 00:00:00.000', N'2016-02-20 00:00:00.000', 3,
        0.5300, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10884, N'LETSS', 4, N'2016-02-12 08:00:00.000', N'2016-03-12 00:00:00.000', N'2016-02-13 00:00:00.000', 2,
        90.9700, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10885, N'SUPRD', 6, N'2016-02-12 07:00:00.000', N'2016-03-12 00:00:00.000', N'2016-02-18 00:00:00.000', 3,
        5.6400, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10886, N'HANAR', 1, N'2016-02-13 05:00:00.000', N'2016-03-13 00:00:00.000', N'2016-03-02 00:00:00.000', 1,
        4.9900, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10887, N'GALED', 8, N'2016-02-13 10:00:00.000', N'2016-03-13 00:00:00.000', N'2016-02-16 00:00:00.000', 3,
        1.2500, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', null, N'8022', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10888, N'GODOS', 1, N'2016-02-16 19:00:00.000', N'2016-03-16 00:00:00.000', N'2016-02-23 00:00:00.000', 2,
        51.8700, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10889, N'RATTC', 9, N'2016-02-16 04:00:00.000', N'2016-03-16 00:00:00.000', N'2016-02-23 00:00:00.000', 3,
        280.6100, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10890, N'DUMON', 7, N'2016-02-16 02:00:00.000', N'2016-03-16 00:00:00.000', N'2016-02-18 00:00:00.000', 1,
        32.7600, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10891, N'LEHMS', 7, N'2016-02-17 10:00:00.000', N'2016-03-17 00:00:00.000', N'2016-02-19 00:00:00.000', 2,
        20.3700, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10892, N'MAISD', 4, N'2016-02-17 10:00:00.000', N'2016-03-17 00:00:00.000', N'2016-02-19 00:00:00.000', 2,
        120.2700, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10893, N'KOENE', 9, N'2016-02-18 05:00:00.000', N'2016-03-18 00:00:00.000', N'2016-02-20 00:00:00.000', 2,
        77.7800, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10894, N'SAVEA', 1, N'2016-02-18 02:00:00.000', N'2016-03-18 00:00:00.000', N'2016-02-20 00:00:00.000', 1,
        116.1300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10895, N'ERNSH', 3, N'2016-02-18 17:00:00.000', N'2016-03-18 00:00:00.000', N'2016-02-23 00:00:00.000', 1,
        162.7500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10896, N'MAISD', 7, N'2016-02-19 00:00:00.000', N'2016-03-19 00:00:00.000', N'2016-02-27 00:00:00.000', 3,
        32.4500, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10897, N'HUNGO', 3, N'2016-02-19 18:00:00.000', N'2016-03-19 00:00:00.000', N'2016-02-25 00:00:00.000', 2,
        603.5400, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10898, N'OCEAN', 4, N'2016-02-20 10:00:00.000', N'2016-03-20 00:00:00.000', N'2016-03-06 00:00:00.000', 2,
        1.2700, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', null, N'1010',
        N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10899, N'LILAS', 5, N'2016-02-20 09:00:00.000', N'2016-03-20 00:00:00.000', N'2016-02-26 00:00:00.000', 3,
        1.2100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10900, N'WELLI', 1, N'2016-02-20 13:00:00.000', N'2016-03-20 00:00:00.000', N'2016-03-04 00:00:00.000', 2,
        1.6600, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10901, N'HILAA', 4, N'2016-02-23 11:00:00.000', N'2016-03-23 00:00:00.000', N'2016-02-26 00:00:00.000', 1,
        62.0900, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10902, N'FOLKO', 1, N'2016-02-23 04:00:00.000', N'2016-03-23 00:00:00.000', N'2016-03-03 00:00:00.000', 1,
        44.1500, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10903, N'HANAR', 3, N'2016-02-24 19:00:00.000', N'2016-03-24 00:00:00.000', N'2016-03-04 00:00:00.000', 3,
        36.7100, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10904, N'WHITC', 3, N'2016-02-24 09:00:00.000', N'2016-03-24 00:00:00.000', N'2016-02-27 00:00:00.000', 3,
        162.9500, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10905, N'WELLI', 9, N'2016-02-24 09:00:00.000', N'2016-03-24 00:00:00.000', N'2016-03-06 00:00:00.000', 2,
        13.7200, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10906, N'WOLZA', 4, N'2016-02-25 06:00:00.000', N'2016-03-11 00:00:00.000', N'2016-03-03 00:00:00.000', 3,
        26.2900, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10907, N'SPECD', 6, N'2016-02-25 12:00:00.000', N'2016-03-25 00:00:00.000', N'2016-02-27 00:00:00.000', 3,
        9.1900, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', null, N'75016', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10908, N'REGGC', 4, N'2016-02-26 12:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-06 00:00:00.000', 2,
        32.9600, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10909, N'SANTG', 1, N'2016-02-26 05:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-10 00:00:00.000', 2,
        53.0500, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', null, N'4110', N'Norway');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10910, N'WILMK', 1, N'2016-02-26 00:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-04 00:00:00.000', 3,
        38.1100, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10911, N'GODOS', 3, N'2016-02-26 13:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-05 00:00:00.000', 1,
        38.1900, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10912, N'HUNGO', 2, N'2016-02-26 08:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-18 00:00:00.000', 2,
        580.9100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10913, N'QUEEN', 4, N'2016-02-26 07:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-04 00:00:00.000', 1,
        33.0500, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10914, N'QUEEN', 6, N'2016-02-27 14:00:00.000', N'2016-03-27 00:00:00.000', N'2016-03-02 00:00:00.000', 1,
        21.1900, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10915, N'TORTU', 2, N'2016-02-27 08:00:00.000', N'2016-03-27 00:00:00.000', N'2016-03-02 00:00:00.000', 2,
        3.5100, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10916, N'RANCH', 1, N'2016-02-27 10:00:00.000', N'2016-03-27 00:00:00.000', N'2016-03-09 00:00:00.000', 2,
        63.7700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10917, N'ROMEY', 4, N'2016-03-02 02:00:00.000', N'2016-03-30 00:00:00.000', N'2016-03-11 00:00:00.000', 2,
        8.2900, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', null, N'28001', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10918, N'BOTTM', 3, N'2016-03-02 10:00:00.000', N'2016-03-30 00:00:00.000', N'2016-03-11 00:00:00.000', 3,
        48.8300, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10919, N'LINOD', 2, N'2016-03-02 12:00:00.000', N'2016-03-30 00:00:00.000', N'2016-03-04 00:00:00.000', 2,
        19.8000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10920, N'AROUT', 4, N'2016-03-03 08:00:00.000', N'2016-03-31 00:00:00.000', N'2016-03-09 00:00:00.000', 2,
        29.6100, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10921, N'VAFFE', 1, N'2016-03-03 17:00:00.000', N'2016-04-14 00:00:00.000', N'2016-03-09 00:00:00.000', 1,
        176.4800, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10922, N'HANAR', 5, N'2016-03-03 02:00:00.000', N'2016-03-31 00:00:00.000', N'2016-03-05 00:00:00.000', 3,
        62.7400, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10923, N'LAMAI', 7, N'2016-03-03 08:00:00.000', N'2016-04-14 00:00:00.000', N'2016-03-13 00:00:00.000', 3,
        68.2600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10924, N'BERGS', 3, N'2016-03-04 20:00:00.000', N'2016-04-01 00:00:00.000', N'2016-04-08 00:00:00.000', 2,
        151.5200, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', null, N'S-958 22', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10925, N'HANAR', 3, N'2016-03-04 18:00:00.000', N'2016-04-01 00:00:00.000', N'2016-03-13 00:00:00.000', 1,
        2.2700, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10926, N'ANATR', 4, N'2016-03-04 16:00:00.000', N'2016-04-01 00:00:00.000', N'2016-03-11 00:00:00.000', 3,
        39.9200, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', null,
        N'05021', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10927, N'LACOR', 4, N'2016-03-05 08:00:00.000', N'2016-04-02 00:00:00.000', N'2016-04-08 00:00:00.000', 1,
        19.7900, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', null, N'78000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10928, N'GALED', 1, N'2016-03-05 10:00:00.000', N'2016-04-02 00:00:00.000', N'2016-03-18 00:00:00.000', 1,
        1.3600, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', null, N'8022', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10929, N'FRANK', 6, N'2016-03-05 00:00:00.000', N'2016-04-02 00:00:00.000', N'2016-03-12 00:00:00.000', 1,
        33.9300, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10930, N'SUPRD', 4, N'2016-03-06 05:00:00.000', N'2016-04-17 00:00:00.000', N'2016-03-18 00:00:00.000', 3,
        15.5500, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10931, N'RICSU', 4, N'2016-03-06 05:00:00.000', N'2016-03-20 00:00:00.000', N'2016-03-19 00:00:00.000', 2,
        13.6000, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10932, N'BONAP', 8, N'2016-03-06 01:00:00.000', N'2016-04-03 00:00:00.000', N'2016-03-24 00:00:00.000', 1,
        134.6400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10933, N'ISLAT', 6, N'2016-03-06 16:00:00.000', N'2016-04-03 00:00:00.000', N'2016-03-16 00:00:00.000', 3,
        54.1500, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10934, N'LEHMS', 3, N'2016-03-09 12:00:00.000', N'2016-04-06 00:00:00.000', N'2016-03-12 00:00:00.000', 3,
        32.0100, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10935, N'WELLI', 4, N'2016-03-09 12:00:00.000', N'2016-04-06 00:00:00.000', N'2016-03-18 00:00:00.000', 3,
        47.5900, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10936, N'GREAL', 3, N'2016-03-09 00:00:00.000', N'2016-04-06 00:00:00.000', N'2016-03-18 00:00:00.000', 2,
        33.6800, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10937, N'CACTU', 7, N'2016-03-10 22:00:00.000', N'2016-03-24 00:00:00.000', N'2016-03-13 00:00:00.000', 3,
        31.5100, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10938, N'QUICK', 3, N'2016-03-10 14:00:00.000', N'2016-04-07 00:00:00.000', N'2016-03-16 00:00:00.000', 2,
        31.8900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10939, N'MAGAA', 2, N'2016-03-10 15:00:00.000', N'2016-04-07 00:00:00.000', N'2016-03-13 00:00:00.000', 2,
        76.3300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10940, N'BONAP', 8, N'2016-03-11 02:00:00.000', N'2016-04-08 00:00:00.000', N'2016-03-23 00:00:00.000', 3,
        19.7700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10941, N'SAVEA', 7, N'2016-03-11 06:00:00.000', N'2016-04-08 00:00:00.000', N'2016-03-20 00:00:00.000', 2,
        400.8100, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10942, N'REGGC', 9, N'2016-03-11 11:00:00.000', N'2016-04-08 00:00:00.000', N'2016-03-18 00:00:00.000', 3,
        17.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10943, N'BSBEV', 4, N'2016-03-11 01:00:00.000', N'2016-04-08 00:00:00.000', N'2016-03-19 00:00:00.000', 2,
        2.1700, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10944, N'BOTTM', 6, N'2016-03-12 04:00:00.000', N'2016-03-26 00:00:00.000', N'2016-03-13 00:00:00.000', 3,
        52.9200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10945, N'MORGK', 4, N'2016-03-12 12:00:00.000', N'2016-04-09 00:00:00.000', N'2016-03-18 00:00:00.000', 1,
        10.2200, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', null, N'04179', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10946, N'VAFFE', 1, N'2016-03-12 04:00:00.000', N'2016-04-09 00:00:00.000', N'2016-03-19 00:00:00.000', 2,
        27.2000, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10947, N'BSBEV', 3, N'2016-03-13 09:00:00.000', N'2016-04-10 00:00:00.000', N'2016-03-16 00:00:00.000', 2,
        3.2600, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10948, N'GODOS', 3, N'2016-03-13 16:00:00.000', N'2016-04-10 00:00:00.000', N'2016-03-19 00:00:00.000', 3,
        23.3900, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10949, N'BOTTM', 2, N'2016-03-13 13:00:00.000', N'2016-04-10 00:00:00.000', N'2016-03-17 00:00:00.000', 3,
        74.4400, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10950, N'MAGAA', 1, N'2016-03-16 02:00:00.000', N'2016-04-13 00:00:00.000', N'2016-03-23 00:00:00.000', 2,
        2.5000, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', null, N'24100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10951, N'RICSU', 9, N'2016-03-16 18:00:00.000', N'2016-04-27 00:00:00.000', N'2016-04-07 00:00:00.000', 2,
        30.8500, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10952, N'ALFKI', 1, N'2016-03-16 00:00:00.000', N'2016-04-27 00:00:00.000', N'2016-03-24 00:00:00.000', 1,
        40.4200, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', null, N'12209', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10953, N'AROUT', 9, N'2016-03-16 02:00:00.000', N'2016-03-30 00:00:00.000', N'2016-03-25 00:00:00.000', 2,
        23.7200, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10954, N'LINOD', 5, N'2016-03-17 16:00:00.000', N'2016-04-28 00:00:00.000', N'2016-03-20 00:00:00.000', 1,
        27.9100, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10955, N'FOLKO', 8, N'2016-03-17 17:00:00.000', N'2016-04-14 00:00:00.000', N'2016-03-20 00:00:00.000', 2,
        3.2600, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10956, N'BLAUS', 6, N'2016-03-17 20:00:00.000', N'2016-04-28 00:00:00.000', N'2016-03-20 00:00:00.000', 2,
        44.6500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10957, N'HILAA', 8, N'2016-03-18 04:00:00.000', N'2016-04-15 00:00:00.000', N'2016-03-27 00:00:00.000', 3,
        105.3600, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10958, N'OCEAN', 7, N'2016-03-18 10:00:00.000', N'2016-04-15 00:00:00.000', N'2016-03-27 00:00:00.000', 2,
        49.5600, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', null, N'1010',
        N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10959, N'GOURL', 6, N'2016-03-18 14:00:00.000', N'2016-04-29 00:00:00.000', N'2016-03-23 00:00:00.000', 2,
        4.9800, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10960, N'HILAA', 3, N'2016-03-19 15:00:00.000', N'2016-04-02 00:00:00.000', N'2016-04-08 00:00:00.000', 1,
        2.0800, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10961, N'QUEEN', 8, N'2016-03-19 08:00:00.000', N'2016-04-16 00:00:00.000', N'2016-03-30 00:00:00.000', 1,
        104.4700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10962, N'QUICK', 8, N'2016-03-19 02:00:00.000', N'2016-04-16 00:00:00.000', N'2016-03-23 00:00:00.000', 2,
        275.7900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10963, N'FURIB', 9, N'2016-03-19 16:00:00.000', N'2016-04-16 00:00:00.000', N'2016-03-26 00:00:00.000', 3,
        2.7000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', null, N'1675', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10964, N'SPECD', 3, N'2016-03-20 09:00:00.000', N'2016-04-17 00:00:00.000', N'2016-03-24 00:00:00.000', 2,
        87.3800, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', null, N'75016', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10965, N'OLDWO', 6, N'2016-03-20 05:00:00.000', N'2016-04-17 00:00:00.000', N'2016-03-30 00:00:00.000', 3,
        144.3800, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10966, N'CHOPS', 4, N'2016-03-20 20:00:00.000', N'2016-04-17 00:00:00.000', N'2016-04-08 00:00:00.000', 1,
        27.1900, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10967, N'TOMSP', 2, N'2016-03-23 18:00:00.000', N'2016-04-20 00:00:00.000', N'2016-04-02 00:00:00.000', 2,
        62.2200, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', null, N'44087', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10968, N'ERNSH', 1, N'2016-03-23 04:00:00.000', N'2016-04-20 00:00:00.000', N'2016-04-01 00:00:00.000', 3,
        74.6000, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10969, N'COMMI', 1, N'2016-03-23 14:00:00.000', N'2016-04-20 00:00:00.000', N'2016-03-30 00:00:00.000', 2,
        0.2100, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10970, N'BOLID', 9, N'2016-03-24 09:00:00.000', N'2016-04-07 00:00:00.000', N'2016-04-24 00:00:00.000', 1,
        16.1600, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', null, N'28023', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10971, N'FRANR', 2, N'2016-03-24 11:00:00.000', N'2016-04-21 00:00:00.000', N'2016-04-02 00:00:00.000', 2,
        121.8200, N'France restauration', N'54, rue Royale', N'Nantes', null, N'44000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10972, N'LACOR', 4, N'2016-03-24 10:00:00.000', N'2016-04-21 00:00:00.000', N'2016-03-26 00:00:00.000', 2,
        0.0200, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', null, N'78000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10973, N'LACOR', 6, N'2016-03-24 09:00:00.000', N'2016-04-21 00:00:00.000', N'2016-03-27 00:00:00.000', 2,
        15.1700, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', null, N'78000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10974, N'SPLIR', 3, N'2016-03-25 21:00:00.000', N'2016-04-08 00:00:00.000', N'2016-04-03 00:00:00.000', 3,
        12.9600, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10975, N'BOTTM', 1, N'2016-03-25 21:00:00.000', N'2016-04-22 00:00:00.000', N'2016-03-27 00:00:00.000', 3,
        32.2700, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10976, N'HILAA', 1, N'2016-03-25 20:00:00.000', N'2016-05-06 00:00:00.000', N'2016-04-03 00:00:00.000', 1,
        37.9700, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10977, N'FOLKO', 8, N'2016-03-26 02:00:00.000', N'2016-04-23 00:00:00.000', N'2016-04-10 00:00:00.000', 3,
        208.5000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10978, N'MAISD', 9, N'2016-03-26 10:00:00.000', N'2016-04-23 00:00:00.000', N'2016-04-23 00:00:00.000', 2,
        32.8200, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10979, N'ERNSH', 8, N'2016-03-26 14:00:00.000', N'2016-04-23 00:00:00.000', N'2016-03-31 00:00:00.000', 2,
        353.0700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10980, N'FOLKO', 4, N'2016-03-27 08:00:00.000', N'2016-05-08 00:00:00.000', N'2016-04-17 00:00:00.000', 1,
        1.2600, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10981, N'HANAR', 1, N'2016-03-27 21:00:00.000', N'2016-04-24 00:00:00.000', N'2016-04-02 00:00:00.000', 2,
        193.3700, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10982, N'BOTTM', 2, N'2016-03-27 21:00:00.000', N'2016-04-24 00:00:00.000', N'2016-04-08 00:00:00.000', 1,
        14.0100, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10983, N'SAVEA', 2, N'2016-03-27 15:00:00.000', N'2016-04-24 00:00:00.000', N'2016-04-06 00:00:00.000', 2,
        657.5400, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10984, N'SAVEA', 1, N'2016-03-30 13:00:00.000', N'2016-04-27 00:00:00.000', N'2016-04-03 00:00:00.000', 3,
        211.2200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10985, N'HUNGO', 2, N'2016-03-30 14:00:00.000', N'2016-04-27 00:00:00.000', N'2016-04-02 00:00:00.000', 1,
        91.5100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10986, N'OCEAN', 8, N'2016-03-30 00:00:00.000', N'2016-04-27 00:00:00.000', N'2016-04-21 00:00:00.000', 2,
        217.8600, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', null, N'1010',
        N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10987, N'EASTC', 8, N'2016-03-31 00:00:00.000', N'2016-04-28 00:00:00.000', N'2016-04-06 00:00:00.000', 1,
        185.4800, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10988, N'RATTC', 3, N'2016-03-31 00:00:00.000', N'2016-04-28 00:00:00.000', N'2016-04-10 00:00:00.000', 2,
        61.1400, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10989, N'QUEDE', 2, N'2016-03-31 00:00:00.000', N'2016-04-28 00:00:00.000', N'2016-04-02 00:00:00.000', 1,
        34.7600, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10990, N'ERNSH', 2, N'2016-04-01 13:00:00.000', N'2016-05-13 00:00:00.000', N'2016-04-07 00:00:00.000', 3,
        117.6100, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10991, N'QUICK', 1, N'2016-04-01 03:00:00.000', N'2016-04-29 00:00:00.000', N'2016-04-07 00:00:00.000', 1,
        38.5100, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10992, N'THEBI', 1, N'2016-04-01 01:00:00.000', N'2016-04-29 00:00:00.000', N'2016-04-03 00:00:00.000', 3,
        4.2700, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10993, N'FOLKO', 7, N'2016-04-01 02:00:00.000', N'2016-04-29 00:00:00.000', N'2016-04-10 00:00:00.000', 3,
        8.8100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10994, N'VAFFE', 2, N'2016-04-02 21:00:00.000', N'2016-04-16 00:00:00.000', N'2016-04-09 00:00:00.000', 3,
        65.5300, N'Vaffeljernet', N'Smagsloget 45', N'Århus', null, N'8200', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10995, N'PERIC', 1, N'2016-04-02 01:00:00.000', N'2016-04-30 00:00:00.000', N'2016-04-06 00:00:00.000', 3,
        46.0000, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10996, N'QUICK', 4, N'2016-04-02 07:00:00.000', N'2016-04-30 00:00:00.000', N'2016-04-10 00:00:00.000', 2,
        1.1200, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10997, N'LILAS', 8, N'2016-04-03 20:00:00.000', N'2016-05-15 00:00:00.000', N'2016-04-13 00:00:00.000', 2,
        73.9100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara',
        N'3508', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10998, N'WOLZA', 8, N'2016-04-03 00:00:00.000', N'2016-04-17 00:00:00.000', N'2016-04-17 00:00:00.000', 2,
        20.3100, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10999, N'OTTIK', 6, N'2016-04-03 01:00:00.000', N'2016-05-01 00:00:00.000', N'2016-04-10 00:00:00.000', 2,
        96.3500, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11000, N'RATTC', 2, N'2016-04-06 19:00:00.000', N'2016-05-04 00:00:00.000', N'2016-04-14 00:00:00.000', 3,
        55.1200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11001, N'FOLKO', 2, N'2016-04-06 04:00:00.000', N'2016-05-04 00:00:00.000', N'2016-04-14 00:00:00.000', 2,
        197.3000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11002, N'SAVEA', 4, N'2016-04-06 14:00:00.000', N'2016-05-04 00:00:00.000', N'2016-04-16 00:00:00.000', 1,
        141.1600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11003, N'THECR', 3, N'2016-04-06 03:00:00.000', N'2016-05-04 00:00:00.000', N'2016-04-08 00:00:00.000', 3,
        14.9100, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11004, N'MAISD', 3, N'2016-04-07 19:00:00.000', N'2016-05-05 00:00:00.000', N'2016-04-20 00:00:00.000', 1,
        44.8400, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', null, N'B-1180', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11005, N'WILMK', 2, N'2016-04-07 16:00:00.000', N'2016-05-05 00:00:00.000', N'2016-04-10 00:00:00.000', 1,
        0.7500, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', null, N'21240', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11006, N'GREAL', 3, N'2016-04-07 10:00:00.000', N'2016-05-05 00:00:00.000', N'2016-04-15 00:00:00.000', 2,
        25.1900, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11007, N'PRINI', 8, N'2016-04-08 19:00:00.000', N'2016-05-06 00:00:00.000', N'2016-04-13 00:00:00.000', 2,
        202.2400, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', null, N'1756', N'Portugal');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11008, N'ERNSH', 7, N'2016-04-08 13:00:00.000', N'2016-05-06 00:00:00.000', null, 3, 79.4600, N'Ernst Handel',
        N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11009, N'GODOS', 2, N'2016-04-08 22:00:00.000', N'2016-05-06 00:00:00.000', N'2016-04-10 00:00:00.000', 1,
        59.1100, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11010, N'REGGC', 2, N'2016-04-09 10:00:00.000', N'2016-05-07 00:00:00.000', N'2016-04-21 00:00:00.000', 2,
        28.7100, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11011, N'ALFKI', 3, N'2016-04-09 09:00:00.000', N'2016-05-07 00:00:00.000', N'2016-04-13 00:00:00.000', 1,
        1.2100, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', null, N'12209', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11012, N'FRANK', 1, N'2016-04-09 13:00:00.000', N'2016-04-23 00:00:00.000', N'2016-04-17 00:00:00.000', 3,
        242.9500, N'Frankenversand', N'Berliner Platz 43', N'München', null, N'80805', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11013, N'ROMEY', 2, N'2016-04-09 13:00:00.000', N'2016-05-07 00:00:00.000', N'2016-04-10 00:00:00.000', 1,
        32.9900, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', null, N'28001', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11014, N'LINOD', 2, N'2016-04-10 06:00:00.000', N'2016-05-08 00:00:00.000', N'2016-04-15 00:00:00.000', 3,
        23.6000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11015, N'SANTG', 2, N'2016-04-10 06:00:00.000', N'2016-04-24 00:00:00.000', N'2016-04-20 00:00:00.000', 2,
        4.6200, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', null, N'4110', N'Norway');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11016, N'AROUT', 9, N'2016-04-10 03:00:00.000', N'2016-05-08 00:00:00.000', N'2016-04-13 00:00:00.000', 2,
        33.8000, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11017, N'ERNSH', 9, N'2016-04-13 12:00:00.000', N'2016-05-11 00:00:00.000', N'2016-04-20 00:00:00.000', 2,
        754.2600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11018, N'LONEP', 4, N'2016-04-13 13:00:00.000', N'2016-05-11 00:00:00.000', N'2016-04-16 00:00:00.000', 2,
        11.6500, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11019, N'RANCH', 6, N'2016-04-13 09:00:00.000', N'2016-05-11 00:00:00.000', null, 3, 3.1700, N'Rancho grande',
        N'Av. del Libertador 900', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11020, N'OTTIK', 2, N'2016-04-14 15:00:00.000', N'2016-05-12 00:00:00.000', N'2016-04-16 00:00:00.000', 2,
        43.3000, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', null, N'50739', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11021, N'QUICK', 3, N'2016-04-14 01:00:00.000', N'2016-05-12 00:00:00.000', N'2016-04-21 00:00:00.000', 1,
        297.1800, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', null, N'01307', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11022, N'HANAR', 9, N'2016-04-14 02:00:00.000', N'2016-05-12 00:00:00.000', N'2016-05-04 00:00:00.000', 2,
        6.2700, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11023, N'BSBEV', 1, N'2016-04-14 15:00:00.000', N'2016-04-28 00:00:00.000', N'2016-04-24 00:00:00.000', 2,
        123.8300, N'B''s Beverages', N'Fauntleroy Circus', N'London', null, N'EC2 5NT', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11024, N'EASTC', 4, N'2016-04-15 20:00:00.000', N'2016-05-13 00:00:00.000', N'2016-04-20 00:00:00.000', 1,
        74.3600, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11025, N'WARTH', 6, N'2016-04-15 13:00:00.000', N'2016-05-13 00:00:00.000', N'2016-04-24 00:00:00.000', 3,
        29.1700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', null, N'90110', N'Finland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11026, N'FRANS', 4, N'2016-04-15 00:00:00.000', N'2016-05-13 00:00:00.000', N'2016-04-28 00:00:00.000', 1,
        47.0900, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', null, N'10100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11027, N'BOTTM', 1, N'2016-04-16 09:00:00.000', N'2016-05-14 00:00:00.000', N'2016-04-20 00:00:00.000', 1,
        52.5200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11028, N'KOENE', 2, N'2016-04-16 10:00:00.000', N'2016-05-14 00:00:00.000', N'2016-04-22 00:00:00.000', 1,
        29.5900, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', null, N'14776', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11029, N'CHOPS', 4, N'2016-04-16 20:00:00.000', N'2016-05-14 00:00:00.000', N'2016-04-27 00:00:00.000', 1,
        47.8400, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11030, N'SAVEA', 7, N'2016-04-17 15:00:00.000', N'2016-05-15 00:00:00.000', N'2016-04-27 00:00:00.000', 2,
        830.7500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11031, N'SAVEA', 6, N'2016-04-17 15:00:00.000', N'2016-05-15 00:00:00.000', N'2016-04-24 00:00:00.000', 2,
        227.2200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11032, N'WHITC', 2, N'2016-04-17 19:00:00.000', N'2016-05-15 00:00:00.000', N'2016-04-23 00:00:00.000', 3,
        606.1900, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11033, N'RICSU', 7, N'2016-04-17 02:00:00.000', N'2016-05-15 00:00:00.000', N'2016-04-23 00:00:00.000', 3,
        84.7400, N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11034, N'OLDWO', 8, N'2016-04-20 05:00:00.000', N'2016-06-01 00:00:00.000', N'2016-04-27 00:00:00.000', 1,
        40.3200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11035, N'SUPRD', 2, N'2016-04-20 15:00:00.000', N'2016-05-18 00:00:00.000', N'2016-04-24 00:00:00.000', 2,
        0.1700, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11036, N'DRACD', 8, N'2016-04-20 19:00:00.000', N'2016-05-18 00:00:00.000', N'2016-04-22 00:00:00.000', 3,
        149.4700, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', null, N'52066', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11037, N'GODOS', 7, N'2016-04-21 12:00:00.000', N'2016-05-19 00:00:00.000', N'2016-04-27 00:00:00.000', 1,
        3.2000, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', null, N'41101', N'Spain');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11038, N'SUPRD', 1, N'2016-04-21 18:00:00.000', N'2016-05-19 00:00:00.000', N'2016-04-30 00:00:00.000', 2,
        29.5900, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', null, N'B-6000', N'Belgium');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11039, N'LINOD', 1, N'2016-04-21 11:00:00.000', N'2016-05-19 00:00:00.000', null, 2, 65.0000,
        N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11040, N'GREAL', 4, N'2016-04-22 13:00:00.000', N'2016-05-20 00:00:00.000', null, 3, 18.8400,
        N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11041, N'CHOPS', 3, N'2016-04-22 04:00:00.000', N'2016-05-20 00:00:00.000', N'2016-04-28 00:00:00.000', 2,
        48.2200, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', null, N'3012', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11042, N'COMMI', 2, N'2016-04-22 09:00:00.000', N'2016-05-06 00:00:00.000', N'2016-05-01 00:00:00.000', 1,
        29.9900, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11043, N'SPECD', 5, N'2016-04-22 17:00:00.000', N'2016-05-20 00:00:00.000', N'2016-04-29 00:00:00.000', 2,
        8.8000, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', null, N'75016', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11044, N'WOLZA', 4, N'2016-04-23 19:00:00.000', N'2016-05-21 00:00:00.000', N'2016-05-01 00:00:00.000', 1,
        8.7200, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', null, N'01-012', N'Poland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11045, N'BOTTM', 6, N'2016-04-23 21:00:00.000', N'2016-05-21 00:00:00.000', null, 2, 70.5800,
        N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11046, N'WANDK', 8, N'2016-04-23 19:00:00.000', N'2016-05-21 00:00:00.000', N'2016-04-24 00:00:00.000', 2,
        71.6400, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', null, N'70563', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11047, N'EASTC', 7, N'2016-04-24 20:00:00.000', N'2016-05-22 00:00:00.000', N'2016-05-01 00:00:00.000', 3,
        46.6200, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11048, N'BOTTM', 7, N'2016-04-24 13:00:00.000', N'2016-05-22 00:00:00.000', N'2016-04-30 00:00:00.000', 3,
        24.1200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11049, N'GOURL', 3, N'2016-04-24 22:00:00.000', N'2016-05-22 00:00:00.000', N'2016-05-04 00:00:00.000', 1,
        8.3400, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11050, N'FOLKO', 8, N'2016-04-27 03:00:00.000', N'2016-05-25 00:00:00.000', N'2016-05-05 00:00:00.000', 2,
        59.4100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', null, N'S-844 67', N'Sweden');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11051, N'LAMAI', 7, N'2016-04-27 20:00:00.000', N'2016-05-25 00:00:00.000', null, 3, 2.7900,
        N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', null, N'31000', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11052, N'HANAR', 3, N'2016-04-27 02:00:00.000', N'2016-05-25 00:00:00.000', N'2016-05-01 00:00:00.000', 1,
        67.2600, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11053, N'PICCO', 2, N'2016-04-27 06:00:00.000', N'2016-05-25 00:00:00.000', N'2016-04-29 00:00:00.000', 2,
        53.0500, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', null, N'5020', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11054, N'CACTU', 8, N'2016-04-28 13:00:00.000', N'2016-05-26 00:00:00.000', null, 1, 0.3300,
        N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', null, N'1010', N'Argentina');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11055, N'HILAA', 7, N'2016-04-28 01:00:00.000', N'2016-05-26 00:00:00.000', N'2016-05-05 00:00:00.000', 2,
        120.9200, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira',
        N'5022', N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11056, N'EASTC', 8, N'2016-04-28 15:00:00.000', N'2016-05-12 00:00:00.000', N'2016-05-01 00:00:00.000', 2,
        278.9600, N'Eastern Connection', N'35 King George', N'London', null, N'WX3 6FW', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11057, N'NORTS', 3, N'2016-04-29 20:00:00.000', N'2016-05-27 00:00:00.000', N'2016-05-01 00:00:00.000', 3,
        4.1300, N'North/South', N'South House 300 Queensbridge', N'London', null, N'SW7 1RZ', N'UK');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11058, N'BLAUS', 9, N'2016-04-29 04:00:00.000', N'2016-05-27 00:00:00.000', null, 3, 31.1400,
        N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', null, N'68306', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11059, N'RICAR', 2, N'2016-04-29 05:00:00.000', N'2016-06-10 00:00:00.000', null, 2, 85.8000,
        N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11060, N'FRANS', 2, N'2016-04-30 00:00:00.000', N'2016-05-28 00:00:00.000', N'2016-05-04 00:00:00.000', 2,
        10.9800, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', null, N'10100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11061, N'GREAL', 4, N'2016-04-30 00:00:00.000', N'2016-06-11 00:00:00.000', null, 3, 14.0100,
        N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11062, N'REGGC', 4, N'2016-04-30 00:00:00.000', N'2016-05-28 00:00:00.000', null, 2, 29.9300,
        N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', null, N'42100', N'Italy');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11063, N'HUNGO', 3, N'2016-04-30 00:00:00.000', N'2016-05-28 00:00:00.000', N'2016-05-06 00:00:00.000', 2,
        81.7300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', null, N'Ireland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11064, N'SAVEA', 1, N'2016-05-01 01:00:00.000', N'2016-05-29 00:00:00.000', N'2016-05-04 00:00:00.000', 1,
        30.0900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11065, N'LILAS', 8, N'2016-05-01 15:00:00.000', N'2016-05-29 00:00:00.000', null, 1, 12.9100,
        N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11066, N'WHITC', 7, N'2016-05-01 12:00:00.000', N'2016-05-29 00:00:00.000', N'2016-05-04 00:00:00.000', 2,
        44.7200, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11067, N'DRACD', 1, N'2016-05-04 21:00:00.000', N'2016-05-18 00:00:00.000', N'2016-05-06 00:00:00.000', 2,
        7.9800, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', null, N'52066', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11068, N'QUEEN', 8, N'2016-05-04 16:00:00.000', N'2016-06-01 00:00:00.000', null, 2, 81.7500, N'Queen Cozinha',
        N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11069, N'TORTU', 1, N'2016-05-04 12:00:00.000', N'2016-06-01 00:00:00.000', N'2016-05-06 00:00:00.000', 2,
        15.6700, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11070, N'LEHMS', 2, N'2016-05-05 08:00:00.000', N'2016-06-02 00:00:00.000', null, 1, 136.0000,
        N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', null, N'60528', N'Germany');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11071, N'LILAS', 1, N'2016-05-05 05:00:00.000', N'2016-06-02 00:00:00.000', null, 1, 0.9300,
        N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508',
        N'Venezuela');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11072, N'ERNSH', 4, N'2016-05-05 15:00:00.000', N'2016-06-02 00:00:00.000', null, 2, 258.6400, N'Ernst Handel',
        N'Kirchgasse 6', N'Graz', null, N'8010', N'Austria');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11073, N'PERIC', 2, N'2016-05-05 12:00:00.000', N'2016-06-02 00:00:00.000', null, 2, 24.9500,
        N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', null, N'05033', N'Mexico');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11074, N'SIMOB', 7, N'2016-05-06 01:00:00.000', N'2016-06-03 00:00:00.000', null, 2, 18.4400, N'Simons bistro',
        N'Vinbæltet 34', N'Kobenhavn', null, N'1734', N'Denmark');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11075, N'RICSU', 8, N'2016-05-06 18:00:00.000', N'2016-06-03 00:00:00.000', null, 2, 6.1900,
        N'Richter Supermarkt', N'Starenweg 5', N'Genève', null, N'1204', N'Switzerland');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11076, N'BONAP', 4, N'2016-05-06 00:00:00.000', N'2016-06-03 00:00:00.000', null, 2, 38.2800, N'Bon app''',
        N'12, rue des Bouchers', N'Marseille', null, N'13008', N'France');
INSERT INTO `order` (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight,
                     ship_name,
                     ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (11077, N'RATTC', 1, N'2016-05-06 17:00:00.000', N'2016-06-03 00:00:00.000', null, 2, 8.5300,
        N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');

INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10248, 11, 14.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10248, 42, 9.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10248, 72, 34.8000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10249, 14, 18.6000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10249, 51, 42.4000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10250, 41, 7.7000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10250, 51, 42.4000, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10250, 65, 16.8000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10251, 22, 16.8000, 6, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10251, 57, 15.6000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10251, 65, 16.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10252, 20, 64.8000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10252, 33, 2.0000, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10252, 60, 27.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10253, 31, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10253, 39, 14.4000, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10253, 49, 16.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10254, 24, 3.6000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10254, 55, 19.2000, 21, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10254, 74, 8.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10255, 2, 15.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10255, 16, 13.9000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10255, 36, 15.2000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10255, 59, 44.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10256, 53, 26.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10256, 77, 10.4000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10257, 27, 35.1000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10257, 39, 14.4000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10257, 77, 10.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10258, 2, 15.2000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10258, 5, 17.0000, 65, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10258, 32, 25.6000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10259, 21, 8.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10259, 37, 20.8000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10260, 41, 7.7000, 16, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10260, 57, 15.6000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10260, 62, 39.4000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10260, 70, 12.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10261, 21, 8.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10261, 35, 14.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10262, 5, 17.0000, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10262, 7, 24.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10262, 56, 30.4000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10263, 16, 13.9000, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10263, 24, 3.6000, 65, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10263, 30, 20.7000, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10263, 74, 8.0000, 65, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10264, 2, 15.2000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10264, 41, 7.7000, 25, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10265, 17, 31.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10265, 70, 12.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10266, 12, 30.4000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10267, 40, 14.7000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10267, 59, 44.0000, 70, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10267, 76, 14.4000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10268, 29, 99.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10268, 72, 27.8000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10269, 33, 2.0000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10269, 72, 27.8000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10270, 36, 15.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10270, 43, 36.8000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10271, 33, 2.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10272, 20, 64.8000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10272, 31, 10.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10272, 72, 27.8000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10273, 10, 24.8000, 24, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10273, 31, 10.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10273, 33, 2.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10273, 40, 14.7000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10273, 76, 14.4000, 33, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10274, 71, 17.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10274, 72, 27.8000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10275, 24, 3.6000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10275, 59, 44.0000, 6, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10276, 10, 24.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10276, 13, 4.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10277, 28, 36.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10277, 62, 39.4000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10278, 44, 15.5000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10278, 59, 44.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10278, 63, 35.1000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10278, 73, 12.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10279, 17, 31.2000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10280, 24, 3.6000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10280, 55, 19.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10280, 75, 6.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10281, 19, 7.3000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10281, 24, 3.6000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10281, 35, 14.4000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10282, 30, 20.7000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10282, 57, 15.6000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10283, 15, 12.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10283, 19, 7.3000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10283, 60, 27.2000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10283, 72, 27.8000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10284, 27, 35.1000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10284, 44, 15.5000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10284, 60, 27.2000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10284, 67, 11.2000, 5, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10285, 1, 14.4000, 45, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10285, 40, 14.7000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10285, 53, 26.2000, 36, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10286, 35, 14.4000, 100, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10286, 62, 39.4000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10287, 16, 13.9000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10287, 34, 11.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10287, 46, 9.6000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10288, 54, 5.9000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10288, 68, 10.0000, 3, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10289, 3, 8.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10289, 64, 26.6000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10290, 5, 17.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10290, 29, 99.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10290, 49, 16.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10290, 77, 10.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10291, 13, 4.8000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10291, 44, 15.5000, 24, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10291, 51, 42.4000, 2, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10292, 20, 64.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10293, 18, 50.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10293, 24, 3.6000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10293, 63, 35.1000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10293, 75, 6.2000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10294, 1, 14.4000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10294, 17, 31.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10294, 43, 36.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10294, 60, 27.2000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10294, 75, 6.2000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10295, 56, 30.4000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10296, 11, 16.8000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10296, 16, 13.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10296, 69, 28.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10297, 39, 14.4000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10297, 72, 27.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10298, 2, 15.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10298, 36, 15.2000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10298, 59, 44.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10298, 62, 39.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10299, 19, 7.3000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10299, 70, 12.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10300, 66, 13.6000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10300, 68, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10301, 40, 14.7000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10301, 56, 30.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10302, 17, 31.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10302, 28, 36.4000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10302, 43, 36.8000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10303, 40, 14.7000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10303, 65, 16.8000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10303, 68, 10.0000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10304, 49, 16.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10304, 59, 44.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10304, 71, 17.2000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10305, 18, 50.0000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10305, 29, 99.0000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10305, 39, 14.4000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10306, 30, 20.7000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10306, 53, 26.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10306, 54, 5.9000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10307, 62, 39.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10307, 68, 10.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10308, 69, 28.8000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10308, 70, 12.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10309, 4, 17.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10309, 6, 20.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10309, 42, 11.2000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10309, 43, 36.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10309, 71, 17.2000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10310, 16, 13.9000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10310, 62, 39.4000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10311, 42, 11.2000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10311, 69, 28.8000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10312, 28, 36.4000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10312, 43, 36.8000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10312, 53, 26.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10312, 75, 6.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10313, 36, 15.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10314, 32, 25.6000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10314, 58, 10.6000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10314, 62, 39.4000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10315, 34, 11.2000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10315, 70, 12.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10316, 41, 7.7000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10316, 62, 39.4000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10317, 1, 14.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10318, 41, 7.7000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10318, 76, 14.4000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10319, 17, 31.2000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10319, 28, 36.4000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10319, 76, 14.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10320, 71, 17.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10321, 35, 14.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10322, 52, 5.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10323, 15, 12.4000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10323, 25, 11.2000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10323, 39, 14.4000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10324, 16, 13.9000, 21, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10324, 35, 14.4000, 70, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10324, 46, 9.6000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10324, 59, 44.0000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10324, 63, 35.1000, 80, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10325, 6, 20.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10325, 13, 4.8000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10325, 14, 18.6000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10325, 31, 10.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10325, 72, 27.8000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10326, 4, 17.6000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10326, 57, 15.6000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10326, 75, 6.2000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10327, 2, 15.2000, 25, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10327, 11, 16.8000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10327, 30, 20.7000, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10327, 58, 10.6000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10328, 59, 44.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10328, 65, 16.8000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10328, 68, 10.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10329, 19, 7.3000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10329, 30, 20.7000, 8, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10329, 38, 210.8000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10329, 56, 30.4000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10330, 26, 24.9000, 50, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10330, 72, 27.8000, 25, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10331, 54, 5.9000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10332, 18, 50.0000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10332, 42, 11.2000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10332, 47, 7.6000, 16, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10333, 14, 18.6000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10333, 21, 8.0000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10333, 71, 17.2000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10334, 52, 5.6000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10334, 68, 10.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10335, 2, 15.2000, 7, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10335, 31, 10.0000, 25, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10335, 32, 25.6000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10335, 51, 42.4000, 48, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10336, 4, 17.6000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10337, 23, 7.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10337, 26, 24.9000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10337, 36, 15.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10337, 37, 20.8000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10337, 72, 27.8000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10338, 17, 31.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10338, 30, 20.7000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10339, 4, 17.6000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10339, 17, 31.2000, 70, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10339, 62, 39.4000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10340, 18, 50.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10340, 41, 7.7000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10340, 43, 36.8000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10341, 33, 2.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10341, 59, 44.0000, 9, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10342, 2, 15.2000, 24, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10342, 31, 10.0000, 56, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10342, 36, 15.2000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10342, 55, 19.2000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10343, 64, 26.6000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10343, 68, 10.0000, 4, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10343, 76, 14.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10344, 4, 17.6000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10344, 8, 32.0000, 70, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10345, 8, 32.0000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10345, 19, 7.3000, 80, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10345, 42, 11.2000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10346, 17, 31.2000, 36, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10346, 56, 30.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10347, 25, 11.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10347, 39, 14.4000, 50, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10347, 40, 14.7000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10347, 75, 6.2000, 6, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10348, 1, 14.4000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10348, 23, 7.2000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10349, 54, 5.9000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10350, 50, 13.0000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10350, 69, 28.8000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10351, 38, 210.8000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10351, 41, 7.7000, 13, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10351, 44, 15.5000, 77, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10351, 65, 16.8000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10352, 24, 3.6000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10352, 54, 5.9000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10353, 11, 16.8000, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10353, 38, 210.8000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10354, 1, 14.4000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10354, 29, 99.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10355, 24, 3.6000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10355, 57, 15.6000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10356, 31, 10.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10356, 55, 19.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10356, 69, 28.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10357, 10, 24.8000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10357, 26, 24.9000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10357, 60, 27.2000, 8, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10358, 24, 3.6000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10358, 34, 11.2000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10358, 36, 15.2000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10359, 16, 13.9000, 56, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10359, 31, 10.0000, 70, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10359, 60, 27.2000, 80, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10360, 28, 36.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10360, 29, 99.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10360, 38, 210.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10360, 49, 16.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10360, 54, 5.9000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10361, 39, 14.4000, 54, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10361, 60, 27.2000, 55, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10362, 25, 11.2000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10362, 51, 42.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10362, 54, 5.9000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10363, 31, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10363, 75, 6.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10363, 76, 14.4000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10364, 69, 28.8000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10364, 71, 17.2000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10365, 11, 16.8000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10366, 65, 16.8000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10366, 77, 10.4000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10367, 34, 11.2000, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10367, 54, 5.9000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10367, 65, 16.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10367, 77, 10.4000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10368, 21, 8.0000, 5, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10368, 28, 36.4000, 13, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10368, 57, 15.6000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10368, 64, 26.6000, 35, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10369, 29, 99.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10369, 56, 30.4000, 18, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10370, 1, 14.4000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10370, 64, 26.6000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10370, 74, 8.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10371, 36, 15.2000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10372, 20, 64.8000, 12, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10372, 38, 210.8000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10372, 60, 27.2000, 70, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10372, 72, 27.8000, 42, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10373, 58, 10.6000, 80, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10373, 71, 17.2000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10374, 31, 10.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10374, 58, 10.6000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10375, 14, 18.6000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10375, 54, 5.9000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10376, 31, 10.0000, 42, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10377, 28, 36.4000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10377, 39, 14.4000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10378, 71, 17.2000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10379, 41, 7.7000, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10379, 63, 35.1000, 16, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10379, 65, 16.8000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10380, 30, 20.7000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10380, 53, 26.2000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10380, 60, 27.2000, 6, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10380, 70, 12.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10381, 74, 8.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10382, 5, 17.0000, 32, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10382, 18, 50.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10382, 29, 99.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10382, 33, 2.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10382, 74, 8.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10383, 13, 4.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10383, 50, 13.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10383, 56, 30.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10384, 20, 64.8000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10384, 60, 27.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10385, 7, 24.0000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10385, 60, 27.2000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10385, 68, 10.0000, 8, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10386, 24, 3.6000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10386, 34, 11.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10387, 24, 3.6000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10387, 28, 36.4000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10387, 59, 44.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10387, 71, 17.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10388, 45, 7.6000, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10388, 52, 5.6000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10388, 53, 26.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10389, 10, 24.8000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10389, 55, 19.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10389, 62, 39.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10389, 70, 12.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10390, 31, 10.0000, 60, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10390, 35, 14.4000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10390, 46, 9.6000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10390, 72, 27.8000, 24, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10391, 13, 4.8000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10392, 69, 28.8000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10393, 2, 15.2000, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10393, 14, 18.6000, 42, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10393, 25, 11.2000, 7, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10393, 26, 24.9000, 70, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10393, 31, 10.0000, 32, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10394, 13, 4.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10394, 62, 39.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10395, 46, 9.6000, 28, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10395, 53, 26.2000, 70, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10395, 69, 28.8000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10396, 23, 7.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10396, 71, 17.2000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10396, 72, 27.8000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10397, 21, 8.0000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10397, 51, 42.4000, 18, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10398, 35, 14.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10398, 55, 19.2000, 120, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10399, 68, 10.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10399, 71, 17.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10399, 76, 14.4000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10399, 77, 10.4000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10400, 29, 99.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10400, 35, 14.4000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10400, 49, 16.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10401, 30, 20.7000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10401, 56, 30.4000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10401, 65, 16.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10401, 71, 17.2000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10402, 23, 7.2000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10402, 63, 35.1000, 65, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10403, 16, 13.9000, 21, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10403, 48, 10.2000, 70, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10404, 26, 24.9000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10404, 42, 11.2000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10404, 49, 16.0000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10405, 3, 8.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10406, 1, 14.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10406, 21, 8.0000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10406, 28, 36.4000, 42, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10406, 36, 15.2000, 5, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10406, 40, 14.7000, 2, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10407, 11, 16.8000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10407, 69, 28.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10407, 71, 17.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10408, 37, 20.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10408, 54, 5.9000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10408, 62, 39.4000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10409, 14, 18.6000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10409, 21, 8.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10410, 33, 2.0000, 49, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10410, 59, 44.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10411, 41, 7.7000, 25, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10411, 44, 15.5000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10411, 59, 44.0000, 9, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10412, 14, 18.6000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10413, 1, 14.4000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10413, 62, 39.4000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10413, 76, 14.4000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10414, 19, 7.3000, 18, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10414, 33, 2.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10415, 17, 31.2000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10415, 33, 2.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10416, 19, 7.3000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10416, 53, 26.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10416, 57, 15.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10417, 38, 210.8000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10417, 46, 9.6000, 2, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10417, 68, 10.0000, 36, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10417, 77, 10.4000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10418, 2, 15.2000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10418, 47, 7.6000, 55, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10418, 61, 22.8000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10418, 74, 8.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10419, 60, 27.2000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10419, 69, 28.8000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10420, 9, 77.6000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10420, 13, 4.8000, 2, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10420, 70, 12.0000, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10420, 73, 12.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10421, 19, 7.3000, 4, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10421, 26, 24.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10421, 53, 26.2000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10421, 77, 10.4000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10422, 26, 24.9000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10423, 31, 10.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10423, 59, 44.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10424, 35, 14.4000, 60, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10424, 38, 210.8000, 49, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10424, 68, 10.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10425, 55, 19.2000, 10, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10425, 76, 14.4000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10426, 56, 30.4000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10426, 64, 26.6000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10427, 14, 18.6000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10428, 46, 9.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10429, 50, 13.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10429, 63, 35.1000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10430, 17, 31.2000, 45, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10430, 21, 8.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10430, 56, 30.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10430, 59, 44.0000, 70, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10431, 17, 31.2000, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10431, 40, 14.7000, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10431, 47, 7.6000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10432, 26, 24.9000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10432, 54, 5.9000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10433, 56, 30.4000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10434, 11, 16.8000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10434, 76, 14.4000, 18, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10435, 2, 15.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10435, 22, 16.8000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10435, 72, 27.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10436, 46, 9.6000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10436, 56, 30.4000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10436, 64, 26.6000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10436, 75, 6.2000, 24, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10437, 53, 26.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10438, 19, 7.3000, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10438, 34, 11.2000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10438, 57, 15.6000, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10439, 12, 30.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10439, 16, 13.9000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10439, 64, 26.6000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10439, 74, 8.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10440, 2, 15.2000, 45, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10440, 16, 13.9000, 49, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10440, 29, 99.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10440, 61, 22.8000, 90, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10441, 27, 35.1000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10442, 11, 16.8000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10442, 54, 5.9000, 80, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10442, 66, 13.6000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10443, 11, 16.8000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10443, 28, 36.4000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10444, 17, 31.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10444, 26, 24.9000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10444, 35, 14.4000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10444, 41, 7.7000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10445, 39, 14.4000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10445, 54, 5.9000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10446, 19, 7.3000, 12, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10446, 24, 3.6000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10446, 31, 10.0000, 3, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10446, 52, 5.6000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10447, 19, 7.3000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10447, 65, 16.8000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10447, 71, 17.2000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10448, 26, 24.9000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10448, 40, 14.7000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10449, 10, 24.8000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10449, 52, 5.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10449, 62, 39.4000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10450, 10, 24.8000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10450, 54, 5.9000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10451, 55, 19.2000, 120, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10451, 64, 26.6000, 35, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10451, 65, 16.8000, 28, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10451, 77, 10.4000, 55, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10452, 28, 36.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10452, 44, 15.5000, 100, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10453, 48, 10.2000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10453, 70, 12.0000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10454, 16, 13.9000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10454, 33, 2.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10454, 46, 9.6000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10455, 39, 14.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10455, 53, 26.2000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10455, 61, 22.8000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10455, 71, 17.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10456, 21, 8.0000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10456, 49, 16.0000, 21, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10457, 59, 44.0000, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10458, 26, 24.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10458, 28, 36.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10458, 43, 36.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10458, 56, 30.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10458, 71, 17.2000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10459, 7, 24.0000, 16, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10459, 46, 9.6000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10459, 72, 27.8000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10460, 68, 10.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10460, 75, 6.2000, 4, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10461, 21, 8.0000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10461, 30, 20.7000, 28, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10461, 55, 19.2000, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10462, 13, 4.8000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10462, 23, 7.2000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10463, 19, 7.3000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10463, 42, 11.2000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10464, 4, 17.6000, 16, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10464, 43, 36.8000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10464, 56, 30.4000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10464, 60, 27.2000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10465, 24, 3.6000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10465, 29, 99.0000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10465, 40, 14.7000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10465, 45, 7.6000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10465, 50, 13.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10466, 11, 16.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10466, 46, 9.6000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10467, 24, 3.6000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10467, 25, 11.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10468, 30, 20.7000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10468, 43, 36.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10469, 2, 15.2000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10469, 16, 13.9000, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10469, 44, 15.5000, 2, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10470, 18, 50.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10470, 23, 7.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10470, 64, 26.6000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10471, 7, 24.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10471, 56, 30.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10472, 24, 3.6000, 80, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10472, 51, 42.4000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10473, 33, 2.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10473, 71, 17.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10474, 14, 18.6000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10474, 28, 36.4000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10474, 40, 14.7000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10474, 75, 6.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10475, 31, 10.0000, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10475, 66, 13.6000, 60, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10475, 76, 14.4000, 42, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10476, 55, 19.2000, 2, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10476, 70, 12.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10477, 1, 14.4000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10477, 21, 8.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10477, 39, 14.4000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10478, 10, 24.8000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10479, 38, 210.8000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10479, 53, 26.2000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10479, 59, 44.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10479, 64, 26.6000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10480, 47, 7.6000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10480, 59, 44.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10481, 49, 16.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10481, 60, 27.2000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10482, 40, 14.7000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10483, 34, 11.2000, 35, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10483, 77, 10.4000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10484, 21, 8.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10484, 40, 14.7000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10484, 51, 42.4000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10485, 2, 15.2000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10485, 3, 8.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10485, 55, 19.2000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10485, 70, 12.0000, 60, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10486, 11, 16.8000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10486, 51, 42.4000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10486, 74, 8.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10487, 19, 7.3000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10487, 26, 24.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10487, 54, 5.9000, 24, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10488, 59, 44.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10488, 73, 12.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10489, 11, 16.8000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10489, 16, 13.9000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10490, 59, 44.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10490, 68, 10.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10490, 75, 6.2000, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10491, 44, 15.5000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10491, 77, 10.4000, 7, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10492, 25, 11.2000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10492, 42, 11.2000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10493, 65, 16.8000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10493, 66, 13.6000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10493, 69, 28.8000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10494, 56, 30.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10495, 23, 7.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10495, 41, 7.7000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10495, 77, 10.4000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10496, 31, 10.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10497, 56, 30.4000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10497, 72, 27.8000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10497, 77, 10.4000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10498, 24, 4.5000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10498, 40, 18.4000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10498, 42, 14.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10499, 28, 45.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10499, 49, 20.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10500, 15, 15.5000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10500, 28, 45.6000, 8, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10501, 54, 7.4500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10502, 45, 9.5000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10502, 53, 32.8000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10502, 67, 14.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10503, 14, 23.2500, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10503, 65, 21.0500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10504, 2, 19.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10504, 21, 10.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10504, 53, 32.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10504, 61, 28.5000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10505, 62, 49.3000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10506, 25, 14.0000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10506, 70, 15.0000, 14, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10507, 43, 46.0000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10507, 48, 12.7500, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10508, 13, 6.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10508, 39, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10509, 28, 45.6000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10510, 29, 123.7900, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10510, 75, 7.7500, 36, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10511, 4, 22.0000, 50, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10511, 7, 30.0000, 50, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10511, 8, 40.0000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10512, 24, 4.5000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10512, 46, 12.0000, 9, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10512, 47, 9.5000, 6, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10512, 60, 34.0000, 12, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10513, 21, 10.0000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10513, 32, 32.0000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10513, 61, 28.5000, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10514, 20, 81.0000, 39, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10514, 28, 45.6000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10514, 56, 38.0000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10514, 65, 21.0500, 39, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10514, 75, 7.7500, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10515, 9, 97.0000, 16, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10515, 16, 17.4500, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10515, 27, 43.9000, 120, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10515, 33, 2.5000, 16, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10515, 60, 34.0000, 84, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10516, 18, 62.5000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10516, 41, 9.6500, 80, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10516, 42, 14.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10517, 52, 7.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10517, 59, 55.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10517, 70, 15.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10518, 24, 4.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10518, 38, 263.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10518, 44, 19.4500, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10519, 10, 31.0000, 16, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10519, 56, 38.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10519, 60, 34.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10520, 24, 4.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10520, 53, 32.8000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10521, 35, 18.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10521, 41, 9.6500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10521, 68, 12.5000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10522, 1, 18.0000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10522, 8, 40.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10522, 30, 25.8900, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10522, 40, 18.4000, 25, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10523, 17, 39.0000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10523, 20, 81.0000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10523, 37, 26.0000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10523, 41, 9.6500, 6, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10524, 10, 31.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10524, 30, 25.8900, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10524, 43, 46.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10524, 54, 7.4500, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10525, 36, 19.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10525, 40, 18.4000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10526, 1, 18.0000, 8, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10526, 13, 6.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10526, 56, 38.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10527, 4, 22.0000, 50, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10527, 36, 19.0000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10528, 11, 21.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10528, 33, 2.5000, 8, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10528, 72, 34.8000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10529, 55, 24.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10529, 68, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10529, 69, 36.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10530, 17, 39.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10530, 43, 46.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10530, 61, 28.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10530, 76, 18.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10531, 59, 55.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10532, 30, 25.8900, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10532, 66, 17.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10533, 4, 22.0000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10533, 72, 34.8000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10533, 73, 15.0000, 24, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10534, 30, 25.8900, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10534, 40, 18.4000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10534, 54, 7.4500, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10535, 11, 21.0000, 50, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10535, 40, 18.4000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10535, 57, 19.5000, 5, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10535, 59, 55.0000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10536, 12, 38.0000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10536, 31, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10536, 33, 2.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10536, 60, 34.0000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10537, 31, 12.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10537, 51, 53.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10537, 58, 13.2500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10537, 72, 34.8000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10537, 73, 15.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10538, 70, 15.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10538, 72, 34.8000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10539, 13, 6.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10539, 21, 10.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10539, 33, 2.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10539, 49, 20.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10540, 3, 10.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10540, 26, 31.2300, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10540, 38, 263.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10540, 68, 12.5000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10541, 24, 4.5000, 35, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10541, 38, 263.5000, 4, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10541, 65, 21.0500, 36, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10541, 71, 21.5000, 9, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10542, 11, 21.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10542, 54, 7.4500, 24, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10543, 12, 38.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10543, 23, 9.0000, 70, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10544, 28, 45.6000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10544, 67, 14.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10545, 11, 21.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10546, 7, 30.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10546, 35, 18.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10546, 62, 49.3000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10547, 32, 32.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10547, 36, 19.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10548, 34, 14.0000, 10, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10548, 41, 9.6500, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10549, 31, 12.5000, 55, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10549, 45, 9.5000, 100, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10549, 51, 53.0000, 48, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10550, 17, 39.0000, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10550, 19, 9.2000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10550, 21, 10.0000, 6, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10550, 61, 28.5000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10551, 16, 17.4500, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10551, 35, 18.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10551, 44, 19.4500, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10552, 69, 36.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10552, 75, 7.7500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10553, 11, 21.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10553, 16, 17.4500, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10553, 22, 21.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10553, 31, 12.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10553, 35, 18.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10554, 16, 17.4500, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10554, 23, 9.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10554, 62, 49.3000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10554, 77, 13.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10555, 14, 23.2500, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10555, 19, 9.2000, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10555, 24, 4.5000, 18, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10555, 51, 53.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10555, 56, 38.0000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10556, 72, 34.8000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10557, 64, 33.2500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10557, 75, 7.7500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10558, 47, 9.5000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10558, 51, 53.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10558, 52, 7.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10558, 53, 32.8000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10558, 73, 15.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10559, 41, 9.6500, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10559, 55, 24.0000, 18, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10560, 30, 25.8900, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10560, 62, 49.3000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10561, 44, 19.4500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10561, 51, 53.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10562, 33, 2.5000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10562, 62, 49.3000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10563, 36, 19.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10563, 52, 7.0000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10564, 17, 39.0000, 16, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10564, 31, 12.5000, 6, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10564, 55, 24.0000, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10565, 24, 4.5000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10565, 64, 33.2500, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10566, 11, 21.0000, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10566, 18, 62.5000, 18, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10566, 76, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10567, 31, 12.5000, 60, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10567, 51, 53.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10567, 59, 55.0000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10568, 10, 31.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10569, 31, 12.5000, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10569, 76, 18.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10570, 11, 21.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10570, 56, 38.0000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10571, 14, 23.2500, 11, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10571, 42, 14.0000, 28, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10572, 16, 17.4500, 12, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10572, 32, 32.0000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10572, 40, 18.4000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10572, 75, 7.7500, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10573, 17, 39.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10573, 34, 14.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10573, 53, 32.8000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10574, 33, 2.5000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10574, 40, 18.4000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10574, 62, 49.3000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10574, 64, 33.2500, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10575, 59, 55.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10575, 63, 43.9000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10575, 72, 34.8000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10575, 76, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10576, 1, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10576, 31, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10576, 44, 19.4500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10577, 39, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10577, 75, 7.7500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10577, 77, 13.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10578, 35, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10578, 57, 19.5000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10579, 15, 15.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10579, 75, 7.7500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10580, 14, 23.2500, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10580, 41, 9.6500, 9, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10580, 65, 21.0500, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10581, 75, 7.7500, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10582, 57, 19.5000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10582, 76, 18.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10583, 29, 123.7900, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10583, 60, 34.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10583, 69, 36.0000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10584, 31, 12.5000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10585, 47, 9.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10586, 52, 7.0000, 4, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10587, 26, 31.2300, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10587, 35, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10587, 77, 13.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10588, 18, 62.5000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10588, 42, 14.0000, 100, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10589, 35, 18.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10590, 1, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10590, 77, 13.0000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10591, 3, 10.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10591, 7, 30.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10591, 54, 7.4500, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10592, 15, 15.5000, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10592, 26, 31.2300, 5, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10593, 20, 81.0000, 21, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10593, 69, 36.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10593, 76, 18.0000, 4, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10594, 52, 7.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10594, 58, 13.2500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10595, 35, 18.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10595, 61, 28.5000, 120, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10595, 69, 36.0000, 65, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10596, 56, 38.0000, 5, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10596, 63, 43.9000, 24, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10596, 75, 7.7500, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10597, 24, 4.5000, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10597, 57, 19.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10597, 65, 21.0500, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10598, 27, 43.9000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10598, 71, 21.5000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10599, 62, 49.3000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10600, 54, 7.4500, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10600, 73, 15.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10601, 13, 6.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10601, 59, 55.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10602, 77, 13.0000, 5, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10603, 22, 21.0000, 48, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10603, 49, 20.0000, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10604, 48, 12.7500, 6, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10604, 76, 18.0000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10605, 16, 17.4500, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10605, 59, 55.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10605, 60, 34.0000, 70, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10605, 71, 21.5000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10606, 4, 22.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10606, 55, 24.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10606, 62, 49.3000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10607, 7, 30.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10607, 17, 39.0000, 100, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10607, 33, 2.5000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10607, 40, 18.4000, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10607, 72, 34.8000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10608, 56, 38.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10609, 1, 18.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10609, 10, 31.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10609, 21, 10.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10610, 36, 19.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10611, 1, 18.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10611, 2, 19.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10611, 60, 34.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10612, 10, 31.0000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10612, 36, 19.0000, 55, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10612, 49, 20.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10612, 60, 34.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10612, 76, 18.0000, 80, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10613, 13, 6.0000, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10613, 75, 7.7500, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10614, 11, 21.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10614, 21, 10.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10614, 39, 18.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10615, 55, 24.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10616, 38, 263.5000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10616, 56, 38.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10616, 70, 15.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10616, 71, 21.5000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10617, 59, 55.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10618, 6, 25.0000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10618, 56, 38.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10618, 68, 12.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10619, 21, 10.0000, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10619, 22, 21.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10620, 24, 4.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10620, 52, 7.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10621, 19, 9.2000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10621, 23, 9.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10621, 70, 15.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10621, 71, 21.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10622, 2, 19.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10622, 68, 12.5000, 18, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10623, 14, 23.2500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10623, 19, 9.2000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10623, 21, 10.0000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10623, 24, 4.5000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10623, 35, 18.0000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10624, 28, 45.6000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10624, 29, 123.7900, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10624, 44, 19.4500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10625, 14, 23.2500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10625, 42, 14.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10625, 60, 34.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10626, 53, 32.8000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10626, 60, 34.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10626, 71, 21.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10627, 62, 49.3000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10627, 73, 15.0000, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10628, 1, 18.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10629, 29, 123.7900, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10629, 64, 33.2500, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10630, 55, 24.0000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10630, 76, 18.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10631, 75, 7.7500, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10632, 2, 19.0000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10632, 33, 2.5000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10633, 12, 38.0000, 36, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10633, 13, 6.0000, 13, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10633, 26, 31.2300, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10633, 62, 49.3000, 80, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10634, 7, 30.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10634, 18, 62.5000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10634, 51, 53.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10634, 75, 7.7500, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10635, 4, 22.0000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10635, 5, 21.3500, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10635, 22, 21.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10636, 4, 22.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10636, 58, 13.2500, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10637, 11, 21.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10637, 50, 16.2500, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10637, 56, 38.0000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10638, 45, 9.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10638, 65, 21.0500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10638, 72, 34.8000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10639, 18, 62.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10640, 69, 36.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10640, 70, 15.0000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10641, 2, 19.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10641, 40, 18.4000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10642, 21, 10.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10642, 61, 28.5000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10643, 28, 45.6000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10643, 39, 18.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10643, 46, 12.0000, 2, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10644, 18, 62.5000, 4, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10644, 43, 46.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10644, 46, 12.0000, 21, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10645, 18, 62.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10645, 36, 19.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10646, 1, 18.0000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10646, 10, 31.0000, 18, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10646, 71, 21.5000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10646, 77, 13.0000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10647, 19, 9.2000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10647, 39, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10648, 22, 21.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10648, 24, 4.5000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10649, 28, 45.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10649, 72, 34.8000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10650, 30, 25.8900, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10650, 53, 32.8000, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10650, 54, 7.4500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10651, 19, 9.2000, 12, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10651, 22, 21.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10652, 30, 25.8900, 2, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10652, 42, 14.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10653, 16, 17.4500, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10653, 60, 34.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10654, 4, 22.0000, 12, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10654, 39, 18.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10654, 54, 7.4500, 6, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10655, 41, 9.6500, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10656, 14, 23.2500, 3, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10656, 44, 19.4500, 28, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10656, 47, 9.5000, 6, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10657, 15, 15.5000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10657, 41, 9.6500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10657, 46, 12.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10657, 47, 9.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10657, 56, 38.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10657, 60, 34.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10658, 21, 10.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10658, 40, 18.4000, 70, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10658, 60, 34.0000, 55, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10658, 77, 13.0000, 70, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10659, 31, 12.5000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10659, 40, 18.4000, 24, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10659, 70, 15.0000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10660, 20, 81.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10661, 39, 18.0000, 3, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10661, 58, 13.2500, 49, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10662, 68, 12.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10663, 40, 18.4000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10663, 42, 14.0000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10663, 51, 53.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10664, 10, 31.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10664, 56, 38.0000, 12, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10664, 65, 21.0500, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10665, 51, 53.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10665, 59, 55.0000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10665, 76, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10666, 29, 123.7900, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10666, 65, 21.0500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10667, 69, 36.0000, 45, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10667, 71, 21.5000, 14, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10668, 31, 12.5000, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10668, 55, 24.0000, 4, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10668, 64, 33.2500, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10669, 36, 19.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10670, 23, 9.0000, 32, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10670, 46, 12.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10670, 67, 14.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10670, 73, 15.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10670, 75, 7.7500, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10671, 16, 17.4500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10671, 62, 49.3000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10671, 65, 21.0500, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10672, 38, 263.5000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10672, 71, 21.5000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10673, 16, 17.4500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10673, 42, 14.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10673, 43, 46.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10674, 23, 9.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10675, 14, 23.2500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10675, 53, 32.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10675, 58, 13.2500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10676, 10, 31.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10676, 19, 9.2000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10676, 44, 19.4500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10677, 26, 31.2300, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10677, 33, 2.5000, 8, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10678, 12, 38.0000, 100, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10678, 33, 2.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10678, 41, 9.6500, 120, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10678, 54, 7.4500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10679, 59, 55.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10680, 16, 17.4500, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10680, 31, 12.5000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10680, 42, 14.0000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10681, 19, 9.2000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10681, 21, 10.0000, 12, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10681, 64, 33.2500, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10682, 33, 2.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10682, 66, 17.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10682, 75, 7.7500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10683, 52, 7.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10684, 40, 18.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10684, 47, 9.5000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10684, 60, 34.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10685, 10, 31.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10685, 41, 9.6500, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10685, 47, 9.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10686, 17, 39.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10686, 26, 31.2300, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10687, 9, 97.0000, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10687, 29, 123.7900, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10687, 36, 19.0000, 6, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10688, 10, 31.0000, 18, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10688, 28, 45.6000, 60, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10688, 34, 14.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10689, 1, 18.0000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10690, 56, 38.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10690, 77, 13.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10691, 1, 18.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10691, 29, 123.7900, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10691, 43, 46.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10691, 44, 19.4500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10691, 62, 49.3000, 48, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10692, 63, 43.9000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10693, 9, 97.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10693, 54, 7.4500, 60, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10693, 69, 36.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10693, 73, 15.0000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10694, 7, 30.0000, 90, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10694, 59, 55.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10694, 70, 15.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10695, 8, 40.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10695, 12, 38.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10695, 24, 4.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10696, 17, 39.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10696, 46, 12.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10697, 19, 9.2000, 7, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10697, 35, 18.0000, 9, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10697, 58, 13.2500, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10697, 70, 15.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10698, 11, 21.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10698, 17, 39.0000, 8, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10698, 29, 123.7900, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10698, 65, 21.0500, 65, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10698, 70, 15.0000, 8, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10699, 47, 9.5000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10700, 1, 18.0000, 5, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10700, 34, 14.0000, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10700, 68, 12.5000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10700, 71, 21.5000, 60, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10701, 59, 55.0000, 42, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10701, 71, 21.5000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10701, 76, 18.0000, 35, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10702, 3, 10.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10702, 76, 18.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10703, 2, 19.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10703, 59, 55.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10703, 73, 15.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10704, 4, 22.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10704, 24, 4.5000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10704, 48, 12.7500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10705, 31, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10705, 32, 32.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10706, 16, 17.4500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10706, 43, 46.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10706, 59, 55.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10707, 55, 24.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10707, 57, 19.5000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10707, 70, 15.0000, 28, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10708, 5, 21.3500, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10708, 36, 19.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10709, 8, 40.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10709, 51, 53.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10709, 60, 34.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10710, 19, 9.2000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10710, 47, 9.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10711, 19, 9.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10711, 41, 9.6500, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10711, 53, 32.8000, 120, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10712, 53, 32.8000, 3, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10712, 56, 38.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10713, 10, 31.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10713, 26, 31.2300, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10713, 45, 9.5000, 110, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10713, 46, 12.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10714, 2, 19.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10714, 17, 39.0000, 27, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10714, 47, 9.5000, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10714, 56, 38.0000, 18, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10714, 58, 13.2500, 12, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10715, 10, 31.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10715, 71, 21.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10716, 21, 10.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10716, 51, 53.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10716, 61, 28.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10717, 21, 10.0000, 32, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10717, 54, 7.4500, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10717, 69, 36.0000, 25, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10718, 12, 38.0000, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10718, 16, 17.4500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10718, 36, 19.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10718, 62, 49.3000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10719, 18, 62.5000, 12, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10719, 30, 25.8900, 3, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10719, 54, 7.4500, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10720, 35, 18.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10720, 71, 21.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10721, 44, 19.4500, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10722, 2, 19.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10722, 31, 12.5000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10722, 68, 12.5000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10722, 75, 7.7500, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10723, 26, 31.2300, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10724, 10, 31.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10724, 61, 28.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10725, 41, 9.6500, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10725, 52, 7.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10725, 55, 24.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10726, 4, 22.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10726, 11, 21.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10727, 17, 39.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10727, 56, 38.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10727, 59, 55.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10728, 30, 25.8900, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10728, 40, 18.4000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10728, 55, 24.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10728, 60, 34.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10729, 1, 18.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10729, 21, 10.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10729, 50, 16.2500, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10730, 16, 17.4500, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10730, 31, 12.5000, 3, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10730, 65, 21.0500, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10731, 21, 10.0000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10731, 51, 53.0000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10732, 76, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10733, 14, 23.2500, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10733, 28, 45.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10733, 52, 7.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10734, 6, 25.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10734, 30, 25.8900, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10734, 76, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10735, 61, 28.5000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10735, 77, 13.0000, 2, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10736, 65, 21.0500, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10736, 75, 7.7500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10737, 13, 6.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10737, 41, 9.6500, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10738, 16, 17.4500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10739, 36, 19.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10739, 52, 7.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10740, 28, 45.6000, 5, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10740, 35, 18.0000, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10740, 45, 9.5000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10740, 56, 38.0000, 14, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10741, 2, 19.0000, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10742, 3, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10742, 60, 34.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10742, 72, 34.8000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10743, 46, 12.0000, 28, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10744, 40, 18.4000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10745, 18, 62.5000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10745, 44, 19.4500, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10745, 59, 55.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10745, 72, 34.8000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10746, 13, 6.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10746, 42, 14.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10746, 62, 49.3000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10746, 69, 36.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10747, 31, 12.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10747, 41, 9.6500, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10747, 63, 43.9000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10747, 69, 36.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10748, 23, 9.0000, 44, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10748, 40, 18.4000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10748, 56, 38.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10749, 56, 38.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10749, 59, 55.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10749, 76, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10750, 14, 23.2500, 5, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10750, 45, 9.5000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10750, 59, 55.0000, 25, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10751, 26, 31.2300, 12, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10751, 30, 25.8900, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10751, 50, 16.2500, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10751, 73, 15.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10752, 1, 18.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10752, 69, 36.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10753, 45, 9.5000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10753, 74, 10.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10754, 40, 18.4000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10755, 47, 9.5000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10755, 56, 38.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10755, 57, 19.5000, 14, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10755, 69, 36.0000, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10756, 18, 62.5000, 21, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10756, 36, 19.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10756, 68, 12.5000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10756, 69, 36.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10757, 34, 14.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10757, 59, 55.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10757, 62, 49.3000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10757, 64, 33.2500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10758, 26, 31.2300, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10758, 52, 7.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10758, 70, 15.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10759, 32, 32.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10760, 25, 14.0000, 12, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10760, 27, 43.9000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10760, 43, 46.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10761, 25, 14.0000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10761, 75, 7.7500, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10762, 39, 18.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10762, 47, 9.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10762, 51, 53.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10762, 56, 38.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10763, 21, 10.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10763, 22, 21.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10763, 24, 4.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10764, 3, 10.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10764, 39, 18.0000, 130, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10765, 65, 21.0500, 80, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10766, 2, 19.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10766, 7, 30.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10766, 68, 12.5000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10767, 42, 14.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10768, 22, 21.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10768, 31, 12.5000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10768, 60, 34.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10768, 71, 21.5000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10769, 41, 9.6500, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10769, 52, 7.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10769, 61, 28.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10769, 62, 49.3000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10770, 11, 21.0000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10771, 71, 21.5000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10772, 29, 123.7900, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10772, 59, 55.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10773, 17, 39.0000, 33, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10773, 31, 12.5000, 70, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10773, 75, 7.7500, 7, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10774, 31, 12.5000, 2, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10774, 66, 17.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10775, 10, 31.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10775, 67, 14.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10776, 31, 12.5000, 16, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10776, 42, 14.0000, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10776, 45, 9.5000, 27, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10776, 51, 53.0000, 120, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10777, 42, 14.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10778, 41, 9.6500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10779, 16, 17.4500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10779, 62, 49.3000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10780, 70, 15.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10780, 77, 13.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10781, 54, 7.4500, 3, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10781, 56, 38.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10781, 74, 10.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10782, 31, 12.5000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10783, 31, 12.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10783, 38, 263.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10784, 36, 19.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10784, 39, 18.0000, 2, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10784, 72, 34.8000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10785, 10, 31.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10785, 75, 7.7500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10786, 8, 40.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10786, 30, 25.8900, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10786, 75, 7.7500, 42, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10787, 2, 19.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10787, 29, 123.7900, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10788, 19, 9.2000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10788, 75, 7.7500, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10789, 18, 62.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10789, 35, 18.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10789, 63, 43.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10789, 68, 12.5000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10790, 7, 30.0000, 3, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10790, 56, 38.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10791, 29, 123.7900, 14, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10791, 41, 9.6500, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10792, 2, 19.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10792, 54, 7.4500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10792, 68, 12.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10793, 41, 9.6500, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10793, 52, 7.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10794, 14, 23.2500, 15, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10794, 54, 7.4500, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10795, 16, 17.4500, 65, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10795, 17, 39.0000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10796, 26, 31.2300, 21, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10796, 44, 19.4500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10796, 64, 33.2500, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10796, 69, 36.0000, 24, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10797, 11, 21.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10798, 62, 49.3000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10798, 72, 34.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10799, 13, 6.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10799, 24, 4.5000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10799, 59, 55.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10800, 11, 21.0000, 50, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10800, 51, 53.0000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10800, 54, 7.4500, 7, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10801, 17, 39.0000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10801, 29, 123.7900, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10802, 30, 25.8900, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10802, 51, 53.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10802, 55, 24.0000, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10802, 62, 49.3000, 5, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10803, 19, 9.2000, 24, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10803, 25, 14.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10803, 59, 55.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10804, 10, 31.0000, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10804, 28, 45.6000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10804, 49, 20.0000, 4, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10805, 34, 14.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10805, 38, 263.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10806, 2, 19.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10806, 65, 21.0500, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10806, 74, 10.0000, 15, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10807, 40, 18.4000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10808, 56, 38.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10808, 76, 18.0000, 50, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10809, 52, 7.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10810, 13, 6.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10810, 25, 14.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10810, 70, 15.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10811, 19, 9.2000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10811, 23, 9.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10811, 40, 18.4000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10812, 31, 12.5000, 16, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10812, 72, 34.8000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10812, 77, 13.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10813, 2, 19.0000, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10813, 46, 12.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10814, 41, 9.6500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10814, 43, 46.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10814, 48, 12.7500, 8, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10814, 61, 28.5000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10815, 33, 2.5000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10816, 38, 263.5000, 30, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10816, 62, 49.3000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10817, 26, 31.2300, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10817, 38, 263.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10817, 40, 18.4000, 60, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10817, 62, 49.3000, 25, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10818, 32, 32.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10818, 41, 9.6500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10819, 43, 46.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10819, 75, 7.7500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10820, 56, 38.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10821, 35, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10821, 51, 53.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10822, 62, 49.3000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10822, 70, 15.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10823, 11, 21.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10823, 57, 19.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10823, 59, 55.0000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10823, 77, 13.0000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10824, 41, 9.6500, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10824, 70, 15.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10825, 26, 31.2300, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10825, 53, 32.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10826, 31, 12.5000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10826, 57, 19.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10827, 10, 31.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10827, 39, 18.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10828, 20, 81.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10828, 38, 263.5000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10829, 2, 19.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10829, 8, 40.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10829, 13, 6.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10829, 60, 34.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10830, 6, 25.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10830, 39, 18.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10830, 60, 34.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10830, 68, 12.5000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10831, 19, 9.2000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10831, 35, 18.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10831, 38, 263.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10831, 43, 46.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10832, 13, 6.0000, 3, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10832, 25, 14.0000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10832, 44, 19.4500, 16, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10832, 64, 33.2500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10833, 7, 30.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10833, 31, 12.5000, 9, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10833, 53, 32.8000, 9, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10834, 29, 123.7900, 8, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10834, 30, 25.8900, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10835, 59, 55.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10835, 77, 13.0000, 2, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10836, 22, 21.0000, 52, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10836, 35, 18.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10836, 57, 19.5000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10836, 60, 34.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10836, 64, 33.2500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10837, 13, 6.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10837, 40, 18.4000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10837, 47, 9.5000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10837, 76, 18.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10838, 1, 18.0000, 4, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10838, 18, 62.5000, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10838, 36, 19.0000, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10839, 58, 13.2500, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10839, 72, 34.8000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10840, 25, 14.0000, 6, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10840, 39, 18.0000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10841, 10, 31.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10841, 56, 38.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10841, 59, 55.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10841, 77, 13.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10842, 11, 21.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10842, 43, 46.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10842, 68, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10842, 70, 15.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10843, 51, 53.0000, 4, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10844, 22, 21.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10845, 23, 9.0000, 70, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10845, 35, 18.0000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10845, 42, 14.0000, 42, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10845, 58, 13.2500, 60, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10845, 64, 33.2500, 48, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10846, 4, 22.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10846, 70, 15.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10846, 74, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10847, 1, 18.0000, 80, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10847, 19, 9.2000, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10847, 37, 26.0000, 60, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10847, 45, 9.5000, 36, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10847, 60, 34.0000, 45, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10847, 71, 21.5000, 55, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10848, 5, 21.3500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10848, 9, 97.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10849, 3, 10.0000, 49, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10849, 26, 31.2300, 18, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10850, 25, 14.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10850, 33, 2.5000, 4, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10850, 70, 15.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10851, 2, 19.0000, 5, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10851, 25, 14.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10851, 57, 19.5000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10851, 59, 55.0000, 42, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10852, 2, 19.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10852, 17, 39.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10852, 62, 49.3000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10853, 18, 62.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10854, 10, 31.0000, 100, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10854, 13, 6.0000, 65, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10855, 16, 17.4500, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10855, 31, 12.5000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10855, 56, 38.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10855, 65, 21.0500, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10856, 2, 19.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10856, 42, 14.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10857, 3, 10.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10857, 26, 31.2300, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10857, 29, 123.7900, 10, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10858, 7, 30.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10858, 27, 43.9000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10858, 70, 15.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10859, 24, 4.5000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10859, 54, 7.4500, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10859, 64, 33.2500, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10860, 51, 53.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10860, 76, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10861, 17, 39.0000, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10861, 18, 62.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10861, 21, 10.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10861, 33, 2.5000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10861, 62, 49.3000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10862, 11, 21.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10862, 52, 7.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10863, 1, 18.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10863, 58, 13.2500, 12, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10864, 35, 18.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10864, 67, 14.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10865, 38, 263.5000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10865, 39, 18.0000, 80, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10866, 2, 19.0000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10866, 24, 4.5000, 6, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10866, 30, 25.8900, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10867, 53, 32.8000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10868, 26, 31.2300, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10868, 35, 18.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10868, 49, 20.0000, 42, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10869, 1, 18.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10869, 11, 21.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10869, 23, 9.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10869, 68, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10870, 35, 18.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10870, 51, 53.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10871, 6, 25.0000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10871, 16, 17.4500, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10871, 17, 39.0000, 16, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10872, 55, 24.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10872, 62, 49.3000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10872, 64, 33.2500, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10872, 65, 21.0500, 21, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10873, 21, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10873, 28, 45.6000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10874, 10, 31.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10875, 19, 9.2000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10875, 47, 9.5000, 21, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10875, 49, 20.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10876, 46, 12.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10876, 64, 33.2500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10877, 16, 17.4500, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10877, 18, 62.5000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10878, 20, 81.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10879, 40, 18.4000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10879, 65, 21.0500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10879, 76, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10880, 23, 9.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10880, 61, 28.5000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10880, 70, 15.0000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10881, 73, 15.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10882, 42, 14.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10882, 49, 20.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10882, 54, 7.4500, 32, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10883, 24, 4.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10884, 21, 10.0000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10884, 56, 38.0000, 21, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10884, 65, 21.0500, 12, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10885, 2, 19.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10885, 24, 4.5000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10885, 70, 15.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10885, 77, 13.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10886, 10, 31.0000, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10886, 31, 12.5000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10886, 77, 13.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10887, 25, 14.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10888, 2, 19.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10888, 68, 12.5000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10889, 11, 21.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10889, 38, 263.5000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10890, 17, 39.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10890, 34, 14.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10890, 41, 9.6500, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10891, 30, 25.8900, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10892, 59, 55.0000, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10893, 8, 40.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10893, 24, 4.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10893, 29, 123.7900, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10893, 30, 25.8900, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10893, 36, 19.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10894, 13, 6.0000, 28, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10894, 69, 36.0000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10894, 75, 7.7500, 120, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10895, 24, 4.5000, 110, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10895, 39, 18.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10895, 40, 18.4000, 91, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10895, 60, 34.0000, 100, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10896, 45, 9.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10896, 56, 38.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10897, 29, 123.7900, 80, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10897, 30, 25.8900, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10898, 13, 6.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10899, 39, 18.0000, 8, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10900, 70, 15.0000, 3, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10901, 41, 9.6500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10901, 71, 21.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10902, 55, 24.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10902, 62, 49.3000, 6, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10903, 13, 6.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10903, 65, 21.0500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10903, 68, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10904, 58, 13.2500, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10904, 62, 49.3000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10905, 1, 18.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10906, 61, 28.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10907, 75, 7.7500, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10908, 7, 30.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10908, 52, 7.0000, 14, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10909, 7, 30.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10909, 16, 17.4500, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10909, 41, 9.6500, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10910, 19, 9.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10910, 49, 20.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10910, 61, 28.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10911, 1, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10911, 17, 39.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10911, 67, 14.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10912, 11, 21.0000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10912, 29, 123.7900, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10913, 4, 22.0000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10913, 33, 2.5000, 40, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10913, 58, 13.2500, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10914, 71, 21.5000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10915, 17, 39.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10915, 33, 2.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10915, 54, 7.4500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10916, 16, 17.4500, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10916, 32, 32.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10916, 57, 19.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10917, 30, 25.8900, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10917, 60, 34.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10918, 1, 18.0000, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10918, 60, 34.0000, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10919, 16, 17.4500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10919, 25, 14.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10919, 40, 18.4000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10920, 50, 16.2500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10921, 35, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10921, 63, 43.9000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10922, 17, 39.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10922, 24, 4.5000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10923, 42, 14.0000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10923, 43, 46.0000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10923, 67, 14.0000, 24, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10924, 10, 31.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10924, 28, 45.6000, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10924, 75, 7.7500, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10925, 36, 19.0000, 25, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10925, 52, 7.0000, 12, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10926, 11, 21.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10926, 13, 6.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10926, 19, 9.2000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10926, 72, 34.8000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10927, 20, 81.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10927, 52, 7.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10927, 76, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10928, 47, 9.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10928, 76, 18.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10929, 21, 10.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10929, 75, 7.7500, 49, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10929, 77, 13.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10930, 21, 10.0000, 36, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10930, 27, 43.9000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10930, 55, 24.0000, 25, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10930, 58, 13.2500, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10931, 13, 6.0000, 42, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10931, 57, 19.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10932, 16, 17.4500, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10932, 62, 49.3000, 14, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10932, 72, 34.8000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10932, 75, 7.7500, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10933, 53, 32.8000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10933, 61, 28.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10934, 6, 25.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10935, 1, 18.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10935, 18, 62.5000, 4, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10935, 23, 9.0000, 8, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10936, 36, 19.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10937, 28, 45.6000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10937, 34, 14.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10938, 13, 6.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10938, 43, 46.0000, 24, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10938, 60, 34.0000, 49, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10938, 71, 21.5000, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10939, 2, 19.0000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10939, 67, 14.0000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10940, 7, 30.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10940, 13, 6.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10941, 31, 12.5000, 44, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10941, 62, 49.3000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10941, 68, 12.5000, 80, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10941, 72, 34.8000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10942, 49, 20.0000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10943, 13, 6.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10943, 22, 21.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10943, 46, 12.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10944, 11, 21.0000, 5, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10944, 44, 19.4500, 18, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10944, 56, 38.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10945, 13, 6.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10945, 31, 12.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10946, 10, 31.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10946, 24, 4.5000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10946, 77, 13.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10947, 59, 55.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10948, 50, 16.2500, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10948, 51, 53.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10948, 55, 24.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10949, 6, 25.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10949, 10, 31.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10949, 17, 39.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10949, 62, 49.3000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10950, 4, 22.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10951, 33, 2.5000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10951, 41, 9.6500, 6, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10951, 75, 7.7500, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10952, 6, 25.0000, 16, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10952, 28, 45.6000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10953, 20, 81.0000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10953, 31, 12.5000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10954, 16, 17.4500, 28, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10954, 31, 12.5000, 25, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10954, 45, 9.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10954, 60, 34.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10955, 75, 7.7500, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10956, 21, 10.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10956, 47, 9.5000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10956, 51, 53.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10957, 30, 25.8900, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10957, 35, 18.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10957, 64, 33.2500, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10958, 5, 21.3500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10958, 7, 30.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10958, 72, 34.8000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10959, 75, 7.7500, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10960, 24, 4.5000, 10, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10960, 41, 9.6500, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10961, 52, 7.0000, 6, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10961, 76, 18.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10962, 7, 30.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10962, 13, 6.0000, 77, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10962, 53, 32.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10962, 69, 36.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10962, 76, 18.0000, 44, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10963, 60, 34.0000, 2, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10964, 18, 62.5000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10964, 38, 263.5000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10964, 69, 36.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10965, 51, 53.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10966, 37, 26.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10966, 56, 38.0000, 12, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10966, 62, 49.3000, 12, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10967, 19, 9.2000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10967, 49, 20.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10968, 12, 38.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10968, 24, 4.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10968, 64, 33.2500, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10969, 46, 12.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10970, 52, 7.0000, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10971, 29, 123.7900, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10972, 17, 39.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10972, 33, 2.5000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10973, 26, 31.2300, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10973, 41, 9.6500, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10973, 75, 7.7500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10974, 63, 43.9000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10975, 8, 40.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10975, 75, 7.7500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10976, 28, 45.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10977, 39, 18.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10977, 47, 9.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10977, 51, 53.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10977, 63, 43.9000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10978, 8, 40.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10978, 21, 10.0000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10978, 40, 18.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10978, 44, 19.4500, 6, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10979, 7, 30.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10979, 12, 38.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10979, 24, 4.5000, 80, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10979, 27, 43.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10979, 31, 12.5000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10979, 63, 43.9000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10980, 75, 7.7500, 40, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10981, 38, 263.5000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10982, 7, 30.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10982, 43, 46.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10983, 13, 6.0000, 84, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10983, 57, 19.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10984, 16, 17.4500, 55, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10984, 24, 4.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10984, 36, 19.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10985, 16, 17.4500, 36, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10985, 18, 62.5000, 8, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10985, 32, 32.0000, 35, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10986, 11, 21.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10986, 20, 81.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10986, 76, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10986, 77, 13.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10987, 7, 30.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10987, 43, 46.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10987, 72, 34.8000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10988, 7, 30.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10988, 62, 49.3000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10989, 6, 25.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10989, 11, 21.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10989, 41, 9.6500, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10990, 21, 10.0000, 65, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10990, 34, 14.0000, 60, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10990, 55, 24.0000, 65, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10990, 61, 28.5000, 66, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10991, 2, 19.0000, 50, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10991, 70, 15.0000, 20, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10991, 76, 18.0000, 90, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10992, 72, 34.8000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10993, 29, 123.7900, 50, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10993, 41, 9.6500, 35, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10994, 59, 55.0000, 18, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10995, 51, 53.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10995, 60, 34.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10996, 42, 14.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10997, 32, 32.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10997, 46, 12.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10997, 52, 7.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10998, 24, 4.5000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10998, 61, 28.5000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10998, 74, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10998, 75, 7.7500, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10999, 41, 9.6500, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10999, 51, 53.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (10999, 77, 13.0000, 21, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11000, 4, 22.0000, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11000, 24, 4.5000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11000, 77, 13.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11001, 7, 30.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11001, 22, 21.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11001, 46, 12.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11001, 55, 24.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11002, 13, 6.0000, 56, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11002, 35, 18.0000, 15, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11002, 42, 14.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11002, 55, 24.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11003, 1, 18.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11003, 40, 18.4000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11003, 52, 7.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11004, 26, 73.5000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11004, 76, 18.0000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11005, 1, 18.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11005, 59, 55.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11006, 1, 18.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11006, 29, 123.7900, 2, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11007, 8, 40.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11007, 29, 123.7900, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11007, 42, 14.0000, 14, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11008, 28, 45.6000, 70, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11008, 34, 14.0000, 90, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11008, 71, 21.5000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11009, 24, 4.5000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11009, 36, 19.0000, 18, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11009, 60, 34.0000, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11010, 7, 30.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11010, 24, 4.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11011, 58, 13.2500, 40, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11011, 71, 21.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11012, 19, 9.2000, 50, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11012, 60, 34.0000, 36, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11012, 71, 21.5000, 60, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11013, 23, 9.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11013, 42, 14.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11013, 45, 9.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11013, 68, 12.5000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11014, 41, 9.6500, 28, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11015, 30, 25.8900, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11015, 77, 13.0000, 18, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11016, 31, 12.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11016, 36, 19.0000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11017, 3, 10.0000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11017, 59, 55.0000, 110, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11017, 70, 15.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11018, 12, 38.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11018, 18, 62.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11018, 56, 38.0000, 5, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11019, 46, 12.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11019, 49, 20.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11020, 10, 31.0000, 24, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11021, 2, 19.0000, 11, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11021, 20, 81.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11021, 26, 31.2300, 63, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11021, 51, 53.0000, 44, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11021, 72, 34.8000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11022, 19, 9.2000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11022, 69, 36.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11023, 7, 30.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11023, 43, 46.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11024, 26, 31.2300, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11024, 33, 2.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11024, 65, 21.0500, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11024, 71, 21.5000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11025, 1, 18.0000, 10, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11025, 13, 6.0000, 20, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11026, 18, 62.5000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11026, 51, 53.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11027, 24, 4.5000, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11027, 62, 49.3000, 21, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11028, 55, 24.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11028, 59, 55.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11029, 56, 38.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11029, 63, 43.9000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11030, 2, 19.0000, 100, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11030, 5, 21.3500, 70, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11030, 29, 123.7900, 60, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11030, 59, 55.0000, 100, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11031, 1, 18.0000, 45, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11031, 13, 6.0000, 80, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11031, 24, 4.5000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11031, 64, 33.2500, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11031, 71, 21.5000, 16, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11032, 36, 19.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11032, 38, 263.5000, 25, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11032, 59, 55.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11033, 53, 32.8000, 70, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11033, 69, 36.0000, 36, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11034, 21, 10.0000, 15, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11034, 44, 19.4500, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11034, 61, 28.5000, 6, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11035, 1, 18.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11035, 35, 18.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11035, 42, 14.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11035, 54, 7.4500, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11036, 13, 6.0000, 7, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11036, 59, 55.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11037, 70, 15.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11038, 40, 18.4000, 5, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11038, 52, 7.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11038, 71, 21.5000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11039, 28, 45.6000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11039, 35, 18.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11039, 49, 20.0000, 60, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11039, 57, 19.5000, 28, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11040, 21, 10.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11041, 2, 19.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11041, 63, 43.9000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11042, 44, 19.4500, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11042, 61, 28.5000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11043, 11, 21.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11044, 62, 49.3000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11045, 33, 2.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11045, 51, 53.0000, 24, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11046, 12, 38.0000, 20, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11046, 32, 32.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11046, 35, 18.0000, 18, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11047, 1, 18.0000, 25, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11047, 5, 21.3500, 30, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11048, 68, 12.5000, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11049, 2, 19.0000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11049, 12, 38.0000, 4, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11050, 76, 18.0000, 50, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11051, 24, 4.5000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11052, 43, 46.0000, 30, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11052, 61, 28.5000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11053, 18, 62.5000, 35, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11053, 32, 32.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11053, 64, 33.2500, 25, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11054, 33, 2.5000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11054, 67, 14.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11055, 24, 4.5000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11055, 25, 14.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11055, 51, 53.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11055, 57, 19.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11056, 7, 30.0000, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11056, 55, 24.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11056, 60, 34.0000, 50, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11057, 70, 15.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11058, 21, 10.0000, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11058, 60, 34.0000, 21, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11058, 61, 28.5000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11059, 13, 6.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11059, 17, 39.0000, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11059, 60, 34.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11060, 60, 34.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11060, 77, 13.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11061, 60, 34.0000, 15, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11062, 53, 32.8000, 10, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11062, 70, 15.0000, 12, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11063, 34, 14.0000, 30, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11063, 40, 18.4000, 40, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11063, 41, 9.6500, 30, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11064, 17, 39.0000, 77, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11064, 41, 9.6500, 12, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11064, 53, 32.8000, 25, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11064, 55, 24.0000, 4, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11064, 68, 12.5000, 55, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11065, 30, 25.8900, 4, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11065, 54, 7.4500, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11066, 16, 17.4500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11066, 19, 9.2000, 42, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11066, 34, 14.0000, 35, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11067, 41, 9.6500, 9, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11068, 28, 45.6000, 8, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11068, 43, 46.0000, 36, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11068, 77, 13.0000, 28, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11069, 39, 18.0000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11070, 1, 18.0000, 40, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11070, 2, 19.0000, 20, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11070, 16, 17.4500, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11070, 31, 12.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11071, 7, 30.0000, 15, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11071, 13, 6.0000, 10, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11072, 2, 19.0000, 8, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11072, 41, 9.6500, 40, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11072, 50, 16.2500, 22, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11072, 64, 33.2500, 130, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11073, 11, 21.0000, 10, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11073, 24, 4.5000, 20, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11074, 16, 17.4500, 14, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11075, 2, 19.0000, 10, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11075, 46, 12.0000, 30, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11075, 76, 18.0000, 2, 0.15);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11076, 6, 25.0000, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11076, 14, 23.2500, 20, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11076, 19, 9.2000, 10, 0.25);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 2, 19.0000, 24, 0.2);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 3, 10.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 4, 22.0000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 6, 25.0000, 1, 0.02);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 7, 30.0000, 1, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 8, 40.0000, 2, 0.1);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 10, 31.0000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 12, 38.0000, 2, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 13, 6.0000, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 14, 23.2500, 1, 0.03);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 16, 17.4500, 2, 0.03);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 20, 81.0000, 1, 0.04);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 23, 9.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 32, 32.0000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 39, 18.0000, 2, 0.05);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 41, 9.6500, 3, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 46, 12.0000, 3, 0.02);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 52, 7.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 55, 24.0000, 2, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 60, 34.0000, 2, 0.06);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 64, 33.2500, 2, 0.03);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 66, 17.0000, 1, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 73, 15.0000, 2, 0.01);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 75, 7.7500, 4, 0);
INSERT INTO order_detail (order_id, product_id, unit_price, quantity, discount)
VALUES (11077, 77, 13.0000, 2, 0);
