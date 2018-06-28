unit uFchCotation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, DBCtrls, Db, OleCtrls, StdCtrls, Mask, Variants,
  Grids, FormConfig, DBTables, LblEffct, ExtCtrls, Buttons,
  DateBox, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO,
  uFrameSendContact, siComp, siLangRT, DBGrids, SMDBGrid,
  SubListPanel, ComCtrls;

type
  TFchCotation = class(TbrwFrmParent)
    quFormIDCotacao: TIntegerField;
    quFormCotacao: TStringField;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    edtPOName: TDBEdit;
    Label43: TLabel;
    quRequest: TADOQuery;
    dsRequest: TDataSource;
    quRequestIDRequest: TIntegerField;
    quRequestIDModel: TIntegerField;
    quRequestModel: TStringField;
    quRequestDescription: TStringField;
    quRequestDateRequest: TDateTimeField;
    quRequestSystemUser: TStringField;
    quModel: TADOQuery;
    dsModel: TDataSource;
    quModelIDCotacao: TIntegerField;
    quModelIDModel: TIntegerField;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    quModelInsert: TADOQuery;
    DBDateBox1: TDBDateBox;
    Label7: TLabel;
    quFormDataCotacao: TDateTimeField;
    quVendor: TADOQuery;
    dsVendor: TDataSource;
    quVendorContato: TStringField;
    quVendorTelefone: TStringField;
    quVendorFax: TStringField;
    quVendorInsert: TADOQuery;
    quHistory: TADOQuery;
    dsHistory: TDataSource;
    quVendorIDPessoa: TIntegerField;
    quModelFabricante: TStringField;
    quVendorResult: TADOQuery;
    dsVendorResult: TDataSource;
    quVendorResultIDFornecedor: TIntegerField;
    quVendorResultFornecedor: TStringField;
    quResult: TADOQuery;
    dsResult: TDataSource;
    quHistoryIDFornecedor: TIntegerField;
    quHistoryVendor: TStringField;
    quHistoryLastPurchase: TDateTimeField;
    quResultGrid: TADOQuery;
    dsResultItem: TDataSource;
    quResultGridIDModel: TIntegerField;
    quResultGridIDFornecedor: TIntegerField;
    quResultGridCost: TFloatField;
    quPOVendor: TADOQuery;
    dsPOVendor: TDataSource;
    quPOVendorIDFornecedor: TIntegerField;
    quPOVendorItems: TIntegerField;
    quPOItem: TADOQuery;
    dsPOItem: TDataSource;
    quPOItemIDModel: TIntegerField;
    quPOItemModel: TStringField;
    quPOItemDescription: TStringField;
    quPOItemCost: TFloatField;
    spPOInsert: TADOStoredProc;
    dsModelQty: TDataSource;
    quModelQty: TADOQuery;
    quModelQtyIDCotacao: TIntegerField;
    quModelQtyIDModel: TIntegerField;
    quModelQtyModel: TStringField;
    quModelQtyDescription: TStringField;
    dsEmail: TDataSource;
    quEmail: TPowerADOQuery;
    quSaveEmail: TPowerADOQuery;
    quEmailModel: TStringField;
    quEmailDescription: TStringField;
    quEmailIDCotacao: TIntegerField;
    quFormIDStore: TIntegerField;
    SD: TSaveDialog;
    quVendorEmail: TStringField;
    quResultIDModel: TAutoIncField;
    quResultModel: TStringField;
    quResultDescription: TStringField;
    quCheckedItems: TADOQuery;
    quCheckedItemsIDModel: TIntegerField;
    quCheckedItemsIDFornecedor: TIntegerField;
    quCheckedItemsPO: TBooleanField;
    PPageControl: TPageControl;
    tsModel: TTabSheet;
    pnlModels: TPanel;
    lblModelCount: TLabel;
    btModelNew: TSpeedButton;
    btModelRemove: TSpeedButton;
    DBText1: TDBText;
    DBText2: TDBText;
    Label8: TLabel;
    pnlProdutoTitle: TPanel;
    pnlRequest: TPanel;
    lblRequestCount: TLabel;
    btRequestNew: TSpeedButton;
    btRequestRemove: TSpeedButton;
    btIncludeModelAll: TSpeedButton;
    btIncludeModel: TSpeedButton;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    scRequestCategory: TSuperComboADO;
    cmbRequestType: TComboBox;
    btCategoryAll: TButton;
    scManufacturer: TSuperComboADO;
    btManufacturerAll: TButton;
    tsVendor: TTabSheet;
    Panel6: TPanel;
    Label17: TLabel;
    Panel7: TPanel;
    pnlVendor: TPanel;
    lblvendorCount: TLabel;
    btVendorNew: TSpeedButton;
    btVenderRemove: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Panel9: TPanel;
    edContato: TDBEdit;
    edPhone: TDBRichEdit;
    edFax: TDBRichEdit;
    DBEdit3: TDBEdit;
    tsReturn: TTabSheet;
    Label6: TLabel;
    sbReturne: TSpeedButton;
    Panel10: TPanel;
    Panel13: TPanel;
    tsQty: TTabSheet;
    Panel14: TPanel;
    tsResult: TTabSheet;
    spMinCost: TShape;
    spPO: TShape;
    Label13: TLabel;
    Label14: TLabel;
    sgResult: TStringGrid;
    tsPO: TTabSheet;
    pnlPOVendor: TPanel;
    lblPOVendorCount: TLabel;
    btCreatePOAll: TSpeedButton;
    Panel11: TPanel;
    Panel8: TPanel;
    lblPOItemCount: TLabel;
    btCreatePO: TSpeedButton;
    Panel12: TPanel;
    tsFax: TTabSheet;
    Splitter1: TSplitter;
    quSaveEmailCost: TBCDField;
    spRemoveRequest: TADOStoredProc;
    quModelVendorCost: TBCDField;
    SendForPO: TFrameSendContact;
    quPOVendorVendor: TStringField;
    quPOVendorFax: TStringField;
    quVendorVendor: TStringField;
    quPOVendorEmail: TStringField;
    SendPriceQuote: TFrameSendContact;
    grdModel: TSMDBGrid;
    grdQuantity: TSMDBGrid;
    dxDBGrid1: TSMDBGrid;
    grdModelQuot: TSMDBGrid;
    grdHistory: TSMDBGrid;
    grdVendorResult: TSMDBGrid;
    gridModelQty: TSMDBGrid;
    grdPOVendor: TSMDBGrid;
    grdPoItem: TSMDBGrid;
    grdVendorReturns: TSMDBGrid;
    SubListModelDetail: TSubListPanel;
    quMinQty: TADOQuery;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField2: TDateTimeField;
    StringField6: TStringField;
    quMaxQty: TADOQuery;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    StringField7: TStringField;
    StringField8: TStringField;
    DateTimeField3: TDateTimeField;
    StringField9: TStringField;
    quModelQtyCotada: TFloatField;
    quModelTotQtyOnHand: TFloatField;
    quMinQtyQty: TFloatField;
    quMaxQtyQty: TFloatField;
    quRequestQty: TFloatField;
    quModelQtyQtyCotada: TFloatField;
    quPOItemQtyxCost: TFloatField;
    quModelCostPrice: TBCDField;
    quPOItemCostPrice: TBCDField;
    quPOItemQtyCotada: TFloatField;
    quPOItemFabricante: TStringField;
    quPOItemQty: TFloatField;
    quResultGridPO: TBooleanField;
    quResultPO: TBooleanField;
    quRequestIdPessoa: TIntegerField;
    quResultCost: TBCDField;
    quResultIdFornecedor: TIntegerField;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure btCategoryAllClick(Sender: TObject);
    procedure btModelNewClick(Sender: TObject);
    procedure btModelRemoveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbRequestTypeChange(Sender: TObject);
    procedure scRequestCategorySelectItem(Sender: TObject);
    procedure quRequestAfterOpen(DataSet: TDataSet);
    procedure quModelAfterOpen(DataSet: TDataSet);
    procedure btRequestNewClick(Sender: TObject);
    procedure btRequestRemoveClick(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btVendorNewClick(Sender: TObject);
    procedure btVenderRemoveClick(Sender: TObject);
    procedure quModelAfterScroll(DataSet: TDataSet);
    procedure PPageControlChange(Sender: TObject);
    procedure quVendorResultAfterScroll(DataSet: TDataSet);
    procedure btManufacturerAllClick(Sender: TObject);
    procedure btIncludeModelClick(Sender: TObject);
    procedure dsModelDataChange(Sender: TObject; Field: TField);
    procedure dsRequestDataChange(Sender: TObject; Field: TField);
    procedure btIncludeModelAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgResultDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgResultDblClick(Sender: TObject);
    procedure quPOVendorAfterOpen(DataSet: TDataSet);
    procedure quPOItemAfterOpen(DataSet: TDataSet);
    procedure quPOVendorAfterScroll(DataSet: TDataSet);
    procedure btCreatePOClick(Sender: TObject);
    procedure quModelQtyAfterScroll(DataSet: TDataSet);
    procedure grdModelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdQuantityDblClick(Sender: TObject);
    procedure dxDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdHistoryDblClick(Sender: TObject);
    procedure grdModelQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdPoItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spHelpClick(Sender: TObject);
    procedure quPOItemCalcFields(DataSet: TDataSet);
    procedure PostOnExit(Sender: TObject);
    procedure SendContactsbCreateFileClick(Sender: TObject);
    procedure SendForPObtPreviewVendorFaxClick(Sender: TObject);
    procedure sbReturneClick(Sender: TObject);
    procedure SendPriceQuotesbEmailFileClick(Sender: TObject);
    procedure SendPriceQuotesbSendFaxClick(Sender: TObject);
    procedure SendPriceQuotebtPreviewVendorFaxClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
  private
    { Private declarations }
    slChecked, slHighLight, slVendorID, slModelID: TStringList;
    //Rodrigo criado p/ email e fax
    sCreateList : TStringList;
    //Translation
    sModel, sRequest, sVendor, sItems : String;
    isPOCreated: Boolean;

    procedure RefreshForm;
    procedure RefreshModel;
    procedure RefreshVendor;
    procedure RefreshHistory;
    procedure RefreshVendorResult;
    procedure RefreshModelResult;
    procedure ResetRequestFilter;
    procedure RefreshRequest;
    procedure RefreshPOVendor;
    procedure RefreshPOItem;
    procedure PaintResultColHeader;
    procedure PaintResultRowHeader;
    procedure RefreshResult;
    procedure RefreshDetail;
    procedure ReadCheckedItems;
    procedure RefreshModelQty;
    //Preenche email list
    function FillEmailOut:String;

    procedure InsertModel(IDModel : Integer; Qty : Double; IDRequest: Integer; DoRefresh: Boolean);
    procedure InsertVendor(IDFornecedor: Integer);

    procedure LoadImages;
    function ExistPO(): Boolean;

    procedure JustNoPOInResponse(argHasPO: Boolean);
    procedure DisableTabsAfterPOCreated(argPOCreated: Boolean);

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmSaleRequest, uMsgBox, uNewFornecedorCode, uDM,
     uMsgConstant, uSystemTypes, uCreateFile, uDMGlobal, PaiDeTodos,
     uSystemConst, uFrmBarcodeSearch, Math;

procedure TFchCotation.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_ADD, btVendorNew.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADD, btCreatePO.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btVenderRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW,btModelNew.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW,btRequestNew.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE,btModelRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE,btRequestRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN,sbReturne.Glyph);
end;


