unit uNewPreSales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, ExtCtrls, DB, DBTables, Mask, DateBox, StdCtrls, Grids, Variants,
  DBGrids, LblEffct, Buttons, uInvoice, ComCtrls, ADODB, SuperComboADO,
  RCADOQuery, PowerADOQuery, DBCtrls, siComp, siLangRT, SMDBGrid, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, uSystemTypes;

const
  INVOICE_ALL     = 0;
  INVOICE_FAST    = 1;
  INVOICE_FULL    = 2;
  INVOICE_AGENCY  = 3;
  INVOICE_LAYAWAY = 4;

type
  TFrmNewPreSales = class(TFrmParent)
    quGuides: TPowerADOQuery;
    dsGuides: TDataSource;
    quRemoveGuide: TADOQuery;
    quTestRefresh: TADOQuery;
    quTestRefreshInvoiceCount: TIntegerField;
    tmrRefresh: TTimer;
    quMedia: TADOQuery;
    quMediaIDMedia: TIntegerField;
    quMediaMedia: TStringField;
    dsMedia: TDataSource;
    btCancel: TButton;
    quAddCustomer: TADOQuery;
    pcNewCostumer: TPageControl;
    tbsFast: TTabSheet;
    tbsCostumerFile: TTabSheet;
    tbsGuide: TTabSheet;
    Label8: TLabel;
    dbedtFirstNameGuide: TEdit;
    dbedtLastNameGuide: TEdit;
    Label9: TLabel;
    btAdd: TSpeedButton;
    btDetail: TSpeedButton;
    lbParamSearch: TLabel;
    Label5: TLabel;
    cbSearchFor: TComboBox;
    sbDetailCustumer: TSpeedButton;
    sbNewCostumer: TSpeedButton;
    quCostumerFile: TPowerADOQuery;
    dsCostumerFile: TDataSource;
    edtParamText: TEdit;
    quCostumerFileDriverLicense: TStringField;
    quCostumerFileSocialSecurity: TStringField;
    quCostumerFileCustomerCard: TStringField;
    quCostumerFileIDPessoa: TIntegerField;
    dtFastDate: TDateBox;
    Label3: TLabel;
    dtCustFileDate: TDateBox;
    Label11: TLabel;
    dtGuideDate: TDateBox;
    Label12: TLabel;
    quCostumerFilePessoaLastName: TStringField;
    quCostumerFileCEP: TStringField;
    Label13: TLabel;
    edtZipFast: TEdit;
    edtZipGuide: TEdit;
    Label14: TLabel;
    spHelp: TSpeedButton;
    pnlFastCustumer: TPanel;
    Label4: TLabel;
    dbedtFirstNameFast: TEdit;
    dbedtLastNameFast: TEdit;
    Label2: TLabel;
    tbsLayaway: TTabSheet;
    Label22: TLabel;
    edtNameSearch: TEdit;
    cbSearchForLay: TComboBox;
    Label23: TLabel;
    dtLayaway: TDateBox;
    Label24: TLabel;
    sdAddLayway: TSpeedButton;
    SpeedButton3: TSpeedButton;
    scMediaClient: TSuperComboADO;
    Label25: TLabel;
    scMediaLayaway: TSuperComboADO;
    Label26: TLabel;
    quCostumerFilePessoaFirstName: TStringField;
    quCostumerFilePessoa: TStringField;
    quGuidesIDTouristGroup: TIntegerField;
    quGuidesTipTouristGroup: TStringField;
    quGuidesEnterDate: TDateTimeField;
    quGuidesStatus: TStringField;
    gridMedia: TSMDBGrid;
    gridGuide: TSMDBGrid;
    trSearchCustomer: TTimer;
    btnImportBudget: TSpeedButton;
    btnImpBudget: TSpeedButton;
    grdCustomerDBTableView: TcxGridDBTableView;
    grdCustomerLevel: TcxGridLevel;
    grdCustomer: TcxGrid;
    btCustomerColumns: TSpeedButton;
    grdLayaway: TcxGrid;
    grdLayawayDBTableView: TcxGridDBTableView;
    grdLayawayLevel: TcxGridLevel;
    grdLayawayDBTableViewIDPessoa: TcxGridDBColumn;
    grdLayawayDBTableViewDriverLicense: TcxGridDBColumn;
    grdLayawayDBTableViewSocialSecurity: TcxGridDBColumn;
    grdLayawayDBTableViewCustomerCard: TcxGridDBColumn;
    grdLayawayDBTableViewPessoaLastName: TcxGridDBColumn;
    grdLayawayDBTableViewCEP: TcxGridDBColumn;
    grdLayawayDBTableViewPessoaFirstName: TcxGridDBColumn;
    grdLayawayDBTableViewPessoa: TcxGridDBColumn;
    grdCustomerDBTableViewIDPessoa: TcxGridDBColumn;
    grdCustomerDBTableViewDriverLicense: TcxGridDBColumn;
    grdCustomerDBTableViewSocialSecurity: TcxGridDBColumn;
    grdCustomerDBTableViewCustomerCard: TcxGridDBColumn;
    grdCustomerDBTableViewPessoaLastName: TcxGridDBColumn;
    grdCustomerDBTableViewCEP: TcxGridDBColumn;
    grdCustomerDBTableViewPessoaFirstName: TcxGridDBColumn;
    grdCustomerDBTableViewPessoa: TcxGridDBColumn;
    btLayawayColumns: TSpeedButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure dsGuidesDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure pcNewCostumerChange(Sender: TObject);
    procedure cbSearchForChange(Sender: TObject);
    procedure sbNewCostumerClick(Sender: TObject);
    procedure sbDetailCustumerClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure dbedtLastNameFastExit(Sender: TObject);
    procedure dbedtLastNameGuideExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNameSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cbSearchForLayChange(Sender: TObject);
    procedure trSearchCustomerTimer(Sender: TObject);
    procedure btnImportBudgetClick(Sender: TObject);
    procedure grdCustomerDBTableViewDblClick(Sender: TObject);
    procedure btCustomerColumnsClick(Sender: TObject);
    procedure btLayawayColumnsClick(Sender: TObject);
  private
    OldCountInvoice,
    iIDPessoa: Integer;
    FAllowCommand : TSetCommandType;

    fRegistryPath : String;
    fIDCashRegMov : integer;
    fIsCashReg    : Boolean;

    bEditCustumer{, bCanEnableTravelAgency} : Boolean;
    procedure RefreshTab(iType:Integer);

    procedure ClearCustomer;
    function CheckEdits:boolean;
    procedure CreateInvoiceOnHold(IsNewCustomer:Boolean);

    //Media
    procedure MediaOpen;
    procedure MediaClose;
    procedure MediaRefresh;

    //Guide
    procedure GuideOpen;
    procedure GuideClose;
    procedure GuideRefresh;

    //Customer
    procedure CustomerOpen;
    procedure CustomerClose;
    procedure CustomerRefresh;

    procedure ConfigColumns(AView: TcxCustomGridTableView);
  public
    FrmInvoice : TFrmInvoice;
    property IDCashRegMov : Integer read fIDCashRegMov;
    property IsCashReg    : Boolean read fIsCashReg;
    function Start(IDCashRegMov,InvType:Integer;IsCashReg:Boolean):Boolean;
  end;

