Update CostType Set DefaultValue = 0
GO

Update CostType Set CostType = 'FREIGHT'
Where IDCostType = 3
GO

Update CostType Set CostType = 'MAILING'
Where IDCostType = 4
GO

Update CostType Set CostType = 'SERVICE'
Where IDCostType = 6
GO

UPDATE Param
SET Desativado = 1
WHERE IDParam IN (1, 10)
GO