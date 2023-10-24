PRAGMA foreign_keys = ON;
PRAGMA encoding='UTF-8';
.mode table
BEGIN TRANSACTION;
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

-- Store entity
CREATE TABLE store (
    store_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_name TEXT NOT NULL CHECK(LENGTH(store_name)>1),
    store_account TEXT NOT NULL CHECK(LENGTH(store_account) >= 10),
    address_no TEXT NOT NULL,
    street TEXT,
    sub_district TEXT NOT NULL,
    district TEXT NOT NULL,
    province TEXT NOT NULL,
    zipcode TEXT NOT NULL
);

CREATE TABLE contactStore (
    store_id INTEGER NOT NULL,
    email TEXT UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT UNIQUE CHECK(LENGTH(phone)=10),
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Product entity
CREATE TABLE product (
    product_id TEXT PRIMARY KEY NOT NULL CHECK(LENGTH(product_id)=12),
    product_name TEXT NOT NULL CHECK(LENGTH(product_name)>1),
    brand TEXT,
    category TEXT NOT NULL CHECK(LENGTH(product_name)>1),
    size TEXT CHECK(size in ('S', 'M', 'L', 'XL', '2XL', '3XL')),
    unit_price INTEGER NOT NULL CHECK(unit_price >= 0),
    stock INTEGER NOT NULL CHECK(stock >= 0),
    image_url TEXT,
    description TEXT
);

-- Customer entity
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    f_name TEXT NOT NULL CHECK(LENGTH(f_name) > 1),
    l_name TEXT NOT NULL CHECK(LENGTH(l_name) > 1),
    birthday DATE NOT NULL CHECK ((birthday GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(birthday)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    -- Using current date will not work to specify the end of the range.
                                    -- SQLite says doing that is bad because it is a
                                    -- "non-deterministic use of date() in a CHECK constraint"
                                    -- i.e, do not try this: (CAST(strftime('%Y',date('now')) AS INTEGER))
                                    -- I hard-coded 2023.  This would require the DBA to do a database dump,
                                    -- update the year in the dump file, and a reload the dump
                                    -- on December 31 of every year, which would need to be in
                                    -- the application's documentation for the DBA....  Eventually
                                    -- the 1900 would also be updated to a larger number too.
                                    -- I assume nobody born before 1910 (113 years old!) is
                                    -- going to be looking for a job from a recruiter.
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
    gender TEXT CHECK(gender in ('M', 'F', 'H')),
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
    birthday DATE NOT NULL CHECK ((birthday GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(birthday)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    -- Using current date will not work to specify the end of the range.
                                    -- SQLite says doing that is bad because it is a
                                    -- "non-deterministic use of date() in a CHECK constraint"
                                    -- i.e, do not try this: (CAST(strftime('%Y',date('now')) AS INTEGER))
                                    -- I hard-coded 2023.  This would require the DBA to do a database dump,
                                    -- update the year in the dump file, and a reload the dump
                                    -- on December 31 of every year, which would need to be in
                                    -- the application's documentation for the DBA....  Eventually
                                    -- the 1900 would also be updated to a larger number too.
                                    -- I assume nobody born before 1910 (113 years old!) is
                                    -- going to be looking for a job from a recruiter.
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
    salary INTEGER NOT NULL CHECK(salary >= 0),
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

CREATE TABLE contactSupplier (
    supplier_id INTEGER NOT NULL,
    email TEXT NULL UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT NULL UNIQUE CHECK(LENGTH(phone)=10),
    FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE storeProduct (
    store_id INTEGER NOT NULL,
    product_id TEXT NOT NULL CHECK(LENGTH(product_id)=12),
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    PRIMARY KEY(store_id, product_id)
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE orderRecord (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    date_order DATE NOT NULL CHECK ((date_order GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(date_order)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    -- Using current date will not work to specify the end of the range.
                                    -- SQLite says doing that is bad because it is a
                                    -- "non-deterministic use of date() in a CHECK constraint"
                                    -- i.e, do not try this: (CAST(strftime('%Y',date('now')) AS INTEGER))
                                    -- I hard-coded 2023.  This would require the DBA to do a database dump,
                                    -- update the year in the dump file, and a reload the dump
                                    -- on December 31 of every year, which would need to be in
                                    -- the application's documentation for the DBA....  Eventually
                                    -- the 1900 would also be updated to a larger number too.
                                    -- I assume nobody born before 1910 (113 years old!) is
                                    -- going to be looking for a job from a recruiter.
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
    order_status TEXT NOT NULL CHECK(order_status in ('Pending', 'Cancel', 'Completed')),
    description TEXT,
    online_status BOOLEAN NOT NULL CHECK(online_status in (0, 1)),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

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
    payment_date DATE NOT NULL CHECK ((payment_date GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(payment_date)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    -- Using current date will not work to specify the end of the range.
                                    -- SQLite says doing that is bad because it is a
                                    -- "non-deterministic use of date() in a CHECK constraint"
                                    -- i.e, do not try this: (CAST(strftime('%Y',date('now')) AS INTEGER))
                                    -- I hard-coded 2023.  This would require the DBA to do a database dump,
                                    -- update the year in the dump file, and a reload the dump
                                    -- on December 31 of every year, which would need to be in
                                    -- the application's documentation for the DBA....  Eventually
                                    -- the 1900 would also be updated to a larger number too.
                                    -- I assume nobody born before 1910 (113 years old!) is
                                    -- going to be looking for a job from a recruiter.
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
    payment_tax INTEGER NOT NULL CHECK(payment_tax >= 0),
    payment_discount INTEGER NOT NULL CHECK(payment_discount >= 0),
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
    date_delivery DATE NOT NULL CHECK ((date_delivery GLOB '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]') AND
                                (CAST(strftime('%Y',date(date_delivery)) AS INTEGER)
                                    BETWEEN 1900 AND 2023) AND
                                    -- Using current date will not work to specify the end of the range.
                                    -- SQLite says doing that is bad because it is a
                                    -- "non-deterministic use of date() in a CHECK constraint"
                                    -- i.e, do not try this: (CAST(strftime('%Y',date('now')) AS INTEGER))
                                    -- I hard-coded 2023.  This would require the DBA to do a database dump,
                                    -- update the year in the dump file, and a reload the dump
                                    -- on December 31 of every year, which would need to be in
                                    -- the application's documentation for the DBA....  Eventually
                                    -- the 1900 would also be updated to a larger number too.
                                    -- I assume nobody born before 1910 (113 years old!) is
                                    -- going to be looking for a job from a recruiter.
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
    cost INTEGER NOT NULL,
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