procedure TFchCotation.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshForm;
end;

procedure TFchCotation.RefreshForm;
begin
   try
      // Baseado no tab atual, dou o refresh nos grid's e tudo mais
      Screen.Cursor := crHourGlass;

      SubListModelDetail.Visible := (PPageControl.ActivePage = tsQty);

      if PPageControl.ActivePage = tsModel then
        begin
          RefreshModel;
          RefreshRequest;
        end
      else if PPageControl.ActivePage = tsVendor then
        begin

          RefreshVendor;
          RefreshModel;
          RefreshHistory;

        end
      else if PPageControl.ActivePage = tsReturn then
        begin
          RefreshVendorResult;
          RefreshModelResult;
        end
      else if PPageControl.ActivePage = tsQty then
        begin
          RefreshModelQty;
          RefreshDetail;
        end
      else if PPageControl.ActivePage = tsResult then
        begin
          //# I have to review why tab result was affected getting incorrect result to lowest cost.

          //slChecked.Clear;
          RefreshResult;
        end
      else if PPageControl.ActivePage = tsPO then
        begin
          RefreshPOVendor;
          RefreshPOItem;
        end;
   finally
     Screen.Cursor := crDefault;
   end;
end;

procedure TFchCotation.RefreshRequest;
var
  CurrentIDRequest,
  NextIDRequest: String;

