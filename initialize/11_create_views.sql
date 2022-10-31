CREATE VIEW current_order_data_orders AS
SELECT odo.order_id as order_id, max(odo.order_data_id) as order_data_max_id from orders as o 
    LEFT JOIN order_data_orders as odo ON odo.order_id = o.id
    GROUP BY odo.order_id
    ORDER BY order_id
;

CREATE VIEW current_orders AS
select o.id as order_id, od.description as order_description, p.description as package_description, pt.name as package_type_name, p.weight as package_weight from orders as o
    JOIN current_order_data_orders as codo ON codo.order_id = o.id
    JOIN order_data as od ON codo.order_data_max_id = od.id
    JOIN order_data_packages as odp ON odp.order_data_id = od.id
    JOIN packages as p ON p.id = odp.package_id
    JOIN package_types as pt ON pt.id = p.package_type_id
;
