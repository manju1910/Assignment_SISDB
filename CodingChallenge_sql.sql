--Creating database

create database Car_rental
use Car_rental

--Creating table

--vehicle table

CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    dailyRate DECIMAL(10, 2),
    available int,
    passengerCapacity INT,
    engineCapacity INT
);

--Customer table

CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(25),
    lastName VARCHAR(25),
    email VARCHAR(25),
    phoneNumber VARCHAR(20)
);

--Lease table

CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate varchar(15),
    endDate varchar(15),
    leasetype varchar(20),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

--Payment table
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate varchar(10),
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);

--	Inserting values
--vehicle table

insert into vehicle values
(1,'toyota','camry',2022,50.00,1,4,1450),
(2,'honda','civic',2023,45.00,1,7,1500),
(3,'ford','focus',2022,48.00,0,4,1400),
(4,'nissan','altima',2023,52.00,1,7,1200),
(5,'chevrolet','malibu',2022,47.00,1,4,1800),
(6,'hyundai','sonata',2023,49.00,0,7,1400),
(7,'bmw','3series',2023,60.00,1,7,2499)

insert into Vehicle values(8,'mercedes','c-class',2022,58.00,1,8,2599),
(9,'audi','a4',2022,55.00,0,4,2500),(10,'lexus','es',2023,54.00,1,4,2500)

--Customer table

insert into customer values(1,'john','doe','johndoe@example.com','555-555-5555'),
(2,'jane','smith', 'janesmith@example.com', '555-123-4567'),
(3,'robert', 'johnson', 'robert@example.com', '555-789-1234'),
(4 ,'sarah', 'brown', 'sarah@example.com' ,'555-456-7890'),
(5 ,'david', 'lee', 'david@example.com',' 555-987-6543'),
(6 ,'laura','hall', 'laura@example.com',' 555-234-5678'),
(7,'michael','davis', 'michael@example.com', '555-876-5432'),
(8 ,'emma' ,'wilson', 'emma@example.com',' 555-432-1098'),
(9 ,'william','taylor', 'william@example.com',' 555-321-6547'),
(10, 'olivia', 'adams', 'olivia@example.com' ,'555-765-4321');

--lease table
insert into lease values
(1,1,1,'2023-01-01','2023-01-05','daily'),
(2,2,2,'2023-02-15','2023-02-28','monthly'),
(3,3,3,'2023-03-10','2023-03-15','daily'),
(4,4,4,'2023-04-20','2023-04-30','monthly'),
(5,5,5,'2023-05-05','2023-05-10','daily'),
(6,4,3,'2023-06-15','2023-06-30','monthly'),
(7,7,7,'2023-07-01','2023-07-10','daily'),
(8,8,8,'2023-08-12','2023-08-15','monthly'),
(9,3,3,'2023-09-07','2023-09-10','daily'),
(10,10,10,'2023-10-10','2023-10-31','monthly');

--Payment table

insert into Payment values(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3 ,'2023-03-12' ,75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00)


--1. Update the daily rate for a Mercedes car to 68.
  update vehicle set dailyRate=68.00 where make='mercedes';

 --2. Delete a specific customer and all associated leases and payments.
       delete from Payment where paymentID=4;
		  delete from Lease where leaseID=4;
		  delete from Customer where customerID=4
		  

--3. Rename the "paymentDate" column in the Payment table to "transactionDate".
  EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';
  
--4. Find a specific customer by email.
  select * from Customer where email='johndoe@example.com';

--5. Get active leases for a specific customer
    SELECT * FROM Lease JOIN Customer ON Lease.CustomerID = Customer.CustomerID JOIN vehicle ON Lease.VehicleID = Vehicle.vehicleID
WHERE Customer.Email = 'michael@example.com' AND Vehicle.available = 1;

 --6. Find all payments made by a customer with a specific phone number.

 SELECT sum(amount) FROM Payment join Lease on Payment.leaseID = Lease.leaseID
join Customer on Lease.customerID = Customer.customerID WHERE Customer.phoneNumber = '555-765-4321' group by Customer.phoneNumber ;

--7. Calculate the average daily rate of all available cars.
 SELECT avg(dailyRate) AS average FROM Vehicle WHERE available = 1;

--8. Find the car with the highest daily rate.
 select * from vehicle where dailyRate=(select max(dailyrate) from vehicle)

--9. Retrieve all cars leased by a specific customer
SELECT Vehicle.* FROM Vehicle JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
WHERE Lease.customerID = 2;

--10. Find the details of the most recent lease.
   SELECT Lease.*, Vehicle.make, Vehicle.model, Vehicle.year FROM Lease JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE Lease.startDate = ( SELECT MAX(startDate) FROM Lease);

--11. List all payments made in the year 2023
   SELECT * FROM Payment WHERE YEAR(transactionDate) = 2023;

--12.Retrieve customers who have not made any payments.
SELECT Customer.* FROM Customer LEFT JOIN Lease ON Customer.customerID = Lease.customerID LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID 
WHERE Payment.paymentID IS NULL;

--13. Retrieve Car Details and Their Total Payments.
SELECT  Vehicle.vehicleID,vehicle.make,vehicle.model,vehicle.year, SUM(Payment.amount) AS total_payments FROM  Vehicle LEFT JOIN 
Lease ON Vehicle.vehicleID = Lease.vehicleID LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID GROUP BY Vehicle.vehicleID,vehicle.make,vehicle.model,vehicle.year;

 --14. Calculate Total Payments for Each Customer.
 SELECT Customer.customerID,Customer.firstName,Customer.lastName,SUM(Payment.amount) AS total_payments
FROM Customer LEFT JOIN  Lease ON Customer.customerID = Lease.customerID LEFT JOIN 
Payment ON Lease.leaseID = Payment.leaseID GROUP BY  Customer.customerID,Customer.firstName,Customer.lastName;

--15. List Car Details for Each Lease.

SELECT Lease.leaseID,Vehicle.make,Vehicle.model,Vehicle.year FROM  Lease JOIN  Vehicle ON Lease.vehicleID = Vehicle.vehicleID GROUP BY 
Lease.leaseID,Vehicle.make, Vehicle.model, Vehicle.year;

--16. Retrieve Details of Active Leases with Customer and Car Information.

select * from customer c inner join lease l on c.customerID=l.customerID inner join vehicle v on l.vehicleID=v.vehicleID
where available=1;
--17. Find the Customer Who Has Spent the Most on Leases.

 select * from Customer where customerID=( select customerid from lease where leaseid =(select leaseid from Payment where amount=(select max(amount) from Payment)))

--18. List All Cars with Their Current Lease Information
   select * from vehicle v join lease l on v.vehicleID=l.vehicleID;