begin

  Screen.Cursor := crHourGlass;

  // Dependendo do selecao de cmbList uso um ou outro TADOQuery
  case cmbRequestType.ItemIndex of
    0, 1, 2: dsRequest.DataSet := quRequest;
    3:       dsRequest.DataSet := quMinQty;
    4:       dsRequest.DataSet := quMaxQty;
  end;
 
  // Dependendo dos filtros selecionados da o refresh no grid de request
  with TADOQuery(dsRequest.DataSet) do
    begin

      CurrentIDRequest := '';
      NextIDRequest    := '';

      if Active then
        begin
          // Antes de fechar, guardo o request atual e o anterior
          if not IsEmpty then
            begin
              CurrentIDRequest := FieldByName('IDRequest').AsString;
              Next;
              NextIDRequest   := FieldByName('IDRequest').AsString;
            end;
          Close;
        end;

      // Filtro por loja
      if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
         Parameters.ParamByName('IDStore').Value := NULL
      else
         Parameters.ParamByName('IDStore').Value := DM.fStore.ID;

      // Filtro o tipo
      case cmbRequestType.ItemIndex of
        0: // Todos os requests
          begin
            Parameters.ParamByName('Type').Value := Null;
            // Passo qual a cotacao, para excluir os requests que ja estao
            // nesta cotacao
            Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
          end;
        1: // Somente de vendedores
          begin
            Parameters.ParamByName('Type').Value := 'P';
            // Passo qual a cotacao, para excluir os requests que ja estao
            // nesta cotacao
            Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
          end;
        2: // Somente de computador
          begin
            Parameters.ParamByName('Type').Value := 'C';
            // Passo qual a cotacao, para excluir os requests que ja estao
            // nesta cotacao
            Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
          end;
      end;

      // Filtro a categoria
      if scRequestCategory.LookUpvalue = '' then
        begin
          Parameters.ParamByName('IDGroup').Value := Null;
        end
      else
        begin
          Parameters.ParamByName('IDGroup').Value :=
                      StrToInt(scRequestCategory.LookUpvalue);
        end;

      // Filtro por Fabricante
      if scManufacturer.LookUpvalue = '' then
        begin
          Parameters.ParamByName('IDFabricante').Value := Null;
        end
      else
        begin
          Parameters.ParamByName('IDFabricante').Value :=
                      StrToInt(scManufacturer.LookUpvalue);
        end;

      Open;

      // Tento me reposicionar
      if CurrentIDRequest <> '' then
        if not Locate('IDRequest', CurrentIDRequest, []) then
          Locate('IDRequest', NextIDRequest, []);
    end;

  Screen.Cursor := crDefault;

end;

procedure TFchCotation.btCategoryAllClick(Sender: TObject);
begin
  inherited;
  scRequestCategory.LookUpvalue := '';
  RefreshRequest;
end;


procedure TFchCotation.InsertModel(IDModel : Integer; Qty : Double;
   IDRequest: Integer; DoRefresh: Boolean);
begin
  // Teste se é necessário incluir e incluo
  with quModelInsert do
    begin
      Parameters.ParamByName('IDCotacao').Value  := quFormIDCotacao.AsInteger;
      Parameters.ParamByName('IDModel1').Value   := IDModel;
      Parameters.ParamByName('IDCotacao1').Value := quFormIDCotacao.AsInteger;
      Parameters.ParamByName('IDModel').Value    := IDModel;

      if IDRequest = 0 then
         Parameters.ParamByName('IDRequest').Value  := NULL
      else
         Parameters.ParamByName('IDRequest').Value  := IDRequest;

      Parameters.ParamByName('Qty').Value           := Qty;
      ExecSQL;
    end;

  // Dou o refresh no tab
  if DoRefresh then
    RefreshForm;

  // Dou o locate no grid para selecionar o modelo
  // E ja deixe editando a Qty
  quModel.Locate('IDModel', IntToStr(IDModel), []);
  grdModel.SetFocus;
end;

procedure TFchCotation.btModelNewClick(Sender: TObject);
var
  IDModel: Integer;

begin
  inherited;
//  Inclui novo modelo na lista
  with TFrmBarcodeSearch.Create(Self) do
    IDModel := Start;
    
  if IDModel > 0 then
      InsertModel (IDModel, 0 , 0, True);
end;

procedure TFchCotation.btModelRemoveClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_DELETE_MODEL_FROM_QUOT, vbYesNo + vbQuestion) = vbYes then
    begin
      with DM.quFreeSQL do
        begin
          if Active then
            Close;
          SQL.Text := 'DELETE CotacaoToModel ' +
                      'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                      ' AND IDModel = ' + quModelIDModel.AsString;
          ExecSQL;

          RefreshForm;
        end;
    end;
end;

procedure TFchCotation.FormShow(Sender: TObject);
begin
  inherited;
  PPageControl.ActivePage := tsModel;
  isPOCreated := dm.IsQuoteHasPOS(quFormIDCotacao.AsString);
  DisableTabsAfterPOCreated(isPOCreated);
  ResetRequestFilter;
end;

procedure TFchCotation.cmbRequestTypeChange(Sender: TObject);
begin
  inherited;
  RefreshRequest;
end;

procedure TFchCotation.scRequestCategorySelectItem(Sender: TObject);
begin
  inherited;
  RefreshRequest;
end;

procedure TFchCotation.quRequestAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblRequestCount.Caption := IntToStr(quRequest.RecordCount) + sRequest;
end;

