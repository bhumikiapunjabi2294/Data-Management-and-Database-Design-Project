/****************************** Project Implementation*************************************/
---------------------------------DDL Statements---------------------------------------

create database RentItOut
Use RentItOut

CREATE TABLE [User] (
   [User_Id] int Identity(1000,1) NOT NULL,
   [User_Name] varchar(45) NOT NULL,
   [PasswordHash] nvarchar(64) NOT NULL,
   Date_of_Birth varchar(45) NOT NULL,
   Email_Address varchar(45) DEFAULT NULL,
   [Address] varchar(200) DEFAULT NULL,
   Contact_Number bigint NOT NULL,
  PRIMARY KEY ([User_Id])
)

CREATE TABLE Property (
   Property_Id int NOT NULL ,
   Property_Name varchar(45) DEFAULT NULL,
   Street_Name varchar(45) NOT NULL,
   State_Name varchar(45) NOT NULL,
   City_Name varchar(45) NOT NULL,
   Zipcode char(6) NOT NULL,
   Crime_Rate varchar(45) NOT NULL,
   PRIMARY KEY ([Property_Id]))


CREATE TABLE Public_Facilities (
  Facility_Id int NOT NULL,
  Grocery_store varchar(45) DEFAULT NULL,
  Bank varchar(45) DEFAULT NULL,
  Subway_Station varchar(45) DEFAULT NULL,
  Bus_Stop varchar(45) DEFAULT NULL,
  Hospital varchar(45) DEFAULT NULL,
  Gym_facility varchar(45) CHECK (Gym_facility IN('Not Available','Available')),
  PRIMARY KEY (Facility_Id),
)

CREATE TABLE Unit (
   Unit_Id int NOT NULL,
   [User_Id] int NOT NULL,
   Property_Id int NOT NULL,
   Unit_Number int NOT NULL,
   Unit_Floor_Number int NOT NULL,
   Unit_Description varchar(45) check (Unit_Description in('Old-Construction','Not-Furnished','Newly Constructed','Furnished Apt')),
   Carpet_area int NOT NULL,
   [Pets_Allowed] char (1) NOT NULL,
   No_of_bedrooms int NOT NULL,
   No_of_bathrooms int NOT NULL,
   Date_of_Posting datetime NOT NULL,
   Date_Available_from datetime NOT NULL,
   [Availability] char(1)NOT NULL,
   PRIMARY KEY (Unit_Id),
   CONSTRAINT [Property_Id1] FOREIGN KEY ([Property_Id]) REFERENCES Property ([Property_Id]),
   CONSTRAINT [User_Id] FOREIGN KEY ([User_Id]) REFERENCES [User] ([User_Id])
) 

CREATE TABLE Lease_Details (
   Lease_Id int NOT NULL ,
   Unit_Id int NOT NULL,
   StartDate datetime NOT NULL,
   EndDate datetime NOT NULL,
   Term int NOT NULL,
   Monthly_Rent int NOT NULL,
   Security_Deposit_Amount int NOT NULL,
   Pet_Deposit int DEFAULT NULL,
   Is_sub_leasing_allowed char(1)NOT NULL,
   Required_people_on_lease int NOT NULL,
  PRIMARY KEY (Lease_Id),
  CONSTRAINT Unit_Id FOREIGN KEY (Unit_Id) REFERENCES Unit (Unit_Id)
)

CREATE TABLE [dbo].[Lease_Payment](
    [Lease_Payment_Id] [int] NOT NULL,
    [User_Id] [int] NULL,
    [Lease_Id] [int] NOT NULL,
    [Payment_Type] [varchar](45) check ([Payment_Type] in('Online Transaction','Check','Cash','DD')),
    [Payment_Date] [datetime] NOT NULL,
    [Payment_Amount] [int] NOT NULL,
	Late_Fees [int] DEFAULT NULL,
	PRIMARY KEY (Lease_Payment_Id),
   CONSTRAINT Lease_Id FOREIGN KEY (Lease_Id) REFERENCES Lease_Details (Lease_Id)
)

CREATE TABLE [dbo].[Agent](
    [User_Id] [int] NOT NULL,
    [Broker_Fee] [int] NOT NULL,
    [Office_Address] [varchar](200) NULL,
	PRIMARY KEY ([User_Id]),
  CONSTRAINT [User_Id6] FOREIGN KEY ([User_Id]) REFERENCES [User] ([User_Id]),
)


CREATE TABLE [dbo].[Owner](
    [User_Id] [int] NOT NULL,
    [Price_Expectation] [int] NULL,
	PRIMARY KEY ([User_Id]),
  CONSTRAINT [User_Id5] FOREIGN KEY ([User_Id]) REFERENCES [User] ([User_Id]),
)



CREATE TABLE [dbo].[Client](
    [User_Id] [int] NOT NULL,
    [Client_Wishlist] [varchar](255) NULL,
	 PRIMARY KEY ([User_Id]))

CREATE TABLE [dbo].[Appointment_Schedule](
    [Appointment_Id] [int] NOT NULL,
    [Scheduled_Date] [datetime] NOT NULL,
    [User_Id] [int] NOT NULL,
    [Meeting_Notes] [varchar](45) default NULL,
	PRIMARY KEY (Appointment_Id),
  CONSTRAINT [User_Id2] FOREIGN KEY ([User_Id]) REFERENCES [User] ([User_Id]),
)

CREATE TABLE [dbo].[Features](
    [Features_Id] [int] NOT NULL,
    [Parking_Facility] [char](1) NULL,
    [Air_Conditioning] [char](1) NULL,
    [Central_Heating] [char](1) NULL,
    [Carpet_floor] [char](1) NULL,
    [Hardwood_floor] [char](1) NULL,
    [InUnit_Fireplace] [char](1) NULL,
    [InUnit_Garden] [char](1) NULL,
    [InUnit_Laundary] [char](1) NULL,
    [Ceiling_Fan] [char](1) NULL,
    [Pets_Allowed] [char](1) NULL,
    [Walkin_Closet] [char](1) NULL,
	PRIMARY KEY (Features_Id),
  )


