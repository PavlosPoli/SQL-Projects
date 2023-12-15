-- Check if database exists. If not, create it
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Netflix')
	BEGIN
		CREATE DATABASE Netflix
	END;
	GO
	
USE Netflix;
GO

-- Check if table exists. If not, create it	
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'tblNetflix' AND xtype = 'U')
	BEGIN
		CREATE TABLE tblNetflix (
			show_id VARCHAR(10) PRIMARY KEY,
			type VARCHAR(20),
			title VARCHAR(150),
			director VARCHAR(250),
			country VARCHAR(50),
			date_added VARCHAR(10),
			release_year VARCHAR(4),
			rating VARCHAR(15),
			duration VARCHAR(20),
			listed_in VARCHAR(150)
			)

			-- Import data from file
			BULK INSERT tblNetflix
			FROM 'E:\backup17092018\Myappdir\Myprojects\Data Science\DA Portfolio Projects\Netflix-Full\netflix1.csv'
			WITH (
				FORMAT = 'CSV',
				FIELDTERMINATOR = ',',
				FIRSTROW = 2
				)
	END;
	GO	
	
	-- Check if data is actually imported
	SELECT *
	FROM tblNetflix;
	GO
	
-- Check if staging database exists. If not, create it
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Netflix_STG')
	BEGIN
		CREATE DATABASE Netflix_STG
	END;
	GO
	
-- Check if staging table exists. If yes, drop it
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'stgNetflix')
	BEGIN
		DROP TABLE stgNetflix
	END;
	GO
		
-- Copy table from the original source to the staging database
	SELECT *
	INTO Netflix_STG.dbo.stgNetflix
	FROM Netflix.dbo.tblNetflix;
	GO