procedure TFchCotation.quModelAfterOpen(DataSet: TDataSet);
begin
  inherited;

  lblModelCount.Caption := IntToStr(quModel.RecordCount) + sModel;

end;

procedure TFchCotation.btRequestNewClick(Sender: TObject);
var
  ID1, ID2: String;

begin
  inherited;
  // Inclui um novo request
  with TbrwFrmRequest.Create(Self) do
    begin
      if Start(btInc, nil, False, ID1, ID2, nil) then
        begin
          ResetRequestFilter;
          RefreshRequest;
          Self.quRequest.Locate('IDRequest', ID1, []);
        end;
      Free;
    end;
end;

procedure TFchCotation.ResetRequestFilter;
begin
  cmbRequestType.ItemIndex := 1;
  scRequestCategory.LookUpValue := '';
  scManufacturer.LookUpValue := '';
end;

procedure TFchCotation.btRequestRemoveClick(Sender: TObject);
begin
  inherited;

  case not cmbRequestType.ItemIndex of
    0, 1, 2: Exit;
  end;

  if MsgBox(MSG_QST_DELETE_REQUEST, vbYesNo + vbQuestion) = vbYes then
    begin
      with spRemoveRequest do
        begin
          Parameters.ParambyName('@IDRequest').Value := quRequestIDRequest.AsInteger;
          ExecProc;
        end;

      RefreshRequest;
    end;

end;

procedure TFchCotation.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormDataCotacao.AsDateTime := Now;
  quFormIDStore.AsInteger := DM.fStore.ID;
end;

procedure TFchCotation.InsertVendor(IDFornecedor: Integer);
begin
  // Teste se é necessário incluir e incluo
  with quVendorInsert do
    begin
      Parameters.ParamByName('IDCotacao1').Value    := quFormIDCotacao.AsInteger;
      Parameters.ParamByName('IDFornecedor1').Value := IDFornecedor;
      Parameters.ParamByName('IDCotacao').Value     := quFormIDCotacao.AsInteger;
      Parameters.ParamByName('IDFornecedor').Value  := IDFornecedor;
      ExecSQL;
    end;

  // Dou o refresh no tab
  RefreshVendor;

  // Dou o locate no grid para selecionar o modelo
  // E ja deixe editando a Qty
  quVendor.Locate('IDPessoa', IntToStr(IDFornecedor), []);
  edFax.SetFocus;

end;

procedure TFchCotation.btVendorNewClick(Sender: TObject);
var
  IDFornecedor: Integer;
  QtyToOrder, CaseQty : Double;
begin
  inherited;
  // Inclui novo vendor na lista ***Combo com o novo vendor!!!
  IDFornecedor := 0;
  with TNewFornecedorCode.Create(Self) do
       IDFornecedor := NewVendor;

  if IDFornecedor > 0 then
    InsertVendor(IDFornecedor);

end;

procedure TFchCotation.btVenderRemoveClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_DELETE_VENDOR_FROM_QUOT, vbYesNo + vbQuestion) = vbYes then
    begin
      with DM.quFreeSQL do
        begin
          if Active then
            Close;
          SQL.Text := 'DELETE CotacaoToFornec ' +
                      'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                      ' AND IDFornecedor = ' + quVendorIDPessoa.AsString;
          ExecSQL;

          RefreshVendor;
        end;
    end;
end;

procedure TFchCotation.RefreshHistory;
begin
  // Testo se o grid de history está visivel
  if PPageControl.ActivePage = tsVendor then
    begin
      with quHistory do
        begin
          if Parameters.ParamByName('IDModel').Value <> quModelIDModel.AsInteger then
            begin
              if Active then
                Close;
              Parameters.ParamByName('IDModel').Value := quModelIDModel.AsInteger;
              Open;
            end;
        end;
    end;
end;

procedure TFchCotation.RefreshModel;
begin
  with quModel do
    begin
      if Active then
        begin
          if State in dsEditModes then
            begin
              UpdateRecord;
              Post;
            end;
          Close;
        end;
      Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
      Open;
    end;
end;

procedure TFchCotation.RefreshVendor;
begin
  with quVendor do
    begin
      if Active then
        begin
          if State in dsEditModes then
            begin
              UpdateRecord;
              Post;
            end;
          Close;
        end;
      Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
      Open;
    end;
end;

procedure TFchCotation.quModelAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshHistory;
end;

procedure TFchCotation.PPageControlChange(Sender: TObject);
begin
  inherited;
  RefreshForm;
end;

procedure TFchCotation.RefreshModelResult;
begin
    try
       if (quResult.Active) then
          close;

       quResult.Parameters.ParamByName('IdCotacao').Value := quFormIDCotacao.AsInteger;
       quResult.Parameters.ParamByName('IDFornecedor').Value := quVendorResult.FieldByName('IDFornecedor').Value;
       quResult.Open;

    except
       on e: Exception do begin
          raise e.Create('Vendor not selected. Please, select one before go to response.');
       end;
    end;

end;

procedure TFchCotation.RefreshVendorResult;
var
 iIDVendor : Integer;
begin
   try
      try
         if (quVendorResult.Active) then
            close;

         quVendorResult.Parameters.ParamByName('IdCotacao').Value := quFormIDCotacao.AsInteger;
         quVendorResult.Open;

         iIdVendor := quVendorResult.FieldByName('IDFornecedor').Value;

         quVendorResult.Locate('IDFornecedor', iIDVendor, []);

      except
         on e: Exception do begin
            quVendorResult.Close;
            PPageControl.ActivePage := tsVendor;
            raise Exception.Create('Vendor not selected. Please, select one before go to response.');
         end;
      end;
   finally
       //Cursor := crDefault;
   end;

end;

procedure TFchCotation.quVendorResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshModelResult;
end;

procedure TFchCotation.btManufacturerAllClick(Sender: TObject);
begin
  inherited;
  scManufacturer.LookUpValue := '';
  RefreshRequest;
end;

procedure TFchCotation.btIncludeModelClick(Sender: TObject);
var
  IDModel,
  IDRequest : Integer;
  Qty : Double;

