PRAGMA foreign_key=ON;
.print 'Query05 : Check the name and contact channel of the 1st supplier and the delivered products.'
SELECT DISTINCT(supplier.supplier_name),
    product.product_name,
    product.brand,
    product.size,
    product.image_url,
    delivery.quantity,
    delivery.status
FROM delivery
INNER JOIN product ON product.product_id = delivery.product_id
INNER JOIN supplier ON supplier.supplier_id = delivery.supplier_id
WHERE supplier.supplier_id = 1;

SELECT supplier_name, email, phone
FROM contactSupplier
LEFT JOIN supplier ON contactSupplier.supplier_id = supplier.supplier_id
WHERE supplier.supplier_id = 1;