CREATE TABLE [dbo].[Has_Features](
    [Unit_Id] [int] NOT NULL,
    [Features_Id] [int] NOT NULL,
	PRIMARY KEY (Unit_Id,Features_Id),
	CONSTRAINT Unit_Id_FK FOREIGN KEY (Unit_Id) REFERENCES Unit (Unit_Id),
	CONSTRAINT Features_Id_FK FOREIGN KEY (Features_Id) REFERENCES Features (Features_Id)
	)

CREATE TABLE [dbo].[Apartment](
    [Unit_Id] [int] NOT NULL,
    [Has_in_unit_laundry] [char](1) NULL,
	PRIMARY KEY (Unit_Id)
 )

CREATE TABLE [dbo].[House](
    [Unit_Id] [int] NOT NULL,
    [Backyard] [char](1) NULL,
    [Parking] [char](1) NULL,
	 PRIMARY KEY (Unit_Id))


CREATE TABLE [dbo].[Has_Zipcode](
    [Property_Id] [int] NOT NULL,
    [Facility_Id] [int] NOT NULL,
	Zipcode char(5) NOT NULL,
	Primary Key (Property_Id,Facility_Id),
	CONSTRAINT Property_Id_FK FOREIGN KEY ([Property_Id]) REFERENCES Property ([Property_Id]),
	CONSTRAINT Facility_Id_FK FOREIGN KEY (Facility_Id) REFERENCES Public_Facilities (Facility_Id),
	)
/*******************************Indexes*****************************************/

---------------------------Non Clustered Index on [User] Table--------------------

CREATE NONCLUSTERED INDEX [Name]
ON [dbo].[User]([User_Name] ASC)


------------------------- Non clustered column on Unit table--------------
CREATE NONCLUSTERED INDEX [Unit_id] 
ON [dbo].[Lease_Details]([Unit_Id] ASC)

/********************************DML Statements********************************/

INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Yash Khokale', 'qwesa123', N'06/19/1997', N'yashkhokale@gmail.com', N'170, Vakhar Bhag, Sangli.', 6174126121)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Anish Naik','qwesf123', N'09/12/1997', N'naik.ani@husky.neu.edu', N'451, Park Drive, Boston, MA', 6172596134)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Bhumika Punjabi','qcxvwe123', N'05/02/2008', N'bhumikapunjabi2294@gmail.com', N'432, Boylston Street, Boston, MA', 6825535655)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Cash Johnson','asqwe123', N'06/10/2019', N'cashj@gmail.com', N'Pragati colony, Sangli, MH', 6174126123)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Rock K', 'dsadqwe123', N'10/11/2020', N'rocky@gmail.com', N'Fenway Park, boston, MA', 8421564564)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Hunter Kelen','vcxvqwe123', N'09/08/2001', N'hunty@gmail.com', N'250, Emerald Necklace, boston, MA', 9876543210)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Joey Tribianni ','vcxqwe123', N'04/01/1998', N'joeyhowudoing@gmail.com', N'Central Park, New York City, NY', 1430001430)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Ross Geller','qfgwe123', N'04/02/1998', N'rossunagi@gmail.com', N'Ungly guy, NYC, NY', 3426517894)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Chandler Bing','dgqwe123', N'04/03/1998', N'iknewit@gmail.com', N'Monica''s Apt, NYC, NY', 5461237894)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Gunther ','qgweh123', N'04/04/1998', N'iloveracheal@gmail.com', N'Centerl Perk, Down town, NYC, NY', 8456482123)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Yash Green','qsdfwe123', N'06/19/1997', N'yashkhokale@gmail.com', N'170, Vakhar Bhag, Sangli.', 6174126121)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Anish Bing','sfsqwe123', N'09/12/1997', N'naik.ani@husky.neu.edu', N'451, Park Drive, Boston, MA', 6172596134)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Jonny Malhotra','ccxvqwe123', N'05/02/2008', N'jonnymalhotra@gmail.com', N'432, Boylston Street, Boston, MA', 6174126122)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES 
( N'Cash Johnson','xvdsvqwe123', N'06/10/2019', N'cashj@gmail.com', N'Pragati colony, Sangli, MH', 6174126123)GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Rock K','mjmqwe123', N'10/11/2020', N'rocky@gmail.com', N'Fenway Park, boston, MA', 8421564564)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Hunter Kelen','hgrqwe123', N'09/08/2001', N'hunty@gmail.com', N'250, Emerald Necklace, boston, MA', 9876543210)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Joey Tribianni ','gfrhqwe123', N'04/01/1998', N'joeyhowudoing@gmail.com', N'Central Park, New York City, NY', 1430001430)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Ross Geller','rthqwe123', N'04/02/1998', N'rossunagi@gmail.com', N'Ungly guy, NYC, NY', 3426517894)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Chandler Bing','czxcqwe123', N'04/03/1998', N'iknewit@gmail.com', N'Monica''s Apt, NYC, NY', 5461237894)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Gunther ','dsadqwe123', N'04/04/1998', N'iloveracheal@gmail.com', N'Centerl Perk, Down town, NYC, NY', 8456482123)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Yash Geller','cxzcqwe123', N'06/19/1997', N'yashkhokale@gmail.com', N'170, Vakhar Bhag, Sangli.', 6174126121)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Anish Tribianni','daavqwe123', N'09/12/1997', N'naik.ani@husky.neu.edu', N'451, Park Drive, Boston, MA', 6172596134)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Jonny Malhotra','bvbaqwe123', N'05/02/2008', N'jonnymalhotra@gmail.com', N'432, Boylston Street, Boston, MA', 6174126122)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Cash Johnson','vdbqwe123', N'06/10/2019', N'cashj@gmail.com', N'Pragati colony, Sangli, MH', 6174126123)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Rock K', 'bxbqwe123', N'10/11/2020', N'rocky@gmail.com', N'Fenway Park, boston, MA', 8421564564)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Hunter Kelen','snme123', N'09/08/2001', N'hunty@gmail.com', N'250, Emerald Necklace, boston, MA', 9876543210)
GO
INSERT [dbo].[User] ( [User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Joey Tribianni ','sfaGqwe123', N'04/01/1998', N'joeyhowudoing@gmail.com', N'Central Park, New York City, NY', 1430001430)
GO
INSERT [dbo].[User] ([User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Ross Geller','dgswe123', N'04/02/1998', N'rossunagi@gmail.com', N'Ungly guy, NYC, NY', 3426517894)
GO
INSERT [dbo].[User] ([User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Chandler Bing','sbsqwe123', N'04/03/1998', N'iknewit@gmail.com', N'Monica''s Apt, NYC, NY', 5461237894)
GO
INSERT [dbo].[User] ([User_Name], [PasswordHash], [Date_of_Birth], [Email_Address], [Address], [Contact_Number]) VALUES ( N'Gunther ','szbswe123', N'04/04/1998', N'iloveracheal@gmail.com', N'Centerl Perk, Down town, NYC, NY', 8456482123)
GO

---------------


INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3000, N'Cityview - 1bhk', N'Amet Rd.', N'AR', N'Fayetteville', N'72005 ', N'12%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3001, N'Robins Apatment-3 bhk', N'Egestas. Av.', N'Vermont', N'Montpelier', N'93499 ', N'15%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3002, N'Parkers View-Studio-Apt', N'Egestas. Av.', N'Idaho', N'Boise', N'48868 ', N'15%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3003, N'Logans 2-bhk', N'Lobortis St.', N'LA', N'New Orleans', N'57620 ', N'2%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3004, N'Barneys Studio-Apt', N'Lobortis St.', N'Maine', N'Bangor', N'91181 ', N'10%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3005, N'Home sweet home 3-bhk', N'Nisl Rd.', N'WA', N'Tacoma', N'42051 ', N'10%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3006, N'Lillys 4-bhk', N'Amet Rd.', N'WI', N'Milwaukee', N'33516 ', N'20%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3007, N'Suncity 3-bhk', N'Donec Rd.', N'AK', N'Fairbanks', N'99610 ', N'2%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3008, N'Hill top view 3-bhk', N'Enim Rd.', N'Idaho', N'Boise', N'37468 ', N'20%')
GO
INSERT [dbo].[Property] ([Property_Id], [Property_Name], [Street_Name], [State_Name], [City_Name], [Zipcode], [Crime_Rate]) VALUES (3009, N'Marino 4-bhk', N'Donec Rd.', N'Illinois', N'Rockford', N'10628 ', N'20%')
GO

-----------------
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (100, N'Trader Joe''s<3miles', N'Chase< 2mile', N'Red_Line<2miles', N'<1.5miles', N'<4miles', N'Not Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (101, N'Whole Food<1mile', N'Santander<2 mile', N'Orange-Line<1miles', N'<1.5miles', N'<5miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (102, N'Walgreens<3miles', N'Chase< 2mile', N'Red_Line<2miles', N'<3miles', N'<3miles', N'Not Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (103, N'Stop-n-shop<1mile', N'Bofa< 1 mile', N'Orange-Line<1mile', N'<1miles', N'<4miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (104, N'Walmart<1mile', N'Bofa< 1 mile', N'Red_Line<2miles', N'<1miles', N'<6miles', N'Not Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (105, N'Indian Store<2miles', N'Chase< 2mile', N'Orange-Line<1miles', N'<2miles', N'<1.5miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (106, N'Whole Food<1mile', N'Bofa< 1 mile', N'Orange-Line<1miles', N'<2miles', N'<2miles', N'Not Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (107, N'Trader Joe''s<1mile', N'Bofa< 1 mile', N'Orange-Line<1mile', N'<2miles', N'<1miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (108, N'Whole Food<1mile', N'Chase< 2mile', N'CommuterRail<3miles', N'<2miles', N'<4miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (109, N'Trader Joe''s<3miles', N'Bofa< 1 mile', N'Red_Line<2miles', N'<3miles', N'<6miles', N'Not Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (110, N'Trader Joe''s<3miles', N'Santander<2 mile', N'Orange-Line<1miles', N'<2miles', N'<1.5miles', N'Not Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (111, N'Walgreens<3miles', N'Santander<2 mile', N'T-Line<1miles', N'<1.5miles', N'<3miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (112, N'Trader Joe''s<3miles', N'Santander<2 mile', N'CommuterRail<3miles', N'<3miles', N'<6miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (113, N'Indian Store<2miles', N'Santander<2 mile', N'CommuterRail<3miles', N'<1.5miles', N'<1.5miles', N'Available')
GO
INSERT [dbo].[Public_Facilities] ([Facility_Id], [Grocery_store], [Bank], [Subway_Station], [Bus_Stop], [Hospital], [Gym_facility]) VALUES (114, N'American Store<2miles', N'Bofa< 1 mile', N'T-Line<1miles', N'<1miles', N'<1miles', N'Available')
GO

------------------

INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2000, 1000, 3000, 286, 24, 'Old-Construction', 2000, 'N', 4, 1, CAST(N'2019-04-27T00:00:00.000' AS DateTime), CAST(N'2020-02-22T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2001, 1001, 3001, 127, 34, 'Old-Construction', 2222, 'Y', 1, 1, CAST(N'2019-06-29T00:00:00.000' AS DateTime), CAST(N'2019-04-04T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2002, 1002, 3002, 170, 36, 'Old-Construction', 2250, 'N', 4, 1, CAST(N'2019-06-21T00:00:00.000' AS DateTime), CAST(N'2020-06-22T00:00:00.000' AS DateTime), N'N')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2003, 1003, 3003, 371, 20, 'Not-Furnished', 1890, 'N', 1, 1, CAST(N'2019-09-10T00:00:00.000' AS DateTime), CAST(N'2020-08-08T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2004, 1004, 3004, 171, 50,'Newly Constructed', 3123, 'Y', 3, 1, CAST(N'2020-03-02T00:00:00.000' AS DateTime), CAST(N'2020-07-08T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2005, 1005, 3005, 328, 49, 'Furnished Apt', 2800, 'Y', 1, 1, CAST(N'2019-09-25T00:00:00.000' AS DateTime), CAST(N'2020-11-10T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2006, 1006, 3006, 356, 14, 'Not-Furnished', 1540, 'Y', 4, 1, CAST(N'2019-07-14T00:00:00.000' AS DateTime), CAST(N'2020-05-31T00:00:00.000' AS DateTime), N'N')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2007, 1007, 3007, 259, 19, 'Furnished Apt', 1980, 'N', 4, 1, CAST(N'2019-05-25T00:00:00.000' AS DateTime), CAST(N'2020-04-17T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2008, 1008, 3008, 430, 43, 'Newly Constructed', 2433, 'Y', 4, 1,CAST(N'2019-08-06T00:00:00.000' AS DateTime), CAST(N'2020-10-07T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2009, 1009, 3009, 108, 16, 'Old-Construction', 2456, 'Y', 4, 1,  CAST(N'2019-08-17T00:00:00.000' AS DateTime), CAST(N'2020-04-07T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2010, 1010, 3000, 286, 4, 'Old-Construction', 2000, 'N', 4, 1, CAST(N'2019-04-27T00:00:00.000' AS DateTime), CAST(N'2020-02-22T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2011, 1011, 3001, 127, 3, 'Old-Construction', 2222, 'Y', 1, 1, CAST(N'2019-06-29T00:00:00.000' AS DateTime), CAST(N'2019-08-04T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2012, 1012, 3002, 170, 6, 'Old-Construction', 2250, 'N', 4, 1, CAST(N'2019-06-21T00:00:00.000' AS DateTime), CAST(N'2020-06-22T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2013, 1013, 3003, 371, 21, 'Not-Furnished', 1890, 'N', 1, 1, CAST(N'2019-09-10T00:00:00.000' AS DateTime), CAST(N'2019-11-11T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2014, 1014, 3004, 171, 15,'Newly Constructed', 3123, 'Y', 3, 1, CAST(N'2020-03-02T00:00:00.000' AS DateTime), CAST(N'2020-05-06T00:00:00.000' AS DateTime), N'N')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2015, 1015, 3005, 328, 40, 'Furnished Apt', 2800, 'Y', 1, 1, CAST(N'2019-09-25T00:00:00.000' AS DateTime), CAST(N'2020-11-10T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2016, 1016, 3006, 356, 24, 'Not-Furnished', 1540, 'Y', 4, 1, CAST(N'2019-07-14T00:00:00.000' AS DateTime), CAST(N'2020-05-31T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2017, 1017, 3007, 259, 39, 'Furnished Apt', 1980, 'N', 4, 1, CAST(N'2019-05-25T00:00:00.000' AS DateTime), CAST(N'2020-04-17T00:00:00.000' AS DateTime), N'N')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2018, 1018, 3008, 430, 23, 'Newly Constructed', 2433, 'Y', 4, 1,CAST(N'2019-08-06T00:00:00.000' AS DateTime), CAST(N'2020-10-07T00:00:00.000' AS DateTime), N'Y')
INSERT [dbo].[Unit] ([Unit_Id], [User_Id], [Property_Id], [Unit_Number], [Unit_Floor_Number], [Unit_Description], [Carpet_area], [Pets_Allowed], [No_of_bedrooms], [No_of_bathrooms], [Date_of_Posting], [Date_Available_from], [Availability]) VALUES (2019, 1019, 3009, 108, 46, 'Old-Construction', 2456, 'Y', 4, 1,  CAST(N'2019-08-17T00:00:00.000' AS DateTime), CAST(N'2019-08-25T00:00:00.000' AS DateTime), N'Y')

--------------
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4000, 2000, CAST(N'2020-04-16T00:00:00.000' AS DateTime), CAST(N'2021-04-16T00:00:00.000' AS DateTime), 12, 1287, 1000, NULL, N'Y', 3)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4001, 2001, CAST(N'2020-12-28T00:00:00.000' AS DateTime), CAST(N'2021-06-28T00:00:00.000' AS DateTime), 6, 874, 1000, NULL, N'Y', 2)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4002, 2002, CAST(N'2021-01-23T00:00:00.000' AS DateTime), CAST(N'2022-01-24T00:00:00.000' AS DateTime), 12, 1697, 1000, NULL, N'Y', 3)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4003, 2003, CAST(N'2020-10-18T00:00:00.000' AS DateTime), CAST(N'2021-10-18T00:00:00.000' AS DateTime), 12, 1282, 1000, NULL, N'Y', 2)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4004, 2004, CAST(N'2021-02-08T00:00:00.000' AS DateTime), CAST(N'2021-06-08T00:00:00.000' AS DateTime), 16, 1840, 2000, NULL, N'Y', 3)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4005, 2005, CAST(N'2021-01-31T00:00:00.000' AS DateTime), CAST(N'2022-01-31T00:00:00.000' AS DateTime), 12, 1279, 3000, NULL, N'Y', 3)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4006, 2006, CAST(N'2020-06-23T00:00:00.000' AS DateTime), CAST(N'2021-06-23T00:00:00.000' AS DateTime), 12, 1952, 2000, NULL, N'Y', 4)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4007, 2007, CAST(N'2021-03-28T00:00:00.000' AS DateTime), CAST(N'2022-03-28T00:00:00.000' AS DateTime), 12, 1307, 2000, NULL, N'Y', 3)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4008, 2008, CAST(N'2020-05-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T00:00:00.000' AS DateTime), 6, 1665, 2000, NULL, N'Y', 3)
INSERT [dbo].[Lease_Details] ([Lease_Id], [Unit_Id], [StartDate], [EndDate], [Term], [Monthly_Rent], [Security_Deposit_Amount], [Pet_Deposit], [Is_sub_leasing_allowed], [Required_people_on_lease]) VALUES (4009, 2009, CAST(N'2020-09-24T00:00:00.000' AS DateTime), CAST(N'2021-02-24T00:00:00.000' AS DateTime), 6, 1106, 3000, NULL, N'Y', 4)

----------------------


INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5000,1000, 4000, N'Cash', CAST(N'2020-04-05T00:00:00.000' AS DateTime), 1080)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5001,1001, 4001, N'Online Transaction', CAST(N'2020-01-11T00:00:00.000' AS DateTime), 1267)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5002,1002, 4002, N'Check', CAST(N'2020-05-02T00:00:00.000' AS DateTime), 1372)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5003,1003, 4003, N'Cash', CAST(N'2020-05-03T00:00:00.000' AS DateTime), 1081)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5004,1004, 4004, N'DD', CAST(N'2020-09-25T00:00:00.000' AS DateTime), 1995)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5005,1005, 4005, N'Online Transaction', CAST(N'2020-02-03T00:00:00.000' AS DateTime), 1863)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5006,1006, 4006, N'Online Transaction', CAST(N'2020-04-05T00:00:00.000' AS DateTime), 1611)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5007,1007, 4007, N'Online Transaction', CAST(N'2020-10-06T00:00:00.000' AS DateTime), 1717)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5008,1008, 4008, N'DD', CAST(N'2020-04-08T00:00:00.000' AS DateTime), 1565)
INSERT [dbo].[Lease_Payment] ([Lease_Payment_Id],[User_Id], [Lease_Id], [Payment_Type], [Payment_Date], [Payment_Amount]) VALUES (5009,1009, 4009, N'DD', CAST(N'2020-11-01T00:00:00.000' AS DateTime), 1930)