begin
  inherited;
  // Caso o request tenha sido baseado em um item de inventário
  // inclui o modelo no reuqest
  // senão da um aviso

  IDModel   := TADOQuery(dsRequest.DataSet).FieldByName('IDModel').AsInteger;
  Qty       := TADOQuery(dsRequest.DataSet).FieldByName('Qty').AsFloat;
  IDRequest := TADOQuery(dsRequest.DataSet).FieldByName('IDRequest').AsInteger;

  if not TADOQuery(dsRequest.DataSet).FieldByName('IDModel').IsNull then
      InsertModel( IDModel, Qty, IDRequest, True );

end;

procedure TFchCotation.dsModelDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btModelRemove.Enabled := NOT quModel.IsEmpty;
end;

procedure TFchCotation.dsRequestDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  btIncludeModel.Enabled    := NOT TADOQuery(dsRequest.DataSet).IsEmpty;
  btIncludeModelAll.Enabled := NOT TADOQuery(dsRequest.DataSet).IsEmpty;
  btRequestRemove.Enabled   := NOT TADOQuery(dsRequest.DataSet).IsEmpty;

  case not cmbRequestType.ItemIndex of
    0, 1, 2: begin
             btRequestRemove.Enabled := False;
             Exit;
             end;
  end;

end;

procedure TFchCotation.btIncludeModelAllClick(Sender: TObject);
var
  IDModel,
  IDRequest : Integer;
  Qty : Double;
begin
  inherited;

  with TADOQuery(dsRequest.DataSet) do
    begin
      try
        DisableControls;
        First;
        while not EOF do
          begin
          IDModel   := TADOQuery(dsRequest.DataSet).FieldByName('IDModel').AsInteger;
          Qty       := TADOQuery(dsRequest.DataSet).FieldByName('Qty').AsFloat;
          IDRequest := TADOQuery(dsRequest.DataSet).FieldByName('IDRequest').AsInteger;
          if not TADOQuery(dsRequest.DataSet).FieldByName('IDModel').IsNull then
             InsertModel( IDModel, Qty, IDRequest, False);
          Next;
          end;
        RefreshForm;
      Finally
        EnableControls;
      end;
    end;
end;

procedure TFchCotation.RefreshResult;
var
  CurrentIDModel, Col, Row: Integer;
  MinCost: Currency;
  MinCostCol: Integer;
  R: TRect;
  _index: integer;

begin
  // Abre os data set's que alimentam os headers das linhas e colunas
  RefreshVendor;
  RefreshModel;

  //slHighLight.Clear;

  // Ajusta o tamanho do StringGrid
  sgResult.RowCount := quModel.RecordCount + 1;
  sgResult.ColCount := quVendor.RecordCount + 1;

  // Se vazio aborta
  If (quModel.RecordCount = 0) or
     (quVendor.RecordCount = 0) then
     Exit;

  sgResult.Cells[0,0] := 'Model';
  sgResult.FixedCols := 1;
  sgResult.FixedRows := 1;

  // Mount vendor name like column header and save ID's to a StringList
  PaintResultColHeader;

  // Mount the lines (records) and save ID's to a StringList
  PaintResultRowHeader;

  // Leio o que já estava selecionado
  ReadCheckedItems;

  // Abre o data set com os itens de resultado
  with quResultGrid do
    begin
      if Active then
        begin
          if State in dsEditModes then
            begin
              UpdateRecord;
              Post;
            end;
          Close;
        end;

      Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
      Open;

      MinCost        := 9999999;
      MinCostCol     := 0;
      CurrentIDModel := quResultGridIDModel.AsInteger;

      while not EOF do
        begin
          if (CurrentIDModel <> quResultGridIDModel.AsInteger) then
            begin
              // Se hove quebra do IDMode, marca o min sale e reseta variaveis
              slHighLight.Add(IntToStr(MinCostCol) + ';' + IntToStr(slModelID.IndexOf(IntToStr(CurrentIDModel))+1));
              //sgResultDblClick(self);

              MinCost    := 9999999;
              MinCostCol := 0;
            end;

          // Para cada item, descubro o index da coluna e da linha e printo o custo

          Col := slVendorID.IndexOf(quResultGridIDFornecedor.AsString) + 1;
          Row := slModelID.IndexOf(quResultGridIDModel.AsString) + 1;

          sgResult.Cells[ Col, Row ] := FormatFloat('#,##0.00;#,##0.00; ', quResultGridCost.AsCurrency);

          // Testo se o atual é menor
          if (MinCost > quResultGridCost.AsCurrency)
             AND
             (quResultGridCost.AsCurrency <> 0)then
            begin
              MinCost := quResultGridCost.AsCurrency;
              MinCostCol := Col;
            end;

          CurrentIDModel := quResultGridIDModel.AsInteger;

          Next;
        end;

      // Adiciona o ultimo
      slHighLight.Add(IntToStr(MinCostCol) + ';' + IntToStr(slModelID.IndexOf(IntToStr(CurrentIDModel))+1));

      Close;
    end;

end;

procedure TFchCotation.PaintResultColHeader;
var
  _col: integer;
  _line: integer;
  CurrentVendor: TBookMarkStr;

begin
  slVendorID.Clear;

  with quVendor do
    begin
      try
        DisableControls;
        CurrentVendor := BookMark;

        First;
        _col  := 1; //1;
        _line := 0; // header

        // mount the vendors like columns header start at second[2] column. 
        while not EOF do
          begin
            slVendorID.Add(quVendorIDPessoa.AsString);
            sgResult.Cells[_col, _line] := quVendorVendor.AsString;
            Inc(_col);
            Next;
          end;

      finally
        BookMark := CurrentVendor;
        EnableControls;
      end;
    end;

end;

procedure TFchCotation.PaintResultRowHeader;
var
  _line: integer;
  CurrentModel: TBookMarkStr;
  _col: integer;
begin
  slModelID.Clear;

  with quModel do
    begin
      try
        DisableControls;
        CurrentModel := BookMark;

        First;
        _line := 1;

        sgResult.ColWidths[0] := 150;

        while not EOF do
          begin
            slModelID.Add(quModelIDModel.AsString);
            sgResult.Cells[0, _line] := quModelModel.AsString + '   ' + 'Last Cost: ' + FormatFloat('#,##0.00', quModelVendorCost.AsCurrency);
            Inc(_line);
            Next;
          end;

      finally
        BookMark := CurrentModel;
        EnableControls;
      end;
    end;
