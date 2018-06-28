unit uFchTaxCategory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, FormConfig, Db, DBTables, Variants,
  LblEffct, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, DateBox,
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT, Grids, DBGrids,
  SMDBGrid, ComCtrls, SuperComboADO, CalcExpress, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, cxDBEdit;

type
  TFchTaxCategory = class(TbrwFrmParent)
    quFormIDTaxCategory: TIntegerField;
    quFormSpecialDateStart: TDateTimeField;
    quFormSpecialDateEnd: TDateTimeField;
    quFormTax: TFloatField;
    quFormSpecialTax: TFloatField;
    quFormTaxCategory: TStringField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormTaxExempt: TBooleanField;
    quFormMaxItemValue: TFloatField;
    quSubTax: TADOQuery;
    dsSubTax: TDataSource;
    quSubTaxTaxCategory: TStringField;
    quSubTaxTax: TBCDField;
    quSubTaxIDTaxCategory: TIntegerField;
    quSubTaxIDTaxCategoryParent: TIntegerField;
    quFormIDTaxCategoryParent: TIntegerField;
    pgTax: TPageControl;
    tsSaleCharge: TTabSheet;
    tsSaleTax: TTabSheet;
    tsPurchase: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    btNew: TSpeedButton;
    btDelete: TSpeedButton;
    btPost: TSpeedButton;
    btCancelPost: TSpeedButton;
    dbedtTaxCategoty: TDBEdit;
    dbedtTax: TDBEdit;
    dbedtSpecialTax: TDBEdit;
    DBDateBox1: TDBDateBox;
    DBDateBox2: TDBDateBox;
    DBCheckBox1: TDBCheckBox;
    dbedtMaxValue: TDBEdit;
    grdSubTax: TSMDBGrid;
    quFormOperationType: TIntegerField;
    quFormSaleTaxType: TIntegerField;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit2: TDBEdit;
    Label11: TLabel;
    quFormIDLancamentoTipo: TIntegerField;
    quFormFormula: TStringField;
    quFormDebit: TBooleanField;
    DBRadioGroup2: TDBRadioGroup;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBSuperComboADO1: TDBSuperComboADO;
    DBRadioGroup1: TDBRadioGroup;
    memFormula: TMemo;
    TestFormula: TCalcExpress;
    pnlFormula: TPanel;
    btnMultiplay: TSpeedButton;
    btnDivide: TSpeedButton;
    btnSubtract: TSpeedButton;
    btnAdd: TSpeedButton;
    btnParent1: TSpeedButton;
    btnParent2: TSpeedButton;
    btnSpace: TSpeedButton;
    btnPercent: TSpeedButton;
    btnFreight: TSpeedButton;
    btnCost: TSpeedButton;
    btnOther: TSpeedButton;
    btnClear: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    btnShowFormula: TSpeedButton;
    btnTest: TSpeedButton;
    scTaxPurc: TSuperComboADO;
    btnAddTax: TSpeedButton;
    Label19: TLabel;
    quFormSituacaoTributaria: TIntegerField;
    cbxSituacaoTrib: TcxDBImageComboBox;
    chkExemptTax: TDBCheckBox;
    btnMVA: TSpeedButton;
    btnDelete: TSpeedButton;
    btnDiscount: TSpeedButton;
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure quSubTaxAfterEdit(DataSet: TDataSet);
    procedure quSubTaxNewRecord(DataSet: TDataSet);
    procedure dsSubTaxStateChange(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quSubTaxAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnMultiplayClick(Sender: TObject);
    procedure btnSpaceClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnPercentClick(Sender: TObject);
    procedure btnCostClick(Sender: TObject);
    procedure btnFreightClick(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure btnShowFormulaClick(Sender: TObject);
    procedure btnAddTaxClick(Sender: TObject);
    procedure btnMVAClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDiscountClick(Sender: TObject);
  private
    { Private declarations }
    fOperationTaxType,
    fSaleTaxType : Integer;

    procedure RefreshTaxType;

    procedure SubTaxRefresh;
    procedure SubTaxPost;
    procedure SubTaxCancel;
    procedure SubTaxOpen;
    procedure SubTaxClose;

    function CalcTotalSubTax:Currency;

    procedure quFormEdit;
    procedure AddFormula(s:String);
  protected
    procedure OnBeforeStart; override;

  public
    { Public declarations }
  end;

implementation

uses uDMGlobal, uDM, uMsgBox, uMsgConstant, uSystemConst, uParamFunctions,
     uSystemTypes, uNumericFunctions, uCharFunctions;

{$R *.DFM}

function TFchTaxCategory.CalcTotalSubTax:Currency;
begin
  with DM.quFreeSQL do
     begin
     if Active then
        Close;
     SQL.Text := 'SELECT Sum(T.Tax) as Tax FROM TaxCategory T WHERE T.IDTaxCategoryParent = ' + quFormIDTaxCategory.AsString;
     Open;
     Result := FieldByName('Tax').AsCurrency;
     Close;
     end;
end;

procedure TFchTaxCategory.SubTaxRefresh;
begin
  SubTaxClose;
  SubTaxOpen;
end;

procedure TFchTaxCategory.SubTaxPost;
begin
  with quSubTax do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TFchTaxCategory.SubTaxCancel;
begin
  with quSubTax do
    if Active then
      if State in dsEditModes then
        Cancel;
end;

procedure TFchTaxCategory.SubTaxOpen;
begin
  with quSubTax do
    if not Active then
       begin
       Parameters.ParamByName('IDTaxCategory').Value := quFormIDTaxCategory.AsInteger;
       Open;
       end;
end;

procedure TFchTaxCategory.SubTaxClose;
begin
  with quSubTax do
    if Active then
       Close;
end;


procedure TFchTaxCategory.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  If quFormMaxItemValue.AsInteger = 0 then
     quFormMaxItemValue.Clear;
end;

procedure TFchTaxCategory.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(2110);
end;

procedure TFchTaxCategory.quSubTaxAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchTaxCategory.quSubTaxNewRecord(DataSet: TDataSet);
begin
  inherited;
  quSubTaxIDTaxCategory.AsInteger       := DM.GetNextID(MR_TAX_CATEG_ID);
  quSubTaxIDTaxCategoryParent.AsInteger := quFormIDTaxCategory.AsInteger;
end;

procedure TFchTaxCategory.dsSubTaxStateChange(Sender: TObject);
begin
  inherited;

  if fIsRestricForm then
     Exit;

  btNew.Enabled := quSubTax.Active;

  with quSubTax do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quSubTax.State in dsEditModes);
  btDelete.Visible := not (quSubTax.State in dsEditModes);

  btPost.Visible := (quSubTax.State in dsEditModes);
  btCancelPost.Visible := (quSubTax.State in dsEditModes);


end;

procedure TFchTaxCategory.btNewClick(Sender: TObject);
begin
  inherited;
  quSubTax.Insert;
  quSubTaxTaxCategory.FocusControl;
end;

procedure TFchTaxCategory.btDeleteClick(Sender: TObject);
begin
  inherited;

  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
     begin
     quSubTax.Delete;
     dsSubTaxStateChange(Nil);
     end;

end;

procedure TFchTaxCategory.btPostClick(Sender: TObject);
begin
  inherited;
  SubTaxPost;
  SubTaxRefresh;
end;

procedure TFchTaxCategory.btCancelPostClick(Sender: TObject);
begin
  inherited;
  SubTaxCancel;
end;

procedure TFchTaxCategory.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  if pgTax.ActivePage = tsSaleCharge then
     SubTaxClose;
end;

procedure TFchTaxCategory.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  //Quando e atualizado pelo LookUp
  if (frmCommand <> btInc) and ((fOperationTaxType = 0) or (fSaleTaxType = 0)) then
     begin
     fOperationTaxType := quFormOperationType.AsInteger;
     fSaleTaxType      := quFormSaleTaxType.AsInteger;
     RefreshTaxType;
     end;

  if pgTax.ActivePage = tsSaleCharge then
     SubTaxOpen;

  memFormula.Text := quFormFormula.AsString;

end;

procedure TFchTaxCategory.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDTaxCategoryParent.AsInteger := 0;
  quFormSituacaoTributaria.AsInteger  := 0;
  quFormDebit.AsBoolean               := False;
  quFormOperationType.AsInteger       := fOperationTaxType;
  if fOperationTaxType = TAX_OP_TYPE_SALE then
     quFormSaleTaxType.AsInteger := fSaleTaxType;
end;

procedure TFchTaxCategory.quSubTaxAfterPost(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
  quFormTax.AsCurrency := CalcTotalSubTax;
end;

procedure TFchTaxCategory.FormCreate(Sender: TObject);
begin
  inherited;

  cbxSituacaoTrib.Visible := (DMGlobal.IDLanguage = LANG_PORTUGUESE);

  if fIsRestricForm then
     begin
     btNew.Visible           := False;
     btDelete.Visible        := False;
     btPost.Visible          := False;
     btCancelPost.Visible    := False;
     end;

end;

procedure TFchTaxCategory.OnBeforeStart;
begin
  inherited;
  if not (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE]) then
     begin
     fOperationTaxType := 1;
     fSaleTaxType      := 1;
     end
  else
     begin
     fOperationTaxType := StrToIntDef(ParseParam(sParam,'OPType'),0);
     fSaleTaxType      := StrToIntDef(ParseParam(sParam,'STType'),0);
     end;
  RefreshTaxType;
end;

procedure TFchTaxCategory.RefreshTaxType;
begin

   tsPurchase.TabVisible           := False;
   tsSaleTax.TabVisible            := False;
   tsSaleCharge.TabVisible         := False;
   quFormIDLancamentoTipo.Required := False;

  if fOperationTaxType = TAX_OP_TYPE_SALE then
     begin
     if fSaleTaxType = SALE_TAX_TYPE_CHARGE then
        tsSaleCharge.TabVisible := True
     else
        tsSaleTax.TabVisible    := True;
     end
  else
     begin
     tsPurchase.TabVisible := True;
     quFormIDLancamentoTipo.Required := True;
     end;
end;


procedure TFchTaxCategory.btnMultiplayClick(Sender: TObject);
begin
  inherited;
  AddFormula(TSpeedButton(Sender).Caption);
end;

procedure TFchTaxCategory.btnSpaceClick(Sender: TObject);
begin
  inherited;
  AddFormula(' ');
end;

procedure TFchTaxCategory.btnClearClick(Sender: TObject);
begin
  inherited;
  memFormula.Clear;
  quFormEdit;
  quFormFormula.AsString := '';
end;

procedure TFchTaxCategory.btnPercentClick(Sender: TObject);
begin
  inherited;
  AddFormula(PUR_PERCENT);
end;

procedure TFchTaxCategory.btnCostClick(Sender: TObject);
begin
  inherited;
  AddFormula(PUR_COST);
end;

procedure TFchTaxCategory.btnFreightClick(Sender: TObject);
begin
  inherited;
  AddFormula(PUR_FREIGHT);
end;

procedure TFchTaxCategory.btnOtherClick(Sender: TObject);
begin
  inherited;
  AddFormula(PUR_OTHER);
end;

procedure TFchTaxCategory.quFormEdit;
begin
  with quForm do
     if Active then
        if not (State in dsEditModes) then
           edit;
end;

procedure TFchTaxCategory.AddFormula(s: String);
begin
  memFormula.SelText := s;
  memFormula.SetFocus;
  quFormEdit;
  quFormFormula.AsString := memFormula.Text;
end;

procedure TFchTaxCategory.btnTestClick(Sender: TObject);
var
  args : array [0..100] of extended; // array of arguments - variable values
  sResult, MyMSG, MyMSG1, Formula : String;
  fConst : TStringList;
  Decim : Char;
  i : Integer;
  sTax : String;
begin
  inherited;

  //Test Formula
  if Trim(memFormula.Text) = '' then
     Exit;

  try

    fConst := TStringList.Create;

    Decim := DecimalSeparator;
    DecimalSeparator := '.';

    //tratar a formula
    Formula := memFormula.Text;
    While Pos('[', Formula) > 0 do
      begin
      sTax := '';
      for i := Pos('[', Formula) to length(Formula) do
         begin
         sTax := sTax + Copy(Formula, i, 1);
         if Formula[i] = ']' then
            Break;
         end;
      MyMSG1  := MyMSG1 + sTax + ' = 10' + #13#10;
      Formula := StringReplace(Formula, sTax, '10', [rfReplaceAll]);
      end;

    // set expression to calculate
    TestFormula.Formula := Formula;

    // set used variables list
    fConst.Add(PUR_COST);
    fConst.Add(PUR_FREIGHT);
    fConst.Add(PUR_OTHER);
    fConst.Add(PUR_PERCENT);
    fConst.Add(PUR_MVA);
    fConst.Add(PUR_DISCOUNT);
    TestFormula.Variables := fConst;

    // prepare arguments
    // SetLength(args,Values.Lines.Count);
    args[0] := 1000; //Cost
    args[1] := 50;  //Freigh
    args[2] := 10;   //Other
    args[3] := (MyStrToMoney(quFormTax.AsString)/100); //Percent
    args[4] := (50/100); //MVA
    args[5] := 3; //Disount

    sResult := FloatToStr(TestFormula.calc(args));

  finally
     FreeAndNil(fConst);
     DecimalSeparator := Decim;
     end;

  MyMSG := 'Formula ' + memFormula.Text + '_';
  MyMSG := MyMSG + 'C = ' + FloatToStr(args[0]) + #13#10;
  MyMSG := MyMSG + 'F = ' + FloatToStr(args[1]) + #13#10;
  MyMSG := MyMSG + 'O = ' + FloatToStr(args[2]) + #13#10;
  MyMSG := MyMSG + 'P = ' + FloatToStr(args[3]) + #13#10;
  MyMSG := MyMSG + 'M = ' + FloatToStr(args[4]) + #13#10;
  MyMSG := MyMSG + 'D = ' + FloatToStr(args[5]) + #13#10;
  MyMSG := MyMSG + MyMSG1;
  MyMSG := MyMSG + '(=) ' + sResult             + #13#10;

  MsgBox(MyMSG, vbOKOnly + vbInformation);

end;

procedure TFchTaxCategory.SpeedButton12Click(Sender: TObject);
begin
  inherited;
  memFormula.Lines.Delete(memFormula.SelStart-1);
end;

procedure TFchTaxCategory.btnShowFormulaClick(Sender: TObject);
begin
  inherited;
  pnlFormula.Visible := not pnlFormula.Visible;
  scTaxPurc.Visible := pnlFormula.Visible;
  btnAddTax.Visible := pnlFormula.Visible;
  btnTest.Visible   := pnlFormula.Visible;
end;

procedure TFchTaxCategory.btnAddTaxClick(Sender: TObject);
begin
  inherited;
  if (scTaxPurc.LookUpValue = '') or (scTaxPurc.LookUpValue = quFormIDTaxCategory.AsString) then
     Exit;

  AddFormula('['+scTaxPurc.LookUpValue+']');

end;

procedure TFchTaxCategory.btnMVAClick(Sender: TObject);
begin
  inherited;
  AddFormula(PUR_MVA);
end;

procedure TFchTaxCategory.btnDeleteClick(Sender: TObject);
var
  S: string;
  iPos : Integer;
begin
  inherited;
  S := memFormula.Text;
  iPos := memFormula.SelStart;
  Delete(S, iPos+1, 1);
  memFormula.Text := S;
  memFormula.SelStart := iPos;
  quFormEdit;
  quFormFormula.AsString := memFormula.Text;
end;

procedure TFchTaxCategory.btnDiscountClick(Sender: TObject);
begin
  inherited;
  AddFormula(PUR_DISCOUNT);
end;

end.
