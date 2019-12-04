CREATE SCHEMA tnstc_db;
USE tnstc_db;
CREATE TABLE users(
	id int AUTO_INCREMENT,
	name varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	password varchar(50) NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp,
	CONSTRAINT pk_user_id PRIMARY KEY(id),
    CONSTRAINT uk_email UNIQUE(email)
);
CREATE TABLE bus_categories(
	id int AUTO_INCREMENT,
	category varchar(50) NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp,
	CONSTRAINT pk_bus_category_id PRIMARY KEY(id)
);
CREATE TABLE buses(
	id int AUTO_INCREMENT,
	bus_number varchar(20),
	bus_category_id int NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp,
	CONSTRAINT pk_buses_id PRIMARY KEY(id),
	CONSTRAINT fk_bus_category_id FOREIGN KEY(bus_category_id) REFERENCES bus_categories(id)
);
ALTER TABLE buses ADD number_of_seats int NOT NULL;
DESC buses;
CREATE TABLE cities(
	id int AUTO_INCREMENT,
	city_name varchar(50),
	CONSTRAINT pk_cities_id PRIMARY KEY(id)
);
CREATE TABLE book_tickets(
	id int AUTO_INCREMENT,
	user_id int,
	bus_id int NOT NULL,
	pickup_point_id int NOT NULL,
	drop_point_id int NOT NULL,
	amount double(15,2) NOT NULL,
	number_of_seat int NOT NULL, 
	CONSTRAINT pk_bookticket_id PRIMARY KEY(id),
	CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES users(id),
	CONSTRAINT fk_pickup_point_id FOREIGN KEY(pickup_point_id) REFERENCES cities(id),
	CONSTRAINT fk_drop_point_id FOREIGN KEY(drop_point_id) REFERENCES cities(id),
	CONSTRAINT fk_bus_id FOREIGN KEY(bus_id) REFERENCES buses(id),
    CONSTRAINT ck_number_of_seat CHECK(number_of_seat >= 0)
);
CREATE TABLE user_wallet(
	id int AUTO_INCREMENT,
    user_id int NOT NULL,
	amount double(15,2) NOT NULL,
	CONSTRAINT pk_user_wallet_id PRIMARY KEY(id),
    CONSTRAINT fk_userwallet_id FOREIGN KEY(user_id) REFERENCES users(id),
	CONSTRAINT ck_amount CHECK(amount > 0)
);
