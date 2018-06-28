unit PaiDeBrowses;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, Grids, ExtCtrls, DB, Variants,
  DBTables, LblEffct, DBGrids, Buttons, ComCtrls, PaiDeFichas,
  PowerADOQuery, PanelRights, Menus,  BrowseConfig, RCADOQuery, uWaitForm,
  Mask, DateBox, ImgList, ADODB, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxGridCustomPopupMenu, cxGridPopupMenu, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxPSCore,  dxPScxGridLnk, uSystemTypes;

type
  TbrwParent = class(TFrmParent)
    pnlButton: TPanelRights;
    quBrowse: TPowerADOQuery;
    dsBrowse: TDataSource;
    pnlMainBrowse: TPanel;
    pnlPage: TPanel;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    pnlBasicFilter: TPanel;
    btAdd: TSpeedButton;
    btDetail: TSpeedButton;
    btRemove: TSpeedButton;
    panel8: TPanel;
    lblBasicFilter: TLabel;
    pnlMain: TPanel;
    BrowseConfig: TBrowseConfig;
    pnlDivisor: TPanel;
    imgFolder: TImage;
    ImgTrash: TImage;
    btRestore: TSpeedButton;
    pnlGenFilter: TPanel;
    lblGenFilter: TLabel;
    btPrint: TSpeedButton;
    spHelp: TSpeedButton;
    btExcel: TSpeedButton;
    SD: TSaveDialog;
    btFilter: TSpeedButton;
    pblGO: TPanel;
    TimeAviso: TTimer;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    pnlDivisoria2: TPanel;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    grdBrowse: TcxGrid;
    gridPrinter: TdxComponentPrinter;
    GridPopupMenu: TcxGridPopupMenu;
    gridPrinterLink: TdxGridReportLink;
    btnVideo: TSpeedButton;
    procedure CommandClick(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btPreviousPageClick(Sender: TObject);
    procedure btFirstPageClick(Sender: TObject);
    procedure btLastPageClick(Sender: TObject);
    procedure brwGridTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure brwGridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure imgFolderDblClick(Sender: TObject);
    procedure ImgTrashDblClick(Sender: TObject);
    procedure quBrowseAfterScroll(DataSet: TDataSet);
    procedure brwGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btExcelClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure TimeAvisoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdBrowseDBFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure grdBrowseDBFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure grdBrowseDBColumnHeaderClick(
      Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure grdBrowseDBCustomization(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    { Private declarations }
    MyquBrowseParams      : TParameters;
    ColorList, ValueList  : TStringList;
    IsMoved    : Boolean;
    NoStateOriginalSQL, FirstRowID : String;
    OldSQLText : String;
    OldFirstOrder  : integer;
    IndexFieldKey1, IndexFieldKey2 : integer;
    WaitForm : TWaitForm;
    sLinesTotal, sLine, sLineOf, sNoLine : String;
    fRegistryPath : String;

    procedure ExecDeleteItem;
    procedure ExecRestoreItem;
    procedure UpdateButtons;
    procedure AtuVisiblePage;
    function  GetActualSQL : String;

  protected
    sUrlHelp, sUrlVideo : String;
    brwForm  : TbrwFrmParent;
    AView    : TcxCustomGridTableView;

    procedure SetBrowseState;
    procedure PushError(ErrorType: Integer; sError: String);

    procedure AfterSetBrowseState; virtual;

    procedure OnBeforeDeleteItem; Virtual;
    procedure OnBeforeRestoreItem; Virtual;
    procedure OnAfterDeleteItem; Virtual;
    procedure OnBeforeExecSQL; Virtual;
    procedure OnAfterRestoreItem; Virtual;
    
    function ValidateDeleteItem:Boolean; virtual;

    procedure ExecBrowseSQLOnDelete; virtual;
    procedure ExecBrowseSQLOnRestore; virtual;

    //Rodrigo - Pnl Pisca BtnGo
    procedure AtivaAviso;
    procedure DesativaAviso;
    procedure LoadImages; virtual;

    //Replication controls
    procedure ReplicationControls; virtual;
    procedure OnBeforeCommandClick(pCommand : TBtnCommandType); virtual;
    procedure OnAfterCommandClick(pCommand : TBtnCommandType); virtual;

  public
    { Public declarations }
    Inicio            : Boolean;
    ActualOrder       : integer;
    ActualTypeOrder   : integer;
    ClickedPos, ClickedField, RealClickedField  : integer;
    Filter         : String;
    OriginalSQL    : String;
    aWhereBasicFilters: array[0..20] of String;
    WhereTreeFilter, WhereGenFilter, WhereSpecial, HavingGenFilter : String;
    sParam         : String;
    //Undo Filter
    aSQLFilter : array[0..20] of String;
    iCounter : integer;
    //Grid
    GridColumn : TcxGridColumn;
    procedure RefreshOnUpdate(PosID1, PosID2, FieldKey1, FieldKey2 : String);
    function LocatePage(aFields : array of integer;
                        aValues : array of string;
                        IsLocate, IsBigger, IsLastInPage : Boolean) : integer;
    procedure RollBackSQL;
    function  ExecBrowseSQL(IsFirstOrFilter : Boolean; arg_originalSQL: String = '') : integer;
    procedure Start;
    procedure ClearSQLFilter;
  end;

implementation

{$R *.DFM}

uses xBase, uPassword, uDM, uMsgBox, uParamFunctions, uWebFunctions,
     uSqlFunctions, uStringFunctions, uMsgConstant, uNumericFunctions,
     uDataBaseFunctions, uSystemConst, uVarianteFunctions, uDMGlobal,
     uHandleError, uFrmExport, DateUtils, cxStyleSheetEditor, cxLookAndFeels;


procedure TbrwParent.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_ADD, btAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_RESTORE, btRestore.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btDetail.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_PREVIEW, btPrint.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_FILTER, btFilter.Glyph);
end;

procedure TbrwParent.PushError(ErrorType: Integer; sError: String);
begin

  DM.SetError(ErrorType, Self.Name, sError);

end;

procedure TbrwParent.ClearSQLFilter;
var i : integer;
begin

  For i := 0 to iCounter do
    begin
    aSQLFilter[i] := '';
    end;

  iCounter := 0;

end;


procedure TbrwParent.Start;
var
  AOptions: TcxGridStorageOptions;
  ASaveViewName : String;
begin

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sLinesTotal := ' Line(s).';
           sLine       := '  Line ';
           sLineOf     := ' of ';
           sNoLine     := '  Empty list.';
           end;

     LANG_PORTUGUESE :
           begin
           sLinesTotal := ' Linha(s).';
           sLine       := '  Linha ';
           sLineOf     := ' de ';
           sNoLine     := '  Lista vazia.';
           end;

     LANG_SPANISH :
           begin
           sLinesTotal := ' Linea(s).';
           sLine       := '  Linea ';
           sLineOf     := ' de ';
           sNoLine     := '  Lista Vacia.';
           end;
   end;


  // Seta o browse da ficha
  if brwForm <> nil then
     begin
     brwForm.FchBrowse := Self;
     brwForm.sParam    := Self.sParam;
     end;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + lblSubMenu.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  Case DM.fGrid.Kind of
   0 : grdBrowse.LookAndFeel.Kind := lfStandard;
   1 : grdBrowse.LookAndFeel.Kind := lfFlat;
   2 : grdBrowse.LookAndFeel.Kind := lfUltraFlat;
  end;

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
     TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

  // Seta os direitos do browse
  pnlButton.Commands := Password.SetRights(pnlButton.Commands);

  //Para ser herdado
  OnBeforeExecSQL;

  //significa que vai executar o SQL ao Abrir
  if BrowseConfig.AutoOpen then
     ExecBrowseSQL(True)
  else
     begin
     //Ativar o aviso do Btn Go caso nao seja auto open
     AtivaAviso;
     //Atualiza os botoes
     UpdateButtons;
     end;

  //Da o show
  ShowModal;

  //Salvar para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
  
end;

procedure TbrwParent.AtivaAviso;
begin
  TimeAviso.Enabled := True;
end;

procedure TbrwParent.DesativaAviso;
begin
  TimeAviso.Enabled := False;
  pnlAviso.ParentColor := True;
end;


procedure TbrwParent.CommandClick(Sender : TObject);
var
  pCommand : TBtnCommandType;
  i        : integer;
  PosID1, PosID2: String;
begin

  pCommand := TBtnCommandType(TComponent(Sender).Tag);

  OnBeforeCommandClick(pCommand);

  case pCommand of

       btInc, btAlt : begin
                        Screen.Cursor := crHourGlass;
                        Inicio := False;

                        //amfsouza June 28, 2012
                        BrowserQuery := quBrowse;

                        brwForm.Start(pCommand, quBrowse, False,
                                      PosID1, PosID2, grdBrowse);

                        Screen.Cursor := crDefault;

                      end;

       btExc        :
                      if ValidateDeleteItem then
                        ExecDeleteItem;

       btFlt        : begin
                       if btFilter.Down then
                          begin
                          TcxGridDBTableView(AView).Filtering.Visible := fvAlways;
                          TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := True;
                          end
                       else
                          begin
                          TcxGridDBTableView(AView).Filtering.Visible := fvNever;
                          TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := False;
                          end;
                      end;


       btImp        : begin
                      gridPrinterLink.Caption := lblSubMenu.Caption;
                      gridPrinter.Preview(True, nil);
                      end;

       btRest       : ExecRestoreItem;

  end;

  if pCommand <> btPos then
     grdBrowse.SetFocus;

  OnAfterCommandClick(pCommand);

end;

procedure TbrwParent.FormCreate(Sender: TObject);
var
   i: integer;
   P: integer;
   MySqlStatement : TSQlStatement;
   aBrowseKeys    : Variant;
begin
  inherited;
  LoadImages;

  Inicio := True;

  WaitForm := TWaitForm.Create(Self);

  if quBrowse.Active then Close;

  //Pega o Browser atual
  AView := TcxCustomGridTableView(grdBrowse.FocusedView);

  // Salva os parametros do quBrowse
  MyquBrowseParams := TParameters.Create(Self, nil);
  MyquBrowseParams.Assign(quBrowse.Parameters);

  ColorList   := TStringList.Create;
  ValueList   := TStringList.Create;

  IsMoved     := False;

  // Reseta String Where variaveis
  lblBasicFilter.Caption := '';
  WhereGenFilter    := '';
  WhereTreeFilter   := '';
  WhereSpecial      := '';
  HavingGenFilter   := '';

  // Limpa o String
  for i := Low(aWhereBasicFilters) to High(aWhereBasicFilters) do
    aWhereBasicFilters[i] := '';

  // Seta o originalSQL
  OriginalSQL := quBrowse.CommandText;
  NoStateOriginalSQL := OriginalSQL;

  // Seta o estado do browse, sobre a delecao ou restore de itens, se mostar desativado ou nao
  SetBrowseState;

  //  Seta a propriedade KeyFields
  if TcxGridDBTableView(AView).DataController.KeyFieldNames <> '' then
    begin
      IndexFieldKey1 := quBrowse.FieldByName(TcxGridDBTableView(AView).DataController.KeyFieldNames).Index;
      IndexFieldKey2 := -1;
    end
  else
    begin
    // Seta as keys dos Browses
    aBrowseKeys := GetTableKeys(DM.quFreeSQL, GetSQLFirstTableName(OriginalSQL));
    if aBrowseKeys[0] <> '' then
      begin
        IndexFieldKey1 := quBrowse.FieldByName(aBrowseKeys[0]).Index;
        if VarArrayHighBound(aBrowseKeys, 1) > 0 then
           IndexFieldKey2 := quBrowse.FieldByName(aBrowseKeys[1]).Index
        else
           IndexFieldKey2 := -1;
      end
    else
      begin
        IndexFieldKey1 := BrowseConfig.ViewIndexFieldKey1;
        IndexFieldKey2 := BrowseConfig.ViewIndexFieldKey2;
      end;
   end;

  quBrowse.KeyFields := quBrowse.Fields[IndexFieldKey1].FieldName;

end;

procedure TbrwParent.FormDestroy(Sender: TObject);
begin
  inherited;

  If quBrowse.Active then
     quBrowse.Close;

  WaitForm.Free;

  MyquBrowseParams.Free;
  ColorList.Free;
  ValueList.Free;

  brwForm.Free;       // Tira a ficha da memoria
end;

procedure TbrwParent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TbrwParent.UpdateButtons;
var
   lEnabled : Boolean;
begin

  with quBrowse do
     // Atualiza botoes
     lEnabled := not (Eof and Bof);

  pnlButton.UpdateButtons(lEnabled);

  // Seta o Panel de filtro
  pnlGenFilter.Visible := ((WhereGenFilter <> '') or (HavingGenFilter <> '')) AND quBrowse.Active;

  if not pnlGenFilter.Visible then
    lblGenFilter.Caption := '';

end;

procedure TbrwParent.AtuVisiblePage;
begin
end;

procedure TbrwParent.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TbrwParent.btPreviousPageClick(Sender: TObject);
var
   Ret        : Integer;
   IsPrevious : Boolean;
begin
  inherited;
  with quBrowse do
   begin
     try
       DisableControls;
       IsPrevious := (TBitBtn(Sender).Tag = 0);
       if IsPrevious then
          if ActualTypeOrder = ORDER_ASC then First else Last
       else
          if ActualTypeOrder = ORDER_ASC then Last  else First;

       Ret := LocatePage([ActualOrder], [Fields[ActualOrder].AsString],
                         False, True, IsPrevious);

       if Ret = 0 then
         begin
           MsgBox(MSG_EXC_NO_MORE_ROWS_RETRIVE, vbOKOnly + vbExclamation);
           // Deve retornar ao antigo
           RollBackSQL;
         end;

     finally
       EnableControls;
     end;
   end;
end;

function TbrwParent.ExecBrowseSQL(IsFirstOrFilter : Boolean; arg_originalSQL: String) : integer;
var
  NewSQL     : String;
  i, FirstIndex : integer;
  MySqlStatement : TSQlStatement;
begin

  // Antonio 2014 Aug 13
  if ( arg_originalSQL <> '' ) then
     OriginalSQL := arg_originalSQL;

 // showMessage(format('original sql: %s', [OriginalSQL]));

  // Antonio 2014 Aug 06
  if ( waitForm = nil ) then
     waitForm := TWaitForm.create(self);

  WaitForm.Start(False);

  Application.ProcessMessages;

  Screen.Cursor := crHourGlass;

  FirstIndex  := ActualOrder;

  with quBrowse do
   begin
     try
        DisableControls;
        if Active then Close;
        // Salva a antiga expressao do query
        OldSQLText := CommandText;
        OldFirstOrder  := FirstIndex;

        //SQL.Clear;
        // Seta o NewSQL referente aos setting atuais
        NewSQL := GetActualSQL;

        // Coloca o order by escolhido
        MySqlStatement := UnMountSQL(NewSQL);

//        MySqlStatement[ST_ORDER] := GetFieldAlias(quBrowse.Fields[FirstIndex].FieldName, NewSQL) +
//                                    quBrowse.Fields[FirstIndex].FieldName;

        // Coloca o tipo de ordenacao
//        if ActualTypeOrder = ORDER_ASC then
//           MySqlStatement[ST_ORDER] := MySqlStatement[ST_ORDER] + ' ASC'
//        else
//           MySqlStatement[ST_ORDER] := MySqlStatement[ST_ORDER] + ' DESC';

        NewSQL := MountSQL(MySqlStatement);
        //showMessage(format('sql mounted: %s', [newSQL]));

        quBrowse.CommandText := NewSQL;

        // Restaura os tipos dos paramteros do browse
        for i := 0 to Parameters.Count - 1 do
           Parameters.Items[i].DataType := MyquBrowseParams.Items[i].DataType;

        quBrowse.Open;

        if IsFirstOrFilter then
          begin
           // AtuVisiblePage; RCGAY
           FirstRowID := quBrowse.Fields[ActualOrder].AsString;
          end;

        // retorna numero de linhas
        Result := quBrowse.RecordCount;

        UpdateButtons;

     finally
        EnableControls;

        // Antonio 2014 Aug 06
        if ( Aview = nil ) then
            AView := TcxCustomGridTableView(grdBrowse.FocusedView);

        // Autaliza o alinha atual e o total
        if (AView.Controller.FocusedRecord = nil) or (quBrowse.RecordCount = 0) then
          begin
            if AView.ViewData.RecordCount > 0 then
              pnlPage.Caption := '  ' + IntToStr(quBrowse.RecordCount) + sLinesTotal
            else
              pnlPage.Caption := sNoLine
          end
        else
          pnlPage.Caption := sLine + IntToStr(AView.Controller.FocusedRecord.Index + 1) + sLineOf + IntToStr(quBrowse.RecordCount) + '.';

        DesativaAviso;

        WaitForm.Hide;

        Screen.Cursor := crDefault;
     end;
   end;
end;

procedure TbrwParent.RollBackSQL;
begin
  with quBrowse do
   begin
     try
        DisableControls;
        if Active then Close;
        CommandText := OldSQLText;
        quBrowse.Open;
        UpdateButtons;
     finally
        EnableControls;
     end;
   end;
end;

procedure TbrwParent.btFirstPageClick(Sender: TObject);
begin
  inherited;
  // E a mesma coisa que trocar a ordem
  ExecBrowseSQL(False);
end;

function TbrwParent.LocatePage(aFields : array of integer;
                               aValues : array of string;
                               IsLocate, IsBigger, IsLastInPage : Boolean) : integer;
var
   i : integer;
   MyFieldName : String;
   MyField : TField;
   OpFirst, OpLast, LocalOldSQLText, StrSQLFirst,
   StrSQLLast, StrSearch, StrValues, NewSQL : String;
   MySqlStatement : TSqlStatement;
begin
  // Procura na pagina
  StrSQLFirst := '';
  StrSQLLast  := '';
  StrSearch   := '';
  StrValues   := '';
  NewSQL      := '';

  OldSqlText  := quBrowse.CommandText;

  // colocar parametro para maior que a chave ou maior ou igual a chave
  // procurada.
  if IsBigger then
    begin
     if ActualTypeOrder = ORDER_ASC then OpFirst := ' > ' else OpFirst := ' < ';
     if ActualTypeOrder = ORDER_ASC then OpLast  := ' < ' else OpLast  := ' > ';
    end
  else
    begin
     if ActualTypeOrder = ORDER_ASC then OpFirst := ' >= ' else OpFirst := ' <= ';
     if ActualTypeOrder = ORDER_ASC then OpLast  := ' <= ' else OpLast  := ' >= ';
    end;

  with quBrowse do
   begin
    try
     DisableControls;
     for i := Low(aFields) to High(aFields) do
       begin
         MyFieldName := Fields[aFields[i]].FieldName;
         MyField     := Fields[aFields[i]];
         // String WHERE first
         IncString(StrSQLFirst, MyFieldName + OpFirst +
                   ConvSQLValue(MyField, aValues[i]));
         // String WHERE last
         IncString(StrSQLLast, MyFieldName + OpLast +
                   ConvSQLValue(MyField, aValues[i]));
         // String Locate
         IncString(StrSearch, MyFieldName);
         IncString(StrValues, aValues[i]);
         if i < High(aFields) then
           begin
            IncString(StrSQLFirst, ' AND ');
            IncString(StrSQLLast, ' AND ');
            IncString(StrValues, ';');
            IncString(StrSearch, ';');
           end;
       end;

     // Se deu certo Result = recordcount
     // Se deu erro  Result = -1
     // Se nao for MultiPage sempre entra no Locate

     if (not BrowseConfig.MultiPage) or IsLocate then
        try
         if Locate(StrSearch, ConvVarArray(StrValues), [loPartialKey, loCaseInsensitive]) then
           begin
             Result := RecordCount;
             EnableControls;
             Exit;
           end
         else if not BrowseConfig.MultiPage then
           begin
             Result := 0;
             EnableControls;
             Exit;
           end;
        except
          on exception do
           begin
             Result := -1;
             EnableControls;
             Exit;
           end;
        end;

     // teste de procura a ser utilizada
     if IsLastInPage then
       begin
         // Acha o ultimo da pagina anterior

         WhereSpecial := StrSQLLast;
         NewSQL       := GetActualSQL;

         // Coloca o order by escolhido
         MySqlStatement := UnMountSQL(NewSQL);

         MySqlStatement[ST_ORDER] := GetFieldAlias(Fields[aFields[0]].FieldName, NewSQL) +
                                     Fields[aFields[0]].FieldName;

         for i := 1 to High(aFields) do
            IncString(MySqlStatement[ST_ORDER], ', ' + GetFieldAlias(Fields[aFields[i]].FieldName, NewSQL) +
                                                       Fields[aFields[i]].FieldName);

         if ActualTypeOrder = ORDER_ASC then
            IncString(MySqlStatement[ST_ORDER], ' DESC ')
         else
            IncString(MySqlStatement[ST_ORDER], ' ASC ');

         NewSQL := MountSQL(MySqlStatement);

         try
           if Active then Close;
           OldSQLText := CommandText;
           LocalOldSQLText := OldSQLText;
           CommandText   := NewSQL;
           Open;
           if Bof and Eof then
              // Retornou vazio
             begin
               EnableControls;  // Restaura o estado anterior
               Result := 0;
               Exit;
             end;
           Last;
           NewSQL := '';
           StrSQLLast := '';
           for i := Low(aFields) to High(aFields) do
             begin
               if ActualTypeOrder = ORDER_ASC then
                  IncString(StrSQLLast, Fields[aFields[i]].FieldName + ' >= ' +
                            ConvSQLValue(Fields[aFields[i]], Fields[aFields[i]].AsString))
               else
                  IncString(StrSQLLast, Fields[aFields[i]].FieldName + ' <= ' +
                            ConvSQLValue(Fields[aFields[i]], Fields[aFields[i]].AsString));

               if i < High(aFields) then
                  IncString(StrSQLLast, ' AND ');
             end;

           WhereSpecial := StrSQLLast;

           ActualOrder := aFields[0];

           Result := ExecBrowseSQL(False);

           if IsLocate then
              if Locate(StrSearch, ConvVarArray(StrValues), [loPartialKey, loCaseInsensitive]) then
                 Result := RecordCount
              else
                begin
                 OldSQLText := LocalOldSQLText;
                 Result  := 0;
                end;
         finally
           EnableControls;
         end;
       end
     else
       begin
         // First in page
         WhereSpecial := StrSQLFirst;

         ActualOrder  := aFields[0];

         Result := ExecBrowseSQL(False);
       end;
    finally
      EnableControls;
    end;
   end;
end;

procedure TbrwParent.btLastPageClick(Sender: TObject);
var
   LastID : String;
begin
  inherited;

  with DM.quFreeSQL do
   begin
      if Active then
         Close;
      SQL.Text := BuildMaxSQL(quBrowse.Fields[ActualOrder].FieldName,
                              GetActualSQL);
      Open;
      if Eof and Bof then
        begin
         Close;
         raise exception.create('There is no items');
        end;
      LastID := Fields[0].AsString;
      Close;
   end;

   if LocatePage([ActualOrder], [LastID], False, False, True) = 0 then
     begin
      MsgBox(MSG_EXC_NO_MORE_ROWS_RETRIVE, vbOkOnly + vbExclamation);
      // Deve retornar ao antigo
      RollBackSQL;
     end;
end;

function TbrwParent.GetActualSQL : String;
var
  i: integer;

begin
  Result := OriginalSQL;

  for i := Low(aWhereBasicFilters) to High(aWhereBasicFilters) do
    if aWhereBasicFilters[i] <> '' then
      Result := ChangeWhereClause(Result, aWhereBasicFilters[i], False);

  if not (WhereGenFilter = '') then
     Result := ChangeWhereClause(Result, WhereGenFilter, False);
  if not (WhereTreeFilter = '') then
     Result := ChangeWhereClause(Result, WhereTreeFilter, False);
  if not (WhereSpecial = '') then
     Result := ChangeWhereClause(Result, WhereSpecial, False);

  if not (HavingGenFilter = '') then
     Result := ChangeHavingClause(Result, HavingGenFilter, False);

  // Reseta valor de WhereSpecial
  WhereSpecial := '';
end;

procedure TbrwParent.RefreshOnUpdate(PosID1, PosID2, FieldKey1, FieldKey2 : String);
begin
 with qubrowse do
  if Active then
    begin
     try
       DisableControls;
       Close;
       Open;
       // AtuVisiblePage; RCGAY
       if PosID2 = '' then
          LocatePage([IndexFieldKey1], [PosID1], True, False, True)
       else
         begin
           LocatePage([quBrowse.FieldByName(FieldKey1).Index, quBrowse.FieldByName(FieldKey2).Index],
                      [PosID1, PosID2], True, False, True);
         end;
     finally
       EnableControls;
     end;

    end;
end;

procedure TbrwParent.brwGridTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  inherited;
  // Muda o titulo para mostrar quem esta ordenado
end;

procedure TbrwParent.brwGridCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  PosList : integer;
begin
  inherited;

  if BrowseConfig.MultiplasCores then 
    begin
      PosList := ColorList.IndexOf(quBrowse.Fields[ActualOrder].AsString);
      if PosList = -1  then
        begin
         if ColorList.Count > 0 then
           begin
            ColorList.Add(quBrowse.Fields[ActualOrder].AsString);
            if ValueList.Strings[ValueList.Count-1] = '1' then
               ValueList.Add('0')
            else
               ValueList.Add('1');
           end
         else
           begin
            ColorList.Add(quBrowse.Fields[ActualOrder].AsString);
            ValueList.Add('1');
           end;

         PosList := ColorList.Count-1;
        end;

      if ValueList.Strings[PosList] = '1' then
         ABrush.Color     := BrowseConfig.Cor1
      else
         ABrush.Color     := BrowseConfig.Cor2;

      if HighLight then
        begin
         AFont.Color     := ABrush.Color;        
         ABrush.Color    := BrowseConfig.CorHighLight;
        end;
    end;
end;

procedure TbrwParent.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if ColorList <> nil then
    begin
     ColorList.Clear;
     ValueList.Clear;
    end;

  UpdateButtons;

end;

procedure TbrwParent.imgFolderDblClick(Sender: TObject);
begin
  inherited;
  BrowseConfig.MostraDesativado := STD_DESATIVADO;
  SetBrowseState;
  ExecBrowseSQL(True);
end;


procedure TbrwParent.ImgTrashDblClick(Sender: TObject);
begin
  inherited;
  BrowseConfig.MostraDesativado := STD_NAODESATIVADO;
  SetBrowseState;
  ExecBrowseSQL(True);
end;

procedure TbrwParent.SetBrowseState;
begin
  OriginalSQL := ChangeSQLState(NoStateOriginalSQL, BrowseConfig.MostraDesativado,
                                BrowseConfig.MostraHidden);

  // Seta se mostra o trash
  case BrowseConfig.MostraDesativado of
       STD_NAODESATIVADO   : begin
                               btRestore.Visible := False;
                               ImgFolder.Visible := True;
                               ImgTrash.Visible  := False;
                             end;
       STD_DESATIVADO      : begin
                               btRestore.Visible := True;
                               ImgFolder.Visible := False;
                               ImgTrash.Visible  := True;
                             end;
       STD_AMBOSDESATIVADO : begin
                               btRestore.Visible := False;
                               ImgFolder.Visible := False;
                               ImgTrash.Visible  := False;
                             end;
  end;

  btAdd.Visible     := not btRestore.Visible;

  //Enable replication buttons
  ReplicationControls;

  AfterSetBrowseState;

end;

procedure TbrwParent.ExecDeleteItem;
var
  Ret         : Boolean;
  DeleteTable : String;
  aKeys       : Variant;
  MyFieldKey1, MyFieldKey2 : Integer;
  MyFieldKey1Name, MyFieldKey2Name : String;
  MyFieldValue1 : String;
  iIndex : Integer;
begin
  Ret := False;

  Try

    //Pega o valor do Key da grid, pois o Dataset nao esta ligado com o Grid
    if (TcxCustomGridTableView(grdBrowse.FocusedView).Controller.SelectedRecordCount > 0) then
    begin
       iIndex := grdBrowseDB.GetColumnByFieldName(grdBrowseDB.DataController.KeyFieldNames).Index;
       MyFieldValue1 := IntToStr(TcxCustomGridTableView(grdBrowse.FocusedView).Controller.FocusedRecord.Values[iIndex]);
    end
    else
       Exit;


      if BrowseConfig.ViewDeleteTable = '' then
        begin
         DeleteTable := GetSQLFirstTableName(quBrowse.CommandText);
         MyFieldKey1 := IndexFieldKey1;
         MyFieldKey1Name := quBrowse.Fields[MyFieldKey1].FieldName;
         MyFieldKey2 := IndexFieldKey2;
         if MyFieldKey2 > 0 then
            MyFieldKey2Name := quBrowse.Fields[MyFieldKey2].FieldName;
        end
      else
        begin
         DeleteTable := BrowseConfig.ViewDeleteTable;

         aKeys := GetTableKeys(DM.quFreeSQL, DeleteTable);

         MyFieldKey1 := BrowseConfig.ViewIndexFieldKey1;
         MyFieldKey1Name := aKeys[0];

         if VarArrayHighBound(aKeys, 1) > 0 then
           begin
            MyFieldKey2     := BrowseConfig.ViewIndexFieldKey1;
            MyFieldKey2Name := aKeys[1];
           end
         else
            MyFieldKey2 := -1;
        end;

      if BrowseConfig.MostraDesativado = STD_DESATIVADO then // ** Lixeira
        begin
          if (MsgBox(MSG_QST_DELETE_PERMANENT, vbYesNo + vbQuestion) = vbYes) then
            begin
               OnBeforeDeleteItem;
               if MyFieldKey2 >= 0 then
                  Ret := SystemDeleteItem(DM.quFreeSQL,
                                          DeleteTable,
                                          [MyFieldKey1Name,
                                           MyFieldKey2Name],
                                          [quBrowse.Fields[MyFieldKey1].AsString,
                                           quBrowse.Fields[MyFieldKey2].AsString],
                                          [quBrowse.Fields[MyFieldKey1].DataType,
                                           quBrowse.Fields[MyFieldKey2].DataType],
                                          BrowseConfig.CheckSystemOnDelete, True)
               else
                  Ret := SystemDeleteItem(DM.quFreeSQL,
                                          DeleteTable,
                                          [MyFieldKey1Name],
                                          [quBrowse.Fields[MyFieldKey1].AsString],
                                          [quBrowse.Fields[MyFieldKey1].DataType],
                                          BrowseConfig.CheckSystemOnDelete, True);
            if Ret then
              OnAfterDeleteItem;                              
            end
          else
            Ret := True;
        end
      else // ** Visão Normal
        begin
          if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
            begin
               OnBeforeDeleteItem;
               if MyFieldKey2 >= 0 then
                  Ret := SystemDeleteItem(DM.quFreeSQL,
                                          DeleteTable,
                                          [MyFieldKey1Name,
                                           MyFieldKey2Name],
                                          [quBrowse.Fields[MyFieldKey1].AsString,
                                           quBrowse.Fields[MyFieldKey2].AsString],
                                          [quBrowse.Fields[MyFieldKey1].DataType,
                                           quBrowse.Fields[MyFieldKey2].DataType],
                                          BrowseConfig.CheckSystemOnDelete, BrowseConfig.RealDeletion)
               else
                  Ret := SystemDeleteItem(DM.quFreeSQL,
                                          DeleteTable,
                                          [MyFieldKey1Name],
                                          //[quBrowse.Fields[MyFieldKey1].AsString],
                                          [MyFieldValue1],
                                          [quBrowse.Fields[MyFieldKey1].DataType],
                                          BrowseConfig.CheckSystemOnDelete, BrowseConfig.RealDeletion);
              if Ret then
                OnAfterDeleteItem;
            end
          else
            Ret := True;
        end;

        if Ret then
           ExecBrowseSQLOnDelete
        else
           PushError(CRITICAL_ERROR, 'ParentBrowser.ExecDeleteItem.Exeception' + #13#10 + 'Result False');

  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentBrowser.ExecDeleteItem.Exeception' + #13#10 +E.Message);
      end;
  end;

end;

procedure TbrwParent.ExecRestoreItem;
var
  Ret : Boolean;
begin

  if (MsgBox(MSQ_QST_RETORE, vbYesNo + vbQuestion) = vbYes) then
  begin
    OnBeforeRestoreItem;
    if IndexFieldKey2 >= 0 then
      Ret := SystemRestoreItem(DM.quFreeSQL,
                              GetSQLFirstTableName(quBrowse.CommandText),
                              [quBrowse.Fields[IndexFieldKey1].FieldName,
                               quBrowse.Fields[IndexFieldKey2].FieldName],
                              [quBrowse.Fields[IndexFieldKey1].AsString,
                               quBrowse.Fields[IndexFieldKey2].AsString],
                              [quBrowse.Fields[IndexFieldKey1].DataType,
                               quBrowse.Fields[IndexFieldKey2].DataType])
    else
      Ret := SystemRestoreItem(DM.quFreeSQL,
                              GetSQLFirstTableName(quBrowse.CommandText),
                              [quBrowse.Fields[IndexFieldKey1].FieldName],
                              [quBrowse.Fields[IndexFieldKey1].AsString],
                              [quBrowse.Fields[IndexFieldKey1].DataType]);

    if Ret then
    begin
      OnAfterRestoreItem;
      ExecBrowseSQLOnRestore;
    end;
  end;
end;

procedure TbrwParent.quBrowseAfterScroll(DataSet: TDataSet);
begin
  // AtuVisiblePage RCGAY
end;

procedure TbrwParent.brwGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = 13) and (btDetail.enabled) then
     btDetail.Click;
end;

procedure TbrwParent.OnBeforeDeleteItem;
begin
  // Para ser herdado
end;

procedure TbrwParent.OnBeforeRestoreItem;
begin
  // Para ser herdado
end;

procedure TbrwParent.OnBeforeExecSQL;
begin
  // Para ser herdado
end;

procedure TbrwParent.btExcelClick(Sender: TObject);
begin
  inherited;
 If (not quBrowse.Active) or
    (quBrowse.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(grdBrowse, lblSubMenu.Caption);


end;

procedure TbrwParent.btColumnClick(Sender: TObject);
begin
  inherited;

  // shows customized column to grid.
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;

end;

procedure TbrwParent.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBrowse do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;

end;

procedure TbrwParent.TimeAvisoTimer(Sender: TObject);
begin
  inherited;
  if pnlAviso.ParentColor = True then
     pnlAviso.Color := clNavy
  else
     pnlAviso.ParentColor := True;
end;

procedure TbrwParent.ReplicationControls;
begin
  btRemove.Visible := not fIsRestricForm;
  if btAdd.Visible then
     btAdd.Visible := not fIsRestricForm;
  if btRestore.Visible then
     btRestore.Visible := not fIsRestricForm;
end;

procedure TbrwParent.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crDefault;

  //Used to store the Filter SQL
  iCounter := 0;
end;

procedure TbrwParent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  //Shor Cuts
  case Key of

    VK_F2 : begin //Add New
            if (btAdd.Enabled) and (btAdd.Visible) then
               CommandClick(btAdd);
            end;

    VK_F3 : begin //Edit
            if (btDetail.Enabled) and (btDetail.Visible) then
               CommandClick(btDetail);
            end;

    VK_F4 : begin //Del
            if (btRemove.Enabled) and (btRemove.Visible) then
               CommandClick(btRemove);
            end;

    VK_F5 : begin //Preview
            if (btPrint.Enabled) and (btPrint.Visible) then
               CommandClick(btPrint);
            end;

    VK_F6 : begin //SpreeadSheet
            if (btExcel.Enabled) and (btExcel.Visible) then
               btExcelClick(nil);
            end;

   end;

end;

procedure TbrwParent.grdBrowseDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;

  //Coloca o item para search
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;

end;

procedure TbrwParent.grdBrowseDBFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  //OnChangeNode atualiza o registro selecionado

  // Antonio 2014 Aug 25
  if ( Aview = nil ) then
     AView := TcxCustomGridTableView(grdBrowse.FocusedView);

  if quBrowse.Active and (quBrowse.RecordCount <> 0) and (TcxGridDBTableView(AView).Filtering.Visible = fvNever) then
     pnlPage.Caption := sLine + IntToStr(AFocusedRecord.Index+1) + sLineOf + IntToStr(quBrowse.RecordCount) + '.';

end;

procedure TbrwParent.grdBrowseDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  //Coloca o header para search
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TbrwParent.grdBrowseDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TbrwParent.grdBrowseDBDblClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  if btDetail.Enabled then
     CommandClick(btDetail);

  Screen.Cursor := crDefault;
end;

procedure TbrwParent.OnBeforeCommandClick(pCommand : TBtnCommandType);
begin
  //Para ser herdado
end;

procedure TbrwParent.AfterSetBrowseState;
begin
  //Herdado
end;

procedure TbrwParent.OnAfterDeleteItem;
begin
  //Para ser herdado;
end;

function TbrwParent.ValidateDeleteItem: Boolean;
begin
  Result := True;
end;

procedure TbrwParent.OnAfterRestoreItem;
begin
  //Para ser herdado;
end;

procedure TbrwParent.ExecBrowseSQLOnDelete;
begin
  ExecBrowseSQL(True);
end;

procedure TbrwParent.ExecBrowseSQLOnRestore;
begin
  ExecBrowseSQL(True);
end;

procedure TbrwParent.OnAfterCommandClick(pCommand: TBtnCommandType);
begin
  //Para ser herdado
end;

procedure TbrwParent.spHelpClick(Sender: TObject);
begin
  inherited;

  if sUrlHelp <> '' then
    OpenURL(sUrlHelp);
  
end;

procedure TbrwParent.btnVideoClick(Sender: TObject);
begin
  inherited;

  if sUrlVideo <> '' then
    OpenURL(sUrlVideo);
  
end;

end.

