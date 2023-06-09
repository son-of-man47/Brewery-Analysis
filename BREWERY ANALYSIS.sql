select * from brewery
limit 5;

-- AN SQL CASE STUDY ON A BREWERY COMPANY

----- PROFIT ANALYSIS ------

--Q1. Within the space of the last three years, what was the profit worth of the breweries,
-- inclusive of the anglophone and the francophone territories?

SELECT DISTINCT("YEARS") FROM BREWERY; 
-- THERE ARE 3 YERS IN THE DATASET 2017 - 2019

SELECT SUM("PROFIT") "PROFIT_WORTH_OF_BREWERY"
FROM BREWERY;
-- TOTAL PROFIT WORTH OF BREWERY = NGN105,587,420.00


--Q2. COMPARE PROFIT BETWEEN THE TWO TERRITORIES 
----- (ANGLOPHONE AND FRANCOPHONE)

SELECT DISTINCT("COUNTRIES") 
FROM BREWERY;
-- 5 countries in total "Benin", "Senegal", "Ghana", "Togo" "Nigeria"

-- USING SUBQUERIES

SELECT "PROFIT_1" ANGLOPHONE_PROFIT,
"PROFIT_2" FRANCOPHONE_PROFIT
FROM
(SELECT SUM("PROFIT") "PROFIT_1"
FROM BREWERY
WHERE "COUNTRIES" IN ('Nigeria', 'Ghana')) A,

(SELECT SUM("PROFIT") "PROFIT_2"
FROM BREWERY
WHERE "COUNTRIES" IN  ('Benin', 'Senegal', 'Togo')) F;

-- FRANCOPHONE TERRITORY MADE MORE PROFIT (NGN 63,198,160.00)
-- THAN THE ANGLOPHONE TERRITORY (NGN 42,389,260.00)


--Q3. Country that generated the highest profit in 2019

SELECT "COUNTRIES", SUM("PROFIT") TOTAL_PROFIT
FROM BREWERY
WHERE "YEARS" = 2019
GROUP BY 1
ORDER BY 2 DESC;

-- GHANA GENERATED THE HIGHEST PROFIT IN 2019 (NGN 7,144,070.00)

--Q4. year with the highest profit

SELECT "YEARS", SUM("PROFIT") TOTAL_PROFIT
FROM BREWERY
GROUP BY 1
ORDER BY 2 DESC;

-- THE YEAR 2017 RECORDED THE HIGHEST PROFIT (NGN 38,503,320.00)

--Q5. What was the minimum profit in the month of December 2018?

SELECT MIN("PROFIT") MIN_PROFIT, "BRANDS"
FROM
BREWERY
WHERE "MONTHS" IN ('December')AND
"YEARS" = 2018
GROUP BY 2
ORDER BY 1;

-- HERO GENERATED THE LEAST PROFIT IN DECEMBER 2018 (NGN 38,150.00)


--Q6 Which particular brand generated the highest profit in Senegal?

SELECT "BRANDS", SUM("PROFIT")
FROM BREWERY
WHERE "COUNTRIES" IN ('Senegal')
group by 1
order by 2 desc;

--Castle lite generated the highest profit in Senegal (NGN 7,012,980.00)



------ BRAND ANALYSIS -------

--- NOTE THAT FOR CONSUMPTION OF BRANDS THE TOTAL QUANTITY SUPPLIES WAS USED AS THE METRICS FOR CALCULATION

SELECT DISTINCT("BRANDS")
FROM BREWERY;

--THERE ARE 7 BRAND TYPES
-- 2 MALTS("beta malt", "grand malt") AND 
-- 5 BEERS ("eagle lager", "hero", "castle lite", "budweiser", "trophy")


--Q1. TOP THREE BRANDS CONSUMED IN FRANCPHONE COUNTRIES IN THE LAST 2 YEARS

SELECT "BRANDS", SUM("QUANTITY") AS CONSUMPTION
FROM BREWERY
WHERE "COUNTRIES" IN ('Senegal', 'Togo', 'Benin') AND
"YEARS" IN (2019, 2018)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

