PRAGMA foreign_key=ON;
.print 'Query03 : Information about products ordered online.'
SELECT orderRecord.order_id AS 'Order NO.',
    employee.f_name||' '||employee.l_name AS 'Employee',
    store.store_name as 'Store',
    customer.f_name||' '||customer.l_name AS 'Customer',
    orderRecord.total_amount AS 'Amount',
    status_order AS 'Order Status',
    payment_status AS 'Payment Status'
FROM orderRecord
INNER JOIN employee ON employee.employee_id = orderRecord.employee_id
INNER JOIN store ON store.store_id = employee.store_id
INNER JOIN customer ON customer.customer_id = orderRecord.customer_id
INNER JOIN payment ON payment.order_id = orderRecord.order_id
WHERE orderRecord.online_status = 1;