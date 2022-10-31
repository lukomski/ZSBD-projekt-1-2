DO $$
DECLARE
    client_name VARCHAR;
    country_id BIGINT;
    voivodeship_id BIGINT;
    postal_office_id BIGINT;
    street_id BIGINT;
    town_id BIGINT;
    address_id BIGINT;
    address_number varchar;
BEGIN
FOR r IN 1..100
	LOOP
        client_name = CONCAT('Client', r);
        country_id = (SELECT floor(random() * 10 + 1));
        voivodeship_id = (SELECT floor(random() * 10 + 1));
        postal_office_id = (SELECT floor(random() * 10 + 1));
        street_id = (SELECT floor(random() * 10 + 1));
        town_id = (SELECT floor(random() * 10 + 1));
        address_number = (SELECT floor(random() * 100 + 1));

        -- Create address for new client
        INSERT INTO addresses (country_id, voivodeship_id, postal_office_id, street_id, town_id, number) VALUES
        (country_id, voivodeship_id, postal_office_id, street_id, town_id, address_number) RETURNING id INTO address_id;

        -- Create new client
        INSERT INTO clients (name, address_id) VALUES (client_name, address_id);
        -- RAISE NOTICE 'address_id: %', address_id;
	END LOOP;
end $$;