PRAGMA foreign_keys = ON;
PRAGMA encoding='UTF-8';
.print "Delete testing"
.read setup.sql
.read insert_data.sql
SELECT * FROM contactStore;
DELETE FROM store WHERE store_id = 1;
.print "Deleted"
SELECT * FROM contactStore;