# Entity-Relationship Diagrams Group 5
update: 2023/10/25

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

1. What If GM want to knows top3 of best-selling product of the store in university and know a total price of it for develop marketing better more than before
2. What If GM want to know about the amount of revenue of BUU Store in 2023
3. What If GM want to know about details of your Online order how can you explain to them
4. What if show top3 of your employee measured by income received
5. What if show describe product information Shipping status and destination, including contact information of delivery, where the sending status is Pending

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
   7.1 update_delete/update.sql
   7.2 update_delete/delete.sql

## Attribute detail
1. The DATE data type fields (example payment date, birthday, etc.) that use the yyyy-mm-dd format and complex validation CHECK constraints
   to ensure that inserted dates are correct. Accurate data is measured from these.
   -- jan, march, may, july, august, october, and december have 31 days
   -- april, june, september, and november have 30 days
   -- feburary has 28 days except leap years when it has 29 days
   -- leap years occur with these rules:
   -- Every year evenly divisible by 4 is a leap year
   -- EXCEPT every year evenly divisible 100 is not a leap year
   -- UNLESS it is evenly divisible by 400
   To perform these checks we use the GLOB operator, strftime, CAST, and CASE in a CHECK constraint.

2. employee, customer has a gender field supporting:
   M male
   F female
   H hermaphrodite

3. [name]_id is the primary key of each entity example produch_id, customer_id.

4. [name]_status is is the status of each available action.
   'Pending',
   'Cancelled',
   'Completed'
   for example delivery.status is the status of delivery

5. orderRecord has a online_status field is to verify that the order has been made. Is it an online order?
   1 is online order
   0 isn't online order

6. In the table with information about the amount Remember that the data is decimal. The program uses the REAL datatype and all units of
   the data are in baht.

7. In the table with information about quantity units Remember that data is EA volume.

8. product has a size field support only clothes('S', 'M', 'L', 'XL', '2XL', '3XL').

9. product has a product_id field using only UPC qrcode and has a CHECK constraint to check whether the characters are 12 or not
   because UPC qrcode only contains 12 digits.

10. In us code have mutivalue attribute. We know sqlite3 not support but We studied the data and found that the data can be stored in
    separate tables(contactStore, contactSupplier). Because 1 of our query has to query such information. Therefore, we request permission not to edit the information. Apologies for such mistake.
