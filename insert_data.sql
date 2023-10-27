PRAGMA foreign_keys = ON;
PRAGMA encoding='UTF-8';
BEGIN TRANSACTION;
-- store
INSERT INTO store(store_name, store_account, address_no, street, sub_district, district, province, zipcode)
VALUES('BUUshop test', '5829637697', '169 Student Activity Center Building', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO store(store_name, store_account, address_no, street, sub_district, district, province, zipcode)
VALUES('BUUshop', '9239980822', '169 Soi Bang Saen Sai 4 Tai 2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO store(store_name, store_account, address_no, street, sub_district, district, province, zipcode)
VALUES('Mr.Johnshop', '9862303919', '169 Soi Bang Saen Sai 4 Tai 2', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

-- contactStore
INSERT INTO contactStore(store_id, email, phone) VALUES('1', 'Burapha.buu@gmail.com', '0863061683');
INSERT INTO contactStore(store_id, email, phone) VALUES('2', 'BUUshop@buu.ac.th','0886982864');

-- product
INSERT INTO product(product_upc, product_name, brand, category, size, unit_price)
VALUES('036000291452', 'T-shirt', 'BUU', 'clothes', 'S', '380');
INSERT INTO product(product_upc, product_name, category, size, unit_price, description)
VALUES('036000291453', 'Slacks', 'clothes', 'XL', '420', 'Student pants');
INSERT INTO product(product_upc, product_name, brand, category, unit_price)
VALUES('136000291452', 'Pen', 'Lancer', 'stationery', '20');
INSERT INTO product(product_upc, product_name, brand, category, unit_price, description)
VALUES('236000291452', 'Python101', 'Chula', 'book', '285', 'Learn tutorial python');

-- customer
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

-- employee
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('1', 'John','Smith', 'M', '1973-10-03','mrjs@dizzy.com','5551234567', 'Manager', '25000', '101/1', 'Sukhumvit', 'Klongtumru', 'MeungChonburi', 'Chon Buri', '20000');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('1', 'Jane','Smith', 'F', '2000-11-11', 'msjs@dizzy.com','5551234568', 'Seller', '15000', '102/2', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('2','Clarence','Kentucky', 'F', '2000-12-05','ck@deemag.co.th','5559999999', 'Cashier', '10000', '103/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, street, sub_district, district, province, zipcode)
VALUES('2','Bruce','Bell', 'M', '2000-12-05','brucebell@deemag.co.th','0012311111', 'Manager', '30000', '104/4', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('3', 'Clark','Kent', 'M', '2000-12-05','superman@dc.com','0011113451', 'Seller', '20000', '105/5', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO employee(store_id, f_name, l_name, gender, birthday, email, phone, job_position, salary, address_no, sub_district, district, province, zipcode)
VALUES('3','Peter','Parker', 'M', '2000-02-05','spiderman@dc.com','0067891111', 'Cashier', '20000', '106/6', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

-- supplier
INSERT INTO supplier(supplier_name, supplier_account, address_no, sub_district, district, province, zipcode)
VALUES('Doble A', '8907285498', '400/1', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO supplier(supplier_name, supplier_account, address_no, street, sub_district, district, province, zipcode)
VALUES('Doble B', '7372677905','401/2', 'Sukhumvit', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');
INSERT INTO supplier(supplier_name, supplier_account, address_no, street, sub_district, district, province, zipcode)
VALUES('Doble C', '8171914542','402/3', 'Long Had Bangsaen Rd', 'Saen Suk', 'Chon Buri District', 'Chon Buri', '20131');

-- contactSupplier
INSERT INTO contactSupplier(supplier_id, email, phone) VALUES('1', 'doble.a@gmail.com', '0900005544');
INSERT INTO contactSupplier(supplier_id, phone) VALUES('1', '0900000001');
INSERT INTO contactSupplier(supplier_id, email) VALUES('2', 'doble.b@gmail.com');
INSERT INTO contactSupplier(supplier_id, phone) VALUES('3', '0904500003');

-- storeProduct
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

-- orderRecord
INSERT INTO orderRecord(customer_id, employee_id, date_order, order_status, online_status)
VALUES('1', '1', '2022-10-15', 'Completed', '0');
INSERT INTO orderRecord(customer_id, employee_id, date_order, order_status, online_status)
VALUES('1', '2', '2023-10-14', 'Pending', '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, order_status, online_status)
VALUES('2', '3', '2023-09-15', 'Completed', '0');
INSERT INTO orderRecord(customer_id, employee_id, date_order, order_status, online_status)
VALUES('4', '4', '2023-07-15', 'Pending', '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, order_status, online_status)
VALUES('5', '5', '2023-10-15', 'Completed', '1');
INSERT INTO orderRecord(customer_id, employee_id, date_order, order_status, online_status)
VALUES('6', '6', '2023-10-15', 'Completed', '1');

-- orderItem
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('1', 1, '1', '1');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('1', 2, '1', '10');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('2', 2, '1', '5');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('3', 3, '2', '10');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('3', 4, '2', '1');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('4', 1, '2', '3');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('4', 2, '3', '1');
INSERT INTO orderItem(order_id, product_id, store_id, quantity)
VALUES('6', 4, '3', '20');

-- payment
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

-- delivery
INSERT INTO delivery(supplier_id, store_id, product_id, date_delivery, cost, quantity, delivery_status)
VALUES('1', '1', 1, '2022-10-22', '1000', '20', 'Completed');
INSERT INTO delivery(supplier_id, store_id, product_id, date_delivery, cost, quantity, delivery_status)
VALUES('2', '1', 3, '2022-11-22', '1500', '20', 'Completed');
INSERT INTO delivery(supplier_id, store_id, product_id, date_delivery, cost, quantity, delivery_status)
VALUES('2', '2', 3, '2022-12-22', '500', '20', 'Completed');
INSERT INTO delivery(supplier_id, store_id, product_id, date_delivery, cost, quantity, delivery_status)
VALUES('1', '2', 2, '2023-01-22', '1000', '10', 'Pending');
INSERT INTO delivery(supplier_id, store_id, product_id, date_delivery, cost, quantity, delivery_status)
VALUES('3', '3', 3, '2023-02-22', '400', '30', 'Completed');
INSERT INTO delivery(supplier_id, store_id, product_id, date_delivery, cost, quantity, delivery_status)
VALUES('3', '3', 4, '2023-03-22', '1000', '20', 'Completed');
.print 'Successfully inserted example'
COMMIT TRANSACTION;
