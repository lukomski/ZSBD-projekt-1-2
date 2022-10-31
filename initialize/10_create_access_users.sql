-- Create users
CREATE USER joe;
CREATE USER olivia;
CREATE USER emma;
CREATE USER oliver;

-- Create groups
CREATE GROUP observers;
CREATE GROUP office_workers;
CREATE GROUP managers;

-- Grant privelages for groups
DO
$$
DECLARE
   rec   record;
BEGIN
   FOR rec IN
      SELECT *
      FROM   pg_tables
      WHERE schemaname = 'public'
      ORDER  BY tablename
   LOOP
    EXECUTE 'GRANT SELECT ON ' || rec.tablename || ' TO observers';
    EXECUTE 'GRANT SELECT ON ' || rec.tablename || ' TO office_workers';
    EXECUTE 'GRANT SELECT ON ' || rec.tablename || ' TO managers';

    EXECUTE 'GRANT INSERT ON ' || rec.tablename || ' TO office_workers';
    EXECUTE 'GRANT INSERT ON ' || rec.tablename || ' TO managers';

    EXECUTE 'GRANT UPDATE ON ' || rec.tablename || ' TO managers';
   END LOOP;
END
$$;

-- Grant users to groups
ALTER GROUP observers ADD USER joe, olivia;
ALTER GROUP office_workers ADD USER emma;
ALTER GROUP managers ADD USER oliver;