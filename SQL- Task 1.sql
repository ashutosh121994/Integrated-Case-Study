create database integrated_case_study
go
use integrated_case_study

-- import table

select * from sustainability

-- Q1. What are the number of unique Geographic Descriptions in data?

select count(distinct [GEOGRAPHIC DESCR#]) as UniqueGeographicCount
from sustainability


-- Q2. Which company has more number of employees in 2011?
--Note : Impute missing values with 0 if any

select top 1 Companies
from sustainability
where Year = 2011
order by coalesce (employees, 0) desc


--Q4. What is the average net sale for "Technology"  sector cluster in 2008 year?
--Note : Filter nulls data If any

select [Sector Cluster], avg([NET SALES OR REVENUES (kUSD)]) as AvgNetSale
from sustainability
where year = 2008 
group by [Sector Cluster]
having [Sector Cluster] = 'Technology'


--Q6. Which ICB sector has lowest average total assets in Australia?
-- Note : Impute missing values with zero

select top 1 [ICB SECTOR NAME], avg([TOTAL ASSETS (kUSD)]) as AvgTotalAsset
from  sustainability
where [GEOGRAPHIC DESCR#] = 'Australia'
group by [ICB SECTOR NAME]
order by AvgTotalAsset  asc

--Q7. What is average injury rate for top 5 companies in 2015 year?
--Note : Pick top-5 companies based on their employee number  and impute missing values with zero

select top 5 Companies, 
		  avg(try_cast([Total Injury Rate] as decimal)) as Avg_Injury_Rate, 
		  count( case when EMPLOYEES = 'NA' then 0 else 1 end) as Employee_count
from sustainability
where [YEAR] = '2015' 
group by Companies
order by Employee_count desc


-- Q8. How many "Japan Geographic Desc" companies has EBIT % Net Sales is between 25 to 50 in 2012?

select count ([GEOGRAPHIC DESCR#]) as Num_Companies
from sustainability
where [GEOGRAPHIC DESCR#] = 'JAPAN' AND [YEAR] = 2012 and [EBIT % of Net Sales] BETWEEN 25 and 50


-- Q9. Which cluster sector has highest waste total. Use data after 2010 year and consider not null records

select top 1 [Sector Cluster] as Cluster_Sector_Highest_Waste_Total
from sustainability
where [year] > 2010 and [waste total] is not null
group by [sector cluster]
order by sum(try_cast([Waste Total] as decimal)) desc


-- Q10. Which company from India has "CSR Sustainability External Audit" and "Average Social Score" is low

select top 1 Companies
from sustainability
where [GEOGRAPHIC DESCR#] = 'INDIA' and [CSR Sustainability External Audit] = 'y'
group by Companies, [GEOGRAPHIC DESCR#], [CSR Sustainability External Audit]
order by avg(cast( [Social Score] as decimal)) asc

-- Q11.  What is the percentage of companies from United States in 2013 year?

select  sum(case when [GEOGRAPHIC DESCR#]= 'UNITED STATES'  and [YEAR] = 2013
						then 1
						else 0 
						end) *100.00 / count(*) as Percentage_US_Companies
from sustainability

-- Q12. Which ICB Sector contains highest percentage of Employees in 2014 Year?

select top 1 [ICB SECTOR NAME], 
					sum([EMPLOYEES])*100 / 
							 (select sum(EMPLOYEES) from sustainability where [year] = 2014) as Percentage_Of_Employees
from sustainability
where [year] = 2014
group by [ICB SECTOR NAME]
order by Percentage_Of_Employees desc


-- Q13. Which year has lowest average net sales for Banks sector?

select top 1 [YEAR]
from sustainability
where [ICB SECTOR NAME] = 'Banks'
group by [year]
order by avg([NET SALES OR REVENUES (kUSD)]) asc

-- Q14. How many number "Geographic desc" are under EUROPE+AFRICAN,NON-U.S. regional cluster in 2008 year?

select count([GEOGRAPHIC DESCR#]) as Number_of_Geographic_Description
from sustainability
where [year] = 2008 and [Regional Cluster] = 'EUROPE+AFRICA, NON-U.S.'


-- Q15. What Percentage of companies not following Emission Reduction Policy Elements in 2010 year?

select sum(case when [YEAR] = 2010 and [Emission Reduction Policy Elements/Emissions] =' N '
							then 1
							else 0
							end) * 100.00 / count(Companies)  as Percentage_of_Companies_not_following_ERP
from sustainability

