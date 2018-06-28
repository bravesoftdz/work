unit uFrmSearchCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Grids, DBGrids, SMDBGrid, Buttons, DB, ADODB, PowerADOQuery, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TFrmSearchCustomer = class(TFrmParent)
    btnOK: TButton;
    quCostumer: TPowerADOQuery;
    quCostumerIDPessoa: TIntegerField;
    quCostumerDriverLicense: TStringField;
    quCostumerSocialSecurity: TStringField;
    quCostumerCustomerCard: TStringField;
    quCostumerPessoaLastName: TStringField;
    quCostumerCEP: TStringField;
    quCostumerPessoaFirstName: TStringField;
    quCostumerPessoa: TStringField;
    dsCostumer: TDataSource;
    quCostumerPhone: TStringField;
    trSearchCustomer: TTimer;
    quCostumerEmail: TStringField;
    Panel4: TPanel;
    edtParamText: TEdit;
    cbSearchFor: TComboBox;
    Label5: TLabel;
    lbParamSearch: TLabel;
    grdCustomer: TcxGrid;
    grdCustomerDB: TcxGridDBTableView;
    grdCustomerDBPessoa: TcxGridDBColumn;
    grdCustomerDBCEP: TcxGridDBColumn;
    grdCustomerDBPhone: TcxGridDBColumn;
    grdCustomerDBEmail: TcxGridDBColumn;
    grdCustomerDBPessoaLastName: TcxGridDBColumn;
    grdCustomerDBPessoaFirstName: TcxGridDBColumn;
    grdCustomerLevel: TcxGridLevel;
    btColumn: TSpeedButton;
    pnlDivisoria2: TPanel;
    sbDetailCustumer: TSpeedButton;
    sbNewCostumer: TSpeedButton;
    grdCustomerDBCustomerCard: TcxGridDBColumn;
    procedure sbNewCostumerClick(Sender: TObject);
    procedure sbDetailCustumerClick(Sender: TObject);
    procedure trSearchCustomerTimer(Sender: TObject);
    procedure edtParamTextKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchForChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure grdCustomerDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdCustomerDBCustomization(Sender: TObject);
    procedure grdCustomerDBFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure grdCustomerDBDblClick(Sender: TObject);
  private
    FIDPessoa : Integer;
    AView  : TcxCustomGridTableView;
    procedure RefreshCustomer;
    procedure RefreshSelection;
    procedure Load_cbSearchFor_ItemIndex;
    procedure Save_cbSearchFor_ItemIndex;
  public
    function Start : Integer;
  end;

implementation

uses uDM, uDMGlobal,
     uFchPessoa, uSystemTypes, uSqlFunctions, uSystemConst,
     SysRegistryDAO, SysRegistryCls;

{$R *.dfm}

{ TFrmSearchCustomer }

function TFrmSearchCustomer.Start: Integer;
var
  AOptions : TcxGridStorageOptions;
  ASaveViewName : String;
  fRegistryPath : String;
begin
  FIDPessoa := -1;
  if DMGlobal.IDLanguage = LANG_ENGLISH then
    cbSearchFor.ItemIndex := 1
  else
    cbSearchFor.ItemIndex := 0;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
     TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

  ShowModal;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

  Result := FIDPessoa;
  
end;

procedure TFrmSearchCustomer.sbNewCostumerClick(Sender: TObject);
var
  PosID1, PosID2, sParam : String;
  bIsPost : boolean;
begin
  inherited;

  bIsPost := False;

  with TFchPessoa.Create(Self) do
    try
      sParam := 'IDTipoPessoa=1;';
      if Start(btInc, Nil, False, PosID1, PosID2, nil) then
         begin
         FIDPessoa := StrToInt(PosID1);
         bIsPost   := True;
         end;
    finally
      Free;
      end;

  if bIsPost then
     Close;

end;

procedure TFrmSearchCustomer.sbDetailCustumerClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;

  if (quCostumer.Active) and (not quCostumer.IsEmpty) then
    with TFchPessoa.Create(Self) do
      begin
      sParam := 'IDTipoPessoa=1;';
      Start(btAlt, quCostumer, False, PosID1, PosID2, nil);
      Free;
      end;

end;

procedure TFrmSearchCustomer.trSearchCustomerTimer(Sender: TObject);
begin
  inherited;
  trSearchCustomer.Enabled := False;
  RefreshCustomer;
end;


