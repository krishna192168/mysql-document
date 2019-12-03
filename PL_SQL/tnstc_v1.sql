CREATE SCHEMA tnstc_db;
USE tnstc_db;
CREATE TABLE tnstc_user(
	id int AUTO_INCREMENT,
	name varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	password varchar(50) NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp,
	CONSTRAINT pk_user_id PRIMARY KEY(id),
    CONSTRAINT uk_email UNIQUE(email)
);
CREATE TABLE tnstc_bus_type(
	id int AUTO_INCREMENT,
	category varchar(50) NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp,
	PRIMARY KEY(id)
);
CREATE TABLE tnstc_bus(
	id int AUTO_INCREMENT,
	bus_number varchar(20),
	bus_type_id int NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp,
	PRIMARY KEY(id),
	FOREIGN KEY(bus_type_id) REFERENCES tnstc_bus_type(id)
);
ALTER TABLE tnstc_bus ADD number_of_seats int NOT NULL;
DESC tnstc_bus;
CREATE TABLE tnstc_city(
	id int AUTO_INCREMENT,
	city varchar(50),
	PRIMARY KEY(id)
);
CREATE TABLE book_ticket(
	id int AUTO_INCREMENT,
	user_id int,
	bus_id int NOT NULL,
	pickup_point_id int NOT NULL,
	drop_point_id int NOT NULL,
	amount double(15,2) NOT NULL,
	number_of_seat int NOT NULL, 
	CONSTRAINT pk_bookticket_id PRIMARY KEY(id),
	CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES tnstc_user(id),
	CONSTRAINT fk_pickup_point_id FOREIGN KEY(pickup_point_id) REFERENCES tnstc_city(id),
	CONSTRAINT fk_drop_point_id FOREIGN KEY(drop_point_id) REFERENCES tnstc_city(id),
	CONSTRAINT fk_bus_id FOREIGN KEY(bus_id) REFERENCES tnstc_bus(id),
    CONSTRAINT ck_number_of_seat CHECK(number_of_seat >= 0)
);
CREATE TABLE user_wallet(
	id int AUTO_INCREMENT,
    user_id int NOT NULL,
	amount double(15,2) NOT NULL,
	CONSTRAINT pk_user_wallet_id PRIMARY KEY(id),
    CONSTRAINT fk_wallet_user_id FOREIGN KEY(user_id) REFERENCES tnstc_user(id),
	CONSTRAINT ck_amount CHECK(amount > 0)
);