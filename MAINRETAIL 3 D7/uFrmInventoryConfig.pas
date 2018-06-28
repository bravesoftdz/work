unit uFrmInventoryConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, DB, ADODB, Mask, SuperComboADO;

type
  TFrmInventoryConfig = class(TFrmParentAll)
    PageControl1: TPageControl;
    tsCurveABC: TTabSheet;
    tsAutoReq: TTabSheet;
    btnOK: TButton;
    Label8: TLabel;
    edtSalesPeriodo: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edtPurchaseClassA: TEdit;
    edtPurchaseClassB: TEdit;
    edtPurchaseClassC: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtMarginClassA: TEdit;
    edtMarginClassB: TEdit;
    edtMarginClassC: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    quPropertyDomain: TADODataSet;
    cmdUpdPropertyDomain: TADOCommand;
    lbStoreToAutoRequest: TLabel;
    scStore: TSuperComboADO;
    btnStoreAll: TButton;
    gbxClassesRequest: TGroupBox;
    chxClassA: TCheckBox;
    chxClassB: TCheckBox;
    chxClassC: TCheckBox;
    lblClassRequest: TLabel;
    GroupBox3: TGroupBox;
    lbPeriod: TLabel;
    edtPeriod: TEdit;
    Label14: TLabel;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtClassAPerc: TEdit;
    edtClassBPerc: TEdit;
    edtClassCPerc: TEdit;
    Label13: TLabel;
    GroupBox5: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    cbxCalcType: TComboBox;
    gbDefaulLeadTime: TGroupBox;
    lbLeadDesc: TLabel;
    lbLeadTime: TLabel;
    edtLeadTime: TEdit;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtPeriodKeyPress(Sender: TObject; var Key: Char);
    procedure btnStoreAllClick(Sender: TObject);
  private
    procedure OpenPropertyDomain;
    procedure ClosePropertyDomain;
    procedure SavePropertyDomain;

    procedure LoadProperties;
    function Validate: Boolean;
  public
    function Start: Boolean;
  end;

implementation

uses uDM, uCharFunctions, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFrmInventoryConfig.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmInventoryConfig.ClosePropertyDomain;
begin
  with quPropertyDomain do
    if Active then
      Close;
end;

procedure TFrmInventoryConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ClosePropertyDomain;
  Action := caFree;
end;

procedure TFrmInventoryConfig.LoadProperties;
begin
  with quPropertyDomain do
    if Active then
      while not Eof do
      begin
        if FieldByName('Property').AsString = 'ABCCalcPeriodInMonth' then
          edtPeriod.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'AutoRequestSalePeriodInMonth' then
          edtSalesPeriodo.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'AutoRequestLeadTime' then
          edtLeadTime.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'ClassAPerc' then
          edtClassAPerc.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'ClassBPerc' then
          edtClassBPerc.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'ClassCPerc' then
          edtClassCPerc.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'POTimeSetupClassAInDays' then
          edtPurchaseClassA.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'POTimeSetupClassBInDays' then
          edtPurchaseClassB.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'POTimeSetupClassCInDays' then
          edtPurchaseClassC.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'PercSecurityMarginClassA' then
          edtMarginClassA.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'PercSecurityMarginClassB' then
          edtMarginClassB.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'PercSecurityMarginClassC' then
          edtMarginClassC.Text := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'StoreToAutoRequest' then
          scStore.LookUpValue := FieldByName('PropertyValue').AsString

        else if FieldByName('Property').AsString = 'AutoRequestClassA' then
          chxClassA.Checked := FieldByName('PropertyValue').Value

        else if FieldByName('Property').AsString = 'AutoRequestClassB' then
          chxClassB.Checked := FieldByName('PropertyValue').Value

        else if FieldByName('Property').AsString = 'AutoRequestClassC' then
          chxClassC.Checked := FieldByName('PropertyValue').Value

        else if FieldByName('Property').AsString = 'ABCCalcType' then
          cbxCalcType.ItemIndex := FieldByName('PropertyValue').Value;

        Next;
      end;
end;

procedure TFrmInventoryConfig.OpenPropertyDomain;
begin
  with quPropertyDomain do
    if not Active then
      Open;
end;

