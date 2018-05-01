
-- Dropping tables used in the database to make sure they're not in use
DROP TABLE Account CASCADE CONSTRAINTS PURGE;
DROP TABLE Car CASCADE CONSTRAINTS PURGE;
DROP TABLE TestResult CASCADE CONSTRAINTS PURGE;
DROP TABLE TestElements CASCADE CONSTRAINTS PURGE;
DROP TABLE Appointment CASCADE CONSTRAINTS PURGE;
DROP TABLE Owner CASCADE CONSTRAINTS PURGE;
DROP TABLE Requests CASCADE CONSTRAINTS PURGE;


-- Request table logs all applications for NCT appointments
CREATE TABLE Requests
(
    RegNo           VARCHAR2(20) NOT NULL,
    O_FName         VARCHAR2(20) NOT NULL,
    O_LName         VARCHAR2(20) NOT NULL,
    Date_Requested  DATE()  NOT NULL,
    
    CONSTRAINT Request_pk PRIMARY KEY (RegNo),
    CONSTRAINT Request_Car_RegNo_fk FOREIGN KEY (RegNo) REFERENCES Car (RegNo), 
    CONSTRAINT Request_Owner_FName_fk FOREIGN KEY (O_FName) REFERENCES Owner (O_FName),
    CONSTRAINT Request_Owner_LName_fk FOREIGN KEY (O_LName) REFERENCES OWNER (O_LName),
);

-- Keeps track of car owners info
CREATE TABLE Owner
(
    OwnerID     INT(10) NOT NULL,
    O_FName     VARCHAR2(20) NOT NULL,
    O_LNAME     VARCHAR2(20) NOT NULL,
    
    CONSTRAINT Owner_pk PRIMARY KEY (OwnerID),
)

-- When a request is approved the info is entered into appointment
CREATE TABLE Appointment
(
    AppID   INT(10) NOT NULL,
    RegNo   VARCHAR2(20) NOT NULL,
    Tested  BOOLEAN NOT NULL,
    Date_Completed  DATE,
    
    CONSTRAINT Appointment_pk PRIMARY KEY (AppID),
    CONSTRAINT App_Car_fk FOREIGN KEY (RegNo) REFERENCES Car (RegNo),
    
)

-- a table of all the elements needed to be tested 
CREATE TABLE TestElements
(
    ElementID       INT(10) NOT NULL,
    ElementName     VARCHAR2(30),
    TestID          INT(10) NOT NULL,
    Element_Pass    BOOLEAN NOT NULL,
    
    CONSTRAINT TestElements_pk PRIMARY KEY (ElementID),
    CONSTRAINT TestElement_TestResult_fk FOREIGN KEY (TestID) REFERENCES TestResult (TestID),
)

-- Records which car, appointment, result and mechanic for each test
CREATE TABLE TestResult
(
    TestID      INT(10) NOT NULL,
    UserID      INT(10) NOT NULL,
    RegNo       VARCHAR2(20) NOT NULL,
    Pass        BOOLEAN,
    Comments    VARCHAR2(50),
    
    CONSTRAINT TestResult_pk PRIMARY KEY (TestID),
    CONSTRAINT TestResult_Account_fk FOREIGN KEY (UserID) REFERENCES Account (UserID),
    CONSTRAINT TestResult_Car_fk FOREIGN KEY (RegNo) REFERENCES Car (RegNo),   
)

-- keeps info on the cars
CREATE TABLE Car
(
    RegNo   VARCHAR2(20) NOT NULL,
    TestID  INT(10),
    AppID   INT(10),
    OwnerID INT(10),
    Make    VARCHAR2(30),
    Model   VARCHAR2(30),
    Year    INT(4),
    
    CONSTRAINT Car_pk PRIMARY KEY (RegNo),
    CONSTRAINT Car_TestResult_fk FOREIGN KEY (TestID) REFERENCES TestResult (TestID),
    CONSTRAINT Car_App_fk FOREIGN KEY (AppID) REFERENCES Appointment (AppID),
    CONSTRAINT Car_Owner_fk FOREIGN KEY (OwnerID) REFERENCES Owner (OwnerID),
)

