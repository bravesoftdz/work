SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[sp_System_dbTables](
			   @table_name		nvarchar(384)	= null,
			   @table_owner 	nvarchar(384)	= null,
			   @table_qualifier sysname	= null,
			   @table_type		varchar(100) = null)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Devido a um problema do BDE com o SQL Server 7, o delphi não recupera colunas do tipo sysname, nvarchar(128)
		Esta procedure foi alterada a partir do master, para retornar varchar(128)

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

declare @type1 varchar(3)
declare @tableindex int


/* Special feature #1:	enumerate databases when owner and name
	 are blank but qualifier is explicitly '%'.  */
if @table_qualifier = '%' and
	@table_owner = '' and
	@table_name = ''
begin	/* If enumerating databases */
	select
		TABLE_QUALIFIER = convert(varchar(255),d.name),
		TABLE_OWNER = convert(varchar(255),null),
		TABLE_NAME = convert(varchar(255),null),
		TABLE_TYPE = convert(varchar(32),null),
		REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
	from master.dbo.sysdatabases d
	where d.name <> 'model'	/* eliminate MODEL database */
	order by 1
end

/* Special feature #2:	enumerate owners when qualifier and name
	 are blank but owner is explicitly '%'.  */
else if @table_qualifier = '' and
	@table_owner = '%' and
	@table_name = ''
begin	/* If enumerating owners */
	select distinct
		TABLE_QUALIFIER = convert(varchar(255),null),
		TABLE_OWNER = convert(varchar(255),user_name(uid)),
		TABLE_NAME = convert(varchar(255),null),
		TABLE_TYPE = convert(varchar(32),null),
		REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
	from sysobjects
	order by 2
end

/* Special feature #3:	enumerate table types when qualifier, owner and
	 name are blank but table type is explicitly '%'.	*/
else if @table_qualifier = '' and
	@table_owner = '' and
	@table_name = '' and
	@table_type = '%'
begin	/* If enumerating table types */
	select
		TABLE_QUALIFIER = convert(varchar(255),null),
		TABLE_OWNER = convert(varchar(255),null),
		TABLE_NAME = convert(varchar(255),null),
		TABLE_TYPE = convert(varchar(32),rtrim(substring('SYSTEM TABLETABLE       VIEW',(colid-1)*12+1,12))),
		REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
	from sysobjects o, syscolumns c
	where o.id=c.id and o.name='sysusers' and colid<=3
end
else
begin /* end of special features - do normal processing */
	if @table_qualifier is not null
	begin
		if db_name() <> @table_qualifier
		begin
			if @table_qualifier = ''
			begin  /* If empty qualifier supplied */
				/* Force an empty result set */
				select @table_name = ''
				select @table_owner = ''
			end
			else
			begin	/* If qualifier doesn't match current database */
				raiserror (15250, -1,-1)
				return
			end
		end
	end
	if @table_type is null
	begin	/* Select all ODBC supported table types */
		select @type1 = 'SUV'
	end
	else
	begin
		/*	TableType is case sensitive if CS server */
		select @type1 = ''
		if (charindex('''SYSTEM TABLE''',@table_type) <> 0)
			select @type1 = @type1 + 'S'	/* Add System Tables */
		if (charindex('''TABLE''',@table_type) <> 0)
			select @type1 = @type1 + 'U'	/* Add User Tables */
		if (charindex('''VIEW''',@table_type) <> 0)
			select @type1 = @type1 + 'V'	/* Add Views */
	end
	if @table_name is null
	begin	/*	If table name not supplied, match all */
		select @table_name = '%'
	end
	else
	begin
		if (@table_owner is null) and (charindex('%', @table_name) = 0)
		begin	/* If owner not specified and table is specified */
			if exists (select * from sysobjects
				where uid = user_id()
				and name = @table_name
				and (type = 'U' or type = 'V' or type = 'S'))
			begin	/* Override supplied owner w/owner of table */
				select @table_owner = user_name()
			end
		end
	end
	if @table_owner is null /* If no owner supplied, force wildcard */
		select @table_owner = '%' 		select
		TABLE_QUALIFIER = convert(varchar(255),db_name()),
		TABLE_OWNER = convert(varchar(255),user_name(o.uid)),
		TABLE_NAME = convert(varchar(255),o.name),	/* make nullable */
		TABLE_TYPE = convert(varchar(32),rtrim(
			substring('SYSTEM TABLE            TABLE       VIEW       ',
				(ascii(o.type)-83)*12+1,12))),	/* 'S'=0,'U'=2,'V'=3 */
		REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
	from sysobjects o
	where
		o.name like @table_name
		and user_name(o.uid) like @table_owner
		and o.type in ('U','V','S')
		and charindex(substring(o.type,1,1),@type1) <> 0 /* Only desired types */
		and permissions (o.id)&4096 <> 0
	order by 4, 1, 2, 3
end
GO
