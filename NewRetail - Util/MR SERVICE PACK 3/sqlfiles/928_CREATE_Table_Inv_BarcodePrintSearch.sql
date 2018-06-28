create table Inv_BarcodePrintSearch
(
 sequence int identity not null
,IdModel int not null
,model varchar(30)
,description varchar(50) not null
,IdBarcode char(20) not null
,category integer null
,subCategory integer null
,smGroup integer null
,dateLastSellingPrice smalldatetime null
,sellingPrice money null
,qtyOnHand decimal(38, 4) null
,dataBarcode smalldatetime null
,vendorModelCode varchar(35) null
,numCopy int not null
,report varchar(20) null
,IdUser integer not null
,searchWith int null
,sendStraightPrinter char(1) null
,printLabelQtyOnHand char(1) null 
,savePrintQueue char(1) null
,displayPrimary char(1) null
,tabIndex integer default 2
,fromSearch smalldatetime
,toSearch smalldatetime
,idVendor integer
constraint Inv_BarcodePrintSearch_PK primary key (sequence)
)

GO