-- Keeps accounts for admin mechanic and customer
CREATE TABLE Account 
(
    UserID  INT(10) NOT NULL,
    UserName    VARCHAR2(20),
    Password    VARCHAR2(20),
    AccountType VARCHAR2(1),
    F_Name      VARCHAR2(30),
    L_Name      VARCHAR2(30),
    Email       VARCHAR2(50),
    
    CONSTRAINT Account_pk PRIMARY KEY (UserID),
    CONSTRAINT Account_AccountType_chk CHECK (AccountType LIKE '%M%' OR AccountType LIKE '%A%' OR AccountType LIKE '%C%'),
    CONSTRAINT Account_Email_chk CHECK (Email LIKE '%@%'),   
)


-- Adding in Accounts for testing
INSERT INTO Account 
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('Admin', 'password', 'A', 'John', 'Smith', 'johnsmith@gmail.com');

INSERT INTO Account
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('SamMech', 'apples', 'M', 'Sam', 'Doyle', 'sam.doyle4@gmail.com');

INSERT INTO Account
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('Drew47', 'red47', 'M', 'Andrew', 'Burke', 'andrewb47@gmail.com');




-- Adding in test elements for test
INSERT INTO TestElements (ElementID, ElementName)
VALUES
('1', 'Registration Plate');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('2', 'Exhaust Smoke');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('3', 'Exhaust CO/HC/Lambda');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('4', 'Service Brake Pedal');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('5', 'Service Brake Operation');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('6', 'Mechanical Brake Hand Actuator');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('7', 'Seats');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('8', 'Horn');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('9', 'Windscreen Wipers and Washers');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('10', 'Glass');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('11', 'Rear View Mirror');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('12', 'Speedometer');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('13', 'Safety Belts');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('14', 'Steering Wheel Play');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('15', 'Doors/Locks/Anti-Theft Devices');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('16', 'Adaptions for Disabled Drivers');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('17', 'Front Wheel Side Slip');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('18', 'Rear Wheel Side Slip');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('19', 'Front Axle Suspension Performance');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('20', 'Rear Axle Suspension Performance');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('21', 'Service Brake Performance');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('22', 'Service Brake Imbalance');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('23', 'Parking Brake Performance');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('24', 'Parking Brake Imbalance');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('25', 'Towing Bracket/Coupling');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('26', 'Stop Lamps');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('27', 'Rear Lamps');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('28', 'Indicators/Tell Tales');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('29', 'Side Lamps(Front Position Lamps)');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('30', 'Headlamp Condition');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('31', 'Headlamp Aim');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('32', 'Auxiliary Lamp Condition & Position');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('33', 'Auxiliary Lamp Aim');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('34', 'Reflectors');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('35', 'Bodywork');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('36', 'Tyre Condition');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('37', 'Tyre Specification');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('38', 'Tyre Tread');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('39', 'Wheels');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('40', 'Spare Wheel and Carrier');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('41', 'Brake Fluid');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('42', 'Chassis/Underbody');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('43', 'Steering Linkage');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('44', 'Wheel Bearings');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('45', 'Front Springs');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('46', 'Front Suspension');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('47', 'Brake Lines/Hoses');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('48', 'Shock Absorber Condition');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('49', 'Electrical System');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('50', 'Fuel System');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('51', 'Brake Wheel Units');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('52', 'Mechanical Brake Components');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('53', 'Brake Master Cylinder/Servo/Valves/Connections');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('54', 'Exhaust System/Noise');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('55', 'Rear Suspension');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('56', 'Rear Springs');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('57', 'Transmission & Drive Train');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('58', 'Rear Fog Lamp(s)');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('59', 'Reverse Lamp(s)');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('60', 'Malfuction Indicators');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('61', 'Registration Plate Lamps');

INSERT INTO TestElements (ElementID, ElementName)
VALUES
('62', 'Modifications Report');