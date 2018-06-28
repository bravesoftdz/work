CREATE TABLE Inv_Nutrition (
       IDNutrition          int NOT NULL,
       Description          varchar(50) NULL,
       Hidden               TBit
                                   CONSTRAINT DEF_Bit1286
                                          DEFAULT 0,
       Desativado           TBit
                                   CONSTRAINT DEF_Bit1287
                                          DEFAULT 0,
       System               TBit
                                   CONSTRAINT DEF_Bit1288
                                          DEFAULT 0
)
GO

ALTER TABLE Inv_Nutrition
       ADD CONSTRAINT XPKInv_Nutrition PRIMARY KEY (IDNutrition)
GO

CREATE TABLE Inv_NutritionItem (
       IDNutritionItem      int NOT NULL,
       IDNutrition          int NOT NULL,
       Description          varchar(100) NULL,
       FieldLength          int NULL,
       FieldPos             int NULL
)
GO

ALTER TABLE Inv_NutritionItem
       ADD CONSTRAINT XPKInv_NutritionItem PRIMARY KEY (
              IDNutritionItem)
GO


ALTER TABLE Inv_NutritionItem
       ADD CONSTRAINT FK_Inv_Nutrition_Inv_NutritionItem_IDNutrition
              FOREIGN KEY (IDNutrition)
                             REFERENCES Inv_Nutrition
GO

CREATE TABLE Inv_ModelNutrition (
       IDModel              int NOT NULL,
       IDNutritionItem      int NOT NULL,
       QtyPortion           decimal(38,4) NULL,
       VDPortion            decimal(38,4) NULL
)
GO

ALTER TABLE Inv_ModelNutrition
       ADD CONSTRAINT XPKInv_ModelNutrition PRIMARY KEY (IDModel, 
              IDNutritionItem)
GO

ALTER TABLE Inv_ModelNutrition
       ADD CONSTRAINT FK_Inv_NutritionItem_Inv_ModelNutrition_IDNutritionItem
              FOREIGN KEY (IDNutritionItem)
                             REFERENCES Inv_NutritionItem
GO

ALTER TABLE Inv_ModelNutrition
       ADD CONSTRAINT FK_Model_Inv_ModelNutrition_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO
