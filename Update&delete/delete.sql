PRAGMA foreign_keys = ON;
PRAGMA encoding='UTF-8';

SELECT * FROM contactStore;

DELETE FROM store WHERE store_id = 4;
.print "Deleted"

SELECT * FROM contactStore;