implementation

uses uPassword, uDM, uFchTouristGroup, uMsgBox, uFchPessoa, uMsgConstant,
     uNumericFunctions, uSqlFunctions, uDMGlobal, uSystemConst,
     uFrmImportEstimated;

{$R *.DFM}

function TFrmNewPreSales.Start(IDCashRegMov, InvType:Integer; IsCashReg: Boolean): Boolean;
var
  sIDMidia : String;
begin
  fIDCashRegMov := IDCashRegMov;
  fIsCashReg    := IsCashReg;

  tbsFast.TabVisible         := False;
  tbsCostumerFile.TabVisible := False;
  tbsGuide.TabVisible        := False;
  tbsLayaway.TabVisible      := False;

  dtFastDate.Date     := Now;
  dtCustFileDate.Date := Now;
  dtLayaway.Date      := Now;
  dtGuideDate.Date    := Now;

  btnImportBudget.Visible := False;

  if DM.fCashRegister.IDMedia > 0 then
     sIDMidia := IntToStr(DM.fCashRegister.IDMedia)
  else
     sIDMidia := '';

  case InvType of
    INVOICE_ALL     : begin
                      //Show the Tabs
                      tbsFast.TabVisible         := (DM.fSystem.SrvParam[PARAM_SHOWTABNOCUSTUMERREGISTER]);
                      tbsCostumerFile.TabVisible := (DM.fSystem.SrvParam[PARAM_SHOWTABCUSTUMERREGISTER]);
                      tbsGuide.TabVisible        := (DM.fSystem.SrvParam[PARAM_SHOWTABTOURGROUP]);
                      tbsLayaway.TabVisible      := (DM.fSystem.SrvParam[PARAM_SHOWTABLAYAWAY]);
                      scMediaLayaway.LookUpValue := sIDMidia;
                      scMediaClient.LookUpValue  := sIDMidia;
                      edtNameSearch.Clear;
                      edtParamText.Clear;
                      end;
    INVOICE_FAST    : begin
                      tbsFast.TabVisible := True;
                      dbedtFirstNameFast.Clear;
                      dbedtLastNameFast.Clear;
                      end;
    INVOICE_FULL    : begin
                      tbsCostumerFile.TabVisible := True;
                      scMediaClient.LookUpValue  := sIDMidia;
                      edtParamText.Clear;
                      ClearCustomer;
                      end;
    INVOICE_AGENCY  : begin
                      tbsGuide.TabVisible := True;
                      dbedtFirstNameGuide.Clear;
                      dbedtLastNameGuide.Clear;
                      end;
    INVOICE_LAYAWAY : begin
                      tbsLayaway.TabVisible      := True;
                      scMediaLayaway.LookUpValue := sIDMidia;
                      btnImportBudget.Visible    := (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE]=CASHREG_TYPE_OFFICE);
                      edtNameSearch.Clear;
                      ClearCustomer;
                      end;
  end;

  ClearCustomer;

  quTestRefresh.Open;
  OldCountInvoice := quTestRefreshInvoiceCount.asInteger;
  quTestRefresh.Close;

  RefreshTab(0);

  ShowModal;
