PRAGMA foreign_key = ON;
PRAGMA encoding='UTF-8';
BEGIN TRANSACTION;
UPDATE storeProduct SET store_id = 1
WHERE store_id = 4;
COMMIT TRANSACTION;

select * from employee where store_id = 4;