drop view if exists last_order_data_id_for_order_id;
create view last_order_data_id_for_order_id as
    select od.order_id, (select odi.id from order_data as odi where odi.order_id = od.order_id order by odi.date desc limit 1) as order_data_id from order_data as od
        group by od.order_id
        order by od.order_id
;

drop view if exists orders_status;
create view orders_status as
    select o.id as order_id, od.id as order_data_id, od.description, od.date, cs.name as sender_name, cr.name as receiver_name, u.name as worker from orders as o
        join last_order_data_id_for_order_id as l on l.order_id = o.id
        join order_data as od on l.order_data_id = od.id
        join clients as cs on cs.id = od.sender_id
        join clients as cr on cr.id = od.receiver_id
        join users as u on u.id = od.author_id
;