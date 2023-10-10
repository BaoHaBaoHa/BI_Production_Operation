SELECT B.ProductID, OrderQty, A.SalesOrderID, C.OrderDate,DueDate, ShipDate, C.ModifiedDate as SalesModifiedDate 
FROM Sales.SalesOrderDetail A
LEFT JOIN Production.Product B
ON A.ProductID = B.ProductID
LEFT JOIN Sales.SalesOrderHeader C
ON  A.SalesOrderID = C.SalesOrderID
------
select B.ProductID, C.LocationID, A.Quantity as InventoryQty, B.ModifiedDate
from Production.ProductInventory A
join Production.Product B
on A.ProductID = B.ProductID
left join Production.Location C
on A.LocationID = C.LocationID
-------
select A.LocationID, Name as 'LocationName', Shelf, Bin
from Production.Location A
join Production.ProductInventory B
ON A.LocationID = B.LocationID
ORDER BY A.LocationID, B.Shelf, B.Bin
----------
SELECT B.WorkOrderID, C.LocationID, A.ProductID, 
  OrderQty AS WorkOrderQty, 
  StockedQty, 
  ScrappedQty, 
  C.Quantity AS InventoryQty, D.SafetyStockLevel , D.ReorderPoint,
A.PlannedCost, 
  A.ActualCost, 

  CAST(YEAR(ScheduledStartDate) AS NVARCHAR) + RIGHT('0' + CAST(MONTH(ScheduledStartDate) AS NVARCHAR), 2) + RIGHT('0' + CAST(DAY(ScheduledStartDate) AS NVARCHAR), 2) AS ScheduledStartDate, 
  CAST(YEAR(ScheduledEndDate) AS NVARCHAR) + RIGHT('0' + CAST(MONTH(ScheduledEndDate) AS NVARCHAR), 2) + RIGHT('0' + CAST(DAY(ScheduledEndDate) AS NVARCHAR), 2) AS ScheduledEndDate, 
  CAST(YEAR(ActualStartDate) AS NVARCHAR) + RIGHT('0' + CAST(MONTH(ActualStartDate) AS NVARCHAR), 2) + RIGHT('0' + CAST(DAY(ActualStartDate) AS NVARCHAR), 2) AS ActualStartDate, 
  CAST(YEAR(ActualEndDate) AS NVARCHAR) + RIGHT('0' + CAST(MONTH(ActualEndDate) AS NVARCHAR), 2) + RIGHT('0' + CAST(DAY(ActualEndDate) AS NVARCHAR), 2) AS ActualEndDate, 
  (DATEDIFF(day, ActualStartDate, ActualEndDate) - DATEDIFF(day, ScheduledStartDate, ScheduledEndDate)) AS LateDay, 
  ((OrderQty) / DATEDIFF(day, ScheduledStartDate, ScheduledEndDate)) * (DATEDIFF(day, ActualStartDate, ActualEndDate) - DATEDIFF(day, ScheduledStartDate, ScheduledEndDate)) AS LateQty
  

FROM Production.WorkOrderRouting A
JOIN Production.WorkOrder B ON A.WorkOrderID = B.WorkOrderID 
JOIN Production.ProductInventory C ON A.ProductID = C.ProductID
JOIN Production.Product D ON C.ProductID = D.ProductID;