---------------------

INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1002, 2800, N'432, Boylston Street, Boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1004, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1008, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1010, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1012, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1014, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1018, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1020, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1022, 1400, N'Fenway Park, boston, MA')
INSERT [dbo].[Agent] ([User_Id], [Broker_Fee], [Office_Address]) VALUES (1024, 1400, N'Fenway Park, boston, MA')

------------------


INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1000, 2400)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1001, 3200)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1003, 2400)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1005, 3200)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1007, 2400)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1009, 3200)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1011, 2400)
INSERT [dbo].[Owner] ([User_Id], [Price_Expectation]) VALUES (1013, 3200)

-----------------


INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1006, 'In-house laundry unit required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1015, '3BHK required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1016, 'Backyard and parking lot required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1017, '4BHK with 1.5 bath required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1019, 'In-house laundry unit required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1020, 'Microwave required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1021, 'Parrking lot required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1023, 'Electric stove and microwave required')
GO
INSERT [dbo].[Client] ([User_Id], [Client_Wishlist]) VALUES (1025, 'Parking lot and backyard required')
GO

----------------------
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (1, CAST(N'2019-08-02T00:00:00.000' AS DateTime), 1000, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (2, CAST(N'2019-12-23T00:00:00.000' AS DateTime), 1001, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (3, CAST(N'2019-12-21T00:00:00.000' AS DateTime), 1002, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (4, CAST(N'2020-02-25T00:00:00.000' AS DateTime), 1003, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (5, CAST(N'2019-11-23T00:00:00.000' AS DateTime), 1004, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (6, CAST(N'2019-11-12T00:00:00.000' AS DateTime), 1005, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (7, CAST(N'2019-08-21T00:00:00.000' AS DateTime), 1006, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (8, CAST(N'2019-08-18T00:00:00.000' AS DateTime), 1007, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (9, CAST(N'2020-01-05T00:00:00.000' AS DateTime), 1008, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (10, CAST(N'2019-04-05T00:00:00.000' AS DateTime), 1009, N'')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (11, CAST(N'2020-06-04T00:00:00.000' AS DateTime), 1009, N'Raised a Maintenance Request')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (12, CAST(N'2020-07-09T00:00:00.000' AS DateTime), 1004, N'Payment queries solved')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (13, CAST(N'2020-06-06T00:00:00.000' AS DateTime), 1003, N'Raised a Maintenance Request')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (14, CAST(N'2020-09-09T00:00:00.000' AS DateTime), 1005, N'Payment queries solved')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (15, CAST(N'2019-03-04T00:00:00.000' AS DateTime), 1006, N'Maintenance Request')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (16, CAST(N'2008-07-06T00:00:00.000' AS DateTime), 1002, N'Payment queries solved')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (17, CAST(N'2003-07-06T00:00:00.000' AS DateTime), 1001, N'Maintenance Request')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (18, CAST(N'2006-02-03T00:00:00.000' AS DateTime), 1008, N'Feedback')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (19, CAST(N'2004-01-01T00:00:00.000' AS DateTime), 1007, N'Lease requirements list')
GO
INSERT [dbo].[Appointment_Schedule] ([Appointment_Id], [Scheduled_Date], [User_Id], [Meeting_Notes]) VALUES (20, CAST(N'1997-01-09T00:00:00.000' AS DateTime), 1000, N'personal requirements')
GO

----------------

INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (500, N'Y', N'Y', N'Y', N'Y', N'Y', N'Y', N'N', N'N', N'N', N'N', N'Y')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (501, N'Y', N'N', N'Y', N'N', N'Y', N'Y', N'Y', N'Y', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (502, N'Y', N'Y', N'Y', N'N', N'Y', N'Y', N'Y', N'Y', N'Y', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (503, N'Y', N'Y', N'N', N'Y', N'N', N'Y', N'Y', N'N', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (504, N'Y', N'N', N'N', N'Y', N'Y', N'N', N'Y', N'Y', N'N', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (505, N'N', N'Y', N'N', N'Y', N'N', N'Y', N'Y', N'Y', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (506, N'N', N'N', N'Y', N'Y', N'N', N'Y', N'Y', N'N', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (507, N'N', N'N', N'Y', N'Y', N'N', N'N', N'Y', N'N', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (508, N'N', N'Y', N'N', N'N', N'N', N'Y', N'N', N'N', N'N', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (509, N'Y', N'Y', N'Y', N'Y', N'N', N'Y', N'Y', N'N', N'Y', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3000, N'Y', N'N', N'Y', N'N', N'N', N'Y', N'Y', N'N', N'N', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3001, N'Y', N'N', N'N', N'Y', N'N', N'Y', N'Y', N'N', N'N', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3002, N'N', N'Y', N'Y', N'N', N'N', N'Y', N'Y', N'N', N'N', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3003, N'N', N'Y', N'N', N'Y', N'Y', N'N', N'Y', N'N', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3004, N'Y', N'N', N'Y', N'N', N'Y', N'N', N'Y', N'N', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3005, N'Y', N'N', N'N', N'Y', N'Y', N'N', N'N', N'Y', N'N', N'Y', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3006, N'N', N'Y', N'Y', N'N', N'N', N'Y', N'N', N'Y', N'N', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3007, N'N', N'Y', N'N', N'Y', N'N', N'Y', N'N', N'Y', N'Y', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3008, N'Y', N'N', N'Y', N'N', N'N', N'Y', N'N', N'Y', N'Y', N'N', N'N')
GO
INSERT [dbo].[Features] ([Features_Id], [Parking_Facility], [Air_Conditioning], [Central_Heating], [Carpet_floor], [Hardwood_floor], [InUnit_Fireplace], [InUnit_Garden], [InUnit_Laundary], [Ceiling_Fan], [Pets_Allowed], [Walkin_Closet]) VALUES (3009, N'Y', N'N', N'N', N'Y', N'Y', N'N', N'N', N'Y', N'Y', N'Y', N'N')
GO

----------------

INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2000, 505)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2001, 507)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2002, 500)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2003, 508)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2004, 509)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2005, 506)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2006, 504)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2007, 503)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2008, 501)
GO
INSERT [dbo].[Has_Features] ([Unit_Id], [Features_Id]) VALUES (2009, 502)
GO

-----------------

INSERT [dbo].[Apartment] ([Unit_Id], [Has_in_unit_laundry]) VALUES (2001, N'Y')
GO
INSERT [dbo].[Apartment] ([Unit_Id], [Has_in_unit_laundry]) VALUES (2004, N'N')
GO
INSERT [dbo].[Apartment] ([Unit_Id], [Has_in_unit_laundry]) VALUES (2006, N'Y')
GO
INSERT [dbo].[Apartment] ([Unit_Id], [Has_in_unit_laundry]) VALUES (2007, N'Y')
GO
INSERT [dbo].[Apartment] ([Unit_Id], [Has_in_unit_laundry]) VALUES (2009, N'N')
GO
INSERT [dbo].[Apartment] ([Unit_Id], [Has_in_unit_laundry]) 
VALUES (2010,'Y'),
        (2012,'N'),
        (2014,'Y'),
        (2016,'N'),
        (2018,'Y');

----------------------
INSERT [dbo].[House] ([Unit_Id], [Backyard], [Parking]) VALUES (2000, N'Y', N'N')
GO
INSERT [dbo].[House] ([Unit_Id], [Backyard], [Parking]) VALUES (2002, N'Y', N'Y')
GO
INSERT [dbo].[House] ([Unit_Id], [Backyard], [Parking]) VALUES (2003, N'N', N'N')
GO
INSERT [dbo].[House] ([Unit_Id], [Backyard], [Parking]) VALUES (2005, N'Y', N'Y')
GO
INSERT [dbo].[House] ([Unit_Id], [Backyard], [Parking]) VALUES (2008, N'N', N'Y')
GO
INSERT [dbo].[House] ([Unit_Id], [Backyard],[Parking]) 
VALUES (2011,'Y','N'),
        (2013,'N','Y'),
        (2015,'Y','N'),
        (2017,'N','N'),
        (2019,'Y','Y');

-------------------------

		
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3000, 109, 72005)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3001, 100, 93499)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3002, 108, 48868)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3003, 107, 57620)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3004, 104, 91181)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3005, 103, 42051)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3006, 102, 33516)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3007, 101, 99610)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3008, 106, 37468)
GO
INSERT [dbo].[Has_Zipcode] ([Property_Id], [Facility_Id], [Zipcode]) VALUES (3009, 105, 10628)
GO


