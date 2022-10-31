--
-- Models
--
drop table if exists articles;
create table articles (
    id        BIGSERIAL PRIMARY KEY,
    name      text
);

drop table if exists packages;
create table packages (
    id  BIGSERIAL PRIMARY KEY
);

drop table if exists packageTypes;
create table packageTypes (
    id  BIGSERIAL PRIMARY KEY,
    name TEXT,
    dimmensions TEXT
);

drop table if exists orders;
create table orders (
    id  BIGSERIAL PRIMARY KEY
);

drop table if exists clients;
create table clients (
    id  BIGSERIAL PRIMARY KEY
);

drop table if exists orderStatus;
create table orderStatus(
    id  BIGSERIAL PRIMARY KEY,
    description TEXT
);

drop table if exists users;
create table users (
    id  BIGSERIAL PRIMARY KEY
);

--
-- References
--
drop table if exists packageTypesPackages;
create table packageTypesPackages (
    id  BIGSERIAL PRIMARY KEY,
    package_type_id BIGINT NOT NULL,
    package_id BIGINT NOT NULL,
    CONSTRAINT fk_package_type
      FOREIGN KEY(package_type_id) 
	  REFERENCES packageTypes(id),
    CONSTRAINT fk_package
      FOREIGN KEY(package_id) 
	  REFERENCES packages(id) 
);

drop table if exists ordersPackages;
create table ordersPackages (
    id  BIGSERIAL PRIMARY KEY,
    order_id BIGINT,
    package_id BIGINT,
    CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
	  REFERENCES orders(id),
    CONSTRAINT fk_package
      FOREIGN KEY(package_id) 
	  REFERENCES packages(id)
);

drop table if exists orderStatusOrder;
create table OrderStatusOrder (
    id  BIGSERIAL PRIMARY KEY,
    order_status_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    CONSTRAINT fk_order_status
      FOREIGN KEY(order_status_id) 
	  REFERENCES orderStatus(id),
    CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
	  REFERENCES orders(id) 
);

drop table if exists clientsOrders;
create table clientsOrders (
    id  BIGSERIAL PRIMARY KEY,
    sender_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    CONSTRAINT fk_sender
      FOREIGN KEY(sender_id) 
	  REFERENCES clients(id),
    CONSTRAINT fk_receiver
      FOREIGN KEY(receiver_id) 
	  REFERENCES clients(id),
    CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
	  REFERENCES orders(id)
);

drop table if exists usersOrderStatus;
create table usersOrderStatus (
    id  BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    order_status_id BIGINT NOT NULL,
    CONSTRAINT fk_user
      FOREIGN KEY(user_id) 
	  REFERENCES users(id),
    CONSTRAINT fk_order_status
      FOREIGN KEY(order_status_id) 
	  REFERENCES orderStatus(id)
);