--
-- Model tables
--
DROP TABLE iF EXISTS countries;
CREATE TABLE countries (
    id        BIGSERIAL PRIMARY KEY,
    name      text
);

DROP TABLE iF EXISTS voivodeships;
CREATE TABLE voivodeships (
    id        BIGSERIAL PRIMARY KEY,
    name      text
);

DROP TABLE iF EXISTS streets;
CREATE TABLE streets (
    id        BIGSERIAL PRIMARY KEY,
    name      text
);

DROP TABLE iF EXISTS towns;
CREATE TABLE towns (
    id        BIGSERIAL PRIMARY KEY,
    name      TEXT
);

DROP TABLE iF EXISTS postal_offices;
CREATE TABLE postal_offices (
    id        BIGSERIAL PRIMARY KEY,
    zip_code  TEXT,
    town_id   BIGINT NOT NULL,
    CONSTRAINT fk_town
      FOREIGN KEY(town_id) 
	    REFERENCES towns(id)
);

DROP TABLE iF EXISTS addresses;
CREATE TABLE addresses (
    id                BIGSERIAL PRIMARY KEY,
    number            TEXT,
    country_id        BIGINT NOT NULL,
    voivodeship_id    BIGINT NOT NULL,
    postal_office_id  BIGINT NOT NULL,
    street_id         BIGINT NOT NULL,
    town_id           BIGINT NOT NULL,
    CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	    REFERENCES countries(id),
    CONSTRAINT fk_voivodeship
      FOREIGN KEY(voivodeship_id) 
	    REFERENCES voivodeships(id),
    CONSTRAINT fk_postal_office
      FOREIGN KEY(postal_office_id) 
	    REFERENCES postal_offices(id),
    CONSTRAINT fk_street
      FOREIGN KEY(street_id) 
	    REFERENCES streets(id),
    CONSTRAINT fk_town
      FOREIGN KEY(town_id) 
	    REFERENCES towns(id)
);

DROP TABLE iF EXISTS users;
CREATE TABLE users (
    id        BIGSERIAL PRIMARY KEY,
    name      TEXT
);

DROP TABLE iF EXISTS clients;
CREATE TABLE clients (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT,
    address_id  BIGINT NOT NULL,
    CONSTRAINT fk_address
      FOREIGN KEY(address_id) 
	    REFERENCES addresses(id)
);

DROP TABLE iF EXISTS order_data;
CREATE TABLE order_data (
    id           BIGSERIAL PRIMARY KEY,
    description  TEXT,
    date         TIMESTAMP,
    sender_id    BIGINT NOT NULL,
    receiver_id  BIGINT NOT NULL,
    author_id    BIGINT NOT NULL,
    CONSTRAINT fk_sender
      FOREIGN KEY(sender_id) 
	    REFERENCES clients(id),
    CONSTRAINT fk_receiver
      FOREIGN KEY(receiver_id) 
	    REFERENCES clients(id),
    CONSTRAINT fk_author
      FOREIGN KEY(author_id) 
	    REFERENCES users(id)
);

DROP TABLE iF EXISTS orders;
CREATE TABLE orders (
    id        BIGSERIAL PRIMARY KEY
);

DROP TABLE iF EXISTS package_types;
CREATE TABLE package_types (
    id        BIGSERIAL PRIMARY KEY,
    name      TEXT
);

DROP TABLE iF EXISTS packages;
CREATE TABLE packages (
    id          BIGSERIAL PRIMARY KEY,
    description TEXT,
    weight      SERIAL,
    package_type_id  BIGINT NOT NULL,
    CONSTRAINT fk_package_type
      FOREIGN KEY(package_type_id) 
	    REFERENCES package_types(id)
);

--
-- Reference tables
--

DROP TABLE iF EXISTS order_data_packages;
CREATE TABLE order_data_packages (
    id            BIGSERIAL PRIMARY KEY,
    order_data_id BIGINT NOT NULL,
    package_id    BIGINT NOT NULL,
    CONSTRAINT fk_order_data
      FOREIGN KEY(order_data_id) 
	    REFERENCES order_data(id),
    CONSTRAINT fk_package
      FOREIGN KEY(package_id) 
	    REFERENCES packages(id)
);

DROP TABLE iF EXISTS order_data_orders;
CREATE TABLE order_data_orders (
    id            BIGSERIAL PRIMARY KEY,
    order_data_id BIGINT NOT NULL,
    order_id    BIGINT NOT NULL,
    CONSTRAINT fk_order_data
      FOREIGN KEY(order_data_id) 
	    REFERENCES order_data(id),
    CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
	    REFERENCES orders(id)
);