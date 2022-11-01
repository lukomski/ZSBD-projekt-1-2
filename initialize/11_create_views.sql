CREATE VIEW current_order_data_orders AS
SELECT p_odo.order_id as order_id,  p_od.id as order_current_id from order_data as p_od
    JOIN order_data_orders as p_odo ON p_odo.order_data_id = p_od.id
    JOIN 
        (SELECT max(odo.order_id) as order_id, max(od.date) as order_date, max(od.id) as oder_data_max_id from orders as o 
    LEFT JOIN order_data_orders as odo ON odo.order_id = o.id
    JOIN order_data as od ON od.id = odo.order_data_id
    GROUP BY odo.order_id
    ORDER BY order_date, oder_data_max_id
    )
        as ddd ON ddd.order_id = p_odo.order_id and ddd.order_date = p_od.date and ddd.oder_data_max_id = p_od.id
;

CREATE VIEW current_orders AS
select o.id as order_id, od.description as order_description, p.description as package_description, pt.name as package_type_name, p.weight as package_weight from orders as o
    JOIN current_order_data_orders as codo ON codo.order_id = o.id
    JOIN order_data as od ON codo.order_current_id = od.id
    JOIN order_data_packages as odp ON odp.order_data_id = od.id
    JOIN packages as p ON p.id = odp.package_id
    JOIN package_types as pt ON pt.id = p.package_type_id
;


select * from order_data as od order by od.date limit 1;