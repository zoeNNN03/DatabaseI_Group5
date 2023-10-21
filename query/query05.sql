PRAGMA foreign_keys = ON;
.print 'Query05: Suppliers with Pending Deliveries.'
SELECT
    supplier.supplier_name AS "Supplier Name",
    product.product_name AS "Product Name",
    store.store_name AS "Store Name",
    date_delivery AS "Delivery Date",
    quantity AS "Quantity",
    cost AS "Cost",
    GROUP_CONCAT(contactSupplier.email, ', ') AS "Email",
    GROUP_CONCAT(contactSupplier.phone, ', ') AS "Contact",
    delivery.status AS "Status"
FROM supplier
INNER JOIN contactSupplier ON supplier.supplier_id = contactSupplier.supplier_id
INNER JOIN delivery ON supplier.supplier_id = delivery.supplier_id
INNER JOIN product ON product.product_id = delivery.product_id
INNER JOIN store ON store.store_id = delivery.store_id
WHERE delivery.status = 'Pending'
GROUP BY supplier.supplier_id;