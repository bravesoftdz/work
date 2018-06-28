CREATE TABLE Sal_TrafficBox (
	IDTrafficBox int NOT NULL,
	TrafficBox varchar(50) NOT NULL,
	IDStore int NULL
)
GO

ALTER TABLE Sal_TrafficBox ADD CONSTRAINT
	XPKSal_TrafficBox PRIMARY KEY (IDTrafficBox)
GO

ALTER TABLE Sal_TrafficBox ADD CONSTRAINT
	R_213 FOREIGN KEY (IDStore) REFERENCES Store
GO

CREATE TABLE Sal_TrafficMov (
	IDTrafficMov int NOT NULL,
	IDTrafficBox int NULL,
	DateMov datetime NOT NULL,
	Qty int NOT NULL
)
GO

ALTER TABLE Sal_TrafficMov ADD CONSTRAINT
	XPKSal_TrafficMov PRIMARY KEY (IDTrafficMov)
GO

ALTER TABLE Sal_TrafficMov ADD CONSTRAINT
	R_212 FOREIGN KEY (IDTrafficBox) REFERENCES Sal_TrafficBox
GO
