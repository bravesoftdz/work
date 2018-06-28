CREATE TABLE InvTechFeatures (
       IDInvTechFeatures    int NOT NULL,
       IDModel		    int NOT NULL,
       TechFeature	    varchar(255) NOT NULL,
       System               bit NOT NULL,
       Hidden               bit NOT NULL,
       Desativado           bit NOT NULL
)
GO

ALTER TABLE InvTechFeatures ADD CONSTRAINT XPKInvTechFeatures PRIMARY KEY (IDInvTechFeatures)
GO

ALTER TABLE InvTechFeatures
       ADD CONSTRAINT FK_Model_InvTechFeatures_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE InvTechFeatures ADD CONSTRAINT
	DF_InvTechFeaturesSystem DEFAULT (0) FOR System
GO

ALTER TABLE InvTechFeatures ADD CONSTRAINT
	DF_InvTechFeaturesHidden DEFAULT (0) FOR Hidden
GO

ALTER TABLE InvTechFeatures ADD CONSTRAINT
	DF_InvTechFeaturesDesativ DEFAULT (0) FOR Desativado
GO
