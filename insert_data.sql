PRAGMA encoding='UTF-8';
BEGIN TRANSACTION;
-- store
INSERT INTO store(store_name, address_no, street, sub_district, district, province, zipcode)
VALUES('Chulabook', '169 Student Activity Center Building', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO store(store_name, address_no, street, sub_district, district, province, zipcode)
VALUES('BUUshop', '169 Soi Bang Saen Sai 4 Tai 2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO store(store_name, address_no, street, sub_district, district, province, zipcode)
VALUES('Chula Test', '169 Soi Bang Saen Sai 4 Tai 2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

INSERT INTO contactStore(store_id, email, phone) VALUES('1', 'chulabook.buu@gmail.com', '0863061683');
INSERT INTO contactStore(store_id, email, phone) VALUES('2', 'BUUshop@buu.ac.th','0886982864');

-- product
INSERT INTO product(product_name, brand, category, size, unit_price, stock, image_url)
VALUES('T-shirt', 'BUU', 'Clothes', 'S', '380', '60', 'testUrl');
INSERT INTO product(product_name, category, size, unit_price, stock, image_url, description)
VALUES('Slacks', 'clothes', 'XL', '420', '70', 'testUrl', 'Student pants');
INSERT INTO product(product_name, brand, category, unit_price, stock, image_url)
VALUES('Pen', 'Lancer', 'stationery', '20', '110', 'testUrl');
INSERT INTO product(product_name, brand, category, unit_price, stock, image_url, description)
VALUES('Python101', 'Chula', 'Book', '285', '70', 'testUrl', 'Learn tutorial python');

INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, 1, 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, 2, 20);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, 3, 20);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (1, 4, 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, 1, 40);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, 2, 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, 3, 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (2, 4, 40);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, 1, 20);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, 2, 10);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, 3, 30);
INSERT INTO storeProduct(store_id, product_id, quantity) VALUES (3, 4, 30);

