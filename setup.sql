-- This is a script to setup and create tables the database for the project.

PRAGMA foreign_keys = ON; -- This is a must for SQLite3 foreign keys to work!
PRAGMA encoding='UTF-8'; -- This is a must for SQLite3 to support UTF-8 encoding!
-- This is a must for SQLite3 to display tables in a nice format!
.mode table 
BEGIN TRANSACTION; -- This is a must for SQLite3 to execute multiple queries in one go or dividing work into TRANSACTION!

-- Drop tables if they exist (in case you want to re-run this script)
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS contactStore;
DROP TABLE IF EXISTS storeProduct;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS orderItem;
DROP TABLE IF EXISTS orderRecord;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS contactSupplier;

-- Create tables
-- Store entity
CREATE TABLE store (
    store_id INTEGER PRIMARY KEY AUTOINCREMENT, -- This is a must for SQLite3 to auto-increment primary keys!
    store_name TEXT NOT NULL CHECK(LENGTH(store_name)>1),
    store_account TEXT NOT NULL CHECK(LENGTH(store_account) >= 10),
    address_no TEXT NOT NULL,
    street TEXT,
    sub_district TEXT NOT NULL,
    district TEXT NOT NULL,
    province TEXT NOT NULL,
    zipcode TEXT NOT NULL
);

-- ContactStore entity
CREATE TABLE contactStore (
    store_id INTEGER NOT NULL,
    email TEXT UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT UNIQUE CHECK(LENGTH(phone)=10),
    FOREIGN KEY(store_id) REFERENCES store(store_id) -- This is a must for SQLite3 foreign keys to work!
        ON DELETE CASCADE -- This is a must for SQLite3 to cascade delete!
        ON UPDATE CASCADE -- This is a must for SQLite3 to cascade update!
);

-- Product entity
CREATE TABLE product (
    product_id TEXT PRIMARY KEY NOT NULL CHECK(LENGTH(product_id)=12), -- Check product_id length to be 12 characters following UPC qrcode standard
    product_name TEXT NOT NULL CHECK(LENGTH(product_name)>1),
    brand TEXT,
    category TEXT NOT NULL CHECK(LENGTH(product_name)>1),
    size TEXT CHECK(size in ('S', 'M', 'L', 'XL', '2XL', '3XL')), -- Check size to be one of these values of clothing size
    unit_price REAL NOT NULL CHECK(unit_price >= 0), -- Check unit_price to be positive
    stock INTEGER NOT NULL CHECK(stock >= 0), -- Check stock to be positive
    image_url TEXT,
    description TEXT
);

