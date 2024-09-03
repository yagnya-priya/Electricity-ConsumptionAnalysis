CREATE DATABASE ECA;
USE ECA; 

CREATE TABLE `Orders` (
    `Order_ID` INT  NOT NULL ,
    `Customer_ID` INT  NOT NULL ,
    `Address_ID` INT  NOT NULL ,
    `Employee_ID` INT  NOT NULL ,
    `Ordered_At` Date  NOT NULL ,
    `Reading_ID` INT  NOT NULL ,
    `Processing_Time` INT  NOT NULL ,
    PRIMARY KEY (
        `Order_ID`
    )
);


CREATE TABLE `Customers` (
    `Customer_ID` INT  NOT NULL ,
    `Customer_FirstName` varchar(200)  NOT NULL ,
    `Customer_LastName` varchar(200)  NOT NULL ,
    `Customer_Contact` varchar(100)  NOT NULL ,
    `Customer_Email` varchar(90)  NOT NULL ,
    `Customer_Address` varchar(150)  NOT NULL ,
    PRIMARY KEY (
        `Customer_ID`
    )
);

CREATE TABLE `Employee` (
    `Employee_ID` INT  NOT NULL ,
    `Employee_FirstName` TEXT  NOT NULL ,
    `Employee_LastName` TEXT  NOT NULL ,
    `Employee_Role` TEXT  NOT NULL ,
    PRIMARY KEY (
        `Employee_ID`
    )
);

CREATE TABLE `Address` (
    `Address_ID` INT  NOT NULL ,
    `Bill_Address` varchar(150)  NOT NULL ,
    `Bill_City` TEXT  NOT NULL ,
    `Address_Email` VARCHAR(100)  NOT NULL ,
    PRIMARY KEY (
        `Address_ID`
    )
);

CREATE TABLE `Payments` (
    `payment_id` INT  NOT NULL ,
    `payment_date` DATE  NOT NULL ,
    `payment_amount` INT  NOT NULL ,
    `Unit_Price` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (
        `payment_id`
    )
);

CREATE TABLE `Readings` (
    `reading_id` INT  NOT NULL ,
    `meter_id` INT  NOT NULL ,
    `reading_date` DATE  NOT NULL ,
    `reading_value` INT  NOT NULL ,
    PRIMARY KEY (
        `reading_id`
    )
);

CREATE TABLE `Meter` (
    `meter_id` INT  NOT NULL ,
    `customer_id` INT  NOT NULL ,
    `meter_type` TEXT  NOT NULL ,
    `installation_date` DATE  NOT NULL ,
    `last_reading_date` DATE  NOT NULL ,
    PRIMARY KEY (
        `meter_id`
    )
);


CREATE TABLE `Complaints` (
    `complaint_id` INT  NOT NULL ,
    `customer_id` INT  NOT NULL ,
    `complaint_date` DATE  NOT NULL ,
    `complaint_details` TEXT  NOT NULL ,
    `Time_Taken` INT  NOT NULL,
    PRIMARY KEY (
        `complaint_id`
    )
);

ALTER TABLE `Orders`
ADD UNIQUE INDEX `idx_Customer_ID` (`Customer_ID`);

ALTER TABLE `Meter`
ADD UNIQUE INDEX `idx_customer_id` (`customer_id`);


CREATE UNIQUE INDEX `idx_Customer_Email` ON `Customers` (`Customer_Email`);
CREATE UNIQUE INDEX `idx_Address_Email` ON `Address` (`Address_Email`);

CREATE INDEX `idx_Address_ID` ON `Orders` (`Address_ID`);
CREATE INDEX `idx_Reading_ID` ON `Orders` (`Reading_ID`);
CREATE INDEX `idx_Employee_ID` ON `Orders` (`Employee_ID`);
CREATE INDEX `idx_Ordered_At` ON `Orders` (`Ordered_At`);

CREATE INDEX `idx_payment_date` ON `Payments` (`payment_date`);

CREATE UNIQUE INDEX idx_readings_meter_id_reading_date ON Readings (meter_id, reading_date);
CREATE INDEX idx_meter_meter_id_last_reading_date ON Meter (meter_id, last_reading_date);


CREATE INDEX idx_customer_id ON Complaints (customer_id);

ALTER TABLE Orders ADD CONSTRAINT fk_Orders_Customer_ID FOREIGN KEY(Customer_ID)
REFERENCES Meter (customer_id);

ALTER TABLE `Customers` ADD CONSTRAINT `fk_Customers_Customer_ID` FOREIGN KEY(`Customer_ID`)
REFERENCES `Orders` (`Customer_ID`);

ALTER TABLE `Customers` ADD CONSTRAINT `fk_Customers_Customer_Email` FOREIGN KEY(`Customer_Email`)
REFERENCES `Address` (`Address_Email`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_Address_ID` FOREIGN KEY(`Address_ID`)
REFERENCES `Address` (`Address_ID`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_Reading_ID` FOREIGN KEY(`Reading_ID`)
REFERENCES `Readings` (`reading_id`);

ALTER TABLE `Employee` ADD CONSTRAINT `fk_Employee_Employee_ID` FOREIGN KEY(`Employee_ID`)
REFERENCES `Orders` (`Employee_ID`);

ALTER TABLE `Payments` ADD CONSTRAINT `fk_Payments_payment_date` FOREIGN KEY(`payment_date`)
REFERENCES `Orders` (`Ordered_At`);

ALTER TABLE `Meter` ADD CONSTRAINT `fk_Meter_meter_id_last_reading_date` FOREIGN KEY(`meter_id`, `last_reading_date`)
REFERENCES `Readings` (`meter_id`, `reading_date`);

ALTER TABLE `Meter` ADD CONSTRAINT `fk_Meter_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `Complaints` (`customer_id`);

ALTER TABLE `Complaints` ADD CONSTRAINT `fk_Complaints_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `Orders` (`Customer_ID`);