end;

procedure TFrmNewPreSales.CustomerOpen;
begin
  with quCostumerFile do
    if not Active then
      Open;
end;

procedure TFrmNewPreSales.CustomerClose;
begin
  with quCostumerFile do
    if Active then
      Close;
end;

procedure TFrmNewPreSales.CustomerRefresh;
begin
  CustomerClose;
  CustomerOpen;
end;

procedure TFrmNewPreSales.GuideOpen;
begin
  with quGuides do
    if not Active then
    begin
      Parameters.ParambyName('IDStore').Value := DM.fStore.ID;
      Parameters.ParambyName('Date1').Value   := Now;
      Parameters.ParambyName('Date2').Value   := Now;
      Open;
    end;
end;

procedure TFrmNewPreSales.GuideClose;
begin
  with quGuides do
    if Active then
      Close;
end;

procedure TFrmNewPreSales.GuideRefresh;
begin
  GuideClose;
  GuideOpen;
end;

procedure TFrmNewPreSales.MediaOpen;
begin
  with quMedia do
    if not Active then
      Open;
end;

procedure TFrmNewPreSales.MediaClose;
begin
  with quMedia do
    if Active then
      Close;
end;

procedure TFrmNewPreSales.MediaRefresh;
begin
  MediaClose;
  MediaOpen;
end;