procedure TFrmInventoryConfig.SavePropertyDomain;
begin
  with cmdUpdPropertyDomain do
  begin
    Parameters.ParamByName('Property').Value := 'ABCCalcPeriodInMonth';
    Parameters.ParamByName('PropertyValue').Value := edtPeriod.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'AutoRequestSalePeriodInMonth';
    Parameters.ParamByName('PropertyValue').Value := edtSalesPeriodo.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'AutoRequestLeadTime';
    Parameters.ParamByName('PropertyValue').Value := edtLeadTime.Text;
    Execute;

	  Parameters.ParamByName('Property').Value := 'ClassAPerc';
    Parameters.ParamByName('PropertyValue').Value := edtClassAPerc.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'ClassBPerc';
    Parameters.ParamByName('PropertyValue').Value := edtClassBPerc.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'ClassCPerc';
    Parameters.ParamByName('PropertyValue').Value := edtClassCPerc.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'POTimeSetupClassAInDays';
    Parameters.ParamByName('PropertyValue').Value := edtPurchaseClassA.Text;
    Execute;

	  Parameters.ParamByName('Property').Value := 'POTimeSetupClassBInDays';
    Parameters.ParamByName('PropertyValue').Value := edtPurchaseClassB.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'POTimeSetupClassCInDays';
    Parameters.ParamByName('PropertyValue').Value := edtPurchaseClassC.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'PercSecurityMarginClassA';
    Parameters.ParamByName('PropertyValue').Value := edtMarginClassA.Text;
    Execute;

	  Parameters.ParamByName('Property').Value := 'PercSecurityMarginClassB';
    Parameters.ParamByName('PropertyValue').Value := edtMarginClassB.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'PercSecurityMarginClassC';
    Parameters.ParamByName('PropertyValue').Value := edtMarginClassC.Text;
    Execute;

    Parameters.ParamByName('Property').Value := 'AutoRequestClassA';
    if chxClassA.Checked then
      Parameters.ParamByName('PropertyValue').Value := 1
    else
      Parameters.ParamByName('PropertyValue').Value := 0;
    Execute;

    Parameters.ParamByName('Property').Value := 'AutoRequestClassB';
    if chxClassB.Checked then
      Parameters.ParamByName('PropertyValue').Value := 1
    else
      Parameters.ParamByName('PropertyValue').Value := 0;
    Execute;

    Parameters.ParamByName('Property').Value := 'AutoRequestClassC';
    if chxClassC.Checked then
      Parameters.ParamByName('PropertyValue').Value := 1
    else
      Parameters.ParamByName('PropertyValue').Value := 0;
    Execute;

    // Grava filtro de inclusao de modelos filtrados por loja.
    if scStore.LookUpValue <> '' then
      Parameters.ParamByName('PropertyValue').Value := scStore.LookUpValue
    else
      Parameters.ParamByName('PropertyValue').Value := '0';

    Parameters.ParamByName('Property').Value := 'StoreToAutoRequest';
    Execute;

    Parameters.ParamByName('Property').Value := 'ABCCalcType';
    Parameters.ParamByName('PropertyValue').Value := cbxCalcType.ItemIndex;
    Execute;
    
  end;
end;

function TFrmInventoryConfig.Start: Boolean;
begin
  ShowModal;
end;

procedure TFrmInventoryConfig.FormShow(Sender: TObject);
begin
  inherited;
  OpenPropertyDomain;
  LoadProperties;
end;

procedure TFrmInventoryConfig.btnOKClick(Sender: TObject);
begin
  inherited;
  if Validate then
  begin
    SavePropertyDomain;
    Close;
  end;
end;

procedure TFrmInventoryConfig.edtPeriodKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

function TFrmInventoryConfig.Validate: Boolean;
var
  iTotalPerc: Integer;
begin
  Result := True;
  iTotalPerc := StrToInt(edtClassAPerc.Text) +
                StrToInt(edtClassBPerc.Text) +
                StrToInt(edtClassCPerc.Text);

  if iTotalPerc <> 100 then
  begin
    MsgBox(MSG_INF_NOT_100_NOT_PERCENT, vbInformation + vbOKOnly);
    Result := False;
  end;
end;

procedure TFrmInventoryConfig.btnStoreAllClick(Sender: TObject);
begin
  scStore.LookUpValue := '';
  scStore.Text := '<' + btnStoreAll.Caption + '>';
end;

end.