--TROPHY WAS THE MOST CONSUMED BRAND IN FRANCOPHONE COUNTRIES FROM 2018 - 2019


--Q2. TOP TWO CHOICE BRANDS IN GHANA

SELECT "BRANDS", SUM("QUANTITY") AS CONSUMPTION
FROM BREWERY
WHERE "COUNTRIES" = 'Ghana'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2;

--EAGLE LAGER AND CASTLE LITE ARE THE MOST CONSUMED BRANDS IN GHANA


--Q3. DETAILS OF BEERS CONSUMED IN THE MOST OIL RICH NATION IN WEST AFRICA

--THE MOST OIL RICH NATION IN WEST AFRICA IS NIGERIA

SELECT "BRANDS", AVG("UNIT_PRICE") AVG_UNIT_PRICE, 
AVG("QUANTITY") AVG_CONSUMPTION, AVG("COST") AVG_COST,
AVG("PROFIT") AVG_PROFIT
FROM BREWERY
WHERE "COUNTRIES" = 'Nigeria'
GROUP BY 1
ORDER BY AVG_CONSUMPTION, AVG_PROFIT DESC;



--Q4. FAVORITE MALT BRAND IN ANGLOPONE TERRITORY BETWEEN 2018 AND 2019

SELECT "BRANDS", SUM("QUANTITY") CONSUMPTION
FROM BREWERY
WHERE "COUNTRIES" IN ('Nigeria', 'Ghana') AND
"YEARS" IN (2018, 2019) AND 
"BRANDS" LIKE '%malt%'
GROUP BY "BRANDS"
ORDER BY 2 DESC;

--GRNAD MALT IS THE FAVORITE MALT BRAND.


--Q5. HIGHEST SELLING BRAND IN NIGERIA AS AT 2019

SELECT "BRANDS", SUM("PROFIT") PROFIT
FROM BREWERY
WHERE "COUNTRIES" = 'Nigeria' AND 
"YEARS" = 2019
GROUP BY 1
ORDER BY 2 DESC;

--BUDWEISER WAS THE HIGHEST SELLING BRAND IN NIGERIA AT 2019 WITH A PROFIT OF NGN 1,372,500.00


--Q6. FAVORITE BRAND IN THE SOUTH SOUTH REGION OF NIGERIA

SELECT DISTINCT("REGION")
FROM BREWERY;

SELECT "BRANDS", SUM("QUANTITY") CONSUMPTION
FROM BREWERY
WHERE "COUNTRIES" = 'Nigeria' AND
"REGION" = 'southsouth'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--EAGLE LAGER IS THE FAVORITE BRAND IN THE SOUTH SOUTH REGION OF NIGERIA

--Q7. BEER CONSUMPTION RATE IN NIGERIA

SELECT SUM(BEER)  BEER_CONSUMPTION,
SUM(MALT) MALT_CONSUMPTION
FROM

(SELECT "BRANDS", SUM("QUANTITY") BEER
FROM BREWERY
WHERE "BRANDS" IN ('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy') 
AND 
"COUNTRIES" =  'Nigeria'
GROUP BY 1
ORDER BY 2) S,

(SELECT "BRANDS", SUM("QUANTITY") MALT
FROM BREWERY
WHERE "BRANDS" IN ('beta malt', 'grand malt')
AND 
"COUNTRIES" =  'Nigeria'
GROUP BY 1
ORDER BY 2) M

--THE CONSUMPTION RATE OF BEERS IS VERY HIGH IN NIGERIA


--Q8. CONSUMPTION RATE OF BUDWEISER IN THE REGIONS OF NIGERIA

SELECT "REGION", SUM("QUANTITY") CONSUMPTION
FROM BREWERY
WHERE "BRANDS" LIKE '%bud%'
AND "COUNTRIES" = 'Nigeria'
GROUP BY 1
ORDER BY 2 DESC

--WESTERN REGION OF NIGERIA HAVE THE HIGHEST CONSUMPTION RATE OF BUDWEISER WHILE THE SOUTHEASTERN REGION HAVE THE LEAST 