-- order
INSERT INTO orderRecord(customer_id, employee_id, date_order, total_amount, status_order, description, online_status)
VALUES('1', '1', '2023-10-15', '100', 'Pending', NULL, '0');
INSERT INTO orderRecord(customer_id, employee_id, date_order, total_amount, status_order, description, online_status)
VALUES('1', '2', '2023-10-14', '500', 'Cancel', NULL, '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, total_amount, status_order, description, online_status)
VALUES('2', '3', '2023-09-15', '1000', 'Succeed', NULL, '0');
INSERT INTO orderRecord(customer_id, employee_id, date_order, total_amount, status_order, description, online_status)
VALUES('4', '4', '2023-07-15', '90', 'Pending', NULL, '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, total_amount, status_order, description, online_status)
VALUES('5', '5', '2022-10-15', '50', 'Succeed', NULL, '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, total_amount, status_order, description, online_status)
VALUES('6', '6', '2023-10-15', '50', 'Succeed', NULL, '1');

INSERT INTO orderItem(product_id, order_id, quantity) VALUES('1', '1', '1');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('2', '2', '10');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('3', '2', '5');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('4', '3', '10');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('1', '4', '1');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('2', '5', '3');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('3', '5', '1');
INSERT INTO orderItem(product_id, order_id, quantity) VALUES('4', '6', '20');

-- customer
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Jakkarin', 'Phunjhob', '2003-03-03', 'M', '404/1', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160035@go.buu.ac.th','0910000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Veerapat', 'Saardiem', '2003-11-11', 'W', '404/2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160284@go.buu.ac.th','0920000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Thanpisit', 'Jantakate', '2003-10-10', 'W', '404/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160138@go.buu.ac.th','0930000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Sunita', 'Miro', '2003-09-09', 'M', '404/14', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160056@go.buu.ac.th','0940000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Wasupakkanut', 'Wattanakul', '2003-01-01', 'M', '404/5', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160282@go.buu.ac.th','0950000000');
INSERT INTO customer(f_name, l_name, birthday, gender, address_no, street, sub_district, district, province, zipcode, email, phone)
VALUES('Nuengthida', 'Wongphuttha', '2003-05-12', 'W', '404/6', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131', '65160404@go.buu.ac.th','0960000000');

-- payment
INSERT INTO payment(customer_id, order_id, payment_status, payment_date, payment_amount, payment_gateway, receiver_account)
VALUES('1', '1', 'Pending', '2023-10-15', '100',  'Truemoney wallet', '123-456-781 ');
INSERT INTO payment(customer_id, order_id, payment_status, payment_date, payment_amount, payment_gateway, receiver_account)
VALUES('1', '2', 'Cancel', '2023-10-14', '200', 'Paypal', '123-456-782');
INSERT INTO payment(customer_id, order_id, payment_status, payment_date, payment_amount, payment_gateway, receiver_account)
VALUES('2', '3', 'Completed', '2023-09-15', '300', 'Truemoney wallet', '123-456-783');
INSERT INTO payment(customer_id, order_id, payment_status, payment_date, payment_amount, payment_gateway, receiver_account)
VALUES('4', '4', 'Completed', '2023-07-15', '400', 'Cash', '123-456-784');
INSERT INTO payment(customer_id, order_id, payment_status, payment_date, payment_amount, payment_gateway, receiver_account)
VALUES('5', '5', 'Completed', '2022-10-15', '500', 'Credit Card', '123-456-785');

-- employee
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('1', 'John','Smith', 'M', '1973-10-03','mrjs@dizzy.com','5551234567', 'Manager', '25,000', '101/1', 'Sukhumvit', 'Klongtumru', 'MeungChonburi', 'Chon Buri', '20000');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('1', 'Jane','Smith', 'W', '2000-11-11', 'msjs@dizzy.com','5551234568', 'Seller', '15,000', '102/2', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('2','Clarence','Kentucky', 'W', '2000-12-05','ck@deemag.co.th','5559999999', 'General', '10,000', '103/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('2','Bruce','Bell', 'M', '2000-12-05','brucebell@deemag.co.th','0012311111', 'Manager', '30,000', '104/4', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('3', 'Clark','Kent', 'M', '2000-12-05','superman@dc.com','0011113451', 'Seller', '20,000', '105/5', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('3','Peter','Parker', 'M', '2000-02-05','spiderman@dc.com','0067891111', 'Seller', '20,000', '106/6', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

-- supplier
INSERT INTO supplier(supplier_name, address_no, sub_district, district, province, zipcode)
VALUES('Doble A', '400/1', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO supplier(supplier_name, address_no, street, sub_district, district, province, zipcode)
VALUES('Doble B', '401/2', 'Sukhumvit', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO supplier(supplier_name, address_no, street, sub_district, district, province, zipcode)
VALUES('Doble C', '402/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

INSERT INTO contactSupplier(supplier_id, email, phone) VALUES('1', 'doble.a@gmail.com', '090000554');
INSERT INTO contactSupplier(supplier_id, phone) VALUES('1', '0900000001');
INSERT INTO contactSupplier(supplier_id, email) VALUES('2', 'doble.b@gmail.com');
INSERT INTO contactSupplier(supplier_id, phone) VALUES('3', '0904500003');

INSERT INTO supplierProduct(product_id, supplier_id, quantity, status)
VALUES('1', '1', '20', 'Successful');
INSERT INTO supplierProduct(product_id, supplier_id, quantity, status)
VALUES('1', '2', '20', 'Successful');
INSERT INTO supplierProduct(product_id, supplier_id, quantity, status)
VALUES('1', '3', '20', 'Successful');
INSERT INTO supplierProduct(product_id, supplier_id, quantity, status)
VALUES('2', '2', '10', 'Pending');
INSERT INTO supplierProduct(product_id, supplier_id, quantity, status)
VALUES('3', '3', '30', 'Successful');
INSERT INTO supplierProduct(product_id, supplier_id, quantity, status)
VALUES('4', '3', '20', 'Successful');
COMMIT TRANSACTION;