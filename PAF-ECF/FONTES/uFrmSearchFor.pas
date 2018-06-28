unit uFrmSearchFor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, uPreSale, Grids, DBGrids, SMDBGrid,
  Mask, DBCtrls, DBClient, DB, uParentAll, siComp, siLangRT;

const
  SEARCH_BARCODE     = 1;
  SEARCH_DESCRIPTION = 2;
  SEARCH_CUSTOMER    = 3;
  SEARCH_MEDIA       = 4;
  SEARCH_USER        = 5;
  SEARCH_MODEL       = 6;
  SEARCH_SERIALNUM   = 7;
  CHOOSE_TABLEPRICE  = 8;

type
  TFrmSearchFor = class(TFrmParentAll)
    pnlTop: TPanel;
    imgSearch: TImage;
    lbSearchOption: TLabel;
    edtValue: TEdit;
    pnlModelInfo: TPanel;
    pnlListModel: TPanel;
    SMDBGrid1: TSMDBGrid;
    dsGrid: TDataSource;
    tmrRefresh: TTimer;
    dsQty: TDataSource;
    lbModel: TLabel;
    lbDescrip: TLabel;
    lbCateg: TLabel;
    lbSalePrice: TLabel;
    lbPromotion: TLabel;
    lbHoriz: TLabel;
    lbVertic: TLabel;
    lbManufect: TLabel;
    lbUnidade: TLabel;
    edtModel: TDBEdit;
    edtDesc: TDBEdit;
    edtCategory: TDBEdit;
    edtPrice: TDBEdit;
    edtPromotion: TDBEdit;
    edtHoriz: TDBEdit;
    edtVerti: TDBEdit;
    edtCodHoriz: TDBEdit;
    edtVertCod: TDBEdit;
    edtManufac: TDBEdit;
    edtUnidade: TDBEdit;
    pnlCustomer: TPanel;
    lbInfo: TLabel;
    lbSearchName: TLabel;
    lbSearchPhone: TLabel;
    pnlIdentification: TPanel;
    lblIdent: TLabel;
    edtIdentification: TEdit;
    lblHelp: TLabel;
    lbF5: TLabel;
    lbIndArr: TLabel;
    edtIndicadorAT: TDBEdit;
    lbIndProd: TLabel;
    edtIndicadorProducao: TDBEdit;
    Label1: TLabel;
    edtDescSituTribut: TDBEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure edtValueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure dsGridDataChange(Sender: TObject; Field: TField);
  private
    SearchBarcode   : String;
    SearchDescrip   : String;
    SearchModel     : String;
    SearchCustomer  : string;
    SearchPhone     : string;
    SearchCPF       : string;
    SearchMedia     : String;
    SearchUser      : String;
    SearchSerial    : String;
    ChooseTablePrice: String;

    sCustomer      : String;

    SearchForOption : Integer;
    bResult: Boolean;
    oCustomer: TObject;

    ClientDataSet : TClientDataSet;
    sCampo: String;

    procedure CloseSearch;
    procedure OpenSearch;

    procedure RefreshCustomer;
    procedure FillEditSearch(sValue: String);
  public
    function Start(SearchFor: Integer; BMP: TBitmap; var oResult: TObject;
      HasIdent: Boolean = False): Boolean;
  end;

implementation

uses uDM, uUserObj, uDMPDV, uFrmNewCustomer, uDMGlobal, uSQLFunctions,
     uFilePersistence;

{$R *.dfm}

