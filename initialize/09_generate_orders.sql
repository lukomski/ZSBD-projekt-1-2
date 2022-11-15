
DO $$
    DECLARE
        od_description VARCHAR;
        order_id BIGINT;
        order_data_id BIGINT;
        sender_id BIGINT;
        receiver_id BIGINT;
        author_id BIGINT;
        package_id BIGINT;
        package_type_id BIGINT;
        weight FLOAT;
        order_date timestamp;
    BEGIN
    -- Create orders
    FOR order_r IN 1..100
        LOOP 
            if MOD(order_r, 1000) = 0 then
                RAISE NOTICE 'order_r: %', order_r;
            end if;
            INSERT INTO orders (id) VALUES (DEFAULT) RETURNING id INTO order_id;
            -- RAISE NOTICE 'order_id: %', order_id;
        
            -- Create order data
            FOR order_data_r IN 1..10
                LOOP
                    sender_id = (SELECT floor(random() * 10 + 1));
                    receiver_id = (SELECT floor(random() * 10 + 1));
                    author_id = (SELECT floor(random() * 10 + 1));
                    od_description = CONCAT('Order ', order_r, ' description ', order_data_r);
                    order_date = (select timestamp '2014-01-10 20:00:00' +
                            random() * (timestamp '2014-01-20 20:00:00' -
                            timestamp '2014-01-10 10:00:00'));

                    INSERT INTO order_data (order_id, description, date, sender_id, receiver_id, author_id) VALUES
                        (order_id, od_description, order_date, sender_id, receiver_id, author_id) RETURNING id INTO order_data_id;
                END LOOP;

            -- Create packages
            FOR package_r IN 1..10
                LOOP
                    package_type_id = (SELECT floor(random() * 10 + 1));
                    weight = (SELECT random() * 100 + 1);
                    od_description = CONCAT('Package descriptions ', order_r, ' package_r is ', package_r);

                    INSERT INTO packages (package_type_id, description, weight) VALUES
                        (package_type_id, od_description, weight) RETURNING id INTO package_id;

                    INSERT INTO order_data_packages (order_data_id, package_id) VALUES (order_data_id, package_id);
                END LOOP;
        END LOOP;
end $$;

