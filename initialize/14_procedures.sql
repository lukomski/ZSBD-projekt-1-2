create or replace procedure update_order(order_id integer, description text, sender_id integer, receiver_id integer, author_id integer, package_ids integer[]) AS $$
    declare
        package_id integer;
        order_data_id bigint;
    begin
        insert into order_data (order_id, description, sender_id, receiver_id, author_id, date) values (order_id, description, sender_id, receiver_id, author_id, now()) returning id into order_data_id;
        raise NOTICE 'create order_data_id: %',order_data_id;
        foreach package_id in array package_ids
        loop 
            insert into order_data_packages(order_data_id, package_id) values (order_data_id, package_id);
        end loop;
    end;
$$ language plpgsql;

-- call update_order(1, 'halo miski 1', 1, 1, 1, array[1,2,3]);