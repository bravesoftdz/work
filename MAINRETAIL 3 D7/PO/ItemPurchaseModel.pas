unit ItemPurchaseModel;

interface

type
   TItemPurchaseModel = class
   private
    fIdpreinventoryMov: Integer;
    fDocumentID: Integer;
    fModelID: Integer;
    fMovDate: TDateTime;
    fQty: Double;
    fSalePrice: Currency;
    fSuggRetail: Currency;
    fCostPrice: Currency;
    fIdPessoa: Integer;
    fDateEstimatedMov: TDateTime;
    fStoreID: Integer;
    fInventoryMovTypeID: Integer;
    fUserID: Integer;
    fCaseCost: Currency;
    fCaseQty: Double;
    function getCaseCost: Currency;
    function getCaseQty: Currency;
    function getCostPrice: Currency;
    function getDateEstimatedMov: TDateTime;
    function getDocumentID: Integer;
    function getIdPessoa: Integer;
    function getIdPreinventoryMov: Integer;
    function getInventoryMovTypeID: Integer;
    function getModelID: Integer;
    function getMovDate: TDateTime;
    function getQty: Double;
    function getSalePrice: Currency;
    function getStoreID: Integer;
    function getSuggRetail: Currency;
    function getUserID: Integer;
    procedure setCaseCost(const Value: Currency);
    procedure setCaseQty(const Value: Currency);
    procedure setCostPrice(const Value: Currency);
    procedure setDateEstimatedMov(const Value: TDateTime);
    procedure setDocumentID(const Value: Integer);
    procedure setIDPessoa(const Value: Integer);
    procedure setIdPreinventoryMov(const Value: Integer);
    procedure setInventoryMovTypeID(const Value: Integer);
    procedure setModelID(const Value: Integer);
    procedure setMovDate(const Value: TDateTime);
    procedure setQty(const Value: Double);
    procedure setSalePrice(const Value: Currency);
    procedure setStoreID(const Value: Integer);
    procedure setSuggRetail(const Value: Currency);
    procedure setUserID(const Value: Integer);
   public
    property IdPreInventoryMov: Integer read getIdPreinventoryMov write setIdPreinventoryMov;
    property DocumentID: Integer read getDocumentID write setDocumentID;
    property ModelID: Integer read getModelID write setModelID;
    property MovDate: TDateTime read getMovDate write setMovDate;
    property Qty: Double read getQty write setQty;
    property SalePrice: Currency read getSalePrice write setSalePrice;
    property SuggRetail: Currency read getSuggRetail write setSuggRetail;
    property CostPrice: Currency read getCostPrice write setCostPrice;
    property IdPessoa: Integer read getIdPessoa write setIDPessoa;
    property DateEstimatedMov: TDateTime read getDateEstimatedMov write setDateEstimatedMov;
    property StoreID: Integer read getStoreID write setStoreID;
    property InventoryMovTypeID: Integer read getInventoryMovTypeID write setInventoryMovTypeID;
    property UserID: Integer read getUserID write setUserID;
    property CaseCost: Currency read getCaseCost write setCaseCost;
    property CaseQty: Currency read getCaseQty write setCaseQty;
   end;


implementation

{ TItemPurchaseModel }

function TItemPurchaseModel.getCaseCost: Currency;
begin
   result := fCaseCost
end;

function TItemPurchaseModel.getCaseQty: Currency;
begin
   result := fCaseQty
end;

function TItemPurchaseModel.getCostPrice: Currency;
begin
   result := fCostPrice
end;

function TItemPurchaseModel.getDateEstimatedMov: TDateTime;
begin
   result := fDateEstimatedMov
end;

function TItemPurchaseModel.getDocumentID: Integer;
begin
  result := fDocumentID
end;

function TItemPurchaseModel.getIdPessoa: Integer;
begin
   result := fIdPessoa
end;

function TItemPurchaseModel.getIdPreinventoryMov: Integer;
begin
   result := fIdpreinventoryMov
end;

function TItemPurchaseModel.getInventoryMovTypeID: Integer;
begin
   result := fInventoryMovTypeID
end;

function TItemPurchaseModel.getModelID: Integer;
begin
   result := fModelID
end;

function TItemPurchaseModel.getMovDate: TDateTime;
begin
   result := fMovDate
end;

function TItemPurchaseModel.getQty: Double;
begin
   result := fQty
end;

function TItemPurchaseModel.getSalePrice: Currency;
begin
   result := fSalePrice
end;

function TItemPurchaseModel.getStoreID: Integer;
begin
   result := fStoreID
end;

function TItemPurchaseModel.getSuggRetail: Currency;
begin
   result := fSuggRetail
end;

function TItemPurchaseModel.getUserID: Integer;
begin
   result := fUserID
end;

procedure TItemPurchaseModel.setCaseCost(const Value: Currency);
begin
   fCaseCost := value
end;

procedure TItemPurchaseModel.setCaseQty(const Value: Currency);
begin
   fCaseQty := value
end;

procedure TItemPurchaseModel.setCostPrice(const Value: Currency);
begin
   fCostPrice := value
end;

procedure TItemPurchaseModel.setDateEstimatedMov(const Value: TDateTime);
begin
   fDateEstimatedMov := value
end;

procedure TItemPurchaseModel.setDocumentID(const Value: Integer);
begin
   fDocumentID := value
end;

procedure TItemPurchaseModel.setIDPessoa(const Value: Integer);
begin
   fIdPessoa := value
end;

procedure TItemPurchaseModel.setIdPreinventoryMov(const Value: Integer);
begin
   fIdpreinventoryMov := value
end;

procedure TItemPurchaseModel.setInventoryMovTypeID(const Value: Integer);
begin
   fInventoryMovTypeID := value
end;

procedure TItemPurchaseModel.setModelID(const Value: Integer);
begin
   fModelID := value
end;

procedure TItemPurchaseModel.setMovDate(const Value: TDatetime);
begin
   fMovDate := value
end;

procedure TItemPurchaseModel.setQty(const Value: Double);
begin
   fQty := value
end;

procedure TItemPurchaseModel.setSalePrice(const Value: Currency);
begin
   fSalePrice := value
end;

procedure TItemPurchaseModel.setStoreID(const Value: Integer);
begin
   fStoreID := value
end;

procedure TItemPurchaseModel.setSuggRetail(const Value: Currency);
begin
   fSuggRetail := value
end;

procedure TItemPurchaseModel.setUserID(const Value: Integer);
begin
   fUserID := value
end;

end.
