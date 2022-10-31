DO $$
DECLARE
    user_name VARCHAR;
BEGIN
FOR r IN 1..100
    LOOP
        user_name = CONCAT('User', r);
        INSERT INTO users (name) VALUES (user_name);
    END LOOP;
END
$$;