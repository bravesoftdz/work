unit uFrmTelemarketingFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  SuperComboADO, Mask, DateBox, ComCtrls, DB, ADODB, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Provider, DBClient;

type
  TFrmTelemarketingFilter = class(TFrmParentAll)
    lbFilterName: TLabel;
    edtFilterName: TEdit;
    Label35: TLabel;
    Button1: TButton;
    PageControl1: TPageControl;
    tsInvoice: TTabSheet;
    lbInvDate: TLabel;
    InvIniDate: TDateBox;
    InvEndDate: TDateBox;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    scMedia: TSuperComboADO;
    Button3: TButton;
    quFilter: TADODataSet;
    quFilterIDTelemarketingFilter: TIntegerField;
    quFilterFilterName: TStringField;
    quFilterFilterValues: TMemoField;
    quFilterSQL: TMemoField;
    dsFilter: TDataSource;
    cmbStore: TSuperComboADO;
    Label4: TLabel;
    cbxSaleTotal: TComboBox;
    edtSalesTotal: TEdit;
    tsCustomer: TTabSheet;
    Label5: TLabel;
    Label7: TLabel;
    edtCity: TEdit;
    Label8: TLabel;
    edtZipCode: TEdit;
    Label9: TLabel;
    edtArePhone: TEdit;
    Label10: TLabel;
    scState: TSuperComboADO;
    btnStateClear: TButton;
    tsResult: TTabSheet;
    lbType: TLabel;
    scType: TSuperComboADO;
    dsResultType: TDataSource;
    cdsResultType: TClientDataSet;
    dspResultType: TDataSetProvider;
    quTypeResult: TADODataSet;
    quTypeResultIDPessoaHistoryResult: TIntegerField;
    quTypeResultIDPessoaHistoryType: TIntegerField;
    quTypeResultPessoaHistoryResult: TStringField;
    quTypeResultResultColor: TStringField;
    cbxResult: TcxLookupComboBox;
    lbResult: TLabel;
    edtBairro: TEdit;
    lbBairro: TLabel;
    lbCell: TLabel;
    Label22: TLabel;
    Label46: TLabel;
    Label14: TLabel;
    Label23: TLabel;
    edtPhone: TEdit;
    edtAreCell: TEdit;
    edtCell: TEdit;
    edtEmail: TEdit;
    edtBeeper: TEdit;
    edtFax: TEdit;
    edtHomePage: TEdit;
    lbCType: TLabel;
    scCusType: TSuperComboADO;
    btnCType: TButton;
    cbxMonth: TComboBox;
    edtDay: TEdit;
    UpDownDay: TUpDown;
    lbCategory: TLabel;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    edtModel: TEdit;
    lbModel: TLabel;
    lbProfession: TLabel;
    scProfession: TSuperComboADO;
    btnProfessionClear: TButton;
    lbSex: TLabel;
    rgGender: TRadioGroup;
    tsSO: TTabSheet;
    lbSOIni: TLabel;
    dtSOIni: TDateBox;
    lbSOEnd: TLabel;
    dtSOEnd: TDateBox;
    lbSOStore: TLabel;
    scSOStore: TSuperComboADO;
    Button4: TButton;
    lbSOProduct: TLabel;
    scSOProduct: TSuperComboADO;
    Button5: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure edtSalesTotalKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnStateClearClick(Sender: TObject);
    procedure scTypeSelectItem(Sender: TObject);
    procedure btnCTypeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnProfessionClearClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    FIDFilter : Integer;

    function ValidateFields : Boolean; 

    procedure OpenFilter(IDFilter : Integer);
    procedure CloseFilter;
    procedure SaveFilter;

    procedure GetValues;
    procedure SetValues(var SQL, Filter : String);

    procedure BuildFilter(sFilter:String);

    procedure TypeResultRefresh;
    procedure TypeResultClose;
    procedure TypeResultOpen;
    procedure FillMonths;
  public
    function Start(IDFilter : Integer):Boolean;
  end;

implementation

uses uDM, uParamFunctions, uMsgBox, uMsgConstant, uCharFunctions,
     uDateTimeFunctions;

{$R *.dfm}

{ TFrmTelemarketingFilter }

