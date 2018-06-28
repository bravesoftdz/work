set xact_abort on;
go
begin tran;
go

-- Use TabGroup to generate test data for tags
/*
select IDGroup as IDTag, Name as TagName
from TabGroup
order by IDGroup;
*/
insert into Tag (TagName)
    select Name as TagName
    from TabGroup
    order by IDGroup;
    
--select * from Tag;

insert into TagModel (IDTag, IDModel)
    select
        (
            select IDTag from Tag where TagName = (
                select Name from TabGroup TG where TG.IDGroup = M.GroupID
            )
        ) as IDTag,
        IDModel
    from Model M
    order by GroupID;

/*
select Tag.TagName, count(*) as ModelCount
from TagModel TM
join Tag on (Tag.IDTag = TM.IDTag)
group by Tag.TagName
order by Tag.TagName;
*/
go

if object_id('sp_TagModelCounts') is not null drop procedure sp_TagModelCounts;
go
create proc sp_TagModelCounts
as
set nocount on
select Tag.TagName, count(*) as ModelCount
from TagModel TM
join Tag on (Tag.IDTag = TM.IDTag)
group by Tag.TagName
order by Tag.TagName;
set nocount off
go

--exec sp_TagModelCounts;

-- List tag for model
if object_id('sp_TagsForModel') is not null drop procedure sp_TagsForModel;
go
create proc sp_TagsForModel
    @IDModel int
as
set nocount on

select Tag.*
from Tag
where IDTag in (
    select IDTag
    from TagModel
    where IDModel = @IDModel
)
order by TagName, IDTag;

set nocount off
go

exec sp_TagsForModel 3;
exec sp_TagsForModel 4;
exec sp_TagsForModel 5;

rollback tran;