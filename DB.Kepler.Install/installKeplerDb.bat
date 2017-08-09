@echo off
@REM Martin Korneffel 2017
@REM Installation der KeplerDB
Title Installation der KeplerDB
DB.Kepler.EF60.tools.cmd serverName .\sql2016dev databaseName KeplerDbTest createDB initDB createSolarSysPlanets asteroidsCsv .\asteroids-main-belt.csv
