USE AmazonEmployeeAccess;
GO

CREATE TABLE Features(
    Id tinyint NOT NULL CONSTRAINT PK_Features PRIMARY KEY,
    Name nchar(32) NOT NULL
)
GO

INSERT INTO Features (Id, Name)
VALUES
    (1,'RESOURCE'),
    (2,'MGR_ID'),
    (3,'ROLE_ROLLUP_1'),
    (4,'ROLE_ROLLUP_2'),
    (5,'ROLE_DEPTNAME'),
    (6,'ROLE_TITLE'),
    (7,'ROLE_FAMILY_DESC'),
    (8,'ROLE_FAMILY'),
    (9,'ROLE_CODE');
GO

CREATE TABLE DataPoints(
    Id int NOT NULL CONSTRAINT PK_DataPoints PRIMARY KEY,
    Action bit NULL
)
GO

CREATE VIEW TrainDataPoints
AS
SELECT Id, 
       Action
FROM DataPoints
WHERE Id < 0
GO
CREATE VIEW TestDataPoints
AS
SELECT Id, 
       Action
FROM DataPoints
WHERE Id > 0
GO

CREATE TABLE DataFeatures(
    DataPointId int NOT NULL,
    FeatureId tinyint NOT NULL,
    Value int NOT NULL
)
GO
ALTER TABLE DataFeatures 
ADD FOREIGN KEY (DataPointId) 
REFERENCES DataPoints (Id)
GO
ALTER TABLE DataFeatures 
ADD FOREIGN KEY (FeatureId) 
REFERENCES Features (Id)
GO
