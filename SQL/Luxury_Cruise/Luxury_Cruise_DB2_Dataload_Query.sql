CONNECT TO SAMPLE;

-- Insert data into dimention cruise_accomodation

INSERT INTO cruise_accomodation (id_accomodation, room_capacity, room_type) 
VALUES 
(1, 2, 'standard'), 
(2, 3, 'VIP'),
(3, 2, 'premium');


-- Insert data into dimention cruise_tickets

INSERT INTO cruise_tickets (id_tickets, purchase_date, departure_date, arrival_date, ticket_price)
VALUES
(1, '2019-02-04', '2019-03-23', '2019-05-31',25000),
(2, '2019-09-22', '2019-09-23', '2019-11-23',40000),
(3, '2019-09-11', '2019-06-20', '2019-08-20', 30000); 


-- Insert data into dimention cruise_crew

Insert into cruise_crew (id_crew, crew_name, crew_age, crew_title, crew_salary)
Values 
(1, 'jack sparrow', 35, 'captain', 15000), 
(2, 'blackbeard theslayer', 35, 'vice-captain', 10000),
(3, 'redmond redbeard', 28, 'steward', 8000),
(4, 'christopher columbus', 23, 'junior steward', 5000);

-- Insert data into dimention cruise_ships

INSERT INTO cruise_ships (id_ships, ship_name, ship_capacity, ship_maintenance_cost) 
VALUES
(1, 'barco1', 1500, 300), 
(2, 'barco2', 2000, 500),
(3, 'barco3', 2500, 600);


-- Insert data into dimention cruise_routes

INSERT INTO cruise_routes (id_routes, route_origin, route_destination, route_cost) 
VALUES 
(1, 'germany','france', 1000), 
(2, 'turkey', 'greece', 1500),
(3, 'sweden','italy', 2000);

-- Insert data into dimension cruise_supply

INSERT INTO cruise_supply (id_supply, supply_family, supply_name, supply_tonnes, supply_cost)
VALUES
(1, 'drinks', 'coca-cola', 10, 3000),
(2, 'food', 'hamburger', 11, 4000),
(3, 'food','potatoes', 15, 2000),
(4, 'drinks', 'pepsi', 20, 6000),
(5, 'beauty', 'products', 3, 2500);


-- insert data into dimention cruise_passengers 

insert into cruise_passengers (id_passengers, passenger_name, passenger_age, 
	passenger_gender, passenger_country)
Values 
(1, 'cheer', 27, 'female', 'taiwan'),
(2, 'anup', 27, 'male', 'nepal'),
(3, 'juliana', 30, 'female', 'colombia'),
(4, 'ignacio', 23, 'male', 'lebanon'),
(5, 'varun', 27, 'male', 'india'),
(6, 'eduardo', 26, 'male', 'spain'),
(7, 'esther', 23, 'female', 'canada');


-- insert data into dimention cruise_amenities

INSERT INTO cruise_amenities (id_amenities, amenities_name, 
	amenities_type, amenities_price)
VALUES 
(1, 'honest green', 'restaurant', 20),
(2, 'bo fin', 'bar', 15),
(3, 'iggy spa', 'spa', 50),
(4, 'casino royale', 'casino', 100),
(5, 'cineplex', 'cinema', 5);

-- Insert data into the fact_table luxury_cruise

INSERT INTO luxury_cruise (id_luxury_cruise, id_ships, id_tickets, id_passengers, id_amenities, 
	id_routes, id_crew, id_accomodation, id_supply) 
VALUES 
	(1, 1, 1, 1, 1, 1, 1, 1, 1),
	(2, 1, 2, 2, 2, 2, 2, 2, 2),
	(3, 1, 3, 3, 3, 3, 3, 3, 3),
	(4, 2, 1, 4, 4, 1, 4, 1, 4),
	(5, 2, 2, 5, 5, 2, 1, 1, 5),
	(6, 2, 3, 6, 1, 3, 2, 2, 1),
	(7, 3, 1, 7, 2, 1, 3, 3, 2),
	(8, 3, 2, 7, 3, 2, 3, 3, 3),
    (9, 3, 3, 7, 4, 3, 3, 3, 4),
    (10, 3, 1, 1, 5, 3, 3, 3, 5);
