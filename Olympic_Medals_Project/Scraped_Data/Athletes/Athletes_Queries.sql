Use [Summer Medals]

/* ALTERING TABLES BY REMOVING UNNECESSARY COLUMNS AND ADDING DATA */

ALTER TABLE SummerMedals1896_2012 DROP COLUMN Gender, City, Event, Discipline

ALTER TABLE Rio2016Medals DROP COLUMN id, sex, dob, height, weight

ALTER TABLE Rio2016Medals
ADD Ano INT

update Rio2016Medals
SET Ano=2016

ALTER TABLE Tokyo_Medals_2021 DROP COLUMN Total, Rank_by_total

/* END OF ALTERING TABLES BY REMOVING UNNECESSARY COLUMNS AND ADDING DATA */


select * from SummerMedals1896_2012

select * from Rio2016Medals

select * from Tokyo_Medals_2021

/* Check Sports from each table*/

select DISTINCT(Sport) from Rio2016Medals

SELECT DISTINCT(Sport) FROM SummerMedals1896_2012

/* END OF Check Sports from each table*/


/* Check the sports by UNION*/

select DISTINCT(Sport) from Rio2016Medals
UNION
SELECT DISTINCT(Sport) FROM SummerMedals1896_2012

/* end of Check the sports by UNION*/

/* Check what Sport was different*/

SELECT *
FROM Rio2016Medals A
LEFT JOIN SummerMedals1896_2012 B
ON A.Sport = B.Sport
WHERE B.Sport IS NULL

/* Update Canoe (Canoe / Kayak), Hockey (Ice Hockey), Rugby (Rugby Sevens)*/

UPDATE SummerMedals1896_2012
SET Sport = 'Hockey'
WHERE Sport = 'Ice Hockey'

UPDATE SummerMedals1896_2012
SET Sport = 'Canoe'
WHERE Sport = 'Canoe / Kayak'

UPDATE Rio2016Medals
SET Sport = 'Rugby'
WHERE Sport = 'Rugby Sevens'

/* Now we have 41 unique sports, let's create a table for each one of them and assign an ID for each one */

CREATE TABLE Sport_ID
(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Sport varchar(50)
)

INSERT INTO Sport_ID
select DISTINCT(Sport) from Rio2016Medals
UNION
SELECT DISTINCT(Sport) FROM SummerMedals1896_2012

select * from Sport_ID
ORDER BY ID ASC

CREATE TABLE Country_ID
(
	Country_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Country_Name varchar(50)
)

INSERT INTO Country_ID
select DISTINCT(a.Country) from Rio2016Medals a
UNION
SELECT DISTINCT(b.Country) FROM SummerMedals1896_2012 b

SELECT * FROM Country_ID

/* Trying to replace values in the Tables */

 /*
 I don't know how this below worked in the first try, but it did lol.
 I tried to update values on the Sport based on the ID in another that I created
 */
BEGIN TRANSACTION

UPDATE Rio2016Medals
SET Sport=ID
FROM Sport_ID a
JOIN Rio2016Medals b
ON b.Sport = a.Sport

UPDATE SummerMedals1896_2012
SET Sport=ID
FROM Sport_ID a
JOIN SummerMedals1896_2012 b
ON b.Sport = a.Sport

select * from Sport_ID
SELECT * FROM Rio2016Medals
SELECT * FROM SummerMedals1896_2012

COMMIT TRANSACTION /* IF EVERYTHING GOES OK*/
ROLLBACK /* IF THERE'S AN ERROR*/

/*Now let's do the same for country*/

BEGIN TRANSACTION 

select * from country_ID

UPDATE Rio2016Medals
SET Country=Country_ID
FROM Country_ID a
JOIN Rio2016Medals b
ON b.Country = a.Country_Name

UPDATE SummerMedals1896_2012
SET Country=Country_ID
FROM Country_ID a
JOIN SummerMedals1896_2012 b
ON b.Country = a.Country_Name

COMMIT TRANSACTION /* IF EVERYTHING GOES OK*/
ROLLBACK /* IF THERE'S AN ERROR*/

select * from Country_ID
order by Country_Name asc

SELECT DISTINCT Country FROM Rio2016Medals

SELECT DISTINCT Country FROM SummerMedals1896_2012

BEGIN TRANSACTION 

alter table Rio2016Medals
alter column country int

alter table Rio2016Medals
alter column Sport int

alter table SummerMedals1896_2012
alter column country int

alter table SummerMedals1896_2012
alter column Sport int

COMMIT TRANSACTION /* IF EVERYTHING GOES OK*/
ROLLBACK /* IF THERE'S AN ERROR*/

ALTER TABLE Rio2016Medals
ADD FOREIGN KEY (Country) REFERENCES Country_ID(Country_ID)

ALTER TABLE SummerMedals1896_2012
ADD FOREIGN KEY (Country) REFERENCES Country_ID(Country_ID)

ALTER TABLE Rio2016Medals
ADD FOREIGN KEY (sport) REFERENCES Sport_ID(ID)

ALTER TABLE SummerMedals1896_2012
ADD FOREIGN KEY (Sport) REFERENCES Sport_ID(ID)