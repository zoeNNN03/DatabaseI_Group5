PRAGMA foreign_keys = ON;
.print 'Query05: Suppliers with Pending Deliveries.'
SELECT
    supplier.supplier_name AS "Supplier Name",
    product.product_name AS "Product Name",
    store.store_name AS "Store Name",
    date_delivery AS "Delivery Date",
    quantity AS "Quantity",
    cost AS "Cost(BATH)",
    -- group concat for get all email and phone in one row if there are more than one contact of each supplier
    GROUP_CONCAT(contactSupplier.email, ', ') AS "Email",
    GROUP_CONCAT(contactSupplier.phone, ', ') AS "Contact",
    delivery.delivery_status AS "Status"
FROM supplier
INNER JOIN contactSupplier ON supplier.supplier_id = contactSupplier.supplier_id
INNER JOIN delivery ON supplier.supplier_id = delivery.supplier_id
INNER JOIN product ON product.product_id = delivery.product_id
INNER JOIN store ON store.store_id = delivery.store_id
WHERE delivery.delivery_status = 'Pending' -- get only pending delivery
GROUP BY supplier.supplier_id; -- group by supplier id for get only one row of each supplier

-- Path: query/query05.sql