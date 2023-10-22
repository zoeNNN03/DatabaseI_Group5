# Entity-Relationship Diagrams Group 5

## Member

65160035 Jakkarin Phunjhob
65160056 Sunita Sathianjarukarn
65160138 Thanpisit Jantakate
65160282 Wasupakkanut Wattanakul
65160284 Veerapat Saardiem
65160404 Nuengthida Wongphuttha

## Project Detail

์Name: Cooperative store in Burapha University, Bangsaen Campus
Subject: 89033064 Database I
Description: From surveying the cooperative store within Burapha University, Bangsaen Campus, we found that if combined with the cooperative store of Burapha Bumpen School in Bangsaen, there would be two current cooperative stores. And in the future, the number might increase. Therefore, we design database for streamline the operations and data access of stores into one database. This will make managing cooperative stores within Burapha University, Bangsaen Campus more efficient..
'What if?' questions

1. What if
2. What if
3. What if
4. What if
5. What if

## How to use this code?

After unzip file.

1. Install sqlite(https://www.sqlite.org/download.html) to ../ProjectDBclass
2. Run terminal or cmd, and change directory to ../ProjectDBclass
3. Run './sqlite3.exe [your database or ./mydb.db]'.
4. Use '.read setup.sql' to create tables, if nothing goes wrong the names of all tables will be displayed.
5. Use '.read insert_data.sql' for insert example data.
6. Try using the query command from folder "query".
   6.1 query/query01.sql
   6.2 query/query02.sql
   6.3 query/query03.sql
   6.4 query/query04.sql
   6.5 query/query05.sql
7. Try using the update&delete command from folder "update&delete".
   7.1 update&delete/update.sql
   7.2 update&delete/delete.sql

## Attribute detail

name_id is the primary key of each entity.

Product entity => product_id is UPC qrcode only.

[delivery.status, orderRecord.status_order, orderRecord.only_status, payment.payment_status] => status is the status of each action. For example, delivery.status is the status of delivery.

[orderRecord.only_status] => Online status is to verify that the order has been made. Is it an online order? If yes, it will have a value of 1. else, it will have a value of 0.

[delivery.cost, employee.salary, payment.payment_tax, payment.payment_discount, product.unit_price] => The currency of all entities is baht only.

[delivery.quantity, orderItem.quantity, product.stock, storeProduct.quantity] => The quantity unit for every entity is EA.
