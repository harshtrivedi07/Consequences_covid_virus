1---First we will going to check not-null contient
select*from covid 
select continent,location,date,total_cases from covid where continent is not null
group by continent,location,total_cases,date
order by continent,location


2--Now we are going to explore date wise covid cases,new cases,deaths,population for different location
--for year 2020 only,so that we can compare with 2021

select continent,location,date,total_cases,new_cases,total_deaths,population from covid
where continent is not null and date <='2020-12-31' --and date >= '2020-12-31
order by location,date


3--Looking at Countries with highest infection rate compared to Population
select location,population,max(total_cases) as Highestinfectioncount,max((total_cases/population))*100 as percentage_of_infectedpopulation
from covid
where continent is not null 
group by location,population
order by percentage_of_infectedpopulation desc


--4---Now we are going to see the countries recovered patients and recovered patients from home, critical care patients and total_hospital_patients 
select location,max(cast(total_cases as numeric)) as Total_cases,
max(cast(total_deaths as numeric)) as Total_deaths,
max(cast(total_cases as numeric)) - max(convert(numeric,total_deaths)) as total_Recoverd_from_covid, 
sum(cast(icu_patients as numeric))as Critical_care_patients ,
max(cast(hosp_patients as numeric))as total_hospital_patients , 
max(cast(total_cases as numeric)) - max(convert(numeric,total_deaths)) - max(cast(hosp_patients as numeric)) as total_Recovered_from_home from covid
group by location
order by max(icu_patients) desc



5--Now we are going to see total cases and total deaths and the percentage of deaths 
--for most populatious country and just added usa for deaths and comparison ref..
select location,date,total_cases,total_deaths,population,(total_deaths/total_cases)*100 as percentage_of_deaths from covid
where location like '%india%' and total_deaths is not null
--where location like '%china%' --and total_deaths is not null
--where location like '%states%' --and total deaths is not null

--6--Now we will going to see what percentage of population got infected in india and china.
select location,date,total_cases,population,(total_cases/population)*100 as percentage_of_infectedpop_india
from covid 
where location like'%india%' 
--where location like '%china%'



--7--Looking at highest death count by country
select location,max(cast(total_deaths as int))as Totaldeathcount
from covid
where continent is not null
group by location
order by Totaldeathcount desc

--8--continent wise death count
select continent,max(cast(total_deaths as int))as Totaldeathcount
from covid
where continent is not null
group by continent
order by Totaldeathcount desc

--9--Here we will going to see the Global count and also compare with india's count
select  sum(new_cases)as total_cases_india,sum(cast(new_deaths as int)) as total_deaths_india,sum(cast
(new_deaths as int ))/sum(new_cases)*100 as deathpercentage_of_india
from covid
--where location like '%india%' and new_cases is not null
---where continent is not null and new_cases is not null
--group by date
--group by population
order by 1,2


10---Now we are going to see the population vs vaccination
	select location,date,population,max(cast(total_vaccinations as numeric)) as count_of_vaccination
	from covid
	where continent is not null and total_vaccinations is not null
	group by location,total_vaccinations,date,population
	order by max(cast(total_vaccinations as numeric)) desc

--11---Now we are going to see continent wise vaccination

	select continent,sum(population)as total_pop,sum(cast(total_vaccinations as numeric)) as total_vaccination
	from covid
	where continent is not null and total_vaccinations is not null
	group by continent
--	order by max(cast(total_vaccinations as numeric)) desc

 