function TFrmNewPreSales.CheckEdits:boolean;
begin
  Result := True;

  //Verifico se e Fast
  if pcNewCostumer.ActivePage= tbsFast then
    if pnlFastCustumer.Visible = True then
    begin
      if Trim(dbedtFirstNameFast.Text) = '' then
      begin
        dbedtFirstNameFast.SetFocus;
        MsgBox(MSG_CRT_NO_FIRST_NAME, vbOKOnly + vbCritical);
        Result := False;
        Exit;
      end;

      if Trim(dbedtLastNameFast.Text) = '' then
      begin
        dbedtLastNameFast.SetFocus;
        MsgBox(MSG_CRT_NO_LAST_NAME, vbOKOnly + vbCritical);
        Result := False;
        Exit;
      end;
    end;

  //Verifico se Cliente Registrado
  if pcNewCostumer.ActivePage = tbsCostumerFile then
  begin
    if scMediaClient.LookUpValue = '' then
    begin
      scMediaClient.SetFocus;
      MsgBox(MSG_CRT_NO_MEDIA, vbOKOnly + vbCritical);
      Result := False;
      Exit;
    end;
  end;

  //Verifico se e Layaway
  if pcNewCostumer.ActivePage = tbsLayaway then
    if (scMediaLayaway.LookUpValue  = '') or (scMediaLayaway.Text = '') then
    begin
      scMediaLayaway.SetFocus;
      MsgBox(MSG_CRT_NO_MEDIA, vbOKOnly + vbCritical);
      Result := False;
      Exit;
    end;

  //Verifico se e Layaway
  if pcNewCostumer.ActivePage = tbsGuide then
    if quGuidesIDTouristGroup.IsNull then
    begin
      MsgBox(MSG_CRT_NO_AGENT, vbOKOnly + vbCritical);
      Result := False;
      Exit;
    end;
end;

procedure TFrmNewPreSales.RefreshTab(iType:Integer);
begin
  Screen.Cursor := crHourGlass;

  //Desabilita o timer do Travel Agency
  if tmrRefresh.Enabled then
    tmrRefresh.Enabled := False;

  //Fast Sale
  if pcNewCostumer.ActivePage = tbsFast then
    MediaOpen;

  //Reg customer & Layaway
  if (pcNewCostumer.ActivePage = tbsCostumerFile) or
     (pcNewCostumer.ActivePage = tbsLayaway) then
  begin
    if iType = 0 then
      CustomerOpen;

    if iType = 1 then
      CustomerRefresh;
  end;

  //Tour Guide
  if pcNewCostumer.ActivePage = tbsGuide then
  begin
    GuideRefresh;

    //Habilita o timer do Travel Agency
    tmrRefresh.Enabled := True;
  end;

  Screen.Cursor := crDefault;
end;

procedure TFrmNewPreSales.CreateInvoiceOnHold(IsNewCustomer:Boolean);
var
  sFirstName, sLastName, sZip: String;
  IDOtherCommission, IDPreSale, IDMedia,
  IDCustomer, IDTouristGroup: Integer;
  bIsFast, bIsGuide, bCustumerFile, bLayaway: Boolean;
  PreSaleDate: TDateTime;
