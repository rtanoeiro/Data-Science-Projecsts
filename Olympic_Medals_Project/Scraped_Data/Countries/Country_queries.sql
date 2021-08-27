use Summer_Medals_Country

SELECT * FROM Country_Medals
ORDER BY YEAR

SELECT * FROM Country_ID

SELECT Country_Name, SUM(GOLD) AS GOLD FROM Country_Medals a
group by A.Country_Name
order by GOLD DESC

CREATE TABLE Cumultative_Medals_by_Year
(
Country_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
Year INT NOT NULL,
Culmutative_Gold INT NOT NULL,
Culmutative_Silver INT NOT NULL,
Culmutative_Bronze INT NOT NULL
)
 
/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"] We need to add each one manually, as I don't know how to do differently.
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1896 AND Year < 1900
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1900 AND Year < 1904
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1904 AND Year < 1908
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1908 AND Year < 1912
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1912 AND Year < 1920
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"]
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1920 AND Year < 1924
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1924 AND Year < 1928
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1928 AND Year < 1932
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1932 AND Year < 1936
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"]
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1936 AND Year < 1948
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1948 AND Year < 1952
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1952 AND Year < 1956
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1956 AND Year < 1960
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"]
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1960 AND Year < 1964
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1964 AND Year < 1968
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1968 AND Year < 1972
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1972 AND Year < 1976
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"]
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1976 AND Year < 1980
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1984 AND Year < 1988
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1988 AND Year < 1992
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1992 AND Year < 1996
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"]
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 1996 AND Year < 2000
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 2000 AND Year < 2004
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 2004 AND Year < 2008
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

/* Years of olympic medals 
["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960",
"1964","1968","1972","1976","1980","1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"]
*/

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 2008 AND Year < 2012
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 2012 AND Year < 2016
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC

SELECT b.Country_ID, SUM(a.Gold) As Cumultative_Gold, SUM(a.Silver) As Cumultative_Silver, SUM(a.Bronze) As Cumultative_Bronze, SUM(a.Gold) + SUM(a.Silver) + SUM(a.Bronze) AS Total_Medals
FROM Country_Medals a
JOIN Country_ID b
ON a.Country_Name =  b.Country_ID
Where a.Year >= 2016 AND Year < 2020
Group By b.Country_ID
ORDER BY Cumultative_Gold DESC