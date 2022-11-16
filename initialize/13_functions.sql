drop function if exists count_changes(integer, integer);
create function count_changes(order_id integer, user_id integer) returns integer as $$
    select count(*) from order_data as od where od.order_id=order_id and od.author_id = user_id;
$$ language sql;