DROP INDEX if exists vrl_index
CREATE INDEX vrl_index ON order_data(date);

