Create database DW_Production_GroupSimpson
--------
Create schema DW
------------
CREATE TABLE DimTime
(
    TimeKey int NOT NULL PRIMARY KEY,
    Date date NOT NULL,
    Week int NOT NULL,
    Month int NOT NULL,
    Quarter int NOT NULL,
    Year int NOT NULL,
    DateName nvarchar(15) NOT NULL,
    MonthName nvarchar(15) NOT NULL,
    QuarterName nvarchar(15) NOT NULL
);

DECLARE @StartDate date = '2000-01-01';
DECLARE @EndDate date = '2025-12-31';

WHILE (@StartDate <= @EndDate)
BEGIN
    
INSERT INTO DimTime (TimeKey, Date, Week, Month, Quarter, Year, DateName, MonthName, QuarterName)
    VALUES (
        CONVERT(int, CONVERT(char(8), @StartDate, 112)),
        @StartDate,
        DATEPART(WEEK, @StartDate),
        DATEPART(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        DATEPART(YEAR, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        DATENAME(MONTH, @StartDate),
        'Q' + CAST(DATEPART(QUARTER, @StartDate) AS NVARCHAR) + ' ' + CAST(DATEPART(YEAR, @StartDate) AS NVARCHAR)
    );
    
    SET @StartDate = DATEADD(day, 1, @StartDate);
END;
-----------------------

---------
CREATE TABLE DW.FactInventory (
    [InventoryKey] int IDENTITY(1,1) NOT NULL,
    [ProductKey] int,
    [LocationKey] smallint,
    [LocationName] nvarchar(50),
    [InventoryQty] smallint
)
----------
CREATE TABLE DimLocation (
[LocationKey] int IDENTITY(1,1) NOT NULL,
    [LocationID] smallint,
    [LocationName] nvarchar(50),
    [Shelf] nvarchar(10),
    [Bin] tinyint
)
------
CREATE TABLE DW.FactProduction (
[FactProductionKey]  INT IDENTITY(1,1) NOT NULL,
    [LocationKey] smallint,
    [ProductKey] int,
    [WorkOrderKey] int,
    [WorkOrderQty] int,
    [StockedQty] int,
    [ScrappedQty] smallint,
    [InventoryQty] smallint,
	[SafetyStockLevel] smallint,
    [ReorderPoint] smallint,
    [ScheduledStartDate] int,
    [ScheduledEndDate] int,
    [ActualStartDate] int,
    [ActualEndDate]int,
    [LateDay] int,
    [LateQty] int,
    [PlannedCost] money,
    [ActualCost] money,
    [OverCost] money,
)
CREATE TABLE [OLE DB Destination] (
    [WorkOrderID] int,
    [LocationID] smallint,
    [ProductID] int,
    [WorkOrderQty] int,
    [StockedQty] int,
    [ScrappedQty] smallint,
    [InventoryQty] smallint,
    [SafetyStockLevel] smallint,
    [ReorderPoint] smallint,
    [ScheduledStartDate] nvarchar(34),
    [ScheduledEndDate] nvarchar(34),
    [ActualStartDate] nvarchar(34),
    [ActualEndDate] nvarchar(34),
    [LateDay] int,
    [LateQty] int,
    [LateDayStatus] varchar(1),
    [PlannedCost] money,
    [ActualCost] money,
    [OverCost] money,
    [OverCostStatus] varchar(1)
)
------
SELECT * FROM DW.FactProduction

----
CREATE TABLE OLEDBCommand(
[SalesKey]  INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
[ProductKey] int,
    [OrderQty] smallint,
    [OrderDate] int,
    [DueDate] int,
    [ShipDate] int,
)
-------------
CREATE TABLE DimProduct (
[ProductKey]  INT IDENTITY(1,1) NOT NULL,
    [ProductID] int,
    [ProductName] nvarchar(50),
    [CategoryName] nvarchar(50),
    [SubcategoryName] nvarchar(50),
    [LastUpdate] datetime
)

------------
CREATE TABLE DW.FactInventory (
[FactInventoryKey]  INT IDENTITY(1,1) NOT NULL,
    [ProductKey] int,
    [LocationKey] smallint,
    [LocationName] nvarchar(50),
    [InventoryQty] smallint,
    [InventoryModifiedDate] datetime,
	[SafetyStockLevel] smallint,
    [ReorderPoint] smallint,
)

--------------
CREATE TABLE DW.FactSales (
    [FactSalesKey] int IDENTITY(1,1) NOT NULL,
    [ProductKey] int,
    [OrderQty] smallint,
    [SalesOrderID] int,
    [SalesModifiedDate] datetime,
    [OrderDate] int,
    [DueDate] int,
    [ShipDate] int
)
----------
CREATE TABLE DimWorkOrder (
[WorkOrderKey]  INT IDENTITY(1,1) NOT NULL,
    [WorkOrderID] int,
    [OperationSequence] smallint,
    [ScrapReasonName] nvarchar(50)
)
-------
CREATE TABLE DW.FactProduction (
[FactProductionKey]  INT IDENTITY(1,1) NOT NULL,
[LocationKey] int,
    [ProductKey] int,
    [WorkOrderKey] int,
    [WorkOrderQty] int,
    [ScrappedQty] smallint,
    [PlannedCost] money,
    [ActualCost] money,
    [OverCost] money,
    [ScheduledStartDate] int,
    [ScheduledEndDate] int,
    [ActualStartDate] int,
    [ActualEndDate] int,
    [LateDay] int,
    [LateQty] int,
)