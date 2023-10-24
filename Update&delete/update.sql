PRAGMA foreign_keys = ON;
PRAGMA encoding='UTF-8';
.print "Update testing"
.read setup.sql
.read insert_data.sql
SELECT * FROM contactStore;
UPDATE store SET store_id = 4
WHERE store_name = 'BUUshop test';
.print "Updated"
SELECT * FROM contactStore;