set @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
set @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
set @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

create schema if not exists `assessment` default CHARACTER set latin1 ;
use `assessment` ;

-- vehicle types table
create table if not exists `assessment`.`Vehicle_Types` (
  `Type` varchar(45) not null,
  `Km_per_Litre` FLOAT not null,
  `Pounds_per_Litre` FLOAT not null,
  primary key (`Type`),
  unique index `Type_UNIQUE` (`Type` asc))
ENGINE = InnoDB;

-- vehicles table
create table if not exists `assessment`.`Vehicles` (
  `ID` int not null auto_increment,
  `Vehicle_Type` varchar(45) not null,
  primary key (`ID`),
  index `fk_Vehicles_Vehicle Types1_idx` (`Vehicle_Type` asc),
  unique index `ID_UNIQUE` (`ID` asc),
  constraint `fk_Vehicles_Vehicle Types1`
    foreign key (`Vehicle_Type`)
    references `assessment`.`Vehicle_Types` (`Type`)
    on delete no action
    on update no action)
ENGINE = InnoDB;

-- departments table
create table if not exists `assessment`.`Departments` (
  `Name` varchar(45) not null,
  `Credit_Card_Number` bigint(16) not null,
  primary key (`Name`),
  unique index `Name_UNIQUE` (`Name` asc))
ENGINE = InnoDB;

-- faculty table
create table if not exists `assessment`.`Faculty` (
  `Name` varchar(45) not null,
  `Departments_Name` varchar(45) not null,
  primary key (`Name`),
  unique index `Name_UNIQUE` (`Name` asc),
  index `fk_Faculty_Departments1_idx` (`Departments_Name` asc),
  constraint `fk_Faculty_Departments1`
    foreign key (`Departments_Name`)
    references `assessment`.`Departments` (`Name`)
    on delete no action
    on update no action)
ENGINE = InnoDB;

-- travel table
create table if not exists `assessment`.`Travel` (
  `ID` int not null auto_increment,
  `Vehicles_ID` int not null,
  `Faculty_Name` varchar(45) not null,
  `Date_From` date not null,
  `Date_Until` date not null,
  `Destination` varchar(45) not null,
  primary key (`ID`),
  index `fk_Travel_Vehicles1_idx` (`Vehicles_ID` asc),
  unique index `ID_UNIQUE` (`ID` asc),
  index `fk_Reservation_Faculty1_idx` (`Faculty_Name` asc),
  constraint `fk_Travel_Vehicles1`
    foreign key (`Vehicles_ID`)
    references `assessment`.`Vehicles` (`ID`)
    on delete no action
    on update no action,
  constraint `fk_Reservation_Faculty1`
    foreign key (`Faculty_Name`)
    references `assessment`.`Faculty` (`Name`)
    on delete no action
    on update no action)
ENGINE = InnoDB;

-- mechanics table
create table if not exists `assessment`.`Mechanics` (
  `Name` varchar(45) not null,
  `Inspection_Authorization` BIT not null,
  primary key (`Name`),
  unique index `Name_UNIQUE` (`Name` asc))
ENGINE = InnoDB;

-- maintenence table
create table if not exists `assessment`.`Maintenance` (
  `ID` int not null auto_increment,
  `Vehicles_ID` int not null,
  `Mechanics_Name` varchar(45) not null,
  `Description` varchar(256) not null,
  `Entry` date not null,
  `Back_To_Service` date not null,
  primary key (`ID`),
  index `fk_Maintainence Log_Vehicles1_idx` (`Vehicles_ID` asc),
  index `fk_Maintainence_Mechanics1_idx` (`Mechanics_Name` asc),
  unique index `ID_UNIQUE` (`ID` asc),
  constraint `fk_Maintainence Log_Vehicles1`
    foreign key (`Vehicles_ID`)
    references `assessment`.`Vehicles` (`ID`)
    on delete no action
    on update no action,
  constraint `fk_Maintainence_Mechanics1`
    foreign key (`Mechanics_Name`)
    references `assessment`.`Mechanics` (`Name`)
    on delete no action
    on update no action)
ENGINE = InnoDB;

-- vehical parts table
create table if not exists `assessment`.`Parts` (
  `Name` varchar(45) not null,
  `Available` int not null,
  `Mininum` int not null,
  primary key (`Name`),
  unique index `Name_UNIQUE` (`Name` asc))
