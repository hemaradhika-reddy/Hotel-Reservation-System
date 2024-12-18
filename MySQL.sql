#### MY SQL ###

1)  CREATE TABLE Hotel_Reservations(Booking_ID VARCHAR(40),no_of_adults INT,no_of_children INT,no_of_weekend_nights INT,no_of_week_nights INT,type_of_meal_plan VARCHAR(50),required_car_parking_space INT,room_type_reserved VARCHAR(50),lead_time INT,arrival_year INT,arrival_month INT,arrival_date INT,market_segment_type VARCHAR(40),repeated_guest INT,no_of_previous_cancellations INT,no_of_previous_bookings_not_canceled INT,avg_price_per_room DECIMAL(10,2),no_of_special_requests INT,booking_status VARCHAR(50));

2)  LOAD DATA LOCAL INFILE 'C:/Users/Ramanareddy/Downloads/Hotel_Reservations.csv' INTO TABLE Hotel_Reservations  FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;

3)  CREATE TABLE Customer_Details(Booking_ID VARCHAR(40),no_of_adults INT,no_of_children INT,repeated_guest INT,no_of_previous_cancellations INT,no_of_previous_bookings_not_canceled INT,booking_status VARCHAR(50));

4)  CREATE TABLE Booking_Details(Booking_ID VARCHAR(40),no_of_weekend_nights INT,no_of_week_nights INT,type_of_meal_plan VARCHAR(50),required_car_parking_space INT,room_type_reserved VARCHAR(50),lead_time INT,arrival_year INT,arrival_month INT,arrival_date INT,market_segment_type VARCHAR(40),avg_price_per_room DECIMAL(10,2),no_of_special_requests INT);

5)  ALTER TABLE Customer_Details
    -> ADD PRIMARY KEY (Booking_ID);

mysql> ALTER TABLE Booking_Details
    -> ADD PRIMARY KEY (Booking_ID);

6)  INSERT INTO Customer_Details SELECT 
    ->     Booking_ID,
    ->     no_of_adults,
    ->     no_of_children,
    ->     repeated_guest,
    ->     no_of_previous_cancellations,
    ->     no_of_previous_bookings_not_canceled,
    ->     booking_status
    -> FROM Hotel_Reservations;
 INSERT INTO Booking_Details
    -> SELECT
    -> Booking_ID,
    ->     no_of_weekend_nights,
    ->     no_of_week_nights,
    ->     type_of_meal_plan,
    ->     required_car_parking_space,
    ->     room_type_reserved,
    ->     lead_time,
    ->     arrival_year,
    ->     arrival_month,
    ->     arrival_date,
    ->     market_segment_type,
    ->     avg_price_per_room,
    ->     no_of_special_requests
    -> FROM Hotel_Reservations;
