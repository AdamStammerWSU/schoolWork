Format Scripts:
formatter.py -> python script to convert the state census released xml data to an importable csv file
		It grabs the data from the correct rows & columns and adds the proper header files

formatBatch.bat -> a batch file that simply runs the formatter.py script on each xml file in a folder
		   I used this to format all of the states at once

madCatter.bat -> a batch file that concatenates csv files without the headers
		 This turnes 50 seperate state census csv files into one making importing the data a lot easier


SQL Scripts:
addStates.sql -> just adds all of the state names to the database

addYears.sql -> adds years 1790 to 2020

createDatabase.sql -> what I used to create the database tables

export1.sql -> the preliminary database export used to add all of the state census data