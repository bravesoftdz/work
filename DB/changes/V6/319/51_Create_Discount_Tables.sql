set xact_abort on;
go
begin tran;

if object_id('DiscCoupons') is not null drop table DiscCoupons;
if object_id('DiscStores') is not null drop table DiscStores;
if object_id('DiscUses') is not null drop table DiscUses;
if object_id('DiscQualifyingTags') is not null drop table DiscQualifyingTags;
if object_id('DiscRewardTags') is not null drop table DiscRewardTags;
if object_id('Discounts') is not null drop table Discounts;
go

/***********************************************
 * Create tables and views for new sync system.*
 ***********************************************/
-- Primary table.
create table Discounts (
    IDDiscount int identity(1, 1) not null,
    DiscountName nvarchar(MAX),
    -- If both are null, there is no date restriction.
    StartOn date,
    EndOn date,
    -- Valid values: 00:00 to 23:59. If not null, the current time must be
    -- between (inclusive) these two values.
    BeginTimeOfDay time,
    EndTimeOfDay time,
    -- Current types: 'Coupon', 'Promo'
    DiscType nvarchar(MAX),
    -- The subtotal, before discounts and tax, must be this much.
    MinSubtotal money,
    -- Only when purchased at this location:
    IDStore int,
    -- If not null, require the users customer loyalty card, so we can look up
    -- previous orders to see if they have used this discount and if it is
    -- over the maximum allowed (usually 1).
    MaxUsesPerCustomer int,
    -- "E.g. First 100 customers get a free widget!"
    MaxUsesInTotal int,
    -- If not null, requires customer card.
    FirstTimeCustomerOnly boolean,
    CustomerCardRequired boolean,
    -- Whether this entire discount can stack with other discounts or not.
    IsStackable boolean default 1,
    RewardAmount money,
    -- AmountType can have several values: 'Sale Price', 'Quantity',
    -- 'Amount Off Item', 'Amount Off Subtotal',
    -- 'Percent Off Item', and 'Percent Off Subtotal'.
    -- 'Sale Price' means the IDModel price is changed to this.
    -- 'Amount Off Item' is a dollar amount to subtract from the IDModel price.
    -- For 'Percent Off': record the value as a multiplication factor for the
    -- best performance. Convert back to "percent" for display (e.g. 0.9 -> 10%)
    -- using "1 - x * 100" (where x is 0.9 for 10% off).
    -- The 'Quantity' AmountType means that you get that DiscAmount number of
    -- the IDModel item above for free.
    AmountType nvarchar(MAX) not null default 'Percent Off',
    -- RewardQuantity is used in circumstances like this: "Buy 3 foos, get 2
    -- for 50% off!" The 2 in that case would be the RewardQuantity.
    -- It will probably not get a lot of use.
    RewardQuantity int,
    -- If a certain number of the QualifyingTag is required.
    MinQuantity int,
    -- MinDollarAmount means that you have to buy enough of the other-wise
    -- qualifying items to reach the minimum. Similar for MinQuantity.
    MinDollarAmount money,
    constraint PK_Discounts primary key (IDDiscount),
);

if object_id('DiscValidOnDays') is not null drop table DiscValidOnDays;
go
create table DiscValidOnDays (
    IDDiscount int not null,
    -- Valid values: 1 to 7. If not null, this requires the current day of week to match.
    -- 1=Sunday, 7=Saturday
    DayOfWeek int not null,
    constraint PK_DiscValidOnDays primary key (IDDiscount, DayOfWeek)
);
alter table DiscValidOnDays with check add constraint FK_DiscValidOnDays_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;

if object_id('TagQtyDiscountBreak') is not null drop table TagQtyDiscountBreak;
go
create table TagQtyDiscountBreak (
    IDTag int not null,
    IDDiscount int not null,
    MinQuantity int not null,
    constraint PK_TagQtyDiscountBreak primary key (IDTag)
);
alter table TagQtyDiscountBreak with check add constraint FK_TagQtyDiscountBreak_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;
alter table TagQtyDiscountBreak with check add constraint FK_TagQtyDiscountBreak_IDTag
    foreign key (IDTag) references Tag (IDTag)
    on update cascade on delete cascade;

create table DiscCoupons (
    -- This is the "coupon" or "promo" code. If not null, then the user
    -- must enter the code in order to use the discount.
    Code nvarchar(255),
    IDDiscount int not null,
    constraint PK_DiscCoupons primary key (Code)
);
alter table DiscCoupons with check add constraint FK_DiscCoupons_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;

create table DiscQualifyingTags (
    IDDiscount int not null,
    IDTag int not null,
    constraint PK_DiscQualifyingTags primary key (IDDiscount, IDTag)
);
alter table DiscQualifyingTags with check add constraint FK_DiscQualifyingTags_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;
alter table DiscQualifyingTags with check add constraint FK_DiscQualifyingTags_IDTag
    foreign key (IDTag) references Tag (IDTag)
    on update cascade on delete cascade;

create table DiscRewardTags (
    IDDiscount int not null,
    IDTag int not null,
    constraint PK_DiscRewardTags primary key (IDDiscount, IDTag)
);
alter table DiscRewardTags with check add constraint FK_DiscRewardTags_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;
alter table DiscRewardTags with check add constraint FK_DiscRewardTags_IDTag
    foreign key (IDTag) references Tag (IDTag)
    on update cascade on delete cascade;

-- Which locations this sale applies to. Normal include exclude logic.
create table DiscStores (
    IDDiscount int not null,
    IDStore int not null,
    ISInclude boolean default 1,
    constraint PK_DiscStores primary key (IDDiscount, IDStore)
);
alter table DiscStores with check add constraint FK_DiscStores_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;
alter table DiscStores with check add constraint FK_DiscStores_IDStore
    foreign key (IDStore) references Store (IDStore)
    on update cascade on delete cascade;

-- TipoPessoa rows are the customer groups (e.g. Customer and Loyalty Program).
create table DiscAllowedCustGroups (
    IDDiscount int not null,
    IDTipoPessoa int not null,
    constraint PK_DiscAllowedCustGroups primary key (IDDiscount, IDTipoPessoa)
);
alter table DiscAllowedCustGroups with check add constraint FK_DiscAllowedCustGroups_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;
alter table DiscAllowedCustGroups with check add constraint FK_DiscAllowedCustGroups_IDTipoPessoa
    foreign key (IDTipoPessoa) references TipoPessoa (IDTipoPessoa)
    on update cascade on delete cascade;


-- Not used yet:
-- For the given IDModel in DiscountEntries, look up the qty in this table.
/*
create table DiscQtyBreaks (
    IDDiscountEntry int not null references DiscountEntries
        on delete cascade on update cascade,
    MinQuantity int not null,
    RewardAmount money,
    AmountType varchar(100) not null default 'Percent Off',
    primary key (IDDiscountEntry, MinQuantity)
)
*/

-- Records each time a discount is used.
create table DiscUses (
    IDDiscount int not null,
    IDInventoryMov int not null,
    constraint PK_DiscUses primary key (IDDiscount, IDInventoryMov)
);
alter table DiscUses with check add constraint FK_DiscUses_IDDiscount
    foreign key (IDDiscount) references Discounts (IDDiscount)
    on update cascade on delete cascade;
alter table DiscUses with check add constraint FK_DiscUses_IDInventoryMov
    foreign key (IDInventoryMov) references InventoryMov (IDInventoryMov)
    on update cascade on delete cascade;
go

commit;