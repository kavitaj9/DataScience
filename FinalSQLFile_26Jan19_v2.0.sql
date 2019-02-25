#Schema Creation
create schema assignment;
use assignment;

##################Question-1#####################
#Create table bajaj1 and for all other stocks having Date, Close Price, 20Day_MA, 50Day_MA
#Tables Creation for 6 stocks
create table bajaj (`date` date, `Close Price` double );
create table eicher (`date` date, `Close Price` double );
create table hero (`date` date, `Close Price` double );
create table infosys (`date` date, `Close Price` double );
create table tcs (`date` date, `Close Price` double );
create table tvs (`date` date, `Close Price` double );

#Check whether tables are created
select * from bajaj;

#need to set safe mode as 0 otherwise where clause is to be given in alter table
set sql_safe_updates=0;

#Read CSV files in corresponding tables, only 2 Columns Date and Close Price is being used, rest are not saved as not needed
LOAD DATA INFILE 'Bajaj Auto.csv' 
INTO TABLE bajaj 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines
(@t1, @t2, @t3, @t4, `Close Price`, @t6, @t7, @t8, @t9, @t10, @t11, @t12, @t13 )
set date = str_to_date(@t1, '%e-%M-%Y');

LOAD DATA INFILE 'Eicher Motors.csv' 
INTO TABLE eicher 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines
(@t1, @t2, @t3, @t4, `Close Price`, @t6, @t7, @t8, @t9, @t10, @t11, @t12, @t13 )
set date = str_to_date(@t1, '%e-%M-%Y');

LOAD DATA INFILE 'Hero Motocorp.csv' 
INTO TABLE hero 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines
(@t1, @t2, @t3, @t4, `Close Price`, @t6, @t7, @t8, @t9, @t10, @t11, @t12, @t13 )
set date = str_to_date(@t1, '%e-%M-%Y');

LOAD DATA INFILE 'Infosys.csv' 
INTO TABLE infosys 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines
(@t1, @t2, @t3, @t4, `Close Price`, @t6, @t7, @t8, @t9, @t10, @t11, @t12, @t13 )
set date = str_to_date(@t1, '%e-%M-%Y');

LOAD DATA INFILE 'TCS.csv' 
INTO TABLE tcs
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines
(@t1, @t2, @t3, @t4, `Close Price`, @t6, @t7, @t8, @t9, @t10, @t11, @t12, @t13 )
set date = str_to_date(@t1, '%e-%M-%Y');

LOAD DATA INFILE 'TVS Motors.csv' 
INTO TABLE tvs 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines
(@t1, @t2, @t3, @t4, `Close Price`, @t6, @t7, @t8, @t9, @t10, @t11, @t12, @t13 )
set date = str_to_date(@t1, '%e-%M-%Y');

#Check whether tables are generated correctly
select * from bajaj order by date limit 5;
select * from eicher order by date limit 5;
select * from hero order by date limit 5;
select * from infosys order by date limit 5;
select * from tcs order by date limit 5;
select * from tvs order by date limit 5;

##############################
Create table bajaj1 as 
	select date,
	`Close Price`, 
	avg(`Close Price`)  over (order by date rows between 19 preceding and 0 following ) as "20Day_MA" ,
	avg(`Close Price`)  over (order by date rows between 49 preceding and 0 following ) as "50Day_MA" 
	from bajaj;
    
Create table eicher1 as 
	select date,
	`Close Price`, 
	avg(`Close Price`)  over (order by date rows between 19 preceding and 0 following ) as "20Day_MA" ,
	avg(`Close Price`)  over (order by date rows between 49 preceding and 0 following ) as "50Day_MA" 
	from eicher;

Create table hero1 as 
	select date,
	`Close Price`, 
	avg(`Close Price`)  over (order by date rows between 19 preceding and 0 following ) as "20Day_MA" ,
	avg(`Close Price`)  over (order by date rows between 49 preceding and 0 following ) as "50Day_MA" 
	from hero;
    
