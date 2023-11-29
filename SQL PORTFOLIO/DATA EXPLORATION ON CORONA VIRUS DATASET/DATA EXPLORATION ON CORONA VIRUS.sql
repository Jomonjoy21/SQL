/*DATA EXPLORATON*/ /*COVID DATASET*/

--SELECT * FROM PortfolioProject.dbo.CovidDeaths ORDER BY 3,4
--SELECT * FROM PortfolioProject.dbo.CovidVaccinations ORDER BY 3,4
--SELECT location, date, total_cases, new_cases, total_deaths, population FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL ORDER BY 1,2

/*Looking at total_cases vs total_deaths*/
--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Death_percentage FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL ORDER BY 1,2

/*Portrays likelihood of dying if anyone contract covid in India*/
--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Death_percentage FROM PortfolioProject.dbo.CovidDeaths WHERE location LIKE '%India%' OR continent IS NOT NULL ORDER BY 1,2

/*Looking at total_cases vs Population*/
/*Reporting percentage of popualtion got covid*/
--SELECT location, date, population, total_cases, (total_cases/population) * 100 AS Percentage_population_infected FROM PortfolioProject.dbo.CovidDeaths WHERE location LIKE '%India%' OR continent IS NOT NULLORDER BY 1,2

/*Countries with Highest Infection Rate compared to Population*/
--SELECT location, population, MAX(total_cases) AS Highest_infection_count, MAX(total_cases/population) * 100 AS Percentage_population_infected FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL GROUP BY location, population ORDER BY Percentage_population_infected DESC

/*Countries with Highest Death Count per Population*/
--SELECT location, MAX(CAST(total_deaths AS int)) AS Total_death_count FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL GROUP BY location ORDER BY Total_death_count DESC /*The issue is total_deaths is in nvarchar, it needed to be converted to int by CAST as int*/
/*In the result we can see some which we really don't need such as World, Asia, Africa etc. So when we look at the continent its null but for the same location name can be seen as continent name. So uses WHERE continent IS NOT NULL*/

/*Continent with highest Death count per Population*/
--SELECT continent, MAX(CAST(total_deaths AS int)) AS Total_death_count FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL GROUP BY continent ORDER BY Total_death_count DESC
--SELECT location, MAX(CAST(total_deaths AS int)) AS Total_death_count FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NULL GROUP BY location ORDER BY Total_death_count DESC /*This is the correct one*/ 

/*Contitnent with Highest Death Counts*/
--SELECT continent(location), MAX(CAST(total_deaths AS int)) AS Total_death_count FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL GROUP BY continent(location) ORDER BY Total_death_count DESC

/*Global Numbers*/
--SELECT date, SUM(new_cases) AS Total_new_cases, SUM(CAST(new_deaths AS int)) AS Total_new_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases)  * 100 AS Global_death_percentage FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL GROUP BY date ORDER BY 1,2 /*We cant just GROUP BY date only*/
--SELECT SUM(new_cases) AS Total_new_cases, SUM(CAST(new_deaths AS int)) AS Total_new_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases)  * 100 AS Global_death_percentage FROM PortfolioProject.dbo.CovidDeaths WHERE continent IS NOT NULL ORDER BY 1,2

/*Representing total Population vs Vaccinations*/
--SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations FROM PortfolioProject.dbo.CovidDeaths AS cd JOIN PortfolioProject.dbo.CovidVaccinations AS cv ON cd.location = cv.location AND cd.date = cv.date WHERE cd.continent IS NOT NULL ORDER BY 2,3
/*Using PARTITON BY in the location as the location changes from one to another, to avoid summing-up all and start as new omn each new location*/
--SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(int,cv.new_vaccinations)) OVER (PARTITION BY cd.location) AS Total_new_vaccinations FROM PortfolioProject.dbo.CovidDeaths AS cd JOIN PortfolioProject.dbo.CovidVaccinations AS cv ON cd.location = cv.location AND cd.date = cv.date WHERE cd.continent IS NOT NULL ORDER BY 2,3 /*Sum-up new vaccinations by location*/
/*Two ways to convert one form to another [1] SUM(CAST(...AS int)  [2] SUM(CONVERT(int,...)*/
--SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(int,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Total_new_vaccinations FROM PortfolioProject.dbo.CovidDeaths AS cd JOIN PortfolioProject.dbo.CovidVaccinations AS cv ON cd.location = cv.location AND cd.date = cv.date WHERE cd.continent IS NOT NULL ORDER BY 2,3 /*Instead of showing the total vaccinations untill it turns to another country. it adds up and make the total based on the date and then location*/

/*How many people got vaccinated in each location*/
/*In order to know that how many people got vaccinated we can't just use the column which we created now, here comes the use of CTE or temp tables*/
/*If the no:of columns in the CTE is != the no:of columns in the SELECT then shows error*/
/*USING CTE*/
--WITH TOPOVA (continent, location, date, population, new_vaccinations, Total_new_vaccinations) AS (SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(int,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Total_new_vaccinations FROM PortfolioProject.dbo.CovidDeaths AS cd JOIN PortfolioProject.dbo.CovidVaccinations AS cv ON cd.location = cv.location AND cd.date = cv.date WHERE cd.continent IS NOT NULL) SELECT *, (Total_new_vaccinations/population) * 100 AS Vaccinaions_per_pop FROM TOPOVA 
/*Using Temp*/
--DROP TABLE IF EXISTS #Percent_population_vaccinated
--CREATE TABLE #Percent_population_vaccinated(continent nvarchar(255), location nvarchar(255), date datetime, population numeric, new_vaccinations numeric, Total_new_vaccinations numeric)
--INSERT INTO #Percent_population_vaccinated SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(int,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Total_new_vaccinations FROM PortfolioProject.dbo.CovidDeaths AS cd JOIN PortfolioProject.dbo.CovidVaccinations AS cv ON cd.location = cv.location AND cd.date = cv.date WHERE cd.continent IS NOT NULL ORDER BY 2,3
--SELECT *, (Total_new_vaccinations/population) * 100 AS Vaccinaions_per_pop FROM #Percent_population_vaccinated

/*CREATE VIEW to store data for later visualization*/
--CREATE VIEW Percent_population_vaccinated AS SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(int,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Total_new_vaccinations FROM PortfolioProject.dbo.CovidDeaths AS cd JOIN PortfolioProject.dbo.CovidVaccinations AS cv ON cd.location = cv.location AND cd.date = cv.date WHERE cd.continent IS NOT NULL 
--SELECT * FROM Percent_population_vaccinated /*VIEW doesn't take ORDER BY*/
