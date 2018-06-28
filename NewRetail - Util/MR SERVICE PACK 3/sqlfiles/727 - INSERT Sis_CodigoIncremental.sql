DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
UPDATE Sis_CodigoIncremental
SET UltimoCodigo = UltimoCodigo +  @Cod
WHERE Tabela = 'Pet.SKU'
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet.IDPet')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet.IDPet', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_PetMedicalCondition.IDPetMedicalCondition')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_PetMedicalCondition.IDPetMedicalCondition', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_PetMedicalCondition.IDPetMedicalCondition')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_PetMedicalCondition.IDPetMedicalCondition', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_PetSale.IDPetSale')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_PetSale.IDPetSale', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_PetTreatment.IDPetTreatment')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_PetTreatment.IDPetTreatment', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_TreatmentLot.IDTreatmentLot')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_TreatmentLot.IDTreatmentLot', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_WarrantyReport.IDWarrantyReport')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_WarrantyReport.IDWarrantyReport', @Cod)
END
GO

DECLARE @Cod int
SET @Cod = (Select UltimoCodigo From Sis_CodigoIncremental where Tabela = 'Hotel.IDHotel')
IF NOT EXISTS (Select Tabela From Sis_CodigoIncremental where Tabela = 'Pet_Weight.IDWeight')
BEGIN
	INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo)
	VALUES ('Pet_Weight.IDWeight', @Cod)
END
GO
