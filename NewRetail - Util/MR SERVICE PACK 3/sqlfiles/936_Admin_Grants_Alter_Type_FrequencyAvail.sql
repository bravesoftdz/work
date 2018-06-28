alter table PT_LocalSetting 
alter column FrequencyPetavail varchar(30)

GO


declare @idusertype int
begin
  select @idusertype = IDUserType from UserType where Upper(name) like 'ADMIN%' and Desativado = 0
  update MenuRights set CanAccess = 1, CanInsert = 1, CanUpdate = 1, CanDelete = 1, CanPrint =1, CanExport = 1 
  where upper(ModuleName) like 'Puppy%' and UserTypeID = @idusertype
end

GO