/********************************Stored Procedures********************************/
------------------Stored Procedure to get user info who has rented the property-----------------------


CREATE PROCEDURE GetUserInfo @Property char(4) 
AS
BEGIN
 SELECT u.[User_Id], u.[User_Name] as full_name, u.Contact_Number, ut.Unit_Number, ut.Unit_Floor_Number,
		 p.Property_Name, p.Street_Name + ' '+ p.State_Name+ ' '+ p.City_Name as Property_Address
		FROM [User] u
			join unit ut on ut.[User_Id]= u.[User_Id]
			join Property p on ut.Property_Id= p.Property_Id
		where p.Property_Id= @Property;
END
exec GetUserInfo '3002'
select * from [User]
Select * from unit



------------------Stored Procedure to Check Pending Payment of rentier-----------------------
CREATE PROCEDURE getremainingamount
@userid int,
@remaining_payment int output
as
BEGIN
WITH 
t1 AS (
Select Unit_Id, Lease_Id, (Monthly_Rent+Security_Deposit_Amount) Total_Amount_to_Pay
from Lease_Details),
t2 AS (
Select t1.Lease_Id, t1.Total_Amount_to_Pay total_amount, lp.[User_Id], lp.Payment_Amount  paid_amount
FROM t1 JOIN Lease_Payment lp ON t1.Lease_Id = lp.Lease_Id where [User_Id] = @userid)

