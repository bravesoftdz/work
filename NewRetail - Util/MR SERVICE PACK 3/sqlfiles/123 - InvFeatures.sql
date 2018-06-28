CREATE TABLE InvFeatures (
       IDInvFeatures        int NOT NULL,
       IDModel		    int NOT NULL,
       Feature		    varchar(255) NOT NULL,
       System               bit NOT NULL,
       Hidden               bit NOT NULL,
       Desativado           bit NOT NULL
)
GO

ALTER TABLE InvFeatures ADD CONSTRAINT XPKInvFeatures PRIMARY KEY (IDInvFeatures)
GO

ALTER TABLE InvFeatures
       ADD CONSTRAINT FK_Model_InvFeatures_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE InvFeatures ADD CONSTRAINT
	DF_InvFeaturesSystem DEFAULT (0) FOR System
GO

ALTER TABLE InvFeatures ADD CONSTRAINT
	DF_InvFeaturesHidden DEFAULT (0) FOR Hidden
GO

ALTER TABLE InvFeatures ADD CONSTRAINT
	DF_InvFeaturesDesativ DEFAULT (0) FOR Desativado
GO
