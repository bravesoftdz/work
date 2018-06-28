unit uFrmAddItemCommission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Buttons, Mask, SuperComboADO, DB, ADODB, PowerADOQuery, uFrmPOSFunctions;

const
  SCREEN_TYPE_PRESALE  = 0;
  SCREEN_TYPE_INVOICE  = 1;
  SCREEN_TYPE_START_PRESALE = 3;

type
  TFrmAddItemCommission = class(TFrmParent)
    lbSalesPerson: TListBox;
    cmbSalesPerson: TSuperComboADO;
    Label7: TLabel;
    edPercent: TEdit;
    quSalesPerson: TPowerADOQuery;
    dsSalesPerson: TDataSource;
    quSalesPersonPessoa: TStringField;
    quSalesPersonIDPessoa: TIntegerField;
    quSalesPersonCommissionPercent: TBCDField;
    quName: TADODataSet;
    quNamePessoa: TStringField;
    lbPercent: TLabel;
    btRemove: TBitBtn;
    btAdd: TBitBtn;
    btApplyAll: TSpeedButton;
    btOK: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure quSalesPersonAfterOpen(DataSet: TDataSet);
    procedure btCloseClick(Sender: TObject);
    procedure edPercentKeyPress(Sender: TObject; var Key: Char);
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FScreenType : Integer;
    procedure AddCommisList;
    function AddItem(IDSalesPerson: String; Percent: Real): Boolean;
    function GetName(ID: String): String;
    function VerifyLimitPercentage(Percent: Real): Boolean;
    function VerifyPercentage: Boolean;
    function VerifyExactlySalesPerson(IDSalesPerson: String):Boolean;
    function GetPercentRemain: String;
  public
    SalesPerson: TSalesPerson;
    MyIDPreInventoryMov: Integer;
    procedure Start(iScreenType: Integer; var AApplyAll: Boolean);
  end;

implementation

uses uDM, uMsgBox, uCharFunctions, uMsgConstant;

{$R *.dfm}

function TFrmAddItemCommission.AddItem(IDSalesPerson: String; Percent:Real): Boolean;
var Name : String;
begin
 Result := False;

 if (lbSalesPerson.Items.IndexOf(IDSalesPerson)=-1) then
    begin
    SalesPerson := TSalesPerson.Create;
    SalesPerson.IDPessoa := StrtoInt(IDSalesPerson);
    SalesPerson.Pessoa   := GetName(IDSalesPerson);
    SalesPerson.Percent  := Percent;
    DM.fPOS.fCommisList.AddObject(SalesPerson.Pessoa + ' - ' + FloattoStr(SalesPerson.Percent) + '%',SalesPerson);
    lbSalesPerson.Items.AddObject(SalesPerson.Pessoa + ' - ' + FloattoStr(SalesPerson.Percent) + '%',SalesPerson);
    Result := True;
    end;
end;

procedure TFrmAddItemCommission.btAddClick(Sender: TObject);
var test : string;
begin
  if (edPercent.Text <> '')
     and (edPercent.Text <> '0')
     and (cmbSalesPerson.LookUpValue <> '') then
   begin
    if not VerifyLimitPercentage(StrToFloat(edPercent.Text)) then
     begin
      MsgBox(MSG_INF_INV_TOT_COMMIS_PERCENT, vbOKOnly + vbInformation);
      Exit;
     end;

    if not VerifyExactlySalesPerson(cmbSalesPerson.LookUpValue) then
     begin
      MsgBox(MSG_INF_EXAC_SALESPERSON_COMMIS, vbOKOnly + vbInformation);
      Exit;
     end;

    if Additem(cmbSalesPerson.LookUpValue,StrtoFloat(edPercent.Text)) then
     begin
      edPercent.Clear;
      edPercent.SetFocus;
     end;
     edPercent.Text := GetPercentRemain;
   end;
end;

procedure TFrmAddItemCommission.btRemoveClick(Sender: TObject);
var
  Friend, Friend2: TSalesPerson;
begin
  if lbSalesPerson.ItemIndex >= 0 then
  begin
    Friend  := TSalesPerson(lbSalesPerson.Items.Objects[lbSalesPerson.ItemIndex]);
    if Friend <> Nil then
      Friend.Free;

    DM.fPOS.fCommisList.Delete(lbSalesPerson.ItemIndex);

    lbSalesPerson.DeleteSelected;
    edPercent.Text := GetPercentRemain;
  end;
end;

procedure TFrmAddItemCommission.Start(iScreenType: Integer; var AApplyAll: Boolean);
var
  SalesPerson: TSalesPerson;
begin
  FScreenType := iScreenType;

  btApplyAll.Visible := FScreenType = SCREEN_TYPE_INVOICE;

  if FScreenType = SCREEN_TYPE_START_PRESALE then
  begin
    cmbSalesPerson.LookUpValue := '';
    cmbSalesPerson.LookUpValue := IntToStr(DM.fUser.IDCommission);
    edPercent.Text := '100';
    lbSalesPerson.Clear;
    DM.fPOS.ClearCommissionList;
  end
  else
  begin
    if DM.fPOS.fCommisList <> nil then
    begin
      if DM.fPOS.fCommisList.Count > 1 then
        AddCommisList
      else
        DM.fPOS.ClearCommissionList;
    end;

    cmbSalesPerson.LookUpValue := '';
    edPercent.Text := GetPercentRemain;
    lbSalesPerson.Items := DM.fPOS.fCommisList;
  end;


  ShowModal;
  AApplyAll := btApplyAll.Down;
end;

procedure TFrmAddItemCommission.quSalesPersonAfterOpen(DataSet: TDataSet);
begin
  lbSalesPerson.Items.Clear;
  lbSalesPerson.Items.DelimitedText := quSalesPersonPessoa.AsString + ':' + quSalesPersonCommissionPercent.AsString;
  edPercent.Text := '';
end;

function TFrmAddItemCommission.GetName(ID: String): String;
begin
  with quName do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := StrtoInt(ID);
    Open;
  end;

  Result :=  quNamePessoa.AsString;
end;

procedure TFrmAddItemCommission.btCloseClick(Sender: TObject);
begin
  DM.fPOS.ClearCommissionList;
  Close;
end;

function TFrmAddItemCommission.VerifyLimitPercentage(Percent: Real): Boolean;
var
  i: Integer;
  TotalPercent: Real;
begin
  Result := False;

  TotalPercent := Percent;
  for i := 0 to lbSalesPerson.Items.Count - 1 do
    TotalPercent := TSalesPerson(lbSalesPerson.Items.Objects[I]).Percent + TotalPercent;

  if TotalPercent <= 100 then
    Result := True;
end;

procedure TFrmAddItemCommission.edPercentKeyPress(Sender: TObject; var Key: Char);
begin
  Key :=  ValidateNumbers(Key);
end;

procedure TFrmAddItemCommission.AddCommisList;
var i: Integer;
begin
  lbSalesPerson.Clear;

  for i:=0 to DM.fPOS.fCommisList.Count - 1 do
  begin
    SalesPerson := TSalesPerson.Create;
    SalesPerson.IDPessoa := TSalesPerson(DM.fPOS.fCommisList.Objects[I]).IDPessoa;
    SalesPerson.Pessoa   := TSalesPerson(DM.fPOS.fCommisList.Objects[I]).Pessoa;
    SalesPerson.Percent  := TSalesPerson(DM.fPOS.fCommisList.Objects[I]).Percent;
    lbSalesPerson.Items.AddObject(SalesPerson.Pessoa + ' - ' + FloattoStr(SalesPerson.Percent) + '%',SalesPerson);
  end;
end;

function TFrmAddItemCommission.VerifyPercentage: Boolean;
var
  i: Integer;
  TotalPercent: Real;
begin
  Result := False;

  TotalPercent := 0;
  for i := 0 to lbSalesPerson.Items.Count - 1 do
    TotalPercent := TSalesPerson(lbSalesPerson.Items.Objects[I]).Percent + TotalPercent;

  Result := TotalPercent = 100;
end;

procedure TFrmAddItemCommission.btOKClick(Sender: TObject);
begin

  if (FScreenType = SCREEN_TYPE_START_PRESALE) and
     ((edPercent.Text = '100') and
      (lbSalesPerson.Items.Count = 0) and
      (cmbSalesPerson.LookUpValue = IntToStr(DM.fUser.IDCommission))) then
        AddItem(cmbSalesPerson.LookUpValue,StrtoFloat(edPercent.Text));

  if (VerifyPercentage) then
    ModalResult := mrOk
  else
    MsgBox(MSG_INF_INV_TOT_COMMIS_PERCENT, vbOKOnly + vbInformation);
end;

function TFrmAddItemCommission.VerifyExactlySalesPerson(IDSalesPerson: String): Boolean;
var
  i: Integer;
begin
  Result := True;

  for i := 0 to lbSalesPerson.Items.Count - 1 do
    if TSalesPerson(lbSalesPerson.Items.Objects[I]).IDPessoa = StrtoInt(IDSalesPerson) then
      Result := False;
end;

function TFrmAddItemCommission.GetPercentRemain: String;
var
  i: Integer;
  PercentRemain: Real;
begin
  PercentRemain := 0;
  for i := 0 to lbSalesPerson.Items.Count - 1 do
    PercentRemain := TSalesPerson(lbSalesPerson.Items.Objects[I]).Percent + PercentRemain;

  Result := FloattoStr(100 - PercentRemain);
end;

procedure TFrmAddItemCommission.FormShow(Sender: TObject);
begin
  inherited;
  cmbSalesPerson.SetFocus;
end;

end.
