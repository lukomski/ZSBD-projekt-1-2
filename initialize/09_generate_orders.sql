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
    BEGIN
    -- Create orders
    FOR order_r IN 1..100
        LOOP   
            INSERT INTO orders (id) VALUES (DEFAULT) RETURNING id INTO order_id;
            -- RAISE NOTICE 'order_id: %', order_id;
        
            -- Create order data
            FOR order_data_r IN 1..10
                LOOP
                    sender_id = (SELECT floor(random() * 10 + 1));
                    receiver_id = (SELECT floor(random() * 10 + 1));
                    author_id = (SELECT floor(random() * 10 + 1));
                    od_description = CONCAT('Order ', order_r, ' description ', order_data_r);

                    INSERT INTO order_data (description, sender_id, receiver_id, author_id) VALUES
                        (od_description, sender_id, receiver_id, author_id) RETURNING id INTO order_data_id;

                    INSERT INTO order_data_orders (order_data_id, order_id) VALUES (order_data_id, order_id);
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

