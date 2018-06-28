SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_System_dbKeys](
			   @table_name		sysname,
			   @table_owner 	sysname = null,
			   @table_qualifier sysname = null )
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

DECLARE @table_id			int
DECLARE @full_table_name	varchar(255) /* 2*128 + 1 */

if @table_qualifier is not null
begin
	if db_name() <> @table_qualifier
	begin	/* If qualifier doesn't match current database */
		raiserror (15250, -1,-1)
		return
	end
end
if @table_owner is null
begin	/* If unqualified table name */
	SELECT @full_table_name = quotename(@table_name)
end
else
begin	/* Qualified table name */
	if @table_owner = ''
	begin	/* If empty owner name */
		SELECT @full_table_name = quotename(@table_owner)
	end
	else
	begin
		SELECT @full_table_name = quotename(@table_owner) +
			'.' + quotename(@table_name)
	end
end
/*	Get Object ID */
SELECT @table_id = object_id(@full_table_name)

select
	TABLE_QUALIFIER = convert(VarChar(128), db_name()),
	TABLE_OWNER = convert(VarChar(128),user_name(o.uid)),
	TABLE_NAME = convert(VarChar(128),o.name),
	COLUMN_NAME = convert(VarChar(128),c.name),
	KEY_SEQ =
		case
			when c.name = index_col(@full_table_name, i.indid,  1) then 1
			when c.name = index_col(@full_table_name, i.indid,  2) then 2
			when c.name = index_col(@full_table_name, i.indid,  3) then 3
			when c.name = index_col(@full_table_name, i.indid,  4) then 4
			when c.name = index_col(@full_table_name, i.indid,  5) then 5
			when c.name = index_col(@full_table_name, i.indid,  6) then 6
			when c.name = index_col(@full_table_name, i.indid,  7) then 7
			when c.name = index_col(@full_table_name, i.indid,  8) then 8
			when c.name = index_col(@full_table_name, i.indid,  9) then 9
			when c.name = index_col(@full_table_name, i.indid, 10) then 10
			when c.name = index_col(@full_table_name, i.indid, 11) then 11
			when c.name = index_col(@full_table_name, i.indid, 12) then 12
			when c.name = index_col(@full_table_name, i.indid, 13) then 13
			when c.name = index_col(@full_table_name, i.indid, 14) then 14
			when c.name = index_col(@full_table_name, i.indid, 15) then 15
			when c.name = index_col(@full_table_name, i.indid, 16) then 16
		end,
	PK_NAME = convert(VarChar(128),i.name)
from
	sysindexes i, syscolumns c, sysobjects o
where
	o.id = @table_id
	and o.id = c.id
	and o.id = i.id
	and (i.status & 0x800) = 0x800
	and (c.name = index_col (@full_table_name, i.indid,  1) or
	c.name = index_col (@full_table_name, i.indid,  2) or
	c.name = index_col (@full_table_name, i.indid,  3) or
	c.name = index_col (@full_table_name, i.indid,  4) or
	c.name = index_col (@full_table_name, i.indid,  5) or
	c.name = index_col (@full_table_name, i.indid,  6) or
	c.name = index_col (@full_table_name, i.indid,  7) or
	c.name = index_col (@full_table_name, i.indid,  8) or
	c.name = index_col (@full_table_name, i.indid,  9) or
	c.name = index_col (@full_table_name, i.indid, 10) or
	c.name = index_col (@full_table_name, i.indid, 11) or
	c.name = index_col (@full_table_name, i.indid, 12) or
	c.name = index_col (@full_table_name, i.indid, 13) or
	c.name = index_col (@full_table_name, i.indid, 14) or
	c.name = index_col (@full_table_name, i.indid, 15) or
	c.name = index_col (@full_table_name, i.indid, 16)
	)
order by 1, 2, 3, 5
GO