function TFrmTelemarketingFilter.Start(IDFilter : Integer): Boolean;
begin
  FillMonths;

  FIDFilter := IDFilter;

  TypeResultRefresh;
  cdsResultType.Filtered := True;
  cdsResultType.Filter   := 'IDPessoaHistoryType = -1';

  if FIDFilter <> -1 then
  begin
    CloseFilter;
    OpenFilter(FIDFilter);
    GetValues;
  end;

  ShowModal;
  Result := True;
end;

procedure TFrmTelemarketingFilter.FillMonths;
var
  i : Integer;
begin

  cbxMonth.Items.Clear;
  for i := 1 to 12 do
    cbxMonth.Items.Add(LongMonthNames[i]);
  cbxMonth.Items.Add('');

end;

procedure TFrmTelemarketingFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseFilter;
  TypeResultClose;
  Action := caFree;
end;

procedure TFrmTelemarketingFilter.OpenFilter(IDFilter: Integer);
begin
  with quFilter do
  begin
    Parameters.ParamByName('IDTelemarketingFilter').Value := IDFilter;
    Open;
  end;
end;

procedure TFrmTelemarketingFilter.CloseFilter;
begin
  with quFilter do
    if Active then
      Close;
end;

procedure TFrmTelemarketingFilter.GetValues;
begin
  edtFilterName.Text := quFilterFilterName.AsString;
  BuildFilter(quFilterFilterValues.AsString);
end;

procedure TFrmTelemarketingFilter.BuildFilter(sFilter: String);
var
  iGender : Integer;
begin
  if sFilter <> '' then
  begin
    InvIniDate.Text          := ParseParam(sFilter, 'InvIniDate');
    InvEndDate.Text          := ParseParam(sFilter, 'InvEndDate');
    UpDownDay.Position       := StrToIntDef(ParseParam(sFilter, 'CusDateDay'), 0);
    cbxMonth.ItemIndex       := StrToIntDef(ParseParam(sFilter, 'CusDateMonth'), 13)-1;
    cmbStore.LookUpValue     := ParseParam(sFilter, 'cmbStore');
    scMedia.LookUpValue      := ParseParam(sFilter, 'scMedia');
    cbxSaleTotal.ItemIndex   := StrToIntDef(ParseParam(sFilter, 'cbxSaleTotal'), 0);
    edtSalesTotal.Text       := ParseParam(sFilter, 'edtSalesTotal');
    edtZipCode.Text          := ParseParam(sFilter, 'edtZipCode');
    edtArePhone.Text         := ParseParam(sFilter, 'edtArePhone');
    edtPhone.Text            := ParseParam(sFilter, 'edtPhone');
    edtAreCell.Text          := ParseParam(sFilter, 'edtAreCell');
    edtCell.Text             := ParseParam(sFilter, 'edtCell');
    scState.LookUpValue      := ParseParam(sFilter, 'scState');
    edtCity.Text             := ParseParam(sFilter, 'edtCity');
    edtEmail.Text            := ParseParam(sFilter, 'edtEmail');
    edtBeeper.Text           := ParseParam(sFilter, 'edtBeeper');
    edtFax.Text              := ParseParam(sFilter, 'edtFax');
    edtHomePage.Text         := ParseParam(sFilter, 'edtHomePage');
    scType.LookUpValue       := ParseParam(sFilter, 'scType');
    edtBairro.Text           := ParseParam(sFilter, 'edtBairro');
    scCusType.LookUpValue    := ParseParam(sFilter, 'scCusType');
    scCategory.LookUpValue   := ParseParam(sFilter, 'scCategory');
    edtModel.Text            := ParseParam(sFilter, 'edtModel');
    scProfession.LookUpValue := ParseParam(sFilter, 'scProfession');
    iGender                  := StrToIntDef(ParseParam(sFilter, 'rgGender'), -1);
    dtSOIni.Text             := ParseParam(sFilter, 'SOIniDate');
    dtSOEnd.Text             := ParseParam(sFilter, 'SOEndDate');
    scSOStore.LookUpValue    := ParseParam(sFilter, 'scSOStore');
    scSOProduct.LookUpValue  := ParseParam(sFilter, 'scSOProduct');

    if iGender <> -1 then
      if iGender = 1 then
        rgGender.ItemIndex := 0
      else
        rgGender.ItemIndex := 1;

    if scType.LookUpValue <> '' then
    begin
      cdsResultType.Filtered := True;
      cdsResultType.Filter := 'IDPessoaHistoryType = ' + scType.LookUpValue;
    end;
    if ParseParam(sFilter, 'cbxResult') <> '' then
      cbxResult.EditValue    := ParseParam(sFilter, 'cbxResult');
  end;