procedure TFrmSearchFor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
   VK_ESCAPE : begin
               bResult := False;
               Close;
               end;
   VK_RETURN : begin
               if SearchForOption = SEARCH_SERIALNUM then
                 bResult := edtValue.Text <> ''
               else
                 bResult := not dsGrid.DataSet.IsEmpty;
               Close;
               end;
   VK_F1     : case SearchForOption of
                 SEARCH_BARCODE     : Application.HelpContext(210);
                 SEARCH_MODEL       : Application.HelpContext(220);
                 SEARCH_DESCRIPTION : Application.HelpContext(230);
                 SEARCH_CUSTOMER    : Application.HelpContext(200);
                 SEARCH_MEDIA       : Application.HelpContext(240);
                 SEARCH_USER        : Application.HelpContext(250);
                 SEARCH_SERIALNUM   : Application.HelpContext(10);
                 CHOOSE_TABLEPRICE  : Application.HelpContext(10);
               end;
   VK_F2     : begin
               if SearchForOption = SEARCH_CUSTOMER then
                  begin
                  with TFrmNewCustomer.Create(Self) do
                     //oCustomer := Start(SALE_TYPE_SQL);
                     oCustomer := Start(1);
                     if oCustomer <> nil then
                        begin
                        bResult := True;
                        Close;
                        end;
                  end;
               end;

   VK_F3     : begin
               if SearchForOption = SEARCH_CUSTOMER then
                  begin
                  lbSearchOption.Caption := SearchCustomer;
                  sCampo := 'Pessoa';
                  SetCDSIndex(DMPDV.cdsCustomer, sCampo);
                  edtValue.Clear;
                  end;
               end;
   VK_F4     : begin
               if SearchForOption = SEARCH_CUSTOMER then
                  begin
                  lbSearchOption.Caption := SearchPhone;
                  sCampo := 'Telefone';
                  SetCDSIndex(DMPDV.cdsCustomer, sCampo);
                  edtValue.Clear;
                  end;
               end;

   VK_F5     : begin
               if SearchForOption = SEARCH_CUSTOMER then
                  begin
                  lbSearchOption.Caption := SearchCPF;
                  sCampo := 'CPF';
                  SetCDSIndex(DMPDV.cdsCustomer, sCampo);
                  edtValue.Clear;
                  end;
               end;

 end;
end;

procedure TFrmSearchFor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmSearchFor.Start(SearchFor: Integer; BMP: TBitmap;
  var oResult: TObject; HasIdent: Boolean = False): Boolean;