begin
  Screen.Cursor := crHourGlass;

  if tmrRefresh.Enabled then
    tmrRefresh.Enabled := False;

  //Verifico so tab
  bIsFast           := pcNewCostumer.ActivePage = tbsFast;
  bIsGuide          := pcNewCostumer.ActivePage = tbsGuide;
  bCustumerFile     := pcNewCostumer.ActivePage = tbsCostumerFile;
  bLayaway          := pcNewCostumer.ActivePage = tbsLayaway;
  IDOtherCommission := -1;

  if bIsFast then
  begin
    sFirstName := dbedtFirstNameFast.Text;
    sLastName  := dbedtLastNameFast.Text;
    sZip       := edtZipFast.Text;
    // Testa se a media é RP, se for pequisa pelo IDComission
    IDOtherCommission := MyStrToInt(DM.DescCodigo(['IDMedia'], [quMediaIDMedia.AsString], 'Media',
                                    'IDOtherCommission'));
  end;

  if bIsGuide then
  begin
    sFirstName := dbedtFirstNameGuide.Text;
    sLastName  := dbedtLastNameGuide.Text;
    sZip       := edtZipGuide.Text;
  end;

  //Se for o btn OK e um cliente cadastrado
  bEditCustumer := (not IsNewCustomer) and (bCustumerFile or bLayaway);

  //Pega o IDCLIENTE cliente da lista se for edit
  //Se for New ele manten o IDPessoa que e passado no OnNewRecord da query
  if bEditCustumer then
    iIDPessoa := quCostumerFileIDPessoa.AsInteger;

  //Pega o customer name
  if bCustumerFile or bLayaway then
  begin
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQl.Clear;
      SQl.ADD('Select P.PessoaFirstName, P.PessoaLastName, P.CEP');
      SQl.ADD('From Pessoa P (NOLOCK) ');
      SQl.ADD('Where IDPessoa = '+ IntToStr(iIDPessoa));
      Open;
      sFirstName := Trim(Copy(FieldByName('PessoaFirstName').AsString,1,20));
      sLastName  := Trim(Copy(FieldByName('PessoaLastName').AsString,1,20));
      sZip       := FieldByName('CEP').AsString;
    end;
    Close;
  end;

  if bCustumerFile or bLayaway then
  begin
    PreSaleDate := dtCustFileDate.Date;
    IDCustomer  := iIDPessoa;
    //Media
    if bCustumerFile then
    begin
      IDMedia := MyStrToInt(scMediaClient.LookUpValue);
      // Testa se a media é RP, se for pequisa pelo IDComission
      if scMediaClient.LookUpValue <> '' then
        IDOtherCommission := MyStrToInt(DM.DescCodigo(['IDMedia'],
                             [scMediaClient.LookUpValue], 'Media', 'IDOtherCommission'));
    end
    else if bLayaway then
    begin
      IDMedia := MyStrToInt(scMediaLayaway.LookUpValue);
      // Testa se a media é RP, se for pequisa pelo IDComission
      if scMediaLayaway.LookUpValue <> '' then
        IDOtherCommission := MyStrToInt(DM.DescCodigo(['IDMedia'],
                             [scMediaLayaway.LookUpValue], 'Media', 'IDOtherCommission'));
    end;
  end;

  if bIsFast then
  begin
    IDCustomer  := 1;
    PreSaleDate := dtFastDate.Date;
    IDMedia     := quMediaIDMedia.AsInteger;
  end;

  if bIsGuide then
  begin
    IDCustomer     := 1;
    PreSaleDate    := dtGuideDate.Date;
    IDTouristGroup := quGuidesIDTouristGroup.AsInteger;
    IDMedia        := MEDIA_TYPE_TOURGROUP;
  end;

  if IDOtherCommission < 0 then
    IDOtherCommission := 0;

  DM.fPOS.CreateHold(DELIVER_TYPE_ONHAND,
                     bLayaway,
                     DM.fStore.ID,
                     sFirstName,
                     sLastName,
                     sZip,
                     IDTouristGroup,
                     PreSaleDate,
                     IDCustomer,
                     IDMedia,
                     IDOtherCommission,
                     DM.fInvoice.OBSText,
                     IDPreSale);

  if DM.fSystem.SrvParam[PARAM_SALECODE_ON_CREATE_SALE] then
    DM.fPOS.CreateSaleCode(IDPreSale, 0, DM.fStore.ID);

  if fIsCashReg then
    FrmInvoice.Start(IDPreSale, SALE_CASHREG, fIDCashRegMov, True)
  else
    FrmInvoice.Start(IDPreSale, SALE_PreSale, 0, True);

  Hide;

  Close;
  ModalResult := mrOK;
end;

procedure TFrmNewPreSales.btCloseClick(Sender: TObject);
begin
  inherited;
  //Valida os Edits
  if not CheckEdits then
    Exit;

  if (pcNewCostumer.ActivePage = tbsLayaway) or
     (pcNewCostumer.ActivePage = tbsCostumerFile) then
  begin
    if (not quCostumerFile.Active) or (quCostumerFile.IsEmpty) then
    begin
      Exit;
    end;
  end;

  Screen.Cursor := crHourGlass;
  CreateInvoiceOnHold(False);
end;

procedure TFrmNewPreSales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  tmrRefresh.Enabled := False;
  CustomerClose;
  GuideClose;
  MediaClose;

  DM.SaveGridToRegistry(TcxGridDBTableView(grdCustomerDBTableView), fRegistryPath, True, [gsoUseFilter, gsoUseSummary]);
  DM.SaveGridToRegistry(TcxGridDBTableView(grdLayawayDBTableView), fRegistryPath, True, [gsoUseFilter, gsoUseSummary]);
