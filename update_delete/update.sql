PRAGMA foreign_keys = ON; -- enable foreign key
PRAGMA encoding='UTF-8'; -- set encoding to UTF-8
.print "Update testing"
-- set up database
.read ../setup.sql
.read ../insert_data.sql

-- show foreign key test of update
SELECT * FROM contactStore;
UPDATE store SET store_id = 4 -- update store_id 1 to 4
WHERE store_name = 'BUUshop test'; -- update store_name 'BUUshop test' to 'BUUshop'
.print "Updated"
SELECT * FROM contactStore; -- check result

-- Path: update_delete/update.sql