begin
  bResult := False;

  BMP.Transparent := True;
  imgSearch.Picture.Bitmap := BMP;

  SearchForOption := SearchFor;

  pnlModelInfo.Visible      := False;
  lbInfo.Visible            := False;
  lbSearchName.Visible      := False;
  lbSearchPhone.Visible     := False;
  pnlIdentification.Visible := HasIdent;

  oCustomer := nil;

  dsGrid.DataSet := nil;

  case SearchForOption of
    SEARCH_BARCODE   : begin
                       lbSearchOption.Caption := SearchBarcode;
                       dsGrid.DataSet := DMPDV.cdsBarcodeSearch;
                       sCampo := 'IDBarCode';
                       OpenSearch;
                       end;

    SEARCH_MODEL     : begin
                       lbSearchOption.Caption := SearchModel;
                       dsGrid.DataSet := DMPDV.cdsModel;
                       sCampo := 'Model';
                       pnlModelInfo.Visible := True;
                       OpenSearch;
                       end;

    SEARCH_DESCRIPTION: begin
                       lbSearchOption.Caption := SearchDescrip;
                       dsGrid.DataSet := DMPDV.cdsMDescription;
                       sCampo := 'Description';
                       pnlModelInfo.Visible := True;
                       OpenSearch;
                       end;
    SEARCH_CUSTOMER  : begin
                         tmrRefresh.Enabled := False;
                         lbSearchOption.Caption := SearchCustomer;
                         dsGrid.DataSet := DMPDV.cdsCustomer;
                         sCampo := 'Pessoa';
                         lbInfo.Visible := True;
                         lbSearchName.Visible := True;
                         lbSearchPhone.Visible := True;
                       end;
    SEARCH_MEDIA     : begin
                         lbSearchOption.Caption := SearchMedia;
                         dsGrid.DataSet := DM.cdsMedia;
                         sCampo := 'Media';
                         OpenSearch;
                       end;
    SEARCH_USER      : begin
                       lbSearchOption.Caption := SearchUser;
                       dsGrid.DataSet := DMPDV.cdsSystemUser;
                       sCampo := 'SystemUser';
                       OpenSearch;
                       DM.FiltraCDS(DMPDV.cdsSystemUser, DM.GetStoreUsersFilter(DM.cdsSystemUser));
                       end;

    SEARCH_SERIALNUM : begin
                         lbSearchOption.Caption := SearchSerial;
                         dsGrid.DataSet := DMPDV.cdsInvSerial;
                         sCampo := 'Serial';
                         OpenSearch;
                       end;

    CHOOSE_TABLEPRICE: begin
                         lbSearchOption.Caption := ChooseTablePrice;
                         if DMPDV.cdsStoreTablePrice.IsEmpty then
                           dsGrid.DataSet := DMPDV.cdsModelTablePrice
                         else
                           dsGrid.DataSet := DMPDV.cdsStoreTablePrice;
                         sCampo := 'SalePrice';
                         OpenSearch;
                       end;
  end;

  ClientDataSet := TClientDataSet(dsGrid.DataSet);

  if pnlModelInfo.Visible then
     begin
     edtModel.DataSource             := dsGrid;
     edtDesc.DataSource              := dsGrid;
     edtCategory.DataSource          := dsGrid;
     edtPromotion.DataSource         := dsGrid;
     edtHoriz.DataSource             := dsGrid;
     edtVerti.DataSource             := dsGrid;
     edtCodHoriz.DataSource          := dsGrid;
     edtVertCod.DataSource           := dsGrid;
     edtManufac.DataSource           := dsGrid;
     edtPrice.DataSource             := dsGrid;
     edtUnidade.DataSource           := dsGrid;
     edtIndicadorAT.DataSource       := dsGrid;
     edtIndicadorProducao.DataSource := dsGrid;
     edtDescSituTribut.DataSource    := dsGrid;
     end;

  try
    ShowModal;
    Result := bResult;

    oResult := nil;

    if not Result then
      Exit;

    case SearchForOption of
      SEARCH_BARCODE:
      begin
        oResult := TSellingItem.Create;
        with TSellingItem(oResult) do
        begin
          Model := DMPDV.cdsBarcodeSearch.FieldByName('Model').AsString;
        end;
      end;

      SEARCH_MODEL :
      begin
        oResult := TSellingItem.Create;
        with TSellingItem(oResult) do
        begin
          Model := DMPDV.cdsModel.FieldByName('Model').AsString;
        end;
      end;

      SEARCH_DESCRIPTION:
      begin
        oResult := TSellingItem.Create;
        with TSellingItem(oResult) do
        begin
          Model := DMPDV.cdsMDescription.FieldByName('Model').AsString;
        end;
      end;

      SEARCH_CUSTOMER :
      begin
        oResult := oCustomer;
        if oResult = nil then
           begin
           oResult := TCustomerInfo.Create;
           with TCustomerInfo(oResult) do
             begin
             IDCustomer := DMPDV.cdsCustomer.FieldByName('IDPessoa').AsInteger;
             Zip        := DMPDV.cdsCustomer.FieldByName('CEP').AsString;
             Endereco   := DMPDV.cdsCustomer.FieldByName('Endereco').AsString;
             Bairro     := DMPDV.cdsCustomer.FieldByName('Bairro').AsString;
             Cidade     := DMPDV.cdsCustomer.FieldByName('Cidade').AsString;
             Telefone   := DMPDV.cdsCustomer.FieldByName('Telefone').AsString;
             IsNew      := False;
              
             if DMPDV.cdsCustomer.FieldByName('PessoaFirstName').AsString = '' then
                FirstName := DMPDV.cdsCustomer.FieldByName('Pessoa').AsString
             else
                begin
                FirstName  := DMPDV.cdsCustomer.FieldByName('PessoaFirstName').AsString;
                LastName   := DMPDV.cdsCustomer.FieldByName('PessoaLastName').AsString;
                end;
             if DMPDV.cdsCustomer.FieldByName('InscEstadual').AsString <> '' then
                CPF  := DMPDV.cdsCustomer.FieldByName('InscEstadual').AsString
             else
                CPF  := DMPDV.cdsCustomer.FieldByName('CPF').AsString;
             end;
           end;
      end;

      SEARCH_MEDIA:
      begin
        oResult := TMediaInfo.Create;
        with TMediaInfo(oResult) do
        begin
          IDMedia    := DM.cdsMediaIDMedia.AsInteger;
          MediaName  := DM.cdsMediaMedia.AsString;
        end;
      end;

      SEARCH_USER:
      begin
        oResult := TSalesPersonInfo.Create;
        with TSalesPersonInfo(oResult) do
        begin
          IDUser           := DMPDV.cdsSystemUser.FieldByName('IDUser').AsInteger;
          IDCommission     := DMPDV.cdsSystemUser.FieldByName('ComissionID').AsInteger;
          UserName         := DMPDV.cdsSystemUser.FieldByName('SystemUser').AsString;
          IDCommissionType := DMPDV.cdsSystemUser.FieldByName('IDTipoPessoa').AsInteger;
        end;
        DM.FiltraCDS(DMPDV.cdsSystemUser, '');
      end;

      SEARCH_SERIALNUM:
      begin
        oResult := TPreSaleItemSerial.Create;
        with TPreSaleItemSerial(oResult) do
        begin
          SerialNumber := edtValue.Text;
          IdentificationNumber := edtIdentification.Text;
        end
      end;

      CHOOSE_TABLEPRICE:
      begin
        oResult := TPreSaleItemPrice.Create;
        with TPreSaleItemPrice(oResult) do
        begin
          IDVendorPrice := dsGrid.DataSet.FieldByName('IDVendor').AsInteger;
          IDDescriptionPrice := dsGrid.DataSet.FieldByName('IDDescriptionPrice').AsInteger;
          SuggPrice := dsGrid.DataSet.FieldByName('SuggPrice').AsCurrency;
          SalePrice := dsGrid.DataSet.FieldByName('SalePrice').AsCurrency;
        end;
      end;

    end;
  finally
    if DM.PersistenceType = ptDB then
      CloseSearch;
  end;
