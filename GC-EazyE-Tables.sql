
DROP TABLE Account CASCADE CONSTRAINTS PURGE;
DROP TABLE Car CASCADE CONSTRAINTS PURGE;
DROP TABLE TestResult CASCADE CONSTRAINTS PURGE;
DROP TABLE TestElements CASCADE CONSTRAINTS PURGE;
DROP TABLE Appointment CASCADE CONSTRAINTS PURGE;
DROP TABLE Owner CASCADE CONSTRAINTS PURGE;
DROP TABLE Requests CASCADE CONSTRAINTS PURGE;


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

CREATE TABLE Owner
(
    OwnerID     INT(10) NOT NULL,
    O_FName     VARCHAR2(20) NOT NULL,
    O_LNAME     VARCHAR2(20) NOT NULL,
    
    CONSTRAINT Owner_pk PRIMARY KEY (OwnerID),
)

CREATE TABLE Appointment
(
    AppID   INT(10) NOT NULL,
    RegNo   VARCHAR2(20) NOT NULL,
    Tested  BOOLEAN NOT NULL,
    Date_Completed  DATE,
    
    CONSTRAINT Appointment_pk PRIMARY KEY (AppID),
    CONSTRAINT App_Car_fk FOREIGN KEY (RegNo) REFERENCES Car (RegNo),
    
)

CREATE TABLE TestElements
(
    ElementID       INT(10) NOT NULL,
    ElementName     VARCHAR2(30),
    TestID          INT(10) NOT NULL,
    Element_Pass    BOOLEAN NOT NULL,
    
    CONSTRAINT TestElements_pk PRIMARY KEY (ElementID),
    CONSTRAINT TestElement_TestResult_fk FOREIGN KEY (TestID) REFERENCES TestResult (TestID),
)

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

INSERT INTO Account
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('FMurph', 'rex1234', 'C', 'Fiona', 'Murphy', 'fmurphy@gmail.com');

INSERT INTO Account
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('danjmoore', 'mary1993', 'C', 'Daniel', 'Moore', 'danjmoore@gmail.com');

INSERT INTO Account
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('jamesred', 'dublin98', 'C', 'James', 'Redmond', 'jamesred32@gmail.com');

INSERT INTO Account
(UserName, Password, AccountType, F_Name, L_Name, Email) 
VALUES 
('sarahk', 'june92', 'C', 'Sarah', 'Keane', 'sarahk@gmail.com');