end;

procedure TFrmNewPreSales.btAddClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  tmrRefresh.Enabled := False;

  with TFchTouristGroup.Create(Self) do
  begin
    ShowCusto := False;
    if Start(btInc, quGuides, False, PosID1, PosID2, nil) then
    begin
      GuideRefresh;
      quGuides.Locate('IDTouristGroup', PosID1, []);
    end;
    Free;
  end;

  tmrRefresh.Enabled := True;
end;

procedure TFrmNewPreSales.btDetailClick(Sender: TObject);
var
  PosID1, PosID2: String;
begin
  inherited;
  tmrRefresh.Enabled := False;

  with TFchTouristGroup.Create(Self) do
  begin
    if Start(btAlt, quGuides, False, PosID1, PosID2, nil) then
    begin
      GuideRefresh;
      quGuides.Locate('IDTouristGroup', PosID1, []);
    end;
    Free;
  end;

  tmrRefresh.Enabled := True;
end;

procedure TFrmNewPreSales.dsGuidesDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btDetail.Enabled := (not (quGuides.Eof and quGuides.Bof)) and Password.HasFuncRight(16);
end;

procedure TFrmNewPreSales.FormCreate(Sender: TObject);
begin
  inherited;
  fRegistryPath            := MR_BRW_REG_PATH + lblSubMenu.Caption;
  fIDCashRegMov            := 0;
  fIsCashReg               := False;
  tmrRefresh.Enabled       := False;
  OldCountInvoice          := -1;
  cbSearchFor.ItemIndex    := 5;
  cbSearchForLay.ItemIndex := 5;


  DM.imgBTN.GetBitmap(BTN_COLUMN, btCustomerColumns.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btLayawayColumns.Glyph);

end;

procedure TFrmNewPreSales.tmrRefreshTimer(Sender: TObject);
var
  OldID: integer;
begin
  inherited;
  with quTestRefresh do
  begin
    Open;
    if quTestRefreshInvoiceCount.AsInteger <> OldCountInvoice then
    begin
      if OldCountInvoice <> -1 then
        MessageBeep(0);
      OldCountInvoice := FieldByName('InvoiceCount').AsInteger;

      with quGuides do
      begin
        if Active then
          OldID := quGuidesIDTouristGroup.AsInteger;
        GuideRefresh;
        Locate('IDTouristGroup', OldID, []);
      end;
    end;
    Close;
  end;
end;

procedure TFrmNewPreSales.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmNewPreSales.pcNewCostumerChange(Sender: TObject);
begin
  inherited;
  RefreshTab(0);
end;

procedure TFrmNewPreSales.cbSearchForChange(Sender: TObject);
begin
  inherited;
  lbParamSearch.Caption := cbSearchFor.Items.Strings[cbSearchFor.ItemIndex];

  if edtParamText.CanFocus then
    edtParamText.SetFocus;
end;

procedure TFrmNewPreSales.sbNewCostumerClick(Sender: TObject);
var
  PosID1, PosID2 : String;
  bIsPost : boolean;
begin
  inherited;

  //Valida os Edits
  if not CheckEdits then
    Exit;


  bIsPost := False;

  with TFchPessoa.Create(Self) do
  begin
    sParam := 'IDTipoPessoa=1;';
    if Start(btInc, Nil, False, PosID1, PosID2, nil) then
    //PosID1 retorna o Registro que que foi gravado
    begin
      iIDPessoa     := StrToInt(PosID1);
      bEditCustumer := False;
      bIsPost       := True;
    end;
    Free;
  end;

  if bIsPost then
    CreateInvoiceOnHold(True);
end;

procedure TFrmNewPreSales.sbDetailCustumerClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;

  if (not quCostumerFile.Active) or (quCostumerFile.IsEmpty) then
    Exit;

  with TFchPessoa.Create(Self) do
  begin
    sParam := 'IDTipoPessoa=1;';

    if Start(btAlt, quCostumerFile, False, PosID1, PosID2, nil) then
      RefreshTab(1);

    bEditCustumer := True;
    Free;
  end;
end;

