ALTER TABLE Store
ADD TicketDetail text
GO

UPDATE Store SET TicketDetail = ''
GO

ALTER TABLE Store
ADD TicketTotals text
GO

UPDATE Store SET TicketTotals = ''
GO

ALTER TABLE Rep_Item
ADD System Boolean
GO

ALTER TABLE Rep_Item
ADD Hint varchar(255)
GO

UPDATE Rep_Item SET Hint = ''
GO