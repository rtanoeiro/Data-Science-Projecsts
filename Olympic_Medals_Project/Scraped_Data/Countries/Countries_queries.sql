USE Summer_Medals_Country

SELECT * FROM Country_Medals
WHERE Host_city IS NULL

/* Updating the Hosts with null values*/
BEGIN TRANSACTION

UPDATE Country_Medals
SET Host_city='Melbourne and Stockholm'
WHERE Host_city IS NULL

UPDATE Country_Medals
SET Host_country='Australia and Sweden'
WHERE Host_country IS NULL

COMMIT TRANSACTION
/* End of updating the Hosts with null values*/

/* Start of updating table columns */
SELECT DISTINCT Country_Code FROM Country_Medals

ALTER TABLE Country_Medals
DROP COLUMN Country_Code
/* End of updaring table columns */

/* -- */
SELECT DISTINCT Country_Name FROM Country_Medals

SELECT * FROM Country_Medals
Where Country_Name LIKE '%Germany'
order by Year
/* -- */

/* Updating the country names*/
UPDATE Country_Medals
SET Country_Name='Germany'
Where Country_Name='United Team of Germany'

UPDATE Country_Medals
SET Country_Name='Independent Olympic Athletes'
Where Country_Name='Independent Olympic Participants'
/* End of updating country names*/

/* Creating Table of IDs*/
CREATE TABLE Country_ID
(
Country_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Country_Name VARCHAR(50)
)
/* Table created */

/* Adding IDs for each country */
INSERT INTO Country_ID
SELECT DISTINCT Country_Name FROM Country_Medals
/* IDs added */

select * from Country_ID
SELECT * FROM Country_Medals

/* Updating the names of countries to the IDs */
BEGIN TRANSACTION

UPDATE Country_Medals
SET Country_Name=Country_ID
FROM Country_ID a
JOIN Country_Medals b
ON b.Country_Name = a.Country_Name

COMMIT TRANSACTION
/* IDs added*/

/* Altering the IDs to Integer and adding referencing tho the country_id key */
ALTER TABLE Country_Medals ALTER COLUMN Country_Name INT

ALTER TABLE COUNTRY_MEDALS
ADD FOREIGN KEY (Country_Name) REFERENCES Country_ID(Country_ID)
/* IDs and references added */

/* -- Messing with data -- */
SELECT * FROM Country_Medals
ORDER BY YEAR

SELECT * FROM Country_ID

SELECT Country_Name, SUM(GOLD) AS GOLD FROM Country_Medals a
group by A.Country_Name
order by GOLD DESC
/* -- Messing with data -- */

/* -- Creating a table with cumultative data, as this will be used for a animated bar chart -- */
CREATE TABLE Cumultative_Medals_by_Year
(
Country_ID INT NOT NULL,
Year INT NOT NULL,
Culmutative_Gold INT,
Culmutative_Silver INT,
Culmutative_Bronze INT,
Total_Medals INT NOT NULL
)
/* -- Table created-- */

/* -- Adding rows for each olympic edition. -- */

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"] We need to add each one manually, as I don't know how to do differently.
*/

SELECT * FROM Cumultative_Medals_by_Year
SELECT * FROM Country_ID
SELECT * FROM Country_Medals
WHERE Country_Name=125

ALTER TABLE Cumultative_Medals_by_Year
ADD FOREIGN KEY (Country_ID)
REFERENCES Country_ID(Country_ID)

SELECT * FROM Cumultative_Medals_by_Year

TRUNCATE TABLE Cumultative_Medals_by_Year

/* Messing with insertion of data */

SELECT  b.Country_Name, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON b.Country_ID=a.Country_Name
Group By b.Country_Name
order by Cumultative_Gold desc


SELECT * FROM Cumultative_Medals_by_Year

INSERT INTO Cumultative_Medals_by_Year(Country_ID, Year, Culmutative_Gold, Culmutative_Silver, Culmutative_Bronze, Total_Medals)
select c.Country_Name, y.Year,
       SUM(cm.Gold) As Cumulative_Gold,
       SUM(cm.Silver) As Cumulative_Silver,
       SUM(cm.Bronze) As Cumulative_Bronze,
       COALESCE(SUM(cm.Gold), 0) + COALESCE(SUM(cm.Silver), 0) + COALESCE(SUM(cm.Bronze), 0) AS Total_Medals
from (select distinct year from Country_Medals) y cross join
     (select distinct country_name from country_medals) c left join
     country_medals cm
     on cm.year = y.year and
        cm.country_name = c.country_name
group By cm.Host_country, c.Country_Name, y.Year

CREATE TABLE Host_Country
(
Year INT not null,
Country_ID INT NOT NULL
)

INSERT INTO Host_Country
select distinct a.YEAR, b.Country_ID from country_medals a
INNER JOIN
Country_ID b
ON a.Host_country = b.Country_Name

select * from Country_ID


/* -- End of data add -- */

SELECT * FROM Cumultative_Medals_by_Year
Where Year=2020

