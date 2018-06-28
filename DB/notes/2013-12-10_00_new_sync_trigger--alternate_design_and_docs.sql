
/*
if object_id('SyncChangeKeyVals') is not null drop table SyncChangeKeyVals;

create table SyncChangeKeyVals (
    IDSyncChange int not null primary key references SyncChanges(IDSyncChange),
    KeyValue varchar(max) not null,
    
    -- KeyOrder is for composite primary keys only, to determine order.
    -- Leave null if it is a single column PK.
    KeyOrder tinyint null
);
*/


/*
declare @InsertedIDSyncChanges table (IDSyncChange int);

insert into SyncChanges (IDSyncTable, ChangedOn, IsExported)
    output Inserted.IDSyncChange into @InsertedIDSyncChanges(IDSyncChange)
    values
    (1, '2013-12-10 12:00:00', 0),
    (1, '2013-12-10 13:00:00', 0),
    (1, '2013-12-10 14:00:00', 0);
   
insert into SyncChangeKeyVals values
    (1, 55519, NULL),
    (2, 55519, NULL),
    (3, 55519, NULL);


select * from SyncChangeKeyVals;

select IDSyncChange, TableName, ChangedOn
from SyncChanges SC
join SyncTables ST on (ST.IDSyncTable = SC.IDSyncTable)
where IsExported = 0;
*/





-- Separate tables for each key datatype is more complicated, but faster:
-- (e.g. 2,147,483,647 is 4 bytes as an int, but 12 bytes as a varchar)
/*
if object_id('Sync_PODB_Int_Keys') is not null drop table Sync_PODB_Int_Keys;
if object_id('Sync_PODB_Char_Keys') is not null drop table Sync_PODB_Char_Keys;

create table Sync_PODB_Int_Keys (
    IDSync bigint not null primary key references Sync_PODB(IDSync),
    Int_Key_Value int not null,
    Key_Order tinyint not null --Which is first key, second key, etc.
);

create table Sync_PODB_Char_Keys (
    IDSync bigint not null primary key references Sync_PODB(IDSync),
    Char_Key_Value varchar(max) not null,
    Key_Order tinyint not null
);
go

*/



/*
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with caller queries SELECT statements.
create trigger Sync_Model on Model for insert, update, delete as
    set nocount on;
    declare @ModelID int;

    SELECT @Count = COUNT(*) FROM DELETED
    if @Count > 0
        BEGIN
            SET @Action = 'D' -- Set Action to 'D'eleted.
            SELECT @Count = COUNT(*) FROM INSERTED
            IF @Count > 0
                SET @Action = 'U' -- Set Action to 'U'pdated.
        END

   if @Action = 'D'
        -- This is a DELETE Record Action
        --
        BEGIN
        END
    ELSE
        BEGIN
            if @Action = 'I'
                BEGIN
                END
            else
                -- This is an Update Record Action
                --
                BEGIN
                END
        END   
go
*/
