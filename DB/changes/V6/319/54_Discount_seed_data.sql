-- Not sure why, but having at least a single row in the table causes the
-- discount queries to be executed faster.
-- to go many times faster.
declare @NewIDDiscount int;
exec sp_Discounts_Upsert
    @IDDiscount = @NewIDDiscount OUTPUT,
    @DiscountName = 'Example Discount',
    @StartOn = '2001-01-01 01:01:01',
    @EndOn = '2001-01-01 02:01:01',
    @BeginTimeOfDay = null,
    @EndTimeOfDay = null,
    @DiscType = 'promo',
    @MinSubtotal = null,
    @IDStore = null,
    @MaxUsesPerCustomer = null,
    @MaxUsesInTotal = null,
    @FirstTimeCustomerOnly = 0,
    @CustomerCardRequired = 0,
    @IsStackable = 0,
    @RewardAmount = 0.0,
    @AmountType = 'Percent Off Item',
    @RewardQuantity = null,
    @MinQuantity = null,
    @MinDollarAmount = null;
select @NewIDDiscount;