procedure TFrmSearchCustomer.RefreshCustomer;
var
sField, sName, sWhereSQL : string;
iSelected : Integer;
begin

  try

    Screen.Cursor := crHourGlass;

    with quCostumer do
      begin
      If Active then
         Close;

      iSelected := cbSearchFor.ItemIndex;
      sName     := edtParamText.Text; 

      Case iSelected of
            // Smart Search
        0 : sField := '(P.PessoaLastName Like ' + QuotedStr(trim(sName) + '%') + ' or ' +
                      'P.PessoaFirstName Like ' + QuotedStr(trim(sName) + '%') + ' or ' +
                      'P.Pessoa Like ' + QuotedStr(trim(sName) + '%') + ' or ' +
                      'P.CustomerCard Like ' + QuotedStr(trim(sName) + '%') + ' or ' +
                      'P.Email Like ' + QuotedStr(trim(sName) + '%') + ' or ' +
                      '(P.PhoneAreaCode + ''-'' + P.Telefone) Like ' + QuotedStr('%' + trim(sName) + '%') + ')';
        1 : sField := 'P.PessoaFirstName Like ' + QuotedStr(trim(sName) + '%');  //First Name
        2 : sField := 'P.PessoaLastName Like ' + QuotedStr(trim(sName) + '%');   //Last Name
        3 : sField := 'P.Pessoa Like ' + QuotedStr(trim(sName) + '%');           //Full Name
        4 : sField := '(P.PhoneAreaCode + ''-'' + P.Telefone) Like ' + QuotedStr('%' + trim(sName) + '%'); //Phone
        5 : sField := 'P.Email Like ' + QuotedStr(trim(sName) + '%');            //Email
        6 : sField := 'P.CustomerCard Like ' + QuotedStr(trim(sName) + '%');     //Customer Card
        7 : sField := 'P.OrgaoEmissor Like ' + QuotedStr(trim(sName) + '%');     //Driver License
      end; 

      sWhereSQL :=
        ' P.System = 0'          +
        ' AND TP.Path LIKE '+ QuotedStr('.001%') + ' ' +
        ' AND P.Desativado = 0 ';

      if trim(sName) <> '' then
        sWhereSQL := sWhereSQL + ' AND ' +sField;

      CommandText := ChangeWhereClause(CommandText, sWhereSQL, True);
      Open;
      end;

  finally
    Screen.Cursor := crDefault;
    end;

end;

procedure TFrmSearchCustomer.edtParamTextKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  trSearchCustomer.Enabled := False;
  if TEdit(Sender).Text <> '' then
     trSearchCustomer.Enabled := True;
  
end;

procedure TFrmSearchCustomer.Load_cbSearchFor_ItemIndex;
var
  TableRow: TSysRegistry;
  sysRegistryDao: TSysRegistryDAO;
  Rows: TList;
begin
  if (not Assigned(DM.ADODBConnect)) then Exit;
  if (not DM.ADODBConnect.Connected) then Exit;

  TableRow:= TSysRegistry.Create;
  sysRegistryDao := TSysRegistryDAO.create(DM.ADODBConnect);
  Rows:= TList.Create;
  try
    try
      if (sysRegistryDao.select('cbSearchFor.ItemIndex', Rows )) then
      begin
        if Rows.Count = 1 then
        begin
          cbSearchFor.ItemIndex:= StrToIntDef(TSysRegistry(Rows[0]).AttributeValue, 0);
        end;
      end;
    except
    end; 
  finally
    TableRow.Free;
    sysRegistryDao.Free;
  end;
end;

procedure TFrmSearchCustomer.Save_cbSearchFor_ItemIndex;
var
  TableRow: TSysRegistry;
  sysRegistryDao: TSysRegistryDAO;
  Rows: TList;
begin
  if (not Assigned(DM.ADODBConnect)) then Exit;
  if (not DM.ADODBConnect.Connected) then Exit;

  TableRow:= TSysRegistry.Create;
  sysRegistryDao := TSysRegistryDAO.create(DM.ADODBConnect);
  Rows:= TList.Create;
  try
    TableRow.AttributeName:= 'cbSearchFor.ItemIndex';
    TableRow.AttributeValue:= IntToStr(cbSearchFor.ItemIndex);
    TableRow.AttributeType:= 'Int';
    TableRow.ConstraintValue:= '1';
    TableRow.ConstraintType:= 2;

    try
      if (sysRegistryDao.select(TableRow.AttributeName, Rows )) then
      begin
        if Rows.Count = 1 then
        begin
          sysRegistryDao.setRegistry(TableRow);
          sysRegistryDao.update(TSysRegistry(Rows[0]).ID);
        end
        else if Rows.Count = 0 then
        begin
          sysRegistryDao.setRegistry(TableRow);
          sysRegistryDao.insert();
        end;
      end;

    except
    end;

  finally
    TableRow.Free;
    sysRegistryDao.Free;
  end;
end;

procedure TFrmSearchCustomer.cbSearchForChange(Sender: TObject);
begin
  inherited;
  RefreshSelection;
  Save_cbSearchFor_ItemIndex;
end;

procedure TFrmSearchCustomer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmSearchCustomer.btCloseClick(Sender: TObject);
begin
  inherited;
  FIDPessoa := -1;
  Close;
end;

procedure TFrmSearchCustomer.RefreshSelection;
begin
  lbParamSearch.Caption := cbSearchFor.Items.Strings[cbSearchFor.ItemIndex];
  if edtParamText.CanFocus then
  begin
    edtParamText.Clear;
    edtParamText.SetFocus;
  end;
end;

procedure TFrmSearchCustomer.FormShow(Sender: TObject);
begin
  inherited;
  Load_cbSearchFor_ItemIndex; 
  RefreshSelection;
end;

procedure TFrmSearchCustomer.btnOKClick(Sender: TObject);
begin
  inherited;
  if (FIDPessoa = -1) and quCostumer.Active and (quCostumerIDPessoa.AsInteger <> 0) then
     FIDPessoa := quCostumerIDPessoa.AsInteger;
end;

procedure TFrmSearchCustomer.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_ADD, sbNewCostumer.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, sbDetailCustumer.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);

  AView := TcxCustomGridTableView(grdCustomer.FocusedView);
end;

procedure TFrmSearchCustomer.btColumnClick(Sender: TObject);
begin
  inherited;

  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
  
end;

procedure TFrmSearchCustomer.grdCustomerDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TFrmSearchCustomer.grdCustomerDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmSearchCustomer.grdCustomerDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TFrmSearchCustomer.grdCustomerDBDblClick(Sender: TObject);
begin
  inherited;
  btnOK.Click;
end;

end.