ENGINE = InnoDB;

-- vehical parts used table
create table if not exists `assessment`.`Parts_Usage` (
  `Maintenance_ID` int not null,
  `Parts_Name` varchar(45) not null,
  primary key (`Maintenance_ID`, `Parts_Name`),
  index `fk_Maintainence_has_Parts_Parts1_idx` (`Parts_Name` asc),
  index `fk_Maintainence_has_Parts_Maintainence1_idx` (`Maintenance_ID` asc),
  constraint `fk_Maintainence_has_Parts_Maintainence1`
    foreign key (`Maintenance_ID`)
    references `assessment`.`Maintenance` (`ID`)
    on delete no action
    on update no action,
  constraint `fk_Maintainence_has_Parts_Parts1`
    foreign key (`Parts_Name`)
    references `assessment`.`Parts` (`Name`)
    on delete no action
    on update no action)
ENGINE = InnoDB;

create table if not exists `assessment`.`Completed Travel` (
  `ID` int not null auto_increment,
  `Travel_ID` int not null,
  `Odometer_Start` varchar(45) not null,
  `Odometer_End` varchar(45) not null,
  primary key (`ID`),
  unique index `ID_UNIQUE` (`ID` asc),
  index `fk_Completed Travel_Travel1_idx` (`Travel_ID` asc),
  constraint `fk_Completed Travel_Travel1`
    foreign key (`Travel_ID`)
    references `assessment`.`Travel` (`ID`)
    on delete no action
    on update no action)
ENGINE = InnoDB;

set SQL_MODE=@OLD_SQL_MODE;
set FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
set UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

start transaction;
use `assessment`;

-- vehicle types data
insert into `assessment`.`Vehicle_Types` (`Type`, `Km_per_Litre`, `Pounds_per_Litre`) VALUES ('Bus', 12, 1.71);
insert into `assessment`.`Vehicle_Types` (`Type`, `Km_per_Litre`, `Pounds_per_Litre`) VALUES ('Minibus', 14, 1.71);
insert into `assessment`.`Vehicle_Types` (`Type`, `Km_per_Litre`, `Pounds_per_Litre`) VALUES ('Car', 16, 1.49);

-- vehicle data
insert into `assessment`.`Vehicles` (`Vehicle_Type`) VALUES ('Bus');
insert into `assessment`.`Vehicles` (`Vehicle_Type`) VALUES ('Bus');
insert into `assessment`.`Vehicles` (`Vehicle_Type`) VALUES ('Minibus');
insert into `assessment`.`Vehicles` (`Vehicle_Type`) VALUES ('Car');
insert into `assessment`.`Vehicles` (`Vehicle_Type`) VALUES ('Minibus');

-- department data
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('Maths', 5287973496936748);
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('Art', 4694245837959353);
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('Physics', 7160197876318370);
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('Geography', 6771167320885219);
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('English', 0957075886603629);
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('History', 8771482551854878);
insert into `assessment`.`Departments` (`Name`, `Credit_Card_Number`) VALUES ('Music', 0394302984459086);

-- faculty data
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('Bob D', 'Music');
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('Albert E', 'Physics');
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('Indiana J', 'History');
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('Lianado V', 'Art');
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('William S', 'English');
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('Bear G', 'Geography');
insert into `assessment`.`Faculty` (`Name`, `Departments_Name`) VALUES ('Ozzy O', 'Maths');

-- travel data
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (2, 'Albert E', '2020-12-8', '2020-12-10', '24 Arnold Street');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (4, 'Indiana J', '2021-3-4', '2021-5-4', '20 Tree Grove');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (1, 'Bob D', '2021-5-5', '2021-5-7', '22 Tree Avenue');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (3, 'Bear G', '2021-6-7', '2022-6-7', '64 Zoo Lane');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (4, 'Bob D', '2021-7-5', '2021-7-5', '74 Rigbys Lane');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (1, 'Albert E', '2021-7-5', '2021-7-5', '74 Anson Avenue');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (5, 'Lianado V', '2021-7-9', '2021-7-9', '5 Oldfield Acres');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (3, 'Ozzy O', '2021-7-9', '2021-7-9', '6 Hornby Gate');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (2, 'Bear G', '2021-8-10', '2021-8-11', '20 Norwood Close');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (4, 'Bear G', '2021-8-13', '2021-8-13', '20 Norwood Close');
insert into `assessment`.`Travel` (`Vehicles_ID`, `Faculty_Name`, `Date_From`, `Date_Until`, `Destination`) VALUES (5, 'Indiana J', '2021-9-10', '2021-9-10', '34 Amberley Green');

