/* Q1. How many number of Electricity ICB sector companies have Renewable energy and their employees’ size less than 5K 
			and their electricity purchased is greater than the electricity produced. */

select count([ICB SECTOR NAME]) as Num_Companies
from sustainability
where [ICB SECTOR NAME] = 'Electricity' and 
			[Renewable Energy Use] = ' Y' and 
			EMPLOYEES < 5000 and   
			[Electricity/Purchased] > [Electricity/Produced]


-- Q2.  How many companies of Oil & Gas Sector from India and CHINA have Commercial Risks in 2008?

select count(Companies) as Num_Companies
from sustainability
where [ICB SECTOR NAME] = 'Oil & Gas Producers' and 
			[GEOGRAPHIC DESCR#] in ('INDIA' , 'CHINA' ) and
			[Commercial Risks and/or Opportunities Due to Climate Change] = ' Y' and
			[year] = '2008'


/* Q3. Which country spend on " Environment R&D"  over revenue average percentage is maximum in 2013? 
			Consider only the Chemical, Mining, and General Industrials sectors. */

select   top 1 [GEOGRAPHIC DESCR#]
from sustainability
where [YEAR] = '2013' and
			([ICB SECTOR NAME] like '%Chemicals%' or  [ICB SECTOR NAME] like '%Mining%' or [ICB SECTOR NAME] like '%Industrial%')
group by [GEOGRAPHIC DESCR#]
order by avg(try_cast([Env# R&D spend over revenue (in%)] as float)) desc


--Q4. In which year the total Women Employees are highest in United Kingdom and consider the company names start with ‘D’

select top 1 [year], max([Women Employees]) as highest_WE
from sustainability
where [GEOGRAPHIC DESCR#] = 'United Kingdom' and 
			Companies like 'D%'
group by [year]
order by highest_WE desc


-- Q5. Which Sector cluster have the Highest average Turnover of Employees in India. Consider only 2012 and 2014 years data.

select top 1 [Sector Cluster], avg(try_cast([Turnover of Employees] as decimal)) as Avg_Turnover
from sustainability
where [GEOGRAPHIC DESCR#] = 'INDIA' and 
			[YEAR] in ('2012' , '2014')
group by [Sector Cluster]
order by Avg_Turnover desc


			

