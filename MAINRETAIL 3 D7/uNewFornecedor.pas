(*
-----------------------------------------------------------------------------------------------------
Version : (288 - 279)
Date    : 01.28.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : wrong format to decimal places
Solution: I pointed correct parameters
Version : (288 - 280)
-----------------------------------------------------------------------------------------------------
*)

unit uNewFornecedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Buttons, Variants,
  SuperComboADO, siComp, siLangRT, Grids, DBGrids, SMDBGrid, DB, ADODB,
  SuperEdit, SuperEditCurrency;

type
  TNewFornecedor = class(TFrmParentAll)
    btOK: TButton;
    cmbFornecedor: TSuperComboADO;
    Label1: TLabel;
    edQtyToOrder: TEdit;
    lbQtyToOrder: TLabel; // Antonio 2013 Dec 04, MR-127
    lbNeedQty: TLabel;
    lbQtyType: TLabel;
    Label2: TLabel;
    edCaseQty: TEdit;
    Panel17: TPanel;
    btnDelVCode: TSpeedButton;
    btAddVendorCode: TSpeedButton;
    pnlVendorCode: TPanel;
    grdVendorCode: TSMDBGrid;
    quVendorCode: TADOQuery;
    quVendorCodeIDVendorModelCode: TIntegerField;
    quVendorCodeIDPessoa: TIntegerField;
    quVendorCodeIDModel: TIntegerField;
    quVendorCodeVendor: TStringField;
    quVendorCodeVendorCode: TStringField;
    dsVendorCode: TDataSource;
    quModelVendorInfo: TADOQuery;
    quModelVendorInfoVendorOrder: TIntegerField;
    quModelVendorInfoMinQtyPO: TFloatField;
    quModelVendorInfoCaseQty: TFloatField;
    lbVendorCost: TLabel;
    edtVendorCost: TSuperEditCurrency;
    edtDate: TEdit;
    quModelVendorInfoVendorCost: TBCDField;
    quModelVendorInfoCostLastChange: TDateTimeField;
    cbxDoNotOrder: TCheckBox;
    quModelVendorInfoDoNotOrder: TBooleanField;
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbFornecedorSelectItem(Sender: TObject);
    procedure edQtyToOrderKeyPress(Sender: TObject; var Key: Char);
    procedure btAddVendorCodeClick(Sender: TObject);
    procedure btnDelVCodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtVendorCostKeyPress(Sender: TObject; var Key: Char);
  private
    FIDVendor,
    FIDModel: Integer;
    FIsNew : Boolean;
    FquModelVendor : TADOQuery;
    function ValidateQtyMinimum: Boolean;
    procedure OpenVendorModelCode;
    procedure CloseVendorModelCode;
    procedure RefreshVendorCode;
    procedure OpenVendorInfor;
    procedure CloseVendorInfor;
  public
    function Start(IDVendor, IDModel: Integer; AquModelVendor : TADOQuery) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uCharFunctions, uNewFornecedorCode,
     uNumericFunctions;

{$R *.DFM}

function TNewFornecedor.Start(IDVendor, IDModel: Integer; AquModelVendor : TADOQuery) : Boolean;
begin
  FIDVendor := IDVendor;
  FIDModel  := IDModel;
  FIsNew    := (IDVendor = -1);
  FquModelVendor := AquModelVendor;
  cmbFornecedor.LookUpValue := '';

  if not FIsNew then
  begin
    cmbFornecedor.ReadOnly := True;
    cmbFornecedor.Enabled  := False;
    cmbFornecedor.LookUpValue := IntToStr(IDVendor);
    RefreshVendorCode;
    OpenVendorInfor;
    CloseVendorInfor;
  end;

  Result := (ShowModal = mrOK);

end;

procedure TNewFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  if FIsNew then
    cmbFornecedor.SetFocus
  else
    edQtyToOrder.SetFocus;

  //amfsouza 01.28.2011 - to correct format.
  edtVendorCost.DisplayFormat := DM.FQtyDecimalFormat;
end;

