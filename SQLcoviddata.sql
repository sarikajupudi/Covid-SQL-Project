--TABLE 1:- COVID DEATHS
SELECT * FROM dbo.CovidDeaths;

--TABLE 2:- COVID VACCINATIONS
SELECT * FROM dbo.CovidVaccinations;

-- SELECTING COLUMNS FROM COVID DEATHS TABLE
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM dbo.CovidDeaths
ORDER BY date DESC;

--Looking total Cases vs Total Deaths in United States and calculating DeathPercentage

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM dbo.CovidDeaths
Where location like 'United States'
ORDER BY date DESC;

--Looking total Cases vs Total Deaths in India and calculating DeathPercentage

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM dbo.CovidDeaths
Where location IN( 'India')
ORDER BY date DESC;



--Looking at total Cases vs Population and calculating the percentage of population got covid as PercentPopulationInfected in USA

SELECT Location, date, population,total_cases,  (total_cases/population)*100 as PercentPopulationInfected
FROM dbo.CovidDeaths
Where location like 'United States'
ORDER BY date DESC;
--24% as of 2022


--Looking at total Cases vs Population and calculating the percentage of population got covid as PercentPopulationInfected in India

SELECT Location, date, population,total_cases,  (total_cases/population)*100 as PercentPopulationInfected
FROM dbo.CovidDeaths
Where location like 'India'
ORDER BY date DESC;
-- 3% as of 2022

--Looking at Countries with Highest Infection Rate compared to Population
SELECT Location, date, population, MAX(total_cases) as HighestInfectionRate,  MAX((total_cases/population))*100 as PercentPopulationInfected
FROM dbo.CovidDeaths
GROUP BY Location, population, date
ORDER BY PercentPopulationInfected DESC;
--Faeroe Islands has highest percentage which is 70%

--Looking at Highest Infection Rate in United States
SELECT Location, date, population, MAX(total_cases) as HighestInfectionRate,  MAX((total_cases/population))*100 as PercentPopulationInfected
FROM dbo.CovidDeaths
Where location like 'United States'
GROUP BY Location, population, date
ORDER BY PercentPopulationInfected DESC;

--Looking at Highest Infection Rate in India
SELECT Location, date, population, MAX(total_cases) as HighestInfectionRate,  MAX((total_cases/population))*100 as PercentPopulationInfected
FROM dbo.CovidDeaths
Where location like 'India'
GROUP BY Location, population, date
ORDER BY PercentPopulationInfected DESC;

--Showing the DeathCount in India
SELECT Location, MAX(total_deaths) as TotalDeaths
FROM dbo.CovidDeaths
Where location like 'India'
GROUP BY Location
ORDER BY  TotalDeaths DESC;
--99773

--Showing the DeathCount in United States
SELECT Location, MAX(total_deaths) as TotalDeaths
FROM dbo.CovidDeaths
Where location like 'United States'
GROUP BY Location
ORDER BY TotalDeaths DESC;
--998040

--Showing countries with highest death count per population
SELECT Location, MAX(cast(total_deaths as int)) as TotalDeaths
FROM dbo.CovidDeaths
Where continent is not null
GROUP BY Location
ORDER BY TotalDeaths DESC;
--United states is highest with 998040

--Breaking things by continent
--Showing countries with highest death count per population
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeaths
FROM dbo.CovidDeaths
Where continent is not null
GROUP BY continent
ORDER BY TotalDeaths DESC;

--GLOBAL NUMBERS

SELECT date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/ sum(new_cases) *100 as DeathPercentage
FROM dbo.CovidDeaths
Where continent is not null
group by date
ORDER BY DeathPercentage DESC;

--GLOBAL DEATH PERCENTAGE

SELECT  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/ sum(new_cases) *100 as DeathPercentage
FROM dbo.CovidDeaths
Where continent is not null
ORDER BY DeathPercentage DESC;
--1.2%

--TABLE 2:- COVID VACCINATIONS
SELECT * FROM dbo.CovidVaccinations;


--Total tests in United States

SELECT location, date, total_tests
FROM dbo.CovidVaccinations
Where location like 'United States'
order by date desc


--Total tests in India in 2022
SELECT location, date, total_tests
FROM dbo.CovidVaccinations
Where location like 'India' and date like '%2022%'
order by date desc


-- JOINING TABLES

SELECT *
from CovidDeaths dea
join CovidVaccinations vac
on dea.location= vac.location
and dea.date = vac.date

--total population in the world are vaccinated per day
--Looking at Total population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidDeaths dea
join CovidVaccinations vac
on dea.location= vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2
