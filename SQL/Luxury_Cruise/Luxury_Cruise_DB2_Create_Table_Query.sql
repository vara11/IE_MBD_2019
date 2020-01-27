CONNECT TO SAMPLE;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_ships`
-- -----------------------------------------------------
CREATE TABLE cruise_ships (
  id_ships INT NOT NULL,
  ship_name VARCHAR(45) NOT NULL,
  ship_capacity VARCHAR(45) NULL,
  ship_maintenance_cost DECIMAL(7,2) NULL,
  PRIMARY KEY (id_ships));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_tickets`
-- -----------------------------------------------------
CREATE TABLE cruise_tickets (
  id_tickets INT NOT NULL,
  purchase_date DATE NOT NULL,
  departure_date DATE NULL,
  arrival_date DATE NULL,
  ticket_price DECIMAL(7,2) NULL,
  PRIMARY KEY (id_tickets));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_passengers`
-- -----------------------------------------------------
CREATE TABLE cruise_passengers (
  id_passengers INT NOT NULL,
  passenger_name VARCHAR(45) NOT NULL,
  passenger_age INT NULL,
  passenger_gender VARCHAR(45) NULL,
  passenger_country VARCHAR(45) NULL,
  PRIMARY KEY (id_passengers));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_amenities`
-- -----------------------------------------------------
CREATE TABLE cruise_amenities (
  id_amenities INT NOT NULL,
  amenities_name VARCHAR(45) NULL,
  amenities_type VARCHAR(45) NULL,
  amenities_price DECIMAL(7,2) NULL,
  PRIMARY KEY (id_amenities));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_routes`
-- -----------------------------------------------------
CREATE TABLE cruise_routes (
  id_routes INT NOT NULL,
  route_origin VARCHAR(45) NULL,
  route_destination VARCHAR(45) NULL,
  route_cost INT NULL,
  PRIMARY KEY (id_routes));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_crew`
-- -----------------------------------------------------
CREATE TABLE cruise_crew (
  id_crew INT NOT NULL,
  crew_name VARCHAR(45) NOT NULL,
  crew_age INT NULL,
  crew_title VARCHAR(45) NULL,
  crew_salary DECIMAL(7,2) NULL,
  PRIMARY KEY (id_crew));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_accomodation`
-- -----------------------------------------------------
CREATE TABLE cruise_accomodation (
  id_accomodation INT NOT NULL,
  room_capacity INT NULL,
  room_type VARCHAR(45) NULL,
  PRIMARY KEY (id_accomodation));


-- -----------------------------------------------------
-- Table `mydb`.`cruise_supply`
-- -----------------------------------------------------
CREATE TABLE cruise_supply (
  id_supply INT NOT NULL,
  supply_family VARCHAR(45) NULL,
  supply_name VARCHAR(45) NULL,
  supply_tonnes INT NULL,
  supply_cost DECIMAL(7,2) NULL,
  PRIMARY KEY (id_supply));


-- -----------------------------------------------------
-- Table `mydb`.`luxury_cruise`
-- -----------------------------------------------------
CREATE TABLE luxury_cruise (
  id_Luxury_Cruise INT NOT NULL,
  id_ships INT NULL,
  id_tickets INT NULL,
  id_passengers INT NULL,
  id_amenities INT NULL,
  id_routes INT NULL,
  id_crew INT NULL,
  id_accomodation INT NULL,
  id_supply INT NULL,
  PRIMARY KEY (id_Luxury_Cruise),
   FOREIGN KEY (id_ships)
    REFERENCES cruise_ships (id_ships),
   FOREIGN KEY (id_tickets)
    REFERENCES cruise_tickets (id_tickets),
   FOREIGN KEY (id_passengers)
    REFERENCES cruise_passengers (id_passengers),
   FOREIGN KEY (id_amenities)
    REFERENCES cruise_amenities (id_amenities),
   FOREIGN KEY (id_routes)
    REFERENCES cruise_routes (id_routes),
    FOREIGN KEY (id_crew)
    REFERENCES cruise_crew (id_crew),
    FOREIGN KEY (id_accomodation)
    REFERENCES cruise_accomodation (id_accomodation),
    FOREIGN KEY (id_supply)
    REFERENCES cruise_supply (id_supply));