end;

procedure TFrmSearchFor.FormShow(Sender: TObject);
begin
  if edtValue.CanFocus then
    edtValue.SetFocus;
end;

procedure TFrmSearchFor.OpenSearch;
begin
  if DM.PersistenceType = ptDB then
    with dsGrid.DataSet do
     if not Active then
        Open;
end;

procedure TFrmSearchFor.CloseSearch;
begin
  if dsGrid.DataSet is TClientDataSet then
    TClientDataSet(dsGrid.DataSet).IndexName := '';
  with dsGrid.DataSet do
   if Active then
      Close;
end;

procedure TFrmSearchFor.edtValueKeyPress(Sender: TObject; var Key: Char);
var
  sAtual, sAposTecla: String;
begin
  edtValue.ClearSelection;

  case Ord(Key) of
    VK_BACK:
    begin
      edtValue.Text := Copy(edtValue.Text, 1, Length(edtValue.Text) - 1);
      sAposTecla := edtValue.Text;
    end;
    else
      sAposTecla := edtValue.Text + Key;
  end;

  sAtual    := edtValue.Text;
  sCustomer := sAposTecla;

  Key := #00;

  if ClientDataSet.Active and ClientDataSet.Locate(sCampo, VarArrayOf([sAposTecla]), [loPartialKey, loCaseInsensitive]) then
    FillEditSearch(sAposTecla)
  else
    begin
    edtValue.Text := sAposTecla;
    edtValue.SelStart := Length(sAposTecla);
    edtValue.SelLength := 0;
    end;

  if SearchForOption = SEARCH_CUSTOMER then
     begin
     tmrRefresh.Enabled := False;
     if {(Trim(sCustomer) <> '') and }(DM.PersistenceType = ptDB) then
        tmrRefresh.Enabled := True;
     end;

end;

procedure TFrmSearchFor.edtValueKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key Of
    VK_UP:
    begin
      if ClientDataSet.Active then
         ClientDataSet.Prior;
    end;
    VK_DOWN:
    begin
      if ClientDataSet.Active then
         ClientDataSet.Next;
    end;
    else
  end;
  if Key in [VK_UP, VK_DOWN] then
  begin
    edtValue.Text := ClientDataSet.FieldByName(sCampo).AsString;
    edtValue.SelectAll;
    Key := 0;
  end;
