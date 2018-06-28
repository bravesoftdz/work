unit uSubModelWarranty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, StdCtrls, DBCtrls,
  dbcgrids, ExtCtrls;

type
  TSubModelWarranty = class(TParentSub)
    quModelWarranty: TADODataSet;
    dsModelWarranty: TDataSource;
    quModelWarrantyIDModel: TIntegerField;
    quModelWarrantyModel: TStringField;
    quModelWarrantyDescription: TStringField;
    quModelWarrantySellingPrice: TBCDField;
    quModelWarrantyCostPrice: TBCDField;
    quModelWarrantyModelDescr: TStringField;
    Label1: TLabel;
    cbxWarranty: TComboBox;
    quModelWarrantyReplacementCost: TBCDField;
    quModelWarrantyStoreSellingPrice: TBCDField;
    procedure quModelWarrantyAfterOpen(DataSet: TDataSet);
    procedure quModelWarrantyCalcFields(DataSet: TDataSet);
    procedure cbxWarrantyChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fIDModel,
    fIDModelSelected : Integer;
    fAmount  : Currency;
    fSellingPrice : Currency;
    procedure FillWarranty;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
    function GiveInfo(InfoString: String): String; override;
  end;

implementation

uses uDM, uParamFunctions, uMsgBox, uMsgConstant, uNumericFunctions, uSystemConst;

{$R *.dfm}

{ TSubModelWarranty }

procedure TSubModelWarranty.AfterSetParam;
begin
  inherited;

  fIDModel         := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
  fAmount          := MyStrToMoney(ParseParam(FParam, 'Amount'));
  fIDModelSelected := -1;

  if (fIDModel = 0) then
     begin
     NotifyChanges('Empty='+BoolToStr(False)+';');
     Exit;
     end;

  DataSetRefresh;

end;

procedure TSubModelWarranty.DataSetClose;
begin
  inherited;
  with quModelWarranty do
    if Active then
       Close;
end;

procedure TSubModelWarranty.DataSetOpen;
begin
  inherited;
  with quModelWarranty do
    if not Active then
       begin
       Parameters.ParamByName('IDModel').Value := fIDModel;
       Parameters.ParamByName('Amount').Value  := fAmount;
       Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
       Open;
       end;
end;

procedure TSubModelWarranty.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubModelWarranty.FillWarranty;
begin

   cbxWarranty.Clear;
   cbxWarranty.Items.AddObject('', Pointer(-1));

   with quModelWarranty do
     if Active then
        begin
        First;
        While not EOF do
          begin
          cbxWarranty.Items.AddObject(quModelWarrantyModelDescr.AsString, Pointer(quModelWarrantyIDModel.AsInteger));
          Next;
          end;
        end;

   cbxWarranty.ItemIndex := 1;
   cbxWarrantyChange(Self);
end;

procedure TSubModelWarranty.quModelWarrantyAfterOpen(DataSet: TDataSet);
var
  bHasID : Boolean;
begin
  inherited;
  bHasID := DataSet.RecordCount>0;
  NotifyChanges('Empty='+BoolToStr(bHasID)+';');
  if bHasID then
     FillWarranty;
end;

procedure TSubModelWarranty.quModelWarrantyCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quModelWarrantyStoreSellingPrice.AsCurrency <> 0 then
     fSellingPrice := quModelWarrantyStoreSellingPrice.AsCurrency
  else
     fSellingPrice := quModelWarrantySellingPrice.AsCurrency;

  quModelWarrantyModelDescr.AsString := '[' + quModelWarrantyModel.AsString + ' - ' +
                                              quModelWarrantyDescription.AsString + '] - ' +
                                              FormatFloat('#,##0.00', fSellingPrice);

end;

procedure TSubModelWarranty.cbxWarrantyChange(Sender: TObject);
var
  sResult : String;
begin
  inherited;

  fIDModelSelected := -1;

  if cbxWarranty.ItemIndex > 0 then
     fIDModelSelected := LongInt(cbxWarranty.Items.Objects[cbxWarranty.ItemIndex]);

  sResult := 'Empty='+BoolToStr(True)+';HasWarranty='+BoolToStr(fIDModelSelected<>-1)+';';
  NotifyChanges(sResult);

end;

function TSubModelWarranty.GiveInfo(InfoString: String): String;
begin

  Result := '';

  if fIDModelSelected = -1 then
     Exit;

  if quModelWarrantyStoreSellingPrice.AsCurrency <> 0 then
     fSellingPrice := quModelWarrantyStoreSellingPrice.AsCurrency
  else
     fSellingPrice := quModelWarrantySellingPrice.AsCurrency;

  if quModelWarranty.Locate('IDModel', fIDModelSelected, []) then
     Result := 'IDModel='   +quModelWarrantyIDModel.AsString      + ';' +
               'SalePrice=' +quModelWarrantySellingPrice.AsString + ';';

  if  DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
      Result := Result + 'CostPrice=' +quModelWarrantyReplacementCost.AsString+';'
  else
      Result := Result + 'CostPrice=' +quModelWarrantyCostPrice.AsString + ';';


end;

procedure TSubModelWarranty.FormDestroy(Sender: TObject);
begin
  DataSetClose;
  inherited;
end;

initialization
   RegisterClass(TSubModelWarranty);


end.