Create table infosys1 as 
	select date,
	`Close Price`, 
	avg(`Close Price`)  over (order by date rows between 19 preceding and 0 following ) as "20Day_MA" ,
	avg(`Close Price`)  over (order by date rows between 49 preceding and 0 following ) as "50Day_MA" 
	from infosys;
    
	Create table tcs1 as 
	select date,
	`Close Price`, 
	avg(`Close Price`)  over (order by date rows between 19 preceding and 0 following ) as "20Day_MA" ,
	avg(`Close Price`)  over (order by date rows between 49 preceding and 0 following ) as "50Day_MA" 
	from tcs;

	Create table tvs1 as 
	select date,
	`Close Price`, 
	avg(`Close Price`)  over (order by date rows between 19 preceding and 0 following ) as "20Day_MA" ,
	avg(`Close Price`)  over (order by date rows between 49 preceding and 0 following ) as "50Day_MA" 
	from tvs;
    
#Check whether tables are generated correctly
select * from bajaj1 order by date limit 5;
select * from eicher1 order by date limit 5;
select * from hero1 order by date limit 5;
select * from infosys1 order by date limit 5;
select * from tcs1 order by date limit 5;
select * from tvs1 order by date limit 5;

##################Ques-1 done############################

########################Question-2################
	#Create Master table 
	Create table MasterTable as 
	select date, `Close Price` from bajaj1;

	
	#updating the Column name of bajaj
	alter table MasterTable
	change `Close Price` Bajaj double;

	#checking on table
	desc Mastertable;
	select * from mastertable order by date limit 10;

	#adding more columns - all being done in a single query
	alter table mastertable
		add column eicher double,
		add column hero double,
		add column infosys double, 
		add column tcs double, 
		add column tvs double;

	#updating mastertable from individual tables using inner join on date

	update mastertable 
	inner join eicher1 on eicher1.date = mastertable.date
	inner join hero1 on hero1.date = mastertable.date
	inner join infosys1 on infosys1.date = mastertable.date
	inner join tcs1 on tcs1.date = mastertable.date
	inner join tvs1 on tvs1.date = mastertable.date
	set mastertable.eicher = eicher1.`Close Price`,
		mastertable.hero = hero1.`Close Price`,
		mastertable.infosys = infosys1.`Close Price`,
		mastertable.tcs = tcs1.`Close Price`,
		mastertable.tvs = tvs1.`Close Price`;

	#check whether everything is fine
	select * from mastertable order by date limit 5;

	########################End of Question-2################
    
#Checking where any Null values
select * from bajaj1 where `Close Price` is Null;
select * from eicher1 where `Close Price` is Null;
select * from hero1 where `Close Price` is Null;
select * from infosys1 where `Close Price` is Null;
select * from tcs1 where `Close Price` is Null;
select * from tvs1 where `Close Price` is Null;

	#Dropping 49 rows as calculated values are not correct due to MA calculations
	delete from bajaj1 order by date limit 49;
	delete from eicher1 order by date limit 49;
	delete from hero1 order by date limit 49;
	delete from infosys1 order by date limit 49;
	delete from tcs1 order by date limit 49;
	delete from tvs1 order by date limit 49;
    
##############################Create Functions, needed for Question-3. #############################
#4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.
#Creating User defined functions for all stocks as those will be used for Ques-3 Signal creation
#There can be a single function with Dynamic Query in which we can pass table name as argument, I tried working on the same but not successfull 
#thus implementation is done with individual function
#Function Logic - Find out current and previous MA values and signal creation is done based on logic
delimiter $$
CREATE FUNCTION `BuySellCalculateBajaj`(inputDate date) 
RETURNS varchar(10) 
    DETERMINISTIC
BEGIN
declare shortTermMACurrent double;
declare longTermMACurrent double;
declare shortTermMAPrevious double;
declare longTermMAPrevious double;
#Find out short term and long term Moving Average from current selected row
set shortTermMACurrent = (select 20Day_MA from bajaj1 where date = inputDate);

set longTermMACurrent = (select 50Day_MA from bajaj1 where date = inputDate);

#Find out short term and long term Moving Average from previous row 
set shortTermMAPrevious = (select prevValue 
from ( select date, lag(20Day_MA,1,0) over (order by date) as prevValue from bajaj1) as TempTable where date = inputDate);