end;

procedure TFrmSearchFor.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           SearchDescrip    := 'Search for description';
           SearchBarcode    := 'Search for barcode';
           SearchCustomer   := 'Search customer';
           SearchMedia      := 'Search Media';
           SearchUser       := 'Search user';
           SearchModel      := 'Search model';
           SearchPhone      := 'Search phone';
           SearchCPF        := 'Search Doc';
           SearchSerial     := 'Search Serial Number';
           ChooseTablePrice := 'Choose price';
           end;

     LANG_PORTUGUESE :
           begin
           SearchDescrip    := 'Procurar por descrição';
           SearchBarcode    := 'Procurar por código de barras';
           SearchCustomer   := 'Procurar por nome';
           SearchMedia      := 'Procurar mídia';
           SearchUser       := 'Procurar por usuário';
           SearchModel      := 'Procurar por modelo';
           SearchPhone      := 'Procurar por telefone';
           SearchCPF        := 'Procurar por CPF';
           SearchSerial     := 'Procurar Número de Série';
           ChooseTablePrice := 'Escolher preço';
           end;

     LANG_SPANISH :
           begin
           SearchDescrip    := 'Busque para la descripción';
           SearchBarcode    := 'Busque para el Cód. barras';
           SearchCustomer   := 'Busque a cliente';
           SearchMedia      := 'Busque Medios';
           SearchUser       := 'Busque a usuario';
           SearchModel      := 'Busque a modelo';
           SearchPhone      := 'Busque a Tel.';
           SearchCPF        := 'Busque a Doc.';
           SearchSerial     := 'Busque Número de Série';
           ChooseTablePrice := 'Elegir el precio';
           end;
   end;

end;

procedure TFrmSearchFor.tmrRefreshTimer(Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled := False;
  if DM.PersistenceType = ptDB then
    RefreshCustomer;
end;

procedure TFrmSearchFor.RefreshCustomer;
var
  sField, sWhereSQL : string;
begin
  if DM.PersistenceType = ptTXT then
    Exit;

  try

    Screen.Cursor := crHourGlass;

    with DMPDV.quCustomer do
      begin
      CloseSearch;
      If Active then
         Close;

      if lbSearchOption.Caption = SearchPhone then
         sField := 'P.Telefone'
      else if lbSearchOption.Caption = SearchCustomer then
         sField := 'P.Pessoa'
      else
         sField := 'P.CPF';


      If Trim(sCustomer) <> '' then
          begin
          sWhereSQL :=
            ' P.System = 0'          +
            ' AND TP.Path like ' + QuotedStr('.001%') +
            ' AND P.Desativado = 0 ' +
            ' AND ' +sField+ ' Like ' + QuotedStr(trim(sCustomer) + '%');
         end
      else
         begin
          sWhereSQL :=
            ' P.System = 0'          +
            ' AND TP.Path like ' + QuotedStr('.001%') +
            ' AND P.Desativado = 0 ' ;
         end;

      CommandText := ChangeWhereClause(CommandText, sWhereSQL, True);
      end;

    OpenSearch;
    FillEditSearch(sCustomer);

  finally
    Screen.Cursor := crDefault;
    end;
end;

procedure TfrmSearchFor.FillEditSearch(sValue:String);
begin
  edtValue.Text := ClientDataSet.FieldByName(sCampo).AsString;
  edtValue.SelStart := Length(sValue);
  edtValue.SelLength := Length(edtValue.Text) - Length(sValue);
end;

procedure TFrmSearchFor.dsGridDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  if (pnlModelInfo.Visible) then
    if dsGrid.DataSet.FieldByName('PromotionPrice').AsCurrency <> 0 then
    begin
      lbPromotion.Visible  := True;
      edtPromotion.Visible := True;
      edtPrice.Font.Color  := clRed;
    end
    else
    begin
      lbPromotion.Visible  := False;
      edtPromotion.Visible := False;
      edtPrice.Font.Color  := clWindowText;
    end;

end;

end.
