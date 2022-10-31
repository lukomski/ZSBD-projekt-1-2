DO $$
DECLARE
    town_name varchar;
    town_id BIGINT;
    zip0 varchar;
    zip1 varchar;
    zip2 varchar;
    zip3 varchar;
    zip4 varchar;
    zip varchar;
BEGIN
FOR town_id, town_name IN SELECT * FROM towns
	LOOP
    zip0 = (SELECT floor(random() * 10));
    zip1 = (SELECT floor(random() * 10));
    zip2 = (SELECT floor(random() * 10));
    zip3 = (SELECT floor(random() * 10));
    zip4 = (SELECT floor(random() * 10));
    zip = (CONCAT(zip0, zip1, '-', zip2, zip3, zip4));
    -- RAISE NOTICE 'zip: %', zip;
    INSERT INTO postal_offices(town_id, zip_code) VALUES (town_id, zip);
	END LOOP;
END$$;