procedure TFrmNewPreSales.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1030);
{  Case pcNewCostumer.ActivePageIndex of
     //Fast Sale
     0 : Application.HelpContext(302);
     //Register Customer
     1 : Application.HelpContext(302);
     //Travel Agency
     2 : Application.HelpContext(305);
     //Layaway
     3 : Application.HelpContext(209);
  end;}
end;

procedure TFrmNewPreSales.dbedtLastNameFastExit(Sender: TObject);
begin
  inherited;
  gridMedia.SetFocus;
end;

procedure TFrmNewPreSales.dbedtLastNameGuideExit(Sender: TObject);
begin
  inherited;
  //gridGuide.SetFocus; Alteracao de modo a jogar o foco normalmente para a proxima edit
end;

procedure TFrmNewPreSales.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F2:
    begin //Add
      case pcNewCostumer.ActivePageIndex of
        //Add in Register Costumer
        1:
        begin
          if sbNewCostumer.Enabled then
            sbNewCostumerClick(nil);
        end;

        //Add in Travel Agency
        2:
        begin
          if btAdd.Enabled then
            btAddClick(nil);
        end;

        //Add in LayAway
        3:
        begin
          if sdAddLayway.Enabled then
            sbNewCostumerClick(nil);
          end;
        end;
      end;

    VK_F3:
    begin //Detail
      case pcNewCostumer.ActivePageIndex of
        //Add in Register Costumer
        1:
        begin
          if sbDetailCustumer.Enabled then
            sbDetailCustumerClick(nil);
        end;

        //Add in Travel Agency
        2:
        begin
          if btDetail.Enabled then
            btDetailClick(nil);
        end;

        //Add in LayAway
        3:
        begin
          if sbDetailCustumer.Enabled then
            sbDetailCustumerClick(nil);
        end;
      end;
    end;

    VK_F4:
    begin //Import Budget
      case pcNewCostumer.ActivePageIndex of
        //Import in Register Costumer
        1: if btnImportBudget.Visible then
             btnImportBudgetClick(Self);

        //Import in LayAway
        3: if btnImportBudget.Visible then
             btnImportBudgetClick(Self);
      end;
    end;

    VK_F5 : begin //Fast Sale
            if tbsFast.TabVisible then
               begin
               pcNewCostumer.ActivePage := tbsFast;
               RefreshTab(0);
               end;
            end;

    VK_F6 : begin //Register Customer
            if tbsCostumerFile.TabVisible then
               begin
               pcNewCostumer.ActivePage := tbsCostumerFile;
               RefreshTab(0);
               end;
            end;

    VK_F7 : begin //Travel Agency
            if tbsGuide.TabVisible then
               begin
               pcNewCostumer.ActivePage := tbsGuide;
               RefreshTab(0);
               end;
            end;

    VK_F8 : begin //Layaway
            if tbsLayaway.TabVisible then
               begin
               pcNewCostumer.ActivePage := tbsLayaway;
               RefreshTab(0);
               end;
            end;
  end;
end;

procedure TFrmNewPreSales.ClearCustomer;
var
  sField, sName, sWhereSQL: String;
  iSelected: Integer;
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;

    with quCostumerFile do
    begin
      if Active then
        Close;

      //Tab Reg Customer
      if pcNewCostumer.ActivePage = tbsCostumerFile then
      begin
        iSelected := cbSearchFor.ItemIndex;
        sName     := edtParamText.Text;
      end;

      //Tab Layaway
      if pcNewCostumer.ActivePage = tbsLayaway then
      begin
        iSelected := cbSearchForLay.ItemIndex;
        sName     := edtNameSearch.Text;
      end;

      case iSelected of
        0 : sField := 'P.PessoaFirstName';
        1 : sField := 'P.PessoaLastName';
        2 : sField := 'P.OrgaoEmissor';
        3 : sField := 'P.CartTrabalho';
        4 : sField := 'P.CustomerCard';
        5 : sField := 'P.Pessoa';
        6 : sField := 'P.CPF';
        7 : sField := 'P.InscEstadual';
      end;

      if trim(sName) <> '' then
      begin
        sWhereSQL :=
          ' P.System = 0'          +
          ' AND TP.Path LIKE ' + QuotedStr('.001%') +
          ' AND P.Desativado = 0 ' +
          ' AND ' +sField+ ' Like ' + QuotedStr(trim(sName) + '%');
      end
      else
      begin
        sWhereSQL :=
          ' P.System = 0'          +
          ' AND TP.Path LIKE ' + QuotedStr('.001%') +
          ' AND P.Desativado = 0 ' ;
      end;
      CommandText := ChangeWhereClause(CommandText, sWhereSQL, True);
      Open;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmNewPreSales.edtNameSearchKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  trSearchCustomer.Enabled := False;

  if TEdit(Sender).Text <> '' then
    trSearchCustomer.Enabled := True;
