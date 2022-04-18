
-- 1) You are required to create two tables PASSENGER and PRICE with the following
-- attributes and properties



create table travelonthego.passenger (Passenger_name varchar(20),
 Category varchar(7),
 Gender varchar(2),
 Boarding_City varchar(20),
 Destination_City varchar(20),
 Distance int,
 Bus_Type varchar(10)
);

create table travelonthego.price(
 Bus_Type varchar(10),
 Distance int,
 Price int
 );
 
-- 2) Insert the following data in the tables


Insert into travelonthego.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values
('Sejal','AC','F','Benguluru','Chennai',350,'Sleeper'),
('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting'),
('Pallavi','AC','F','Panaji','Benguluru',600,'Sleeper'),
('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper'),
('Udit','Non-AC','M','Trivandrum','Panaji',1000,'Sleeper'),
('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting'),
('Hemant','Non-AC','M','Panaji','Mumbai',700,'Sleeper'),
('Manish','Non-AC','M','Hyderabad','Benguluru',500,'Sitting'),
('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

insert into travelonthego.price(bus_type,distance,price) values
 ('Sleeper', 350,770),
('Sleeper', 500,1100),
('Sleeper', 600,1320),
('Sleeper', 700,1540),
('Sleeper', 1000,2200),
('Sleeper', 1200,2640),
('Sleeper', 1500,2700),
('Sitting', 500,620),
('Sitting', 600,744),
('Sitting', 700,868),
('Sitting', 1000,1240),
('Sitting', 1200,1488),
('Sitting', 1500,1860);


-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

select count(Passenger_name),gender from travelonthego.passenger where Distance > 600 group by Gender ;

-- 4) Find the minimum ticket price for Sleeper Bus. 

select min(price) from travelonthego.price where Bus_Type="Sleeper";

-- 5) Select passenger names whose names start with character 'S' 

select Passenger_name from travelonthego.passenger where Passenger_name like "S%";

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output

select p.Passenger_name , p.Boarding_City, p.Destination_City, p.Bus_Type, c.Price 
from travelonthego.passenger p left join travelonthego.price c on p.distance = c.distance and p.Bus_Type=c.Bus_Type;

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
-- for a distance of 1000 KM s 
select p.Passenger_name,c.Price from travelonthego.passenger p left join travelonthego.price c 
on c.Distance = p.Distance and c.Bus_Type=p.Bus_Type where (p.distance > 1000 or p.distance = 1000 )and c.Bus_Type = "Sitting" ;

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

select * from travelonthego.price where distance =  (
select distance from travelonthego.passenger where (Boarding_City = "Benguluru" and Destination_City="Panaji") or (Boarding_City = "Panaji" and Destination_City="Benguluru"));

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.

select distinct distance from travelonthego.passenger order by distance desc; 

-- 10) Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables
with total as ( select sum(distance) as total from travelonthego.passenger)

select passenger_Name,(distance / total.total)*100 as percentage_travel from travelonthego.passenger,total ;

-- 11) Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise

SELECT Distance, Price,CASE
WHEN
Price > 1000 THEN "Expensive"
WHEN Price <1000 and Price > 500 THEN "Average Cost"
ELSE "cheap" END as Cost FROM travelonthego.price;



