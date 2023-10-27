PRAGMA foreign_keys = ON; -- enable foreign key
PRAGMA encoding='UTF-8'; -- set encoding to UTF-8
.print "Delete testing"
-- set up database
.read setup.sql

-- show foreign key test of delete
SELECT * FROM contactStore;
DELETE FROM store WHERE store_id = 1; -- delete store_id 1
.print "Deleted"
SELECT * FROM contactStore; -- check result

-- Path: update_delete/delete.sql