end;

procedure TFchCotation.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
  // Crio os string's list que fazem o lookup dos ID's
  slModelID    := TStringList.Create;
  slVendorID   := TStringList.Create;
  slHighLight  := TStringList.Create;
  slChecked    := TStringList.Create;

  //frmModelDetail.Init;
  SubListModelDetail.CreateSubList; 

  PPageControl.ActivePage := tsModel;

  //1 - PO
  SendForPO.Init(2);
  //2 - PriceQuote
  SendPriceQuote.Init(1);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sModel    := ' Model(s).';
           sRequest  := ' Request(s).';
           sVendor   := ' Vendor(s)';
           sItems    := ' Item(s)';
           end;

     LANG_PORTUGUESE :
           begin
           sModel    := ' Modelo(s)';
           sRequest  := ' Requisições.';
           sVendor   := ' Fornecedor(es)';
           sItems    := ' Iten(s)';
           end;

     LANG_SPANISH :
           begin
           sModel    := ' Modelo(s).';
           sRequest  := ' Solicitude(s)';
           sVendor   := ' Proveedor(s)';
           sItems    := ' Item(s)';
           end;
   end;

   if fIsRestricForm then
      begin
      btModelNew.Visible        := False;
      btModelRemove.Visible     := False;
      btIncludeModel.Visible    := False;
      btIncludeModelAll.Visible := False;
      btRequestNew.Visible      := False;
      btRequestRemove.Visible   := False;
      btVendorNew.Visible       := False;
      btVenderRemove.Visible    := False;
      sbReturne.Visible         := False;
      btCreatePO.Visible        := False;
      btCreatePOAll.Visible     := False;
      end;

end;

procedure TFchCotation.FormDestroy(Sender: TObject);
begin
  inherited;
  //frmModelDetail.UnInit;
  SendForPO.UnInit;
  SendPriceQuote.UnInit;  
  slModelID.Free;
  slVendorID.Free;
  slHighLight.Free;
  slChecked.Free;
end;

procedure TFchCotation.sgResultDrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var
  _canvas: TCanvas;
  _lowestCost: String;
begin
  inherited;

  if ( (Row > 0) and (Col > 0) ) then begin

      _canvas := sgResult.Canvas;
      _lowestCost := sgResult.Cells[col, row];

      if (slChecked.IndexOf(IntToStr(Col) + ';' + IntToStr(Row)) <> -1) and (slChecked.Count>0) then
        begin
          _canvas.Font.Color := clBlack;
          _canvas.Font.Style := [fsBold];
          _canvas.Brush.Color := clYellow;

          _canvas.FillRect(Rect);
          _canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, _lowestCost);

                  // Marco no BD
          DM.RunSQL( 'UPDATE CotacaoResult SET PO = 0 ' +
                     'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                     ' AND IDModel = ' + slModelID.Strings[row-1] +
                     ' AND IDFornecedor = ' + slVendorID.Strings[col-1]);

        end
      else if (slHighLight.IndexOf(IntToStr(Col) + ';' + IntToStr(Row)) <> -1) and (slHighLight.Count>0) then
        begin
          _canvas.Font.Color := clBlack;
          _canvas.Font.Style := [fsBold];
          _canvas.Brush.Color := clAqua;

          _canvas.FillRect(Rect);
          _canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, _lowestCost);
                  // Marco no BD
          DM.RunSQL( 'UPDATE CotacaoResult SET PO = 1 ' +
                     'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                     ' AND IDModel = ' + slModelID.Strings[row-1] +
                     ' AND IDFornecedor = ' + slVendorID.Strings[col-1]);
        end;
  end;

end;