SELECT @remaining_payment =  (t2.total_amount-t2.paid_amount) FROM t2;
END

DECLARE @remp int
EXECUTE getremainingamount 1000,@remaining_payment = @remp OUT
SELECT @remp as RemainingPayment
select * from Lease_Payment
select * from Lease_Details

---------------------------Stored Procedure to retrieve lateFee of user if any---------------------------------------------------

CREATE PROCEDURE GetLateFee @user_id int,
@message varchar(100) output
as
Declare @lateDays int, @lateFees int, @leaseId int, @lastRentDay int
BEGIN 

set @leaseId= (SELECT lp.Lease_Id from Lease_Payment lp join Lease_Details ld on ld.Lease_Id= lp.Lease_Id join Unit u on u.Unit_Id= ld.Unit_Id
	where u.[User_Id] = @user_id);
set @lastRentDay = (SELECT DATEPART(day, '2020/04/01') AS DatePartInt);
set @lateDays= (select cast(datediff( day,'2020/04/01',lp.Payment_Date) as int) from Lease_Payment lp where Lease_Id= @leaseId);
set @lateFees= (@lateDays * 10);

 IF NOT EXISTS (
	SELECT 1 from Unit u where u.[User_Id]= @user_id)
		SET @message ='Invalid User'
ELSE IF EXISTS (
	SELECT 1 from Lease_Payment lp where lp.Lease_Id= @leaseId 
			and datepart(day,lp.Payment_Date)<@lastRentDay)
	BEGIN
		 UPDATE Lease_Payment set Late_Fees = 0 where Lease_Id= @leaseId;  
		 SET @message ='No Late Fees Charged,Updated late fee as 0'
	END;
	ELSE IF EXISTS (
	SELECT 1 from Lease_Payment lp where lp.Lease_Id= @leaseId 
		and  datepart(day,lp.Payment_Date)>@lastRentDay)
	 BEGIN
		 UPDATE Lease_Payment set Late_Fees = @lateFees where Lease_Id = @leaseId;    
		 SET @message ='Late Fees is Updated'
	END;
