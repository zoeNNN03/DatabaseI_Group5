PRAGMA foreign_key=ON;
.print 'Query02 : The amount of revenue of stores in 2023.'
SELECT store.store_name as 'Store Name',
    SUM(orderRecord.total_amount) as 'Total(BATH)'
FROM orderRecord
INNER JOIN employee ON employee.employee_id = orderRecord.employee_id
INNER JOIN store ON store.store_id = employee.store_id
WHERE orderRecord.status_order == 'Succeed' AND 
    strftime('%Y', orderRecord.date_order) = '2023'
GROUP BY store.store_id