procedure TFchCotation.sgResultDblClick(Sender: TObject);

    procedure UnCheckAll;
    var
      i: integer;
    begin
      // Desmarco todos os fornecedores para este item

      for i:= slChecked.Count - 1 downto 0 do
        begin
          if POS( ';' + IntToStr(sgResult.Row), slChecked.Strings[i] ) > 0 then
            slChecked.Delete(i);
        end;

      // Desmarco todos no BD
      DM.RunSQL( 'UPDATE CotacaoResult SET PO = 0 ' +
                 'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                 ' AND IDModel = ' + slModelID.Strings[sgResult.Row-1] );
    end;

// Main
begin
  inherited;

  with sgResult do
    begin
      if Trim(Cells[Col, Row]) <> '' then
        begin
          if slChecked.IndexOf(IntToStr(Col) + ';' + IntToStr(Row)) <> -1 then
            begin
              UnCheckAll;
            end
          else
            begin
              UnCheckAll;
              slChecked.Add(IntToStr(Col) + ';' + IntToStr(Row));

              {
              // Marco no BD
              DM.RunSQL( 'UPDATE CotacaoResult SET PO = 1 ' +
                         'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                         ' AND IDModel = ' + slModelID.Strings[sgResult.Row-1] +
                         ' AND IDFornecedor = ' + slVendorID.Strings[sgResult.Col-1] );


              // Marco no BD
              DM.RunSQL( 'UPDATE CotacaoResult SET PO = 1 ' +
                         'WHERE IDCotacao = ' + quFormIDCotacao.AsString +
                         ' AND IDModel = ' + slModelID.Strings[sgResult.Row-1] +
                         ' AND IDFornecedor = ' + slVendorID.Strings[sgResult.Col-1] );
              }
            end;
        end;
    end;

  ReadCheckedItems;

  sgResult.Repaint;
end;


procedure TFchCotation.ReadCheckedItems;
begin
  //slChecked.Clear;

  with quCheckedItems do
    begin
      Close;
      Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
      Open;
      while NOT EOF do begin
          if quCheckedItemsPO.AsBoolean then begin
              slHighLight.Add( IntToStr(slVendorID.IndexOf(quCheckedItemsIDFornecedor.AsString)+1) +
                             ';' +
                             IntToStr(slModelID.IndexOf(quCheckedItemsIDModel.AsString)+1));
          end;
          
          Next;
      end;
      Close;
    end;
end;




procedure TFchCotation.quPOVendorAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblPOVendorCount.Caption := IntToStr(quPOVendor.RecordCount) + sVendor;
end;

procedure TFchCotation.quPOItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblPOItemCount.Caption := IntToStr(quPOItem.RecordCount) + sItems;

end;

procedure TFchCotation.RefreshPOVendor;
begin
  with quPOVendor do
    begin
      if Active then
        Close;
      Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
      Open;
    end;
end;

procedure TFchCotation.RefreshPOItem;
begin
  with quPOItem do
    begin
      if Active then
        Close;
      Parameters.ParamByName('IDCotacao').Value    := quFormIDCotacao.AsInteger;
      Parameters.ParamByName('IDFornecedor').Value := quPOVendorIDFornecedor.AsInteger;
      Open;
    end;
end;


procedure TFchCotation.quPOVendorAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshPOItem;

end;

function TFchCotation.ExistPO():Boolean;
begin
   result := False;
   if ( quPOVendor.Active ) then begin
       with DM.quFreeSQL do begin
          if Active then
             Close;
          SQL.Clear;
          SQL.Add('SELECT IDPO FROM PO');
          SQL.Add('WHERE IDFornecedor ='+quPOVendorIDFornecedor.AsString);
          SQL.Add('AND IDStore =' +quFormIDStore.AsString);
          SQL.Add('AND Aberto = 1');

          Open;

          Result := (RecordCount<>0);

          Close;

       end;
   end;

end;


procedure TFchCotation.btCreatePOClick(Sender: TObject);
begin
  inherited;

  with quPOItem do
    begin
    if not Active then
       Open;

    if RecordCount = 0 then
     begin
     MsgBox(MSG_CRT_NO_POITEM, vbCritical + vbOkOnly);
     Exit;
     end;
    end;

  //Veificar se o PO ja foi criado
  if ExistPO then
     if MsgBox(MSG_QST_PO_OPEN_SAVE, vbYesNo + vbQuestion) = vbNo then
        Exit;

  try
      with spPOInsert do
        begin
          Parameters.ParamByName('@IDCotacao').Value    := quFormIDCotacao.AsInteger;
          Parameters.ParamByName('@IDFornecedor').Value := quPOVendorIDFornecedor.AsInteger;
          Parameters.ParamByName('@Date').Value         := quFormDataCotacao.AsDateTime;
          Parameters.ParamByName('@IDStore').Value      := DM.fStore.ID;
          Parameters.ParamByName('@IDUser').Value       := DM.fUser.ID;
          ExecProc;
        end;
       MsgBox(MSG_INF_PART1_PO_CREATE_MR + ' ' + quPOVendorVendor.AsString + ' ' + MSG_INF_PART2_PO_CREATE_MR
              ,vbInformation + vbOkOnly);

       isPOCreated := True;
       DisableTabsAfterPOCreated(isPOCreated);

      (*
       // Apply filter to show just itens not selected to generate a PO.
       if ( not quResult.Active )then begin
          quResult.Parameters.ParamByName('IdCotacao').Value := quFormIDCotacao.Value;
          quResult.Parameters.ParamByName('IdFornecedor').Value := quPOVendorIDFornecedor.Value;
          quResult.Open();
       end;

       JustNoPOInResponse(True)
       *)
   except
      on e:Exception do begin
         raise e.Create('Cannot create PO '+ e.Message);
      end;
   end;
end;

procedure TFchCotation.quModelQtyAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshDetail;

end;

procedure TFchCotation.RefreshDetail;
begin

  SubListModelDetail.Param := 'IDModel='+quModelQtyIDModel.AsString+';IDStore='+IntToStr(DM.fStore.ID);

end;

procedure TFchCotation.RefreshModelQty;
begin
  with quModelQty do
    begin
      if Active then
        Close;
      Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;
      Open;
    end;

end;

function TFchCotation.FillEmailOut:String;
var
i:Integer;
begin
  With quVendor do
    begin
    If RecordCount = 0 then
       Exit;
    i := 1;
    DisableControls;
    First;
    While i <= RecordCount do
       begin
       If Trim(quVendorEmail.AsString) <> '' then
          If i = RecordCount then
             Result := Result + quVendorEmail.AsString
          else
             Result := Result + quVendorEmail.AsString +', ';
       Next;
       Inc(i);
       end;
    EnableControls;
    end;
end;


procedure TFchCotation.grdModelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Return then
    with quModel do
      begin
        if State in dsEditModes then
          begin
            UpdateRecord;
            Post;
          end;
        Next;
      end;
end;

procedure TFchCotation.grdQuantityDblClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crHourGlass;

  if btIncludeModel.Enabled then
    btIncludeModelClick(nil);

  Screen.Cursor := crDefault;  

end;

procedure TFchCotation.dxDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Return then
    with quResult do
      begin
        if State in dsEditModes then
          begin
            UpdateRecord;
            Post;
          end;
        Next;
        if EOF then
          begin
            quVendorResult.Next;
            First;
          end;
      end;
end;

procedure TFchCotation.grdHistoryDblClick(Sender: TObject);
begin
  inherited;

  InsertVendor(quHistoryIDFornecedor.AsInteger);

end;

procedure TFchCotation.grdModelQtyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Return then
    with quModelQty do
      begin
        if State in dsEditModes then
          begin
            UpdateRecord;
            Post;
          end;
        Next;
      end;
end;

procedure TFchCotation.grdPoItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Return then
    with quPOItem do
      begin
        if State in dsEditModes then
          begin
            UpdateRecord;
            Post;
          end;
        Next;
      end;
end;

procedure TFchCotation.spHelpClick(Sender: TObject);
begin
  inherited;
  case PPageControl.ActivePageIndex of

       0 : Application.HelpContext(1480); //Select Models

       1 : Application.HelpContext(1490); //Select Vendors

       2 : Application.HelpContext(1500); //Select Responses

       3 : Application.HelpContext(1520); //Result Sheet

       4 : Application.HelpContext(1510); //Revise Quantities

       5 : Application.HelpContext(1530); //Sugg Purchase Orders

      end;
end;

procedure TFchCotation.quPOItemCalcFields(DataSet: TDataSet);
begin
  inherited;

  quPOItemQtyxCost.AsCurrency := quPOItemCost.AsCurrency * quPOItemQtyCotada.AsFloat;

end;

procedure TFchCotation.PostOnExit(Sender: TObject);
var
   update: TADOQuery;
begin
  inherited;

  if ( Sender = gridModelQty ) then begin
      with TDBGrid(Sender).DataSource.DataSet do begin
           if Active then
              if State in dsEditModes then
                 Post;
      end;
  end else if ( sender = grdVendorResult ) then begin
              // update in CotacaoResult to force the value typed on grid.
              try
                  TDBGrid(Sender).DataSource.DataSet.First;
                  while ( not TDBGrid(Sender).DataSource.DataSet.Eof ) do begin
                      update := TADOQuery.Create(nil);
                      update.Connection := dm.ADODBConnect;
                      update.SQL.Add('update CotacaoResult set Cost = :param_cost');
                      update.SQL.Add(' where Idmodel = :param_idmodel and IdFornecedor = :param_idfornecedor');

                      update.Parameters.ParamByName('param_cost').Value := TDBGrid(sender).DataSource.DataSet.fieldByName('Cost').Value;
                      update.Parameters.ParamByName('param_idmodel').Value := TDBGrid(sender).DataSource.DataSet.fieldByName('IdModel').Value;
                      update.Parameters.ParamByName('param_idfornecedor').Value := TDBGrid(sender).DataSource.DataSet.fieldByName('IdFornecedor').Value;

                      update.ExecSQL();
                      TDBGrid(Sender).DataSource.DataSet.Next();
                  end;
              finally
                  FreeAndNil(update);
              end;
      end;

end;

procedure TFchCotation.SendContactsbCreateFileClick(Sender: TObject);
begin
  inherited;

  with SendForPO do
     begin
     IDStore  := quFormIDStore.AsInteger;
     IDVendor := quPOVendorIDFornecedor.AsInteger;
     VendorName := quPOVendorVendor.AsString;
     IDPO     := -1;
     IDPayDay := -1;
     SetModelDataSet(quPOItem);
     end;

  SendForPO.sbEmailFileClick(Sender);

end;

procedure TFchCotation.SendForPObtPreviewVendorFaxClick(Sender: TObject);
begin
  inherited;

  with SendForPO do
  begin
   if quPOVendor.Active then
      VendorName := quPOVendorVendor.asString;
   IDStore := quFormIDStore.AsInteger;
  end;

  SendForPO.btPreviewVendorFaxClick(Sender);

end;

procedure TFchCotation.sbReturneClick(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TFrmCreateFile, FrmCreateFile);

  With FrmCreateFile do
    begin
    //verificar o nome do arquivo
    sFileName := 'Desc' + edtPOName.Text + '.txt';
    LbTotal.Caption := IntToStr(quModel.RecordCount)+ ' Record(s)';
    quEmail.Parameters.ParamByName('IDCotacao').Value := quFormIDCotacao.AsInteger;

    Start(quEmail, quSaveEmail, quResult);
    SbOpen.Enabled := True;
    IDVendor.Caption := quVendorResultIDFornecedor.AsString;
    LbVendorName.Caption := quVendorResultFornecedor.AsString;
    ShowModal;

    quEmail.Close;
    Free;
    end;

  RefreshForm;

end;

procedure TFchCotation.SendPriceQuotesbEmailFileClick(Sender: TObject);
begin
  inherited;

  with SendPriceQuote do
     begin
     VendorName := Self.quVendorVendor.AsString;
     IDStore    := quFormIDStore.AsInteger;
     SetVendorDataSet(Self.quVendor);
     SetModelDataSet(Self.quModel);
     sbEmailFile.Enabled := (Pos('@', quVendorEmail.Value) > 0);
     end;

  SendPriceQuote.sbEmailFileClick(Sender);

end;

procedure TFchCotation.SendPriceQuotesbSendFaxClick(Sender: TObject);
begin
  inherited;
  
  with SendPriceQuote do
     begin
     IDStore    := quFormIDStore.AsInteger;
     VendorName := Self.quVendorVendor.AsString;
     SetVendorDataSet(Self.quVendor);
     SetModelDataSet(Self.quModel);
     end;

end;

procedure TFchCotation.SendPriceQuotebtPreviewVendorFaxClick(
  Sender: TObject);
begin
  inherited;

  with SendPriceQuote do
  begin
    VendorName := Self.quVendorVendor.AsString;
    IDStore    := quFormIDStore.AsInteger;
  end;

  SendPriceQuote.btPreviewVendorFaxClick(Sender);

end;

procedure TFchCotation.JustNoPOInResponse(argHasPO: Boolean);
begin
   if ( argHasPO ) then begin
      quResult.Filter := 'PO = False';  // to get just itens without a PO
      quResult.Filtered := True;
   end else begin
           quResult.Filtered := False; 
       end;
end;

procedure TFchCotation.DisableTabsAfterPOCreated(argPOCreated: Boolean);
begin
     if ( argPOCreated ) then begin
        tsReturn.TabVisible := False;
        tsQty.TabVisible := tsReturn.TabVisible;
        tsResult.TabVisible := tsReturn.TabVisible;
        tsPO.TabVisible := tsReturn.TabVisible;
     end else begin
            tsReturn.TabVisible := True;
            tsQty.TabVisible := tsReturn.TabVisible;
            tsResult.TabVisible := tsReturn.TabVisible;
            tsPO.TabVisible := tsReturn.TabVisible;
         end;
end;

procedure TFchCotation.btCloseClick(Sender: TObject);
begin
  inherited;
  if ( not isPOCreated ) then begin

      DM.RunSQL( 'UPDATE CotacaoResult SET PO = 0 ' +
                 'WHERE IDCotacao = ' + quFormIDCotacao.AsString);
  end;
end;

procedure TFchCotation.btCancelClick(Sender: TObject);
begin
  btCloseClick(sender);
  inherited;

end;

procedure TFchCotation.DBEdit3Change(Sender: TObject);
begin
  inherited;
  SendPriceQuote.sbEmailFile.Enabled := (Pos('@', quVendorEmail.Value) > 0);
end;

end.
