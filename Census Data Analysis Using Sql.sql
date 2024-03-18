CREATE database Census;

USE Census;

-- Reading the Data

SELECT * FROM census.dataset1;

SELECT * FROM census.dataset2;

-- Counting number of rows 

select count(*) from census.dataset1;

select count(*) from census.dataset2;


-- Selecting data for selected states

select * from  census.dataset1
WHERE State IN ('Andhra Pradesh', 'Bihar');


-- Total Population 

select sum(Population) as Total_population from  census.dataset2;


-- Avg growth 

select avg(growth) as avg_growth from census.dataset1;


-- Avg growth for States 

SELECT * FROM census.dataset1;

select State, avg(growth) as avg_growth from census.dataset1
group by State;


-- Avg Sex ratio

SELECT * FROM census.dataset1;
select avg(Sex_Ratio) as avg_sex_ratio from census.dataset1;

-- Avg Sex ratio by State

select State, avg(Sex_Ratio) as avg_sex_ratio from census.dataset1
group by State;


--  Top Avg Sex ratio by States

select State, avg(Sex_Ratio) as avg_sex_ratio from census.dataset1
group by State
order by 2 desc;


--  Least Avg Sex ratio by States

select State, avg(Sex_Ratio) as avg_sex_ratio from census.dataset1
group by State
order by 2;


-- Averagre Literacy rate

SELECT * FROM census.dataset1;
select avg(Literacy) as avg_literacy from census.dataset1;


-- Averagre Literacy rate by state 

SELECT * FROM census.dataset1;
select State , avg(Literacy) as avg_literacy from census.dataset1
group by State;



-- Selecting the whose avg literacy rate is greater than 85

select State , avg(Literacy) as avg_literacy from census.dataset1
group by State
having	avg_literacy >= 85
order by 2 desc	;


-- Top 3 Averagre Literacy rate by state 

SELECT * FROM census.dataset1;
select State , avg(Literacy) as avg_literacy from census.dataset1
group by State
order by 2 desc
limit 3	;


-- Using Common Table Expressions

WITH avg_literacy as (
select State , avg(Literacy) as avg_literacy from census.dataset1
group by State
)
select	* from avg_literacy
order by avg_literacy desc
limit 3;

WITH avg_literacy as (
select State , avg(Literacy) as avg_literacy from census.dataset1
group by State
)
select	* from avg_literacy
order by avg_literacy 
limit 3;



-- States Starting with Letter a 

SELECT State FROM census.dataset1
where State like 'a%';

-- States Starting with Letter a or m

SELECT State FROM census.dataset1
where State like 'a%' or State like 'm%';


-- States Starting with Letter a and m

SELECT State FROM census.dataset1
where State like 'a%' and State like '%h';



-- Joining the Tables 

SELECT * FROM 
census.dataset1 as t1
inner join  
census.dataset2 as t2
on t1.District = t2.District;


-- Joining the Tables and selecting wanted columns 

SELECT t1.District, t1.State, t1.Sex_Ratio, t2.Population FROM 
census.dataset1 as t1
inner join  
census.dataset2 as t2
on t1.District = t2.District;


-- Windows Functions 

SELECT * FROM census.dataset1;
select District,State,Literacy, sum(Literacy)
OVER (partition by State) as Sum_literacy
from census.dataset1;


SELECT * FROM census.dataset1;
select District,State,Sex_Ratio, sum(Sex_Ratio)
OVER (partition by State) as Sum_Sex_Ratio
from census.dataset1;

SELECT * FROM census.dataset1;
select District,State,Sex_Ratio, max(Sex_Ratio)
OVER (partition by State) as Max_Sex_Ratio
from census.dataset1;

SELECT * FROM census.dataset1;
select District,State,Sex_Ratio, min(Sex_Ratio)
OVER (partition by State order by Sex_Ratio desc) as  Min_Sex_Ratio
from census.dataset1;

-- Rank
select District,State,Literacy,
rank() OVER (partition by State order by Literacy ) as Rank_literacy
from census.dataset1;

select District,State,Sex_Ratio,
rank() OVER (partition by State order by Sex_Ratio ) as Rank_Sex_Ratio
from census.dataset1;


SELECT * FROM census.dataset2;

select District,State, sum(Population)
OVER (partition by State) as Sum_Population
from census.dataset2;


-- Ntile
SELECT * FROM census.dataset1;
select District,State,Sex_Ratio, ntile(3)
OVER (partition by State) as n_tile
from census.dataset1;


-- First Value
select District,State,Sex_Ratio,
first_value(District)
OVER (partition by State) as first_value_
from census.dataset1;


select District,State,Sex_Ratio,
last_value(District)
OVER (partition by State) as last_value_
from census.dataset1;








