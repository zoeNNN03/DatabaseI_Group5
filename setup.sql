PRAGMA foreign_key = ON;
PRAGMA encoding='UTF-8';
.mode table
BEGIN TRANSACTION;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS contactStore;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS storeProduct;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS orderRecord;
DROP TABLE IF EXISTS orderItem;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS delivery;
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

INSERT INTO store(store_name, store_account, address_no, street, sub_district, district, province, zipcode)
VALUES('BUUshop test', '5829637697', '169 Student Activity Center Building', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO store(store_name, store_account, address_no, street, sub_district, district, province, zipcode)
VALUES('BUUshop', '9239980822', '169 Soi Bang Saen Sai 4 Tai 2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO store(store_name, store_account, address_no, street, sub_district, district, province, zipcode)
VALUES('Mr.Johnshop', '9862303919', '169 Soi Bang Saen Sai 4 Tai 2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

CREATE TABLE contactStore (
    store_id INTEGER NOT NULL,
    email TEXT UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT UNIQUE CHECK(LENGTH(phone)=10),
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO contactStore(store_id, email, phone) VALUES('1', 'chulabook.buu@gmail.com', '0863061683');
INSERT INTO contactStore(store_id, email, phone) VALUES('2', 'BUUshop@buu.ac.th','0886982864');

CREATE TABLE storeProduct (
    store_id INTEGER NOT NULL,
    product_id TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    PRIMARY KEY(store_id, product_id)
    FOREIGN KEY(store_id) REFERENCES store(store_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, '036000291452', 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, '036000291453', 20);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, '136000291452', 20);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, '236000291452', 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, '036000291452', 40);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, '036000291453', 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, '136000291452', 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, '236000291452', 40);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, '036000291452', 20);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, '036000291453', 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, '136000291452', 30);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, '236000291452', 30);

-- Product entity
CREATE TABLE product (
    product_id TEXT PRIMARY KEY NOT NULL CHECK(LENGTH(product_id)=12),
    product_name TEXT NOT NULL CHECK(LENGTH(product_name)>1),
    brand TEXT,
    category TEXT NOT NULL CHECK(LENGTH(product_name)>1),
    size TEXT CHECK(size in ('S', 'M', 'L', 'XL', '2XL', '3XL')),
    unit_price REAL NOT NULL CHECK(unit_price >= 0),
    stock INTEGER NOT NULL CHECK(stock >= 0),
    image_url TEXT,
    description TEXT
);
INSERT INTO product(product_id, product_name, brand, category, size, unit_price, stock, image_url)
VALUES('036000291452', 'T-shirt', 'BUU', 'Clothes', 'S', '380', '60', 'testUrl');
INSERT INTO product(product_id, product_name, category, size, unit_price, stock, image_url, description)
VALUES('036000291453', 'Slacks', 'clothes', 'XL', '420', '70', 'testUrl', 'Student pants');
INSERT INTO product(product_id, product_name, brand, category, unit_price, stock, image_url)
VALUES('136000291452', 'Pen', 'Lancer', 'stationery', '20', '110', 'testUrl');
INSERT INTO product(product_id, product_name, brand, category, unit_price, stock, image_url, description)
VALUES('236000291452', 'Python101', 'Chula', 'Book', '285', '70', 'testUrl', 'Learn tutorial python');

CREATE TABLE orderRecord (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    date_order DATE NOT NULL,
    status_order TEXT NOT NULL CHECK(status_order in ('Pending', 'Cancel', 'Succeed')),
    description TEXT,
    online_status BOOLEAN NOT NULL CHECK(online_status in (0, 1)),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO orderRecord(customer_id, employee_id, date_order, status_order, online_status)
VALUES('1', '1', '2022-10-15', 'Succeed', '0');
INSERT INTO orderRecord(customer_id, employee_id, date_order, status_order, online_status)
VALUES('1', '2', '2023-10-14', 'Pending', '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, status_order, online_status)
VALUES('2', '3', '2023-09-15', 'Succeed', '0');
INSERT INTO orderRecord(customer_id, employee_id, date_order, status_order, online_status)
VALUES('4', '4', '2023-07-15', 'Pending', '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, status_order, online_status)
VALUES('5', '5', '2023-10-15', 'Succeed', '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, status_order, online_status)
VALUES('6', '6', '2023-10-15', 'Succeed', '1');

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
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('1', '036000291452', '1', '1');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('1', '036000291453', '1', '10');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('2', '036000291453', '1', '5');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('3', '136000291452', '2', '10');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('3', '236000291452', '2', '1');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('4', '036000291452', '2', '3');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('5', '036000291453', '3', '1');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('6', '236000291452', '3', '20');

-- Customer entity
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    f_name TEXT NOT NULL CHECK(LENGTH(f_name) > 1),
    l_name TEXT NOT NULL CHECK(LENGTH(l_name) > 1),
    birthday DATE NOT NULL,
    gender TEXT CHECK(gender in ('M', 'F')),
    email TEXT NOT NULL UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT NOT NULL UNIQUE CHECK(LENGTH(phone)=10),
    address_no TEXT NOT NULL,
    street TEXT,
    sub_district TEXT NOT NULL,
    district TEXT NOT NULL,
    province TEXT NOT NULL,
    zipcode TEXT NOT NULL
);
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Jakkarin', 'Phunjhob', '2003-03-03', 'M', '404/1', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160035@go.buu.ac.th','0910000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Veerapat', 'Saardiem', '2003-11-11', 'F', '404/2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160284@go.buu.ac.th','0920000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Thanpisit', 'Jantakate', '2003-10-10', 'F', '404/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160138@go.buu.ac.th','0930000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Sunita', 'Miro', '2003-09-09', 'M', '404/14', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160056@go.buu.ac.th','0940000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Wasupakkanut', 'Wattanakul', '2003-01-01', 'M', '404/5', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160282@go.buu.ac.th','0950000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Nuengthida', 'Wongphuttha', '2003-05-12', 'F', '404/6', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160404@go.buu.ac.th','0960000000');

CREATE TABLE payment (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    account_number TEXT NOT NULL CHECK(LENGTH(account_number) >= 10),
    payment_status TEXT NOT NULL CHECK(payment_status in ('Pending', 'Cancel', 'Completed')),
    payment_date DATE NOT NULL,
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
INSERT INTO payment(customer_id, order_id, account_number, payment_status, payment_date, payment_gateway, payment_tax, payment_discount, receiver_account)
VALUES('1', '1', '7988635891', 'Pending', '2023-10-15', 'Truemoney wallet', '0.07', '0', '5829637697');
INSERT INTO payment(customer_id, order_id, account_number, payment_status, payment_date, payment_gateway, payment_tax, payment_discount, receiver_account)
VALUES('1', '3', '6538064416','Pending', '2023-10-14', 'Paypal', '0.07', '500', '5829637697');
INSERT INTO payment(customer_id, order_id, account_number, payment_status, payment_date, payment_gateway, payment_tax, payment_discount, receiver_account)
VALUES('2', '4', '5179214337','Completed', '2023-09-15', 'Truemoney wallet', '0.07', '0', '9239980822');
INSERT INTO payment(customer_id, order_id, account_number, payment_status, payment_date, payment_gateway, payment_tax, payment_discount, receiver_account)
VALUES('4', '5', '8755667378','Completed', '2023-07-15', 'Cash', '0.07', '300', '9239980822');
INSERT INTO payment(customer_id, order_id, account_number, payment_status, payment_date, payment_gateway, payment_tax, payment_discount, receiver_account)
VALUES('5', '6', '5095881796','Completed', '2022-10-15', 'Credit Card', '0.07', '100', '9862303919');
INSERT INTO payment(customer_id, order_id, account_number, payment_status, payment_date, payment_gateway, payment_tax, payment_discount, receiver_account)
VALUES('5', '6', '5095881796','Completed', '2022-10-15', 'Credit Card', '0.07', '100', '9862303919');

-- Employee entity
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_id INTEGER NOT NULL,
    f_name TEXT NOT NULL CHECK(LENGTH(f_name)>1),
    l_name TEXT NOT NULL CHECK(LENGTH(l_name)>1),
    gender TEXT NOT NULL CHECK(gender in ('M', 'F')),
    birthday DATE NOT NULL,
    job_position TEXT NOT NULL,
    salary REAL NOT NULL CHECK(salary >= 0),
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
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('1', 'John','Smith', 'M', '1973-10-03','mrjs@dizzy.com','5551234567', 'Manager', '25,000', '101/1', 'Sukhumvit', 'Klongtumru', 'MeungChonburi', 'Chon Buri', '20000');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('1', 'Jane','Smith', 'F', '2000-11-11', 'msjs@dizzy.com','5551234568', 'Seller', '15,000', '102/2', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('2','Clarence','Kentucky', 'F', '2000-12-05','ck@deemag.co.th','5559999999', 'General', '10,000', '103/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('2','Bruce','Bell', 'M', '2000-12-05','brucebell@deemag.co.th','0012311111', 'Manager', '30,000', '104/4', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('3', 'Clark','Kent', 'M', '2000-12-05','superman@dc.com','0011113451', 'Seller', '20,000', '105/5', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('3','Peter','Parker', 'M', '2000-02-05','spiderman@dc.com','0067891111', 'Seller', '20,000', '106/6', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

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
INSERT INTO supplier(supplier_name, supplier_account, address_no, sub_district, district, province, zipcode)
VALUES('Doble A', '8907285498', '400/1', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO supplier(supplier_name, supplier_account, address_no, street, sub_district, district, province, zipcode)
VALUES('Doble B', '7372677905','401/2', 'Sukhumvit', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO supplier(supplier_name, supplier_account, address_no, street, sub_district, district, province, zipcode)
VALUES('Doble C', '8171914542','402/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

CREATE TABLE contactSupplier (
    supplier_id INTEGER NOT NULL,
    email TEXT NULL UNIQUE CHECK(LENGTH(email)>4),
    phone TEXT NULL UNIQUE CHECK(LENGTH(phone)=10),
    FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO contactSupplier(supplier_id, email, phone) VALUES('1', 'doble.a@gmail.com', '0900005544');
INSERT INTO contactSupplier(supplier_id, phone) VALUES('1', '0900000001');
INSERT INTO contactSupplier(supplier_id, email) VALUES('2', 'doble.b@gmail.com');
INSERT INTO contactSupplier(supplier_id, phone) VALUES('3', '0904500003');

CREATE TABLE delivery (
    supplier_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    cost REAL NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    status TEXT NOT NULL,
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
INSERT INTO delivery(supplier_id, store_id, product_id, cost, quantity, status)
VALUES('1', '1', '036000291452', '1000', '20', 'Successful');
INSERT INTO delivery(supplier_id, store_id, product_id, cost, quantity, status)
VALUES('1', '1', '136000291452', '1500', '20', 'Successful');
INSERT INTO delivery(supplier_id, store_id, product_id, cost, quantity, status)
VALUES('2', '2', '136000291452', '500', '20', 'Successful');
INSERT INTO delivery(supplier_id, store_id, product_id, cost, quantity, status)
VALUES('2', '2', '036000291453', '1000', '10', 'Pending');
INSERT INTO delivery(supplier_id, store_id, product_id, cost, quantity, status)
VALUES('3', '3', '136000291452', '400', '30', 'Successful');
INSERT INTO delivery(supplier_id, store_id, product_id, cost, quantity, status)
VALUES('3', '3', '236000291452', '1000', '20', 'Successful');
COMMIT TRANSACTION;
.table