set longTermMAPrevious = (select prevValue 
from ( select date, lag(50Day_MA,1,0) over (order by date) as prevValue from bajaj1) as TempTable where date = inputDate);

#First records - Hold
if ( shortTermMAPrevious = 0 ) then
	return("Hold");
end if;

if ( shortTermMACurrent <= longTermMACurrent) then

	if (shortTermMAPrevious <= longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		#Death Cross Situation, Signal will be to Sell the stock
		return("Sell");
	end if;
else
	if (shortTermMAPrevious > longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		#Golder Cross Signal will be to Buy the stock
		return("Buy");
	end if;
end if;
END
$$

delimiter;

##############################Eicher###############################
delimiter $$
CREATE FUNCTION `BuySellCalculateEicher`(inputDate date) 
RETURNS varchar(10) 
    DETERMINISTIC
BEGIN
declare shortTermMACurrent double;
declare longTermMACurrent double;
declare shortTermMAPrevious double;
declare longTermMAPrevious double;

set shortTermMACurrent = (select 20Day_MA from eicher1 where date = inputDate);

set longTermMACurrent = (select 50Day_MA from eicher1 where date = inputDate);
 
set shortTermMAPrevious = (select prevValue 
from ( select date, lag(20Day_MA,1,0) over (order by date) as prevValue from eicher1) as TempTable
where date = inputDate);

set longTermMAPrevious = (select prevValue 
from ( select date, lag(50Day_MA,1,0) over (order by date) as prevValue from eicher1) as TempTable
where date = inputDate);

if ( shortTermMAPrevious = 0 ) then
	return("Hold");
end if;

if ( shortTermMACurrent <= longTermMACurrent) then

	if (shortTermMAPrevious <= longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Sell");
	end if;
else
	if (shortTermMAPrevious > longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Buy");
	end if;
end if;
END $$

delimiter;
#####################################Hero###################################
Delimiter $$
CREATE FUNCTION `BuySellCalculatehero`(inputDate date) 
RETURNS varchar(10)
    DETERMINISTIC
BEGIN
declare shortTermMACurrent double;
declare longTermMACurrent double;
declare shortTermMAPrevious double;
declare longTermMAPrevious double;

set shortTermMACurrent = (select 20Day_MA from hero1 where date = inputDate);

set longTermMACurrent = (select 50Day_MA from hero1 where date = inputDate);
 
set shortTermMAPrevious = (select prevValue 
from ( select date, lag(20Day_MA,1,0) over (order by date) as prevValue from hero1) as TempTable
where date = inputDate);

set longTermMAPrevious = (select prevValue 
from ( select date, lag(50Day_MA,1,0) over (order by date) as prevValue from hero1) as TempTable
where date = inputDate);

if ( shortTermMAPrevious = 0 ) then
	return("Hold");
end if;

if ( shortTermMACurrent <= longTermMACurrent) then

	if (shortTermMAPrevious <= longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Sell");
	end if;
else
	if (shortTermMAPrevious > longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Buy");
	end if;
end if;
END $$

delimiter ;

####################################Infosys####################################
delimiter $$
CREATE FUNCTION `BuySellCalculateinfosys`(inputDate date) 
RETURNS varchar(10) 
    DETERMINISTIC
BEGIN
declare shortTermMACurrent double;
declare longTermMACurrent double;
declare shortTermMAPrevious double;
declare longTermMAPrevious double;

set shortTermMACurrent = (select 20Day_MA from infosys1 where date = inputDate);

set longTermMACurrent = (select 50Day_MA from infosys1 where date = inputDate);
 
set shortTermMAPrevious = (select prevValue 
from ( select date, lag(20Day_MA,1,0) over (order by date) as prevValue from infosys1) as TempTable
where date = inputDate);

set longTermMAPrevious = (select prevValue 
from ( select date, lag(50Day_MA,1,0) over (order by date) as prevValue from infosys1) as TempTable
where date = inputDate);

if ( shortTermMAPrevious = 0 ) then
	return("Hold");
end if;

if ( shortTermMACurrent <= longTermMACurrent) then

	if (shortTermMAPrevious <= longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Sell");
	end if;
else
	if (shortTermMAPrevious > longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Buy");
	end if;
end if;
END
$$

delimiter;
############################TCS#################################
delimiter $$
CREATE FUNCTION `BuySellCalculateTcs`(inputDate date) 
RETURNS varchar(10) 
    DETERMINISTIC
BEGIN
declare shortTermMACurrent double;
declare longTermMACurrent double;
declare shortTermMAPrevious double;
declare longTermMAPrevious double;

set shortTermMACurrent = (select 20Day_MA from tcs1 where date = inputDate);

set longTermMACurrent = (select 50Day_MA from tcs1 where date = inputDate);
 
set shortTermMAPrevious = (select prevValue 
from ( select date, lag(20Day_MA,1,0) over (order by date) as prevValue from tcs1) as TempTable
where date = inputDate);

set longTermMAPrevious = (select prevValue 
from ( select date, lag(50Day_MA,1,0) over (order by date) as prevValue from tcs1) as TempTable
where date = inputDate);

if ( shortTermMAPrevious = 0 ) then
	return("Hold");
end if;
if ( shortTermMACurrent <= longTermMACurrent) then

	if (shortTermMAPrevious <= longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Sell");
	end if;
else
	if (shortTermMAPrevious > longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Buy");
	end if;
end if;
END $$
delimiter ;

#################################### TVS###############################
DELIMITER $$
CREATE FUNCTION `BuySellCalculateTVS`(inputDate date) 
RETURNS varchar(10) 
    DETERMINISTIC
BEGIN
declare shortTermMACurrent double;
declare longTermMACurrent double;
declare shortTermMAPrevious double;
declare longTermMAPrevious double;

set shortTermMACurrent = (select 20Day_MA from tvs1 where date = inputDate);

set longTermMACurrent = (select 50Day_MA from tvs1 where date = inputDate);
 
set shortTermMAPrevious = (select prevValue 
from ( select date, lag(20Day_MA,1,0) over (order by date) as prevValue from tvs1) as TempTable
where date = inputDate);

set longTermMAPrevious = (select prevValue 
from ( select date, lag(50Day_MA,1,0) over (order by date) as prevValue from tvs1) as TempTable
where date = inputDate);

if ( shortTermMAPrevious = 0 ) then
	return("Hold");
end if;

if ( shortTermMACurrent <= longTermMACurrent) then

	if (shortTermMAPrevious <= longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Sell");
	end if;
else
	if (shortTermMAPrevious > longTermMAPrevious) then
		#no change in this situation
        return("Hold");
	else 
		return("Buy");
	end if;
end if;
END $$
DELIMITER ;

###########################################################

	#########################Question-3####################
	#Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.
	#        Date      	          Close Price       	      Signal        

	create table bajaj2 as
	select date, `Close Price`, `Signal`
	from (select date, `Close Price`, BuySellCalculateBajaj(date) as `Signal` from bajaj1)tempTable ;

	create table eicher2 as
	select date, `Close Price`, `Signal`
	from (select date, `Close Price`, BuySellCalculateEicher(date) as `Signal` from eicher1)tempTable ;

	create table hero2 as
	select date, `Close Price`, `Signal`
	from (select date, `Close Price`, BuySellCalculateHero(date) as `Signal` from hero1)tempTable ;

	create table infosys2 as
	select date, `Close Price`, `Signal`
	from (select date, `Close Price`, BuySellCalculateInfosys(date) as `Signal` from infosys1)tempTable ;

	create table tcs2 as
	select date, `Close Price`, `Signal`
	from (select date, `Close Price`, BuySellCalculateTcs(date) as `Signal` from tcs1)tempTable ;

	create table tvs2 as
	select date, `Close Price`, `Signal`
	from (select date, `Close Price`, BuySellCalculateTvs(date) as `Signal` from tvs1)tempTable ;

	#Check whether tables are generated correctly
	select * from bajaj2 order by date;
#############################End of question-3#################################