-- mechanics data
insert into `assessment`.`Mechanics` (`Name`, `Inspection_Authorization`) VALUES ('Bill', 1);
insert into `assessment`.`Mechanics` (`Name`, `Inspection_Authorization`) VALUES ('James', 1);
insert into `assessment`.`Mechanics` (`Name`, `Inspection_Authorization`) VALUES ('Andrew', 0);

-- maintenence data
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (2, 'Bill', 'Gasket replacement', '2020-10-9', '2020-10-9');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (3, 'James', 'Exploded air filter motor replacement', '2020-11-18', '2020-12-1');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (1, 'Bill', 'Tire Replacement', '2020-11-20', '2020-11-20');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (3, 'Bill', 'Oil Filter Fix', '2021-1-16', '2021-1-16');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (3, 'James', 'Oil Filter Replacement', '2021-1-18', '2021-1-19');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (2, 'Bill', 'Anual Maintenance', '2021-2-1', '2021-2-1');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (3, 'Andrew', 'Replacement of 2 tires', '2021-2-3', '2021-2-5');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (2, 'James', 'Engine Repairs', '2021-4-5', '2021-4-6');
insert into `assessment`.`Maintenance` (`Vehicles_ID`, `Mechanics_Name`, `Description`, `Entry`, `Back_To_Service`) VALUES (5, 'Bill', 'Tire Replacement', '2021-5-9', '2021-5-9');

-- vehicle parts data
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Small Tire', 10, 5);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Large Tire', 6, 4);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Small Gear Belt', 8, 6);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Large Gear Belt', 6, 5);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('4L Engine Oil', 20, 12);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Air Filter', 3, 2);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Oil filter', 5, 5);
insert into `assessment`.`Parts` (`Name`, `Available`, `Mininum`) VALUES ('Gasket', 6, 2);

-- vehical parts usage data
insert into `assessment`.`Parts_Usage` (`Maintenance_ID`, `Parts_Name`) VALUES (1, 'Gasket');
insert into `assessment`.`Parts_Usage` (`Maintenance_ID`, `Parts_Name`) VALUES (2, 'Air Filter');
insert into `assessment`.`Parts_Usage` (`Maintenance_ID`, `Parts_Name`) VALUES (3, 'Large Tire');
insert into `assessment`.`Parts_Usage` (`Maintenance_ID`, `Parts_Name`) VALUES (5, 'Oil Filter');
insert into `assessment`.`Parts_Usage` (`Maintenance_ID`, `Parts_Name`) VALUES (7, 'Small Tire');
insert into `assessment`.`Parts_Usage` (`Maintenance_ID`, `Parts_Name`) VALUES (9, 'Large Tire');

-- completed travel data
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (1, '5654', '5678');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (2, '12939', '12950');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (3, '4536', '4570');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (4, '4356', '4376');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (5, '4376', '4401');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (7, '2344', '2360');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (8, '4401', '4422');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (9, '5678', '5690');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (10, '12950', '12990');
insert into `assessment`.`Completed Travel` (`Travel_ID`, `Odometer_Start`, `Odometer_End`) VALUES (11, '2360', '2385');

commit;

-- Display all available vehicles on a given date.
delimiter $$
use `assessment`$$
create procedure `Vehicles_Not_In_Travel` (in dt date)
begin
	select distinct v.`ID`, v.`Vehicle_Type`
	from `assessment`.`Vehicles` v,
		`assessment`.`Travel` t
	where not v.`ID` = any (
		select v.`ID`
			from `assessment`.`Vehicles` v,
				`assessment`.`Travel` t
			where dt >= t.`Date_From`
				and dt <= t.`Date_Until`
				and t.`Vehicles_ID` = v.`ID`
	)
  order by v.`ID` asc;
end$$
delimiter ;

delimiter $$
use `assessment`$$
create procedure `Vehicles_Not_In_Maintenence` (in dt date)
begin
	select distinct v.`ID`, v.`Vehicle_Type`
	from `assessment`.`Vehicles` v,
		`assessment`.`Maintenance` m
	where not v.`ID` = any (
		select v.`ID`
			from `assessment`.`Vehicles` v,
				`assessment`.`Maintenance` m
			where dt >= m.`Entry`
				and dt <= m.`Back_To_Service`
				and m.`Vehicles_ID` = v.`ID`
	)
  order by v.`ID` asc;
end$$
delimiter ;

delimiter $$
use `assessment`$$
create procedure `Available_Vehicles` (dt date)
begin
    select A.`ID`, A.`Vehicle_Type`
    from (
		select distinct v.*
			from `assessment`.`Vehicles` v,
				`assessment`.`Travel` t
			where not v.`ID` = any (
				select v.`ID`
					from `assessment`.`Vehicles` v,
						`assessment`.`Travel` t
					where dt >= t.`Date_From`
						and dt <= t.`Date_Until`
						and t.`Vehicles_ID` = v.`ID`)
		) as A
    inner join (select distinct v.*
			from `assessment`.`Vehicles` v,
				`assessment`.`Maintenance` m
			where not v.`ID` = any (
				select v.`ID`
					from `assessment`.`Vehicles` v,
						`assessment`.`Maintenance` m
					where dt >= m.`Entry`
						and dt <= m.`Back_To_Service`
						and m.`Vehicles_ID` = v.`ID`)
		) as B
    where A.`ID`=B.`ID`
    order by A.`ID` asc;
end$$

delimiter ; 

-- Display how many vehicles each department has used so far.
create view `Department_Vehicle_Usage` as
	select f.`Departments_Name`, count(*) as `Vehicles_Used`
	from `assessment`.`Travel` t,
		`assessment`.`Faculty` f
	where t.`Faculty_Name` = f.`Name`
	group by f.`Departments_Name`
  order by `Vehicles_Used`;

-- Display the total mileage driven by a department this year.
delimiter $$
use `assessment`$$
create procedure `Total_Department_Milage` (date_from date, date_to date)
begin
	select f.`Departments_Name` as `Department`, sum(c.`Odometer_End` - c.`Odometer_Start`) as `Distance(km)`
    from `assessment`.`Travel` t,
		`assessment`.`Faculty` f,
        `assessment`.`Completed Travel` c
    where t.`Date_From` > date_from
		and  t.`Date_Until` <= date_to
        and t.`Faculty_Name` = f.`Name`
        and c.`Travel_ID` = t.`ID`
	group by f.`Departments_Name`
  order by `Distance(km)`;
end$$

delimiter ;

-- Show details of a particular bill.
delimiter $$
use `assessment`$$
create procedure `Bill Information` (travel_id int)
begin
	select t.`ID`, f.`Name`, d.`Name` as `Department`, d.`Credit_Card_Number`,
    convert((c.`Odometer_End` - c.`Odometer_Start`) * vt.`Pounds_per_Litre` / vt.`Km_per_Litre`, decimal(4,2)) as `Price(£)`
    from `assessment`.`Travel` t,
		`assessment`.`Faculty` f,
		`assessment`.`Departments`d,
        `assessment`.`Vehicles` v,
        `assessment`.`Vehicle_Types` vt,
        `assessment`.`Completed Travel` c
	where travel_id = t.`ID`
		and t.`ID` = c.`Travel_ID`
        and c.`Travel_ID` = t.`ID`
        and f.`Name` = t.`Faculty_Name`
        and d.`Name` = f.`Departments_Name`
        and t.`Vehicles_ID` = v.`ID`
        and v.`Vehicle_Type` = vt.`Type`;
end$$
delimiter ;

-- Display those who booked vehicles but not actually used them.
create view `Unused_Bookings` as 
	select t.*
    from `assessment`.`Travel` t
	where not t.`ID` = any (
		select c.`Travel_ID`
        from `assessment`.`Completed Travel` c
    );

call `assessment`.`Vehicles_Not_In_Travel`('2021-5-9');
call `assessment`.`Vehicles_Not_In_Maintenence`('2021-5-9');
call `assessment`.`Available_Vehicles`('2021-5-9');
select * from `Department_Vehicle_Usage`;
call `assessment`.`Total_Department_Milage`('2019-1-1', '2021-12-31');
call `assessment`.`Bill Information`(3);
select * from `Unused_Bookings`;

select * from `assessment`.`Parts_Usage`;