END
declare @message varchar(100), @user_id int
set @user_id = 1008
exec GetLateFee @user_id, @message output
print @message;

declare @message varchar(100), @user_id int
set @user_id = 1000
exec GetLateFee @user_id, @message output
print @message;

declare @message varchar(100), @user_id int
set @user_id = 1006
exec GetLateFee @user_id, @message output
print @message;
select * from Lease_Payment

---------------------Stored Procedure to Check Availability Status of a Property Unit ---------------------------------------------

CREATE PROCEDURE AptStatus @unit_id int,
@message varchar(100) output
as
BEGIN
Declare @availableFrom int, @status varchar(200), @UserId int
set @availableFrom= (select datediff( month,getdate(),u.Date_Available_from) from Unit u where Unit_Id=@unit_id);
set @status =(select case when @availableFrom < 0  then 'Not Available' 
						when @availableFrom = 0  then 'Immediate move-In'
						 when @availableFrom = 1 then 'Available 1 months from now'
						 when @availableFrom = 2 then 'Available 2 months from now'
						 when @availableFrom = 3 then 'Available 3 months from now'
						 when @availableFrom = 4 then 'Available 4 months from now'
						 when @availableFrom = 5 then 'Available 5 months from now'
						 when @availableFrom >5 then 'Not available before 6 months'
						 end)
select Unit_Id, Property_Id , Unit_Number ,Unit_Floor_Number , Date_Available_from 
           , @status as Availability  from Unit where Unit_Id=@unit_id;
END
declare @output varchar(100)
exec AptStatus 2002,@output
select * from Unit

/*******************************User Defined Functions********************************/

---------------Function to retrieve  best property in terms of crime rate and facilities available----------------------------------

create   function GetPropertyRating()
returns @Table table (Property_Id int,Property_Address varchar(250),Crime_Rate varchar(45),Grocery_store varchar(250), Subway_Station varchar(250), Gym_facility varchar(250))

As
Begin
insert into @Table 
select p.Property_Id,p.Street_Name + ' '+ p.State_Name+ ' '+ p.City_Name as Property_Address, p.Crime_Rate, pf.Grocery_store, pf.Subway_Station,pf.Gym_facility
from Property p join Has_Zipcode z on p.Property_Id=z.Property_Id
join Public_Facilities pf on pf.Facility_Id= z.Facility_Id
where p.Crime_Rate = '2%'
and pf.Grocery_store  like '%<1mile%'
and pf.Subway_Station like '%<1mile%' 
and pf.Gym_facility='Available'
return
End
select * from dbo.GetPropertyRating()
select * from Property
select * from Public_Facilities


--------------------------Function to retrieve Property Details------------------------------

create function GetPropertyName(@Property_Id int)
returns @Table table (Property_name varchar(50),street_name varchar(50),city_name varchar(50), zipcode int)

As
Begin
 insert into @Table
 select Property_name,street_name,city_name,zipcode from Property where Property_Id=@Property_Id
return
End

select * from GetPropertyName(3000)


/********************************Triggers********************************/

------------------Trigger to track Availability status of Apartments-----------------------
Create TABLE AvlStatus(
Property_Id int,Unit_no int, Unit_Floor_no int,Date_Available_from date,[message] varchar(1000)
);

SELECT * from Unit

create TRIGGER availability_status ON Unit
FOR INSERT
AS 
BEGIN
Declare @availableDate date,@availableFrom int, @status varchar(200)
select @availableDate= Date_Available_from FROM INSERTED;
set @availableFrom= datediff( month,getdate(),@availableDate);
set @status =(select case when @availableFrom < 0  then 'Not Available'
						 when @availableFrom = 0  then 'Immediate move-In'
						 when @availableFrom = 1 then 'Available 1 months from now'
						 when @availableFrom = 2 then 'Available 2 months from now'
						 when @availableFrom = 3 then 'Available 3 months from now'
						 when @availableFrom = 4 then 'Available 4 months from now'
						 when @availableFrom = 5 then 'Available 5 months from now'
						 when @availableFrom >5 then 'Not available before 6 months'
						 end )						 
INSERT INTO [dbo].[AvlStatus]
     VALUES
           ( (select Property_Id from Inserted)
           ,(select Unit_Number from Inserted)
           ,(select Unit_Floor_Number from Inserted)
           ,(select Date_Available_from from Inserted)
           ,(@status))
END
INSERT INTO Unit values(2020,1020,3009,170,36,'Old-Construction',2250,'N',4,1,getdate(),'2020-04-10 00:00:00.000', 'Y');
Select * from AvlStatus;
Select * from unit;


----------------------------Trigger to track availability of a unit when posted----------------------------

create TRIGGER newAvailability ON Unit
FOR INSERT
AS 
BEGIN
DECLARE @unitId int, @propertyId int, @UnitNo int, @FloorNo int, @availabiltyFrom date, @bedrooms int,@bathrooms int;
SELECT  @propertyId= Property_Id, @UnitNo=Unit_Number, @FloorNo=Unit_Floor_Number, @availabiltyFrom =Date_Available_from, @bedrooms=No_of_bedrooms, @bathrooms=No_of_bathrooms FROM inserted
INSERT INTO UnitInfo
VALUES('Unit Number = ' + CAST(@UnitNo as nvarchar(5)) + ' at floor = ' + CAST(@FloorNo as nvarchar(5)) +' for property number ' + CAST(@propertyId as nvarchar(5)) +'  is available from  ' + CAST(@availabiltyFrom as nvarchar(10)) + '  having  ' + cast(@bedrooms as nvarchar(20)) + 'Bedrooms and ' +cast(@bathrooms as nvarchar(20)) +'Bathrooms')
END

Create TABLE UnitInfo(
id int IDENTITY(1,1) PRIMARY KEY,
[message] varchar(1000));

INSERT INTO Unit values(2021,1002,3002,170,36,'Old-Construction',2250,'N',4,1,'2019-06-21 00:00:00.000','2020-06-22 00:00:00.000','N');

select * from UnitInfo
SELECT * from Unit

--------------- trigger to generate first payment( monthly_rent +security deposit) required by the user for each unit-----------
 
create  trigger first_payment on 
Lease_details 
FOR INSERT
AS 
BEGIN
DECLARE @unit_id int, @rent int, @deposit int,  @firstPay int
SELECT @unit_id = [Unit_id],  @firstPay = (Monthly_rent + Security_Deposit_amount)
FROM inserted
INSERT INTO first_pay
 
VALUES( 'For Unit id = '+CAST(@unit_id as nvarchar(5)) +  ',  User initially needs to pay amount(first month rent + security deposit) =' + CAST(@firstPay as nvarchar(20)))
END
 
CREATE TABLE first_pay
( [message] varchar(100));
 
INSERT INTO Lease_details values(4012, 2008, CAST(N'2020-02-01T00:00:00.000' AS DateTime), CAST(N'2021-02-01T00:00:00.000' AS DateTime), 12, 1500, 1500, NULL, N'Y', 2)
 
select * from first_pay
select * from Lease_details


/********************************Views********************************/

-----------------------View for Unit Count by User ------------------------------------------

Create VIEW UnitCountbyUser
as
select u.[User_Id],u.Unit_Description, COUNT(u.Unit_Description)  OVER (PARTITION BY u.[User_Id] Order by u.Unit_Description desc) as [count]
from Unit u

select * from UnitCountbyUser

----------------------view for facilities near the property --------------------

create view Vw_Property_facility as
select p.Property_Id, p.property_name, p.street_name, p.city_name, p.zipcode, p.crime_rate, f.grocery_store, f.bank, f.subway_station, f.bus_stop, f.hospital, f.gym_facility
from [dbo].[Property] p, Public_Facilities f,  [dbo].[Has_Zipcode] zp
where p.Property_Id = zp.Property_Id and f.Facility_Id = zp.Facility_Id


select * from Vw_Property_facility


----------------------------View for Unit features --------------------------

create view Unit_Features as
select u.Unit_Id, u.[User_Id], u.Property_Id,u.Unit_Number, u.Unit_Floor_Number, u.Unit_Description,l.term,l.Monthly_Rent, u.Carpet_area, u.Pets_Allowed,u.No_of_bedrooms,u.No_of_bathrooms,
f.Features_Id, f.Parking_Facility,f.Air_Conditioning,f.Central_Heating,f.Carpet_floor,f.Hardwood_floor,f.InUnit_Fireplace,
f.InUnit_Garden,f.InUnit_Laundary,f.Ceiling_Fan,f.Walkin_Closet
from [Unit] u,  [Features] f, Has_Features hf, [Lease_details] l
where u.Unit_Id = hf.Unit_Id and f.Features_Id = hf.Features_Id and u.Unit_Id = l.Unit_Id

select * from Unit_Features



/********************************Column Data Encryption********************************/

-------------------------------Column Data Encryption on User's Password-------------------- 

USE master;
GO
SELECT *
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##';
GO

USE RentItOut;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password123';

GO
CREATE CERTIFICATE Certificate1
WITH SUBJECT = 'Protect Data';
GO

GO
CREATE SYMMETRIC KEY SymmetricKey1
 WITH ALGORITHM = AES_128
 ENCRYPTION BY CERTIFICATE Certificate1;
GO

--- above code run it just once--------

GO
ALTER TABLE [User]
ADD PasswordHash_encrypt varbinary(MAX) NULL
GO

GO
-- Opens the symmetric key for use
OPEN SYMMETRIC KEY SymmetricKey1
DECRYPTION BY CERTIFICATE Certificate1;
GO
UPDATE [User]
SET PasswordHash_encrypt = EncryptByKey (Key_GUID('SymmetricKey1'),PasswordHash)
FROM dbo.[User];
GO
-- Closes the symmetric key
CLOSE SYMMETRIC KEY SymmetricKey1;
GO
GO
ALTER TABLE [User]
DROP COLUMN PasswordHash;
GO

Select * from [User]

-------------Decryption---------
OPEN SYMMETRIC KEY SymmetricKey1
DECRYPTION BY CERTIFICATE Certificate1;
-- Now list the original ID, the encrypted ID

SELECT [User_Id],[User_Name], PasswordHash_encrypt AS 'Encrypted PasswordHash',
CONVERT(nvarchar, DecryptByKey(PasswordHash_encrypt)) AS 'PasswordHash'
FROM dbo.[User];
 -- Close the symmetric key
CLOSE SYMMETRIC KEY SymmetricKey1;

Select * from [User]





