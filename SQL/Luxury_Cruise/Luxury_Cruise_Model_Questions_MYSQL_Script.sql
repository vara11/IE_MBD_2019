-- Which are the top 3 demanding services on board?

SELECT amenities_name, amenities_price,
	COUNT(luxury_cruise.id_amenities) AS number_of_services,
	amenities_price * COUNT(luxury_cruise.id_amenities) AS services_revenue
FROM luxury_cruise
	INNER JOIN cruise_amenities
		ON luxury_cruise.id_amenities = cruise_amenities.id_amenities
GROUP BY amenities_name
ORDER BY services_revenue DESC
LIMIT 3;

-- Show the average number of tons of food & drinks needed per day

SELECT supply_family, 
	(AVG(supply_tonnes)) AS avg_tonnes_per_trip,
	(AVG(datediff(arrival_date, departure_date))) AS avg_trip_days,
	ROUND(
	(
		(AVG(supply_tonnes)) /
		(AVG(datediff(arrival_date, departure_date)))),2)
		AS avg_tonnes_per_day
FROM luxury_cruise
	INNER JOIN cruise_supply
		ON luxury_cruise.id_supply = cruise_supply.id_supply
     INNER JOIN cruise_tickets
		ON luxury_cruise.id_tickets = cruise_tickets.id_tickets
GROUP BY supply_family
HAVING supply_family IN ("drinks", "food");

-- How much money will be lost per day, if a ship is under repair

SELECT ship_name, 
	SUM(ticket_price) as ticket_revenue, 
	SUM(amenities_price) as amenities_revenue, 
	ship_maintenance_cost, 
	(-ship_maintenance_cost-SUM(ticket_price)-SUM(amenities_price)) AS loss,
	(AVG(datediff(arrival_date, departure_date))) AS avg_trip_days,
	ROUND(
			((-ship_maintenance_cost-SUM(ticket_price)-SUM(amenities_price))) / 
			(AVG(datediff(arrival_date, departure_date))),2) AS loss_per_day
FROM luxury_cruise 
	INNER JOIN cruise_tickets 
		ON luxury_cruise.id_tickets = cruise_tickets.id_tickets
	INNER JOIN cruise_ships
		ON luxury_cruise.id_ships = cruise_ships.id_ships
	INNER JOIN cruise_amenities 
		ON luxury_cruise.id_amenities = cruise_amenities.id_amenities
GROUP BY ship_name;

-- -- Which is the most profitable cruise route(include seasons)?

SELECT 
	CASE WHEN ((month(departure_date) >= 3 AND month(arrival_date) <= 5)) THEN "spring"
		WHEN ((month(departure_date) >= 12 AND month(arrival_date) <= 2)) THEN "winter"
        WHEN ((month(departure_date) >= 6 AND month(arrival_date) <= 8)) THEN "summer"
        WHEN ((month(departure_date) >= 9 AND month(arrival_date) <= 11)) THEN "fall"
        ELSE 0 END AS season,
	concat(route_origin," -> ", route_destination) AS Routes, 
	SUM(ticket_price) AS ticket_revenue,
    SUM(amenities_price) AS amenities_revenue,
    route_cost,
    SUM(crew_salary) AS salary_cost,
    (SUM(ticket_price) +  SUM(amenities_price) - route_cost -  SUM(crew_salary)) AS route_profit 
FROM luxury_cruise 
	INNER JOIN cruise_ships
		ON luxury_cruise.id_ships = cruise_ships.id_ships
	INNER JOIN cruise_tickets
		ON luxury_cruise.id_tickets = cruise_tickets.id_tickets
	INNER JOIN cruise_amenities
		ON luxury_cruise.id_amenities = cruise_amenities.id_amenities
	INNER JOIN cruise_crew
		ON luxury_cruise.id_crew = cruise_crew.id_crew
	INNER JOIN cruise_routes
		ON luxury_cruise.id_routes = cruise_routes.id_routes
 GROUP BY 
	CASE WHEN ((month(departure_date) >= 3 AND month(arrival_date) <= 5)) THEN "spring"
		WHEN ((month(departure_date) >= 12 AND month(arrival_date) <= 2)) THEN "winter"
        WHEN ((month(departure_date) >= 6 AND month(arrival_date) <= 8)) THEN "summer"
        WHEN ((month(departure_date) >= 9 AND month(arrival_date) <= 11)) THEN "fall"
        ELSE 0 END,
	concat(route_origin," -> ", route_destination)
ORDER BY route_profit DESC;

-- What is the occupancy rate by type of room

SELECT ship_name, 
ship_capacity,
concat(route_origin," -> ", route_destination) as route,
	COUNT(distinct(luxury_cruise.id_passengers)) AS passengers,
	round(((COUNT(distinct(luxury_cruise.id_passengers)))/ship_capacity) * 100,2) AS occupancy_rate
FROM luxury_cruise
	INNER JOIN cruise_ships 
		ON luxury_cruise.id_ships = cruise_ships.id_ships
	INNER JOIN cruise_passengers
		ON luxury_cruise.id_passengers = cruise_passengers.id_passengers
    INNER JOIN cruise_accomodation
		ON luxury_cruise.id_accomodation = cruise_accomodation.id_accomodation
	INNER JOIN cruise_routes
		ON luxury_cruise.id_routes = cruise_routes.id_routes
    GROUP BY ship_name, route;