procedure TNewFornecedor.btOKClick(Sender: TObject);
var
  QtyToOrder, CaseQty : Double;
  VendorCost, CostDate : String;
  iOrder : Integer;
  sSQL : String;
  DoNotOrder: Byte; //YAA April 30th, 2012: Added
begin
  inherited;

  if cmbFornecedor.LookUpValue = '' then
    begin
     MsgBox(MSG_CRT_NO_VENDOR, vbOKOnly + vbInformation);
     Exit;
    end;

  if not ValidateQtyMinimum then
    Exit;

  try
    VendorCost := MyFormatCur(StrToFloat(edtVendorCost.Text), '.')
  except
    VendorCost := 'NULL';
    CostDate := QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm', Now));
    end;

  try
    CostDate := QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm', StrToDateTime(edtDate.Text)));
  except
    CostDate := 'GetDate()';
    end;

  //*** YAA April 30th, 2012: Added. To be used in the queries below ***
  if cbxDoNotOrder.Checked then
    DoNotOrder:= 1
  else
    DoNotOrder:= 0;
  //********************************************************************

  if FIsNew then
  begin
    if StrToIntDef(cmbFornecedor.LookUpValue, 0) <> 0 then
    begin
       if not FquModelVendor.Active then
       begin
         FquModelVendor.Parameters.ParamByName('IDModel').Value := FIDModel;
         FquModelVendor.Open;
       end;
       FquModelVendor.First;
       FIDVendor  := StrToInt(cmbFornecedor.LookUpValue);
       QtyToOrder := MyStrToDouble(edQtyToOrder.Text);
       CaseQty    := MyStrToDouble(edCaseQty.Text);
       if not FquModelVendor.Locate('IDModel;IDPessoa', VarArrayOf([IntToStr(FIDModel), IntToStr(FIDVendor)]), []) then
       begin
         FquModelVendor.Last;
         iOrder := FquModelVendor.FieldByName('VendorOrder').AsInteger + 1;

         //YAA April 30th, 2012: This query is to be replaced with the one below
         //sSQL := 'INSERT Inv_ModelVendor (IDModel, IDPessoa, VendorOrder, MinQtyPO, CaseQty, VendorCost, CostLastChange) ' +
         //        ' VALUES ( ' + IntToStr(FIDModel) + ' , ' +
         //                     IntToStr(FIDVendor) + ' , ' +
         //                     IntToStr(iOrder) + ' , ' + MyFormatCur(QtyToOrder, '.') + ' , ' + MyFormatCur(CaseQty, '.') + ' , ' + VendorCost +' , ' + CostDate +' ) ';

         //YAA April 30th, 2012: This query replaced the one above
         sSQL := 'INSERT Inv_ModelVendor (IDModel, IDPessoa, VendorOrder, MinQtyPO, CaseQty, VendorCost, CostLastChange, DoNotOrder) ' +
                 ' VALUES ( ' + IntToStr(FIDModel) + ' , ' +
                              IntToStr(FIDVendor) + ' , ' +
                              IntToStr(iOrder) + ' , ' + MyFormatCur(QtyToOrder, '.') + ' , ' + MyFormatCur(CaseQty, '.') + ' , ' + VendorCost +' , ' + CostDate +' , ' + IntToStr(DoNotOrder)  +' ) ';


         DM.RunSQL(sSQL);
       end;
    end;
  end
  else
  begin
    QtyToOrder := MyStrToDouble(edQtyToOrder.Text);
    CaseQty    := MyStrToDouble(edCaseQty.Text);
    sSQL := 'UPDATE Inv_ModelVendor ' +
           ' SET MinQtyPO = ' + MyFormatCur(QtyToOrder, '.') +
           ' ,CaseQty = ' + FloatToStr(CaseQty) +
           ' ,VendorCost = ' + VendorCost +
           ' ,CostLastChange = ' + CostDate +
           ' ,DoNotOrder = ' + IntToStr(DoNotOrder) + //YAA April 30th, 2012: Added one more field to update
           ' WHERE IDModel = ' + IntToStr(FIDModel) +
           ' AND IDPessoa = ' + IntToStr(FIDVendor);
    DM.RunSQL(sSQL);
  end;

  ModalResult := mrOK;

end;

function TNewFornecedor.ValidateQtyMinimum: Boolean;
begin
  Result := False;

  if (edQtyToOrder.Text = '0') or (edQtyToOrder.Text = '') then
    begin
     MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbOKOnly + vbInformation);
     edQtyToOrder.SetFocus;
     Exit;
    end;

  Result := True;
end;

procedure TNewFornecedor.btCloseClick(Sender: TObject);
var
  sSQL : String;
begin
  inherited;

  if FIsNew then
  begin
    sSQL := 'DELETE VendorModelCode WHERE IDPessoa = ' + IntToStr(FIDVendor) +
            ' AND IDModel = ' + IntToStr(FIDModel);
    DM.RunSQL(sSQL);
  end;


  ModalResult := mrCancel;
end;

procedure TNewFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseVendorInfor;
  CloseVendorModelCode;
  Action := caFree;
end;

procedure TNewFornecedor.cmbFornecedorSelectItem(Sender: TObject);
begin
  inherited;

  if cmbFornecedor.Text <> '' then
     btOK.Enabled := True;

end;

procedure TNewFornecedor.edQtyToOrderKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key :=  ValidateQty(Key);
end;

procedure TNewFornecedor.btAddVendorCodeClick(Sender: TObject);
begin
  inherited;

  FIDVendor := StrToIntDef(cmbFornecedor.LookUpValue, 0);

  if FIDVendor <> 0 then
    with TNewFornecedorCode.Create(Self) do
      if Start(FIDModel, FIDVendor) then
      begin
         RefreshVendorCode;
         cmbFornecedor.ReadOnly := True;
         cmbFornecedor.Enabled  := False;
      end;

end;

procedure TNewFornecedor.btnDelVCodeClick(Sender: TObject);
begin
  inherited;

  if (quVendorCode.Active) and (quVendorCodeIDVendorModelCode.AsInteger <> 0) then
  begin
    DM.RunSQL('DELETE VendorModelCode WHERE IDVendorModelCode = ' + quVendorCodeIDVendorModelCode.AsString);
    RefreshVendorCode;
  end;

end;

procedure TNewFornecedor.CloseVendorModelCode;
begin

  with quVendorCode do
    if Active then
      Close;
      
end;

procedure TNewFornecedor.OpenVendorModelCode;
begin

  with quVendorCode do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := FIDModel;
      Parameters.ParamByName('IDVendor').Value := FIDVendor;
      Open;
    end;

end;

procedure TNewFornecedor.RefreshVendorCode;
begin
  CloseVendorModelCode;
  OpenVendorModelCode;
end;

procedure TNewFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddVendorCode.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDelVCode.Glyph);
end;

procedure TNewFornecedor.CloseVendorInfor;
begin
  with quModelVendorInfo do
    if Active then
      Close;
end;

procedure TNewFornecedor.OpenVendorInfor;
begin
  with quModelVendorInfo do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := FIDModel;
      Parameters.ParamByName('IDVendor').Value := FIDVendor;
      Open;
      if not IsEmpty then
      begin
        edQtyToOrder.Text  := quModelVendorInfoMinQtyPO.AsString;

        //*** YAA April 30th, 2012: Added
        cbxDoNotOrder.Checked:= quModelVendorInfoDoNotOrder.Value;
        //**************************

        edCaseQty.Text     := quModelVendorInfoCaseQty.AsString;
        edtVendorCost.Text := FormatFloat('#,##0.00', quModelVendorInfoVendorCost.AsCurrency);
        edtDate.Text       := FormatDateTime('ddddd hh:nn', quModelVendorInfoCostLastChange.AsDateTime);
      end;
    end;
end;

procedure TNewFornecedor.edtVendorCostKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  edtDate.Text := FormatDateTime('ddddd hh:nn', Now);
end;

end.