end;

procedure TFrmTelemarketingFilter.SaveFilter;
var
 sSQL : String;
 sFilter : String;
begin

  SetValues(sSQL, sFilter);

  if FIDFilter = -1 then
  begin
    with quFilter do
    begin
      if not Active then
        Open;
      Append;
      quFilterIDTelemarketingFilter.AsInteger := DM.GetNextID('Sal_TelemarketingFilter.IDTelemarketingFilter');
      quFilterFilterName.AsString             := edtFilterName.Text;
      quFilterFilterValues.AsString           := sFilter;
      quFilterSQL.AsString                    := sSQL;
      Post;
    end;
  end
  else
  begin
    with quFilter do
    begin
      Edit;
      quFilterFilterName.AsString             := edtFilterName.Text;
      quFilterFilterValues.AsString           := sFilter;
      quFilterSQL.AsString                    := sSQL;
      Post;
    end;
  end;
end;

procedure TFrmTelemarketingFilter.SetValues(var SQL, Filter: String);
var
  ASQL    : TStringList;
  AFilter : TStringList;
  i : Integer;
begin

  ASQL    := TStringList.Create;
  AFilter := TStringList.Create;

  try

    AFilter.Add('IDPessoa<>1;');
    ASQL.Add('P.IDPessoa <> 1');

    AFilter.Add('TipoPessoa=1;');
    ASQL.Add('TP.Path like '+QuotedStr('%.001%'));

    AFilter.Add('DHS=0;');
    ASQL.Add('P.Desativado = 0 AND P.Hidden = 0 AND P.System = 0');

    if Trim(InvIniDate.Text) <> '' then
    begin
      AFilter.Add('InvIniDate='+InvIniDate.Text+';');
      ASQL.Add('I.InvoiceDate > ' + QuotedStr(FormatDateTime('mm/dd/yyyy',InvIniDate.Date)));
    end;

    if Trim(InvEndDate.Text) <> '' then
    begin
      AFilter.Add('InvEndDate='+InvEndDate.Text+';');
      ASQL.Add('I.InvoiceDate <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', InvEndDate.Date+1)));
    end;

    if cmbStore.LookUpValue <> '' then
    begin
      AFilter.Add('cmbStore='+cmbStore.LookUpValue+';');
      ASQL.Add('I.IDStore = ' + cmbStore.LookUpValue);
    end;

    if scMedia.LookUpValue <> '' then
    begin
      AFilter.Add('scMedia='+scMedia.LookUpValue+';');
      ASQL.Add('I.MediaID = ' + scMedia.LookUpValue);
    end;

    if cbxSaleTotal.ItemIndex <> 0 then
      if Trim(edtSalesTotal.Text) <> '' then
        begin
          AFilter.Add('cbxSaleTotal='+IntToStr(cbxSaleTotal.ItemIndex)+';');
          AFilter.Add('edtSalesTotal='+edtSalesTotal.Text+';');
          ASQL.Add('(I.SubTotal + I.Tax + AditionalExpenses - I.InvoiceDiscount - I.ItemDiscount ) ' +
                   cbxSaleTotal.Items.Strings[cbxSaleTotal.ItemIndex] + ' ' +edtSalesTotal.Text);
        end;

    if (UpDownDay.Position <> 0) then
    begin
      AFilter.Add('CusDateDay='+edtDay.Text+';');
      ASQL.Add('Day(P.Nascimento) = ' + edtDay.Text);
    end;

    if (Trim(cbxMonth.Text) <> '') then
    begin
      AFilter.Add('CusDateMonth='+ IntToStr(cbxMonth.ItemIndex + 1) +';');
      ASQL.Add('Month(P.Nascimento) = ' + IntToStr(cbxMonth.ItemIndex + 1));
    end;

    if Trim(edtBairro.Text) <> '' then
    begin
      AFilter.Add('edtBairro=' + edtBairro.Text+';');
      ASQL.Add('P.Bairro like ' + QuotedStr('%' + edtBairro.Text + '%'));
    end;

    if Trim(edtZipCode.Text) <> '' then
    begin
      AFilter.Add('edtZipCode=' + edtZipCode.Text+';');
      ASQL.Add('P.CEP like ' + QuotedStr('%' + edtZipCode.Text + '%'));
    end;

    if Trim(edtCity.Text) <> '' then
    begin
      AFilter.Add('edtCity='+edtCity.Text+';');
      ASQL.Add('P.Cidade like '+QuotedStr('%' + edtCity.Text + '%'));
    end;

    if Trim(edtArePhone.Text) <> '' then
    begin
      AFilter.Add('edtArePhone='+edtArePhone.Text+';');
      ASQL.Add('P.PhoneAreaCode like '+ QuotedStr('%' + edtArePhone.Text + '%'));
    end;

    if Trim(edtPhone.Text) <> '' then
    begin
      AFilter.Add('edtPhone='+edtPhone.Text+';');
      ASQL.Add('P.Telefone like '+ QuotedStr('%' + edtPhone.Text + '%'));
    end;

    if Trim(edtAreCell.Text) <> '' then
    begin
      AFilter.Add('edtAreCell='+edtAreCell.Text+';');
      ASQL.Add('P.CellAreaCode like '+ QuotedStr('%' + edtAreCell.Text + '%'));
    end;

    if Trim(edtCell.Text) <> '' then
    begin
      AFilter.Add('edtCell='+edtCell.Text+';');
      ASQL.Add('P.Cellular like '+ QuotedStr('%' + edtCell.Text + '%'));
    end;

    if Trim(edtEmail.Text) <> '' then
    begin
      AFilter.Add('edtEmail='+edtEmail.Text+';');
      ASQL.Add('P.Email like '+ QuotedStr('%' + edtEmail.Text + '%'));
    end;

    if Trim(edtBeeper.Text) <> '' then
    begin
      AFilter.Add('edtBeeper='+edtBeeper.Text+';');
      ASQL.Add('P.Beeper like '+ QuotedStr('%' + edtBeeper.Text + '%'));
    end;

    if Trim(edtFax.Text) <> '' then
    begin
      AFilter.Add('edtFax='+edtFax.Text+';');
      ASQL.Add('P.Fax like '+ QuotedStr('%' + edtFax.Text + '%'));
    end;

    if Trim(edtHomePage.Text) <> '' then
    begin
      AFilter.Add('edtHomePage='+edtHomePage.Text+';');
      ASQL.Add('P.HomePage like '+ QuotedStr('%' + edtHomePage.Text + '%'));
    end;

    if scCusType.LookUpValue <> '' then
    begin
      AFilter.Add('scCusType='+scCusType.LookUpValue+';');
      ASQL.Add('TP.IDTipoPessoa = ' + QuotedStr(scCusType.LookUpValue));
    end;

    if scState.LookUpValue <> '' then
    begin
      AFilter.Add('scState='+scState.LookUpValue+';');
      ASQL.Add('P.IDEstado = ' + QuotedStr(scState.LookUpValue));
    end;

    if scType.LookUpValue <> '' then
    begin
      AFilter.Add('scType=' + scType.LookUpValue+';');
      ASQL.Add('H.IDPessoaHistoryType = ' + scType.LookUpValue);
    end;

    if (cbxResult.EditValue <> NULL) and (StrToInt(cbxResult.EditValue) <> 0) then
    begin
      AFilter.Add('cbxResult='+IntToStr(cbxResult.EditValue)+';');
      ASQL.Add('H.IDPessoaHistoryResult = ' + IntToStr(cbxResult.EditValue));
    end;

    if scCategory.LookUpValue <> '' then
    begin
      AFilter.Add('scCategory=' + scCategory.LookUpValue+';');
      ASQL.Add('M.GroupID = ' + scCategory.LookUpValue);
    end;

    if scProfession.LookUpValue <> '' then
    begin
      AFilter.Add('scProfession=' + scProfession.LookUpValue+';');
      ASQL.Add('P.IDRamoAtividade = ' + scProfession.LookUpValue);
    end;

    if rgGender.ItemIndex <> -1 then
      if rgGender.ItemIndex = 0 then
      begin
        AFilter.Add('rgGender=1;');
        ASQL.Add('P.Sexo = 1');
      end
      else
      begin
        AFilter.Add('rgGender=0;');
        ASQL.Add('P.Sexo = 0');
      end;

    if Trim(edtModel.Text) <> '' then
    begin
      AFilter.Add('edtModel=' + edtModel.Text +';');
      ASQL.Add('M.Model = ' + QuotedStr(edtModel.Text));
    end;

    if Trim(dtSOIni.Text) <> '' then
    begin
      AFilter.Add('SOIniDate='+dtSOIni.Text+';');
      ASQL.Add('SO.SODate > ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtSOIni.Date)));
    end;

    if Trim(dtSOEnd.Text) <> '' then
    begin
      AFilter.Add('SOEndDate='+dtSOEnd.Text+';');
      ASQL.Add('SO.SOCloseDate <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtSOEnd.Date + 1)));
    end;

    if scSOStore.LookUpValue <> '' then
    begin
      AFilter.Add('scSOStore='+scSOStore.LookUpValue+';');
      ASQL.Add('SO.IDStore = ' + QuotedStr(scSOStore.LookUpValue));
    end;

    if scSOProduct.LookUpValue <> '' then
    begin
      AFilter.Add('scSOProduct=' + scSOProduct.LookUpValue+';');
      ASQL.Add('SOI.IDSOCustomerProduct = ' + scSOProduct.LookUpValue);
    end;

    Filter := '';
    SQL    := '';

    for i:=0 to AFilter.Count-1 do
      Filter := Filter + aFilter.Strings[i];

    for i:=0 to ASQL.Count-1 do
      if i = 0 then
        SQL := ASQL.Strings[0]
      else
        SQL := SQL + ' AND ' + ASQL.Strings[i];

  finally
    FreeAndNil(ASQL);
    FreeAndNil(AFilter);
    end;

end;

function TFrmTelemarketingFilter.ValidateFields: Boolean;
begin

  Result := True;

  if Trim(edtFilterName.Text) = '' then
  begin
    MsgBox(MSG_CRT_NO_FILTER, vbOkOnly + vbCritical);
    Result := False;
  end;

end;

procedure TFrmTelemarketingFilter.Button1Click(Sender: TObject);
begin
  inherited;
  if ValidateFields then
  begin
    SaveFilter;
    Close;
  end;
end;

procedure TFrmTelemarketingFilter.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmTelemarketingFilter.edtSalesTotalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Key := ValidateFloats(Key);

end;

procedure TFrmTelemarketingFilter.Button2Click(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text := '';
end;

procedure TFrmTelemarketingFilter.Button3Click(Sender: TObject);
begin
  inherited;
  scMedia.LookUpValue := '';
  scMedia.Text := '';
end;

procedure TFrmTelemarketingFilter.btnStateClearClick(Sender: TObject);
begin
  inherited;
  scState.LookUpValue := '';
  scState.Text        := '';
end;

procedure TFrmTelemarketingFilter.TypeResultClose;
begin
  with cdsResultType do
    if Active then
    begin
      Filtered := False;
      Close;
    end;
end;

procedure TFrmTelemarketingFilter.TypeResultOpen;
begin
  with cdsResultType do
    if not Active then
      Open;
end;

procedure TFrmTelemarketingFilter.TypeResultRefresh;
begin
  TypeResultClose;
  TypeResultOpen;
end;

procedure TFrmTelemarketingFilter.scTypeSelectItem(Sender: TObject);
begin
  inherited;
  if scType.LookUpValue <> '' then
    with cdsResultType do
    begin
      Filtered := True;
      Filter   := 'IDPessoaHistoryType = ' + scType.LookUpValue;
    end;
end;

procedure TFrmTelemarketingFilter.btnCTypeClick(Sender: TObject);
begin
  inherited;
  scCusType.LookUpValue := '';
  scCusType.Text        := '';
end;

procedure TFrmTelemarketingFilter.FormShow(Sender: TObject);
begin
  inherited;
  Caption := Application.Title;
end;

procedure TFrmTelemarketingFilter.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '';
end;

procedure TFrmTelemarketingFilter.btnProfessionClearClick(Sender: TObject);
begin
  inherited;
  scProfession.LookUpValue := '';
  scProfession.Text := '';
end;

procedure TFrmTelemarketingFilter.Button4Click(Sender: TObject);
begin
  inherited;
  scSOStore.LookUpValue := '';
  scSOStore.Text := '';
end;

procedure TFrmTelemarketingFilter.Button5Click(Sender: TObject);
begin
  inherited;
  scSOProduct.LookUpValue := '';
  scSOProduct.Text := '';
end;

end.