-- Customer entity
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    f_name TEXT NOT NULL CHECK(LENGTH(f_name) > 1),
    l_name TEXT NOT NULL CHECK(LENGTH(l_name) > 1),
    birthday DATE NOT NULL CHECK((birthday GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND -- Check birthday to be in YYYY-MM-DD format
                                (CAST(strftime('%Y',date(birthday)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND -- Check year DATE to be in range of 1900-2023
                                    (CAST(strftime('%m',date(birthday)) AS INTEGER) BETWEEN 1 AND 12) AND -- Check month DATE to be in range of 1-12
                                    (CASE
                                        WHEN (CAST(strftime('%m',date(birthday)) AS INTEGER) IN (1,3,5,7,8,10,12)) THEN -- Check day DATE to be in range of 1-31 for months that have 31 days
                                            (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 31)
                                        WHEN (CAST(strftime('%m',date(birthday)) AS INTEGER) IN (4,6,9,11)) THEN -- Check day DATE to be in range of 1-30 for months that have 30 days
                                            (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 30)
                                        WHEN (CAST(strftime('%m',date(birthday)) AS INTEGER) == 2) THEN -- Check day DATE to be in range of 1-28 for February
                                            CASE
                                                WHEN (CAST(strftime('%Y',date(birthday)) AS INTEGER) % 4 != 0) THEN -- Check day DATE to be in range of 1-28 for February in non-leap years
                                                    (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 28)
                                            ELSE
                                                CASE
                                                    WHEN (CAST(strftime('%Y',date(birthday)) AS INTEGER) % 100 == 0) THEN -- Check day DATE to be in range of 1-28 for February in non-leap years
                                                        CASE
                                                            WHEN (CAST(strftime('%Y',date(birthday)) AS INTEGER) % 400 == 0) THEN -- Check day DATE to be in range of 1-29 for February in leap years
                                                                (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 29)
                                                            ELSE                                                                  -- Check day DATE to be in range of 1-28 for February in non-leap years
                                                                (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 28)
                                                        END
                                                    ELSE
                                                        (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 29) -- Check day DATE to be in range of 1-29 for February in leap years
                                                END
                                            END
                                    ELSE
                                        (1 == 2) -- FALSE condition
                                    END)),
    gender TEXT CHECK(gender in ('M', 'F', 'H')), -- M is male, F is Female, H is Hermaphrodite
    email TEXT NOT NULL UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT NOT NULL UNIQUE CHECK(LENGTH(phone)=10),
    address_no TEXT NOT NULL,
    street TEXT,
    sub_district TEXT NOT NULL,
    district TEXT NOT NULL,
    province TEXT NOT NULL,
    zipcode TEXT NOT NULL
);

-- Employee entity
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_id INTEGER NOT NULL,
    f_name TEXT NOT NULL CHECK(LENGTH(f_name)>1),
    l_name TEXT NOT NULL CHECK(LENGTH(l_name)>1),
    gender TEXT NOT NULL CHECK(gender in ('M', 'F', 'H')),
    birthday DATE NOT NULL CHECK((birthday GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND 
                                (CAST(strftime('%Y',date(birthday)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND 
                                    (CAST(strftime('%m',date(birthday)) AS INTEGER) BETWEEN 1 AND 12) AND 
                                    (CASE
                                        WHEN (CAST(strftime('%m',date(birthday)) AS INTEGER) IN (1,3,5,7,8,10,12)) THEN 
                                            (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 31)
                                        WHEN (CAST(strftime('%m',date(birthday)) AS INTEGER) IN (4,6,9,11)) THEN 
                                            (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 30)
                                        WHEN (CAST(strftime('%m',date(birthday)) AS INTEGER) == 2) THEN 
                                            CASE
                                                WHEN (CAST(strftime('%Y',date(birthday)) AS INTEGER) % 4 != 0) THEN 
                                                    (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 28)
                                            ELSE
                                                CASE
                                                    WHEN (CAST(strftime('%Y',date(birthday)) AS INTEGER) % 100 == 0) THEN 
                                                        CASE
                                                            WHEN (CAST(strftime('%Y',date(birthday)) AS INTEGER) % 400 == 0) THEN 
                                                                (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 29)
                                                            ELSE
                                                                (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 28) 
                                                        END
                                                    ELSE
                                                        (CAST(strftime('%d',date(birthday)) AS INTEGER) BETWEEN 1 AND 29) 
                                                END
                                            END
                                    ELSE
                                        (1 == 2) 
                                    END)),
    job_position TEXT NOT NULL,
    salary REAL NOT NULL CHECK(salary >= 0), -- Check salary to be positive
    email TEXT NOT NULL UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT NOT NULL UNIQUE CHECK(LENGTH(phone)=10),
    address_no TEXT NOT NULL,
    street TEXT,
    sub_district TEXT NOT NULL,
    district TEXT NOT NULL,
    province TEXT NOT NULL,
    zipcode TEXT NOT NULL,
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- supplier entity
CREATE TABLE supplier (
    supplier_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_name TEXT NOT NULL CHECK(LENGTH(supplier_name)>=1),
    supplier_account TEXT NOT NULL CHECK(LENGTH(supplier_account) >= 10),
    address_no TEXT NOT NULL,
    street TEXT,
    sub_district TEXT NOT NULL,
    district TEXT NOT NULL,
    province TEXT NOT NULL,
    zipcode TEXT NOT NULL
);

-- contactSupplier entity
CREATE TABLE contactSupplier (
    supplier_id INTEGER NOT NULL,
    email TEXT NULL UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT NULL UNIQUE CHECK(LENGTH(phone)=10),
    FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- storeProduct entity
CREATE TABLE storeProduct (
    store_id INTEGER NOT NULL,
    product_id TEXT NOT NULL CHECK(LENGTH(product_id)=12), -- Check product_id length to be 12 characters following UPC qrcode standard
    quantity INTEGER NOT NULL CHECK(quantity >= 0), -- Check quantity to be positive
    PRIMARY KEY(store_id, product_id) -- This is a must for SQLite3 to create composite primary keys!
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- orderRecord entity
CREATE TABLE orderRecord (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    date_order DATE NOT NULL CHECK((date_order GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND 
                                (CAST(strftime('%Y',date(date_order)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND 
                                    (CAST(strftime('%m',date(date_order)) AS INTEGER) BETWEEN 1 AND 12) AND
                                    (CASE
                                        WHEN (CAST(strftime('%m',date(date_order)) AS INTEGER) IN (1,3,5,7,8,10,12)) THEN 
                                            (CAST(strftime('%d',date(date_order)) AS INTEGER) BETWEEN 1 AND 31)
                                        WHEN (CAST(strftime('%m',date(date_order)) AS INTEGER) IN (4,6,9,11)) THEN 
                                            (CAST(strftime('%d',date(date_order)) AS INTEGER) BETWEEN 1 AND 30)
                                        WHEN (CAST(strftime('%m',date(date_order)) AS INTEGER) == 2) THEN 
                                            CASE
                                                WHEN (CAST(strftime('%Y',date(date_order)) AS INTEGER) % 4 != 0) THEN 
                                                    (CAST(strftime('%d',date(date_order)) AS INTEGER) BETWEEN 1 AND 28)
                                            ELSE
                                                CASE
                                                    WHEN (CAST(strftime('%Y',date(date_order)) AS INTEGER) % 100 == 0) THEN 
                                                        CASE
                                                            WHEN (CAST(strftime('%Y',date(date_order)) AS INTEGER) % 400 == 0) THEN 
                                                                (CAST(strftime('%d',date(date_order)) AS INTEGER) BETWEEN 1 AND 29)
                                                            ELSE
                                                                (CAST(strftime('%d',date(date_order)) AS INTEGER) BETWEEN 1 AND 28) 
                                                        END
                                                    ELSE
                                                        (CAST(strftime('%d',date(date_order)) AS INTEGER) BETWEEN 1 AND 29) 
                                                END
                                            END
                                    ELSE
                                        (1 == 2)
                                    END)),
    order_status TEXT NOT NULL CHECK(order_status in ('Pending', 'Cancel', 'Completed')), -- Check order_status to be one of these values
    description TEXT,
    online_status BOOLEAN NOT NULL CHECK(online_status in (0, 1)), -- Check online_status to be either 0 or 1, 0 is false, 1 is true
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- orderItem entity
CREATE TABLE orderItem (
    order_id INTEGER NOT NULL,
    product_id TEXT NOT NULL CHECK(LENGTH(product_id)=12),
    store_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    PRIMARY KEY(order_id, product_id, store_id),
    FOREIGN KEY(order_id) REFERENCES orderRecord(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE payment (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    account_number TEXT NOT NULL CHECK(LENGTH(account_number) >= 10),
    payment_status TEXT NOT NULL CHECK(payment_status in ('Pending', 'Cancel', 'Completed')),
    payment_date DATE NOT NULL CHECK((payment_date GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(payment_date)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    (CAST(strftime('%m',date(payment_date)) AS INTEGER) BETWEEN 1 AND 12) AND
                                    (CASE
                                        WHEN (CAST(strftime('%m',date(payment_date)) AS INTEGER) IN (1,3,5,7,8,10,12)) THEN
                                            (CAST(strftime('%d',date(payment_date)) AS INTEGER) BETWEEN 1 AND 31)
                                        WHEN (CAST(strftime('%m',date(payment_date)) AS INTEGER) IN (4,6,9,11)) THEN
                                            (CAST(strftime('%d',date(payment_date)) AS INTEGER) BETWEEN 1 AND 30)
                                        WHEN (CAST(strftime('%m',date(payment_date)) AS INTEGER) == 2) THEN
                                            CASE
                                                WHEN (CAST(strftime('%Y',date(payment_date)) AS INTEGER) % 4 != 0) THEN
                                                    (CAST(strftime('%d',date(payment_date)) AS INTEGER) BETWEEN 1 AND 28)
                                            ELSE
                                                CASE
                                                    WHEN (CAST(strftime('%Y',date(payment_date)) AS INTEGER) % 100 == 0) THEN
                                                        CASE
                                                            WHEN (CAST(strftime('%Y',date(payment_date)) AS INTEGER) % 400 == 0) THEN
                                                                (CAST(strftime('%d',date(payment_date)) AS INTEGER) BETWEEN 1 AND 29)
                                                            ELSE
                                                                (CAST(strftime('%d',date(payment_date)) AS INTEGER) BETWEEN 1 AND 28)
                                                        END
                                                    ELSE
                                                        (CAST(strftime('%d',date(payment_date)) AS INTEGER) BETWEEN 1 AND 29)
                                                END
                                            END
                                    ELSE
                                        (1 == 2)
                                    END)),
    payment_gateway TEXT NOT NULL,
    payment_tax REAL NOT NULL CHECK(payment_tax >= 0),
    payment_discount REAL NOT NULL CHECK(payment_discount >= 0),
    receiver_account TEXT NOT NULL CHECK(LENGTH(receiver_account) >= 10),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(order_id) REFERENCES orderRecord(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE delivery (
    supplier_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    product_id TEXT NOT NULL CHECK(LENGTH(product_id)=12),
    date_delivery DATE NOT NULL CHECK((date_delivery GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(date_delivery)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    (CAST(strftime('%m',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 12) AND
                                    (CASE
                                        WHEN (CAST(strftime('%m',date(date_delivery)) AS INTEGER) IN (1,3,5,7,8,10,12)) THEN
                                            (CAST(strftime('%d',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 31)
                                        WHEN (CAST(strftime('%m',date(date_delivery)) AS INTEGER) IN (4,6,9,11)) THEN
                                            (CAST(strftime('%d',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 30)
                                        WHEN (CAST(strftime('%m',date(date_delivery)) AS INTEGER) == 2) THEN
                                            CASE
                                                WHEN (CAST(strftime('%Y',date(date_delivery)) AS INTEGER) % 4 != 0) THEN
                                                    (CAST(strftime('%d',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 28)
                                            ELSE
                                                CASE
                                                    WHEN (CAST(strftime('%Y',date(date_delivery)) AS INTEGER) % 100 == 0) THEN
                                                        CASE
                                                            WHEN (CAST(strftime('%Y',date(date_delivery)) AS INTEGER) % 400 == 0) THEN
                                                                (CAST(strftime('%d',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 29)
                                                            ELSE
                                                                (CAST(strftime('%d',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 28)
                                                        END
                                                    ELSE
                                                        (CAST(strftime('%d',date(date_delivery)) AS INTEGER) BETWEEN 1 AND 29)
                                                END
                                            END
                                    ELSE
                                        (1 == 2)
                                    END)),
    cost REAL NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    delivery_status TEXT NOT NULL CHECK(delivery_status in ('Pending', 'Cancel', 'Completed')),
    PRIMARY KEY(supplier_id, store_id, product_id),
    FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
COMMIT TRANSACTION;
.table
-- If you go here without errors, then your database is on the disk and ready-to-go!