end;

procedure TFrmNewPreSales.FormShow(Sender: TObject);
begin
  inherited;
  //Verifico se o Panel pode ser Visible
  if tbsFast.TabVisible = True then
  begin
    pnlFastCustumer.Visible := (DM.fSystem.SrvParam[PARAM_SHOWNAME_NOREGISTERCUSTUMER]);

    if (pcNewCostumer.ActivePageIndex = 0) then
      if pnlFastCustumer.Visible = True then
        dbedtFirstNameFast.SetFocus
      else
        gridMedia.SetFocus;
  end;

  if pcNewCostumer.ActivePageIndex = 1 then
    edtParamText.SetFocus;

  if pcNewCostumer.ActivePageIndex = 2 then
    dbedtFirstNameGuide.SetFocus;

  if pcNewCostumer.ActivePageIndex = 3 then
    edtNameSearch.SetFocus;

  DM.LoadGridFromRegistry(TcxGridDBTableView(grdCustomerDBTableView), fRegistryPath, [gsoUseFilter, gsoUseSummary]);
  DM.LoadGridFromRegistry(TcxGridDBTableView(grdLayawayDBTableView), fRegistryPath, [gsoUseFilter, gsoUseSummary]);

  FAllowCommand := Password.GetAllowCommand(2, 6, DM.fUser.Password);

  sbNewCostumer.Enabled := (TBtnCommandType(btInc) in FAllowCommand);
  sdAddLayway.Enabled := sbNewCostumer.Enabled;

  sbDetailCustumer.Enabled := (TBtnCommandType(btAlt) in FAllowCommand);
  SpeedButton3.Enabled := sbDetailCustumer.Enabled;
  
end;

procedure TFrmNewPreSales.cbSearchForLayChange(Sender: TObject);
begin
  inherited;
  Label22.Caption := cbSearchForLay.Items.Strings[cbSearchForLay.ItemIndex];

  if edtNameSearch.CanFocus then
    edtNameSearch.SetFocus;
end;

procedure TFrmNewPreSales.trSearchCustomerTimer(Sender: TObject);
begin
  inherited;
  trSearchCustomer.Enabled := False;
  ClearCustomer;
end;

procedure TFrmNewPreSales.btnImportBudgetClick(Sender: TObject);
var
  IDPreSale, IDMedia: Integer;
begin
  inherited;
  //Valida os Edits
  if not CheckEdits then
    Exit;

  if pcNewCostumer.ActivePageIndex = 1 then
    IDMedia := StrToInt(scMediaClient.LookUpValue)
  else if pcNewCostumer.ActivePageIndex = 3 then
    IDMedia := StrToInt(scMediaLayaway.LookUpValue);

  with TFrmImportEstimated.Create(Self) do
    if Start(IDPreSale, IDMedia) then
      FrmInvoice.Start(IDPreSale, SALE_CASHREG, fIDCashRegMov, True);

  btCancelClick(Sender);
end;

procedure TFrmNewPreSales.grdCustomerDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  if (sender = grdCustomer) or (Sender = grdLayaway) then
    bEditCustumer := True;

  btCloseClick(nil);
end;

procedure TFrmNewPreSales.ConfigColumns(AView: TcxCustomGridTableView);
begin
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmNewPreSales.btCustomerColumnsClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdCustomerDBTableView);
end;

procedure TFrmNewPreSales.btLayawayColumnsClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdLayawayDBTableView);
end;

end.
