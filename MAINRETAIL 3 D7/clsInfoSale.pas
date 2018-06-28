unit clsInfoSale;

interface

type
   InfoCashSale = class
     private
        subTotal: Currency;
        itemDiscounts: Currency;
        saleDiscount: Currency;
        otherCosts: Currency;
        tax: Currency;
        totalDue: Currency;
        totalSaved: Currency;
     public
        function getSubtotal: Currency;
        procedure setSubtotal(pValue: Currency);

        function getItemDiscounts: Currency;
        procedure setItemDiscounts(pValue: Currency);

        function getSaleDiscount: Currency;
        procedure setSaleDiscount(pValue: Currency);

        function getOtherCosts: Currency;
        procedure setOtherCosts(pValue: Currency);

        function getTax: Currency;
        procedure setTax(pValue: Currency);

        function getTotalDue: Currency;
        procedure setTotalDue(pValue: Currency);

        function getTotalSaved: Currency;
        procedure setTotalSaved(pValue: Currency);

   end;

implementation

{ InfoSale }

function InfoCashSale.getItemDiscounts: Currency;
begin
   result := self.itemDiscounts;
end;

function InfoCashSale.getOtherCosts: Currency;
begin
   result := self.otherCosts;
end;

function InfoCashSale.getSaleDiscount: Currency;
begin
   result := self.saleDiscount;
end;

function InfoCashSale.getSubtotal: Currency;
begin
   result := self.subTotal;
end;

function InfoCashSale.getTax: Currency;
begin
   result := self.tax;
end;

function InfoCashSale.getTotalDue: Currency;
begin
   result := self.totalDue;
end;

function InfoCashSale.getTotalSaved: Currency;
begin
   result := self.totalSaved;
end;

procedure InfoCashSale.setItemDiscounts(pValue: Currency);
begin
   self.itemDiscounts := pValue;
end;

procedure InfoCashSale.setOtherCosts(pValue: Currency);
begin
   self.otherCosts := pValue;
end;

procedure InfoCashSale.setSaleDiscount(pValue: Currency);
begin
   self.saleDiscount := pValue;
end;

procedure InfoCashSale.setSubtotal(pValue: Currency);
begin
   self.subTotal := pValue;
end;

procedure InfoCashSale.setTax(pValue: Currency);
begin
   self.tax := pValue;
end;

procedure InfoCashSale.setTotalDue(pValue: Currency);
begin
   self.totalDue := pValue;
end;

procedure InfoCashSale.setTotalSaved(pValue: Currency);
begin
   self.totalSaved := pValue;
end;

end.
