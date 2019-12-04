USE tnstc_db;
DROP PROCEDURE IF EXISTS tnstc_ticket_booking;
DELIMITER ||
SET autocommit = 0||
START TRANSACTION||
CREATE PROCEDURE tnstc_ticket_booking(
	IN user_id int,
	IN bus_id int,
	IN pickup_point int,
	IN drop_point int,
	IN number_of_bus_seats int,
	IN amount double(15,2)
)

BEGIN
    DECLARE bookedSeats int DEFAULT 0;
    DECLARE busSeats int DEFAULT 0;
    DECLARE availableSeats int DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		SELECT 'ticket booking is failed' AS message;
		ROLLBACK to bookticket;
	END;
	BEGIN
    SAVEPOINT bookticket;
		SELECT IFNULL(SUM(bookTicket.number_of_seat),0) INTO bookedSeats FROM book_tickets bookTicket WHERE bookTicket.bus_id = bus_id;
        SELECT number_of_seats INTO busSeats FROM buses WHERE id = bus_id;
        SET availableSeats = busSeats - bookedSeats;
        IF availableSeats >= number_of_bus_seats THEN
			INSERT INTO book_tickets(
				user_id,
				bus_id,
				pickup_point_id,
				drop_point_id,
				number_of_seat,
				amount
			) VALUES(
				user_id,
				bus_id,
				pickup_point,
				drop_point,
				number_of_bus_seats,
				amount
			);
	SAVEPOINT wallet;
			UPDATE user_wallet SET user_wallet.amount = user_wallet.amount - amount WHERE user_wallet.user_id = user_id;
			SELECT 'ticket booking is success' AS message;
			COMMIT;
		ELSE
			SELECT 'Bus seats is not available' AS message;
        END IF;
    END;
END||
DELIMITER ;
CALL tnstc_ticket_booking(1,1,1,2,5,5000);

SELECT * FROM book_tickets;
SELECT * FROM users;
SELECT * FROM user_wallet;
INSERT INTO users(
	name,
    email,
    password
) VALUES(
	'krishna',
    'krishna@gmail.com',
    'pass123'
);
INSERT INTO user_wallet(user_id,amount)VALUES(
	1,
    1500.05
);
INSERT INTO bus_categories(
	category	
)VALUES(
	'ULTRA DELUX'
);
INSERT INTO buses(
	bus_number,
    bus_category_id,
    number_of_seats
) VALUES(
	'TN1009',
    1,
    80
);
INSERT INTO cities(
	city
)VALUES(
	'madurai'
);
