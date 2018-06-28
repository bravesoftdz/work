Create table Inv_BarcodePrintSearch
(sequence int identity not null,
 IdUser int not null,
 IdModel int not null,
 model varchar(30) not null,
 description varchar(50) not null,
 IdBarcode char(20) not null,
 qtyOnHand decimal(38,4),
 sellingPrice money,
 numCopy int,
 report varchar(10) not null,
 IdSearchType int not null,
 constraint InvBarPrnSearch_PK primary key(sequence)   )
GO