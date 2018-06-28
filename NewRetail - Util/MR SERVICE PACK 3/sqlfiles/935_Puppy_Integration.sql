update model set ServiceMap = null

GO

alter table model 
add RequireOnSale bit

GO

alter table PT_GlobalSettingDetail
add price money

GO

alter table PT_GlobalSettingDetail
add description varchar(50)

GO