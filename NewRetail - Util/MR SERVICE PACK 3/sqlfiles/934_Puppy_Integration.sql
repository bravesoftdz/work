insert into MenuItem values (8, 14, 'PuppyTracker Parameters', 'Maintenance', 'Set up parameters for PuppyTracker', NULL, 1, 1, NULL, NULL)

GO

update MenuItem set ImageIndex = 68 where IDMenu = 8 and IDSubMenu = 14

GO

insert into MenuItemLanguage values (8, 14, 1, 'PuppyTracker Parameters', 'Maintenance', 'PuppyTracker Integration')

GO

update param set defaultValue = 'False' where IdParam = 73

GO

create table PT_LocalSetting (
 Id integer identity not null
,PathToSaleExec varchar(100)
,PuppyInstalled bit 
,PathToAvail varchar(100)
,FrequencyPetAvail char(1)
,constraint PT_LocalSetting_PK primary key(Id)
)

GO

create table PT_GlobalSetting (
 Id integer identity not null
,IdPetCategory integer 
,IdServiceCategory integer
,IdKitCategory integer
,constraint PT_GlobalSetting_PK primary key(Id)
)

GO

create table PT_GlobalSettingDetail (
  Id integer identity not null
 ,GlobalSettingID integer not null
 ,ServiceMap varchar(30) 
 ,IdModel int 
 ,RequireOnSale bit 
 ,constraint PT_GlobalSettingDetail_PK primary key(Id)
 ,constraint PT_GlobalSet_Model_FK foreign key(IdModel) references Model(IdModel)
)

GO

Alter table Model 
add ServiceMap varchar(30) default NULL

GO 
