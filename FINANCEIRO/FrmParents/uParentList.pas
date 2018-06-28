unit uParentList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, BrowseConfig, Db, Menus, DBTables, 
  Buttons, uParentFch, StdCtrls, SuperComboADO,
  dxCntner, dxTL, dxDBGrid, dximctrl, dxBar, dxBarExtItems, dxGrClms, DBGrids,
  dxBarExtDBItems, uParentListWaitFrm, dxDBGridPrint, ExtCtrls, ImgList,
  dxDBCtrl, ADODB, PowerADOQuery, uDataBaseFunctions, uHandleError,
  dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

const OpenModal = True;

type
  TParentList = class(TParentFixedFrm)
    quBrowse: TPowerADOQuery;
    dsBrowse: TDataSource;
    BrowseConfig: TBrowseConfig;
    pnlBasicFilter: TPanel;
    SaveDialog: TSaveDialog;
    bbListaNovo: TdxBarButton;
    bbListaOpen: TdxBarButton;
    bbListaRemove: TdxBarButton;
    bbListaFiltra: TdxBarButton;
    bbListaImprime: TdxBarButton;
    bbListaColuna: TdxBarButton;
    bbListaAgrupamento: TdxBarButton;
    bbListaRestore: TdxBarButton;
    bpmDetail: TdxBarPopupMenu;
    bdcFiltraData: TdxBarDateCombo;
    beFiltraTexto: TdxBarEdit;
    bbDetailFiltraCampo: TdxBarButton;
    bbDetailFIltraExcluindoCampo: TdxBarButton;
    bbDetailRemoveFiltro: TdxBarButton;
    bbDetailClassificacaoCre: TdxBarButton;
    bbDetailClassificaoDesc: TdxBarButton;
    bpmHeader: TdxBarPopupMenu;
    bbHeaderAgrupar: TdxBarButton;
    bbHeaderRemoveColuna: TdxBarButton;
    bsHeaderAlinhamento: TdxBarSubItem;
    bbHeaderAjuste: TdxBarButton;
    bbHeaderDireita: TdxBarButton;
    bbHeaderEsquerda: TdxBarButton;
    bbHeaderCentro: TdxBarButton;
    bbDetailHelp: TdxBarButton;
    bbFooterTotal: TdxBarButton;
    bbFooterMin: TdxBarButton;
    bbFooterMax: TdxBarButton;
    bbFooterAVG: TdxBarButton;
    bbFooterNenhum: TdxBarButton;
    bpmSummary: TdxBarPopupMenu;
    bbVisaoSalva: TdxBarButton;
    bbVisaoDelete: TdxBarButton;
    bbVisaoOrganiza: TdxBarButton;
    pnlExecuta: TPanel;
    pnlExecutaAviso: TPanel;
    btExecuta: TButton;
    dxDBGridPrint: TdxDBGridPrint;
    pnlBrowse: TPanel;
    pnlGenFilter: TPanel;
    brwGrid: TdxDBGrid;
    pnlCountLine: TPanel;
    pnlDivisor: TPanel;
    bbListaZoom: TdxBarCombo;
    Zoom: TdxBarStatic;
    trmAviso: TTimer;
    bbColunaSalva: TdxBarButton;
    siListaExporta: TdxBarSubItem;
    bbExportaHTML: TdxBarButton;
    bbExportaExcel: TdxBarButton;
    bbExportaTexto: TdxBarButton;
    lblFilterBar: TLabel;
    bbFiltroItemRemove: TdxBarButton;
    pmFilterBar: TPopupMenu;
    bbFilterItemRemove: TMenuItem;
    bbRemoveEsteFiltro: TMenuItem;
    quVisao: TADOQuery;
    dsVisao: TDataSource;
    cbxStatus: TdxBarImageCombo;
    bbHeaderAjusteAll: TdxBarButton;
    cpList: TdxComponentPrinter;
    cpListGridLink: TdxDBGridReportLink;
    btnXML: TdxBarButton;
    procedure abbSumClick(Sender: TObject);
    procedure CommandClick(Sender : TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure SearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btParentMinimizeClick(Sender: TObject);
    procedure brwGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure brwGridEndColumnsCustomizing(Sender: TObject);
    procedure piSortDescendingClick(Sender: TObject);
    procedure miCaixadeagrupamentoClick(Sender: TObject);
    procedure piColumnSelectorClick(Sender: TObject);
    procedure bbDetailClassificacaoCreClick(Sender: TObject);
    procedure bbDetailClassificaoDescClick(Sender: TObject);
    procedure bbHeaderAgruparClick(Sender: TObject);
    procedure bbHeaderRemoveColunaClick(Sender: TObject);
    procedure bbHeaderEsquerdaClick(Sender: TObject);
    procedure bbHeaderCentroClick(Sender: TObject);
    procedure bbHeaderDireitaClick(Sender: TObject);
    procedure bbHeaderAjusteClick(Sender: TObject);
    procedure bbDetailFiltraCampoClick(Sender: TObject);
    procedure bbDetailRemoveFiltroClick(Sender: TObject);
    procedure bdcFiltraDataChange(Sender: TObject);
    procedure beFiltraTextoChange(Sender: TObject);
    procedure btRemoveFiltroClick(Sender: TObject);
    procedure bbDetailHelpClick(Sender: TObject);
    procedure brwGridCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure brwGridDblClick(Sender: TObject);
    procedure bbListaImprimeClick(Sender: TObject);
    procedure brwGridChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure bpmDetailPopup(Sender: TObject);
    procedure bbListaAgrupamentoClick(Sender: TObject);
    procedure bbListaZoomChange(Sender: TObject);
    procedure trmAvisoTimer(Sender: TObject);
    procedure bbListaColunaClick(Sender: TObject);
    procedure bbListaRestoreClick(Sender: TObject);
    procedure bbExportaHTMLClick(Sender: TObject);
    procedure bbExportaExcelClick(Sender: TObject);
    procedure bbExportaTextoClick(Sender: TObject);
    procedure bbFilterItemRemoveClick(Sender: TObject);
    procedure bbRemoveEsteFiltroClick(Sender: TObject);
    procedure cbxStatusChange(Sender: TObject);
    procedure brwGridChangeColumn(Sender: TObject; Node: TdxTreeListNode;
      Column: Integer);
    procedure brwGridCustomDrawColumnHeader(Sender: TObject;
      AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect;
      var AText: String; var AColor: TColor; AFont: TFont;
      var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
      var ADone: Boolean);
    procedure btExecutaClick(Sender: TObject);
    procedure bbHeaderAjusteAllClick(Sender: TObject);
    procedure btnXMLClick(Sender: TObject);
  private
    { Private declarations }
    OldS: String;

    //Translation
    sLines,
    sEmptyList,
    sLinha,
    sDe,
    sPrintBy,
    sIn,
    sPages,
    sFiltro : String;

    iBaseTableCount: integer;
    FirstRefresh: Boolean;

    OriginalHeaderSize, OriginalItemSize: Integer;

    slFilter: TStringList;

    GridColumn, GridFooterColumn : TdxDBGridColumn;
    MyquBrowseParams      : TParams;
    SearchBuffer: String;

    MyUserRightsList: TStringList;

    ParentListWaitFrm: TParentListWaitFrm;

    // Velharia
    NoStateOriginalSQL, FirstRowID : String;
    OldSQLText : String;
    OldFirstOrder  : integer;
    IndexFieldKey1, IndexFieldKey2 : integer;

    // Procedures e Function NOVAS

    function GetdxDBGridColumnClass(Field : TField) :TdxDBTreeListColumnClass;

    function  MudaOrdenacao(MySQL: String; MyFieldName: String; Ascending: Boolean): String;

    procedure UnGroupAllColumns(dxDBGrid :TdxDBGrid);
    procedure LoadDxDBGridFromStream(dxDBGrid: TdxDBGrid; Stream: TStream);
    procedure SaveDxDBGridToStream(dxDBGrid :TdxDBGrid;Stream: TStream);

    procedure FilterExec;
    procedure FilterBarPaint;
    procedure FilterItemMouseDown(Sender: TObject;
                 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    function GetBaseTableCount: integer;

    procedure SetParcialLoad;
    procedure SetLoadAllRecords;

    // Velharia
    procedure CreateParams( var Params: TCreateParams ); override;
    procedure ExecDeleteItem;
    procedure ExecRestoreItem;
    procedure SetBrowseState;
    function  GetRealFieldName(VirtualField : integer) : String;
    procedure UpdateButtons;
    function  GetActualSQL : String;

    //Suggested fields for Browse
    function HasSuggestion(Sugg : TStringList):Boolean;

    //New
    procedure CreateFch;

  protected
    brwForm  : TParentFch;

    ParametroFicha: String;

    MyUserRights:  String;

    MyReportFilter : String;

    procedure PushError(ErrorType: Integer; sError: String);

    function OnTestDelete: Boolean; virtual;

    procedure ExecDelete;
    procedure LigaAviso;
    procedure DesligaAviso;

    procedure OnAfterRestoreItem; virtual;
    procedure OnBeforeDeleteItem; virtual;
    procedure OnAfterDeleteItem; virtual;
    procedure OnBeforeStart; virtual;
    procedure OnAfterStart; virtual;

    function HasRight(IDOperacao: Integer): Boolean;

  public
    { Public declarations }
    ActualOrderField: TField;
    ClickedPos, ClickedField, RealClickedField  : integer;
    Filter            : String;
    OriginalSQL       : String;
    WhereBasicFilter  : array[1..10] of String;
    WhereTreeFilter, WhereGenFilter, WhereSpecial, HavingGenFilter : String;

    procedure RollBackSQL;
    procedure Start(Parametro: String; UserRights: String; Suggestion : TStringList); Override;

    function  ListRefresh : integer;
    function  DoListRefresh : integer;
    function  ListParamRefresh : integer; virtual;

    //New
    procedure OnCreateFch; virtual;

  end;

implementation

{$R *.DFM}

uses xBase, uDM, uMsgBox, uParentListFilterHelp, uParamFunctions, uSystemConst,
     uSisSenha, uSQLFunctions, uNumericFunctions, uSystemTypes, uCriarForm,
     uMsgConstant, uDMGlobal;


procedure TParentList.CreateFch;
begin
  if brwForm = nil then
    OnCreateFch;

  if brwForm <> nil then
    brwForm.FchBrowse := Self;
end;

procedure TParentList.OnCreateFch;
var aForm : TForm;
begin
  if (BrowseConfig.FchClassName <> '') and (brwForm = Nil) then
  begin
    aForm   := CriaForm(Self,BrowseConfig.FchClassName);
    if aForm <> nil then
      brwForm := aForm as TParentFch
    else
      MsgBox(MSG_CRT_PART_CLASS_NOT_DEFINED + Self.Name+': ' + BrowseConfig.FchClassName, vbCritical + vbOkOnly);
  end;
end;


procedure TParentList.PushError(ErrorType: Integer; sError: String);
begin

  DM.SetError(ErrorType, Self.Name, sError);

end;


function  TParentList.ListParamRefresh : integer;
begin
 //Write the code for build the Where Clause before open a query
end;

procedure TParentList.Start(Parametro: String; UserRights: String; Suggestion : TStringList);
begin

  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  MyUserRights := UserRights;
  MyParametro := Parametro;
  OnBeforeStart;

  // Descubro que é a chave do grid
  with brwGrid do
    if KeyField = '' then
      KeyField := DM.GetSQLKey(quBrowse.CommandText);

  // Le os direitos do usuario os carrega em um string list
  ParseUserRights(UserRights, MyUserRightsList);

  WindowState := wsMaximized;

  SearchBuffer := '';

  lblModulo.Caption := self.Caption;
  lblModuloSadow.Caption := self.Caption;

  // Leio do registry as colunas salvas
  if (Self.Caption <> '') then
     begin
     brwGrid.LoadFromRegistry('\Software\AppleNet\OfficeM\CurrentViews\' + Self.Caption);
     brwGrid.RegistryPath := '\Software\AppleNet\OfficeM\CurrentViews\' + Self.Caption;
     brwGrid.Options := brwGrid.Options + [egoStoreToRegistry];
     end;

  // Seta os direitos nos controles;
  if HasRight(1) then
    bbListaNovo.Visible := ivAlways
  else
    bbListaNovo.Visible := ivNever;

  if HasRight(3) then
    bbListaOpen.Visible := ivAlways
  else
    bbListaOpen.Visible := ivNever;

  if HasRight(2) then
    bbListaRemove.Visible := ivAlways
  else
    bbListaRemove.Visible := ivNever;

  Show;

  //If It is AutoOpen or has Suggestion
  if BrowseConfig.AutoOpen then
     ListRefresh
  else
     if HasSuggestion(Suggestion) then
        ListParamRefresh;

  brwGrid.SetFocus;

  // Abre a query de visoes
  {
  with quVisao do
    begin
      if Active then
        Close;
      ParamByName('FormCaption').AsString := Self.Caption;
      Open;
    end;
  }

  OnAfterStart;

  Screen.Cursor := crDefault;

end;

function TParentList.HasSuggestion(Sugg : TStringList):Boolean;
var
  i,j,iFound : integer;
  sComp, sName, sValue : String;
begin

  Result := False;

  if (Sugg = nil) or (Trim(Sugg.Text) = '') then
     Exit;

  j := 0;
  iFound := 0;

  While (j < Sugg.Count) do
    begin
    inc(j);

    //Get components Values
    sComp  := ParseParam(Sugg.Strings[0], SUGG_CLASS);
    sName  := ParseParam(Sugg.Strings[0], SUGG_NAME);
    sValue := ParseParam(Sugg.Strings[0], SUGG_VALUE);

    for i:=0 to ComponentCount-1 do
       if Components[i].ClassName = sComp then
          if Components[i].Name = sName then
             begin

             //Super Combo
             if (Components[i].ClassName = 'TSuperComboADO') then
                 TSuperComboADO(Components[i]).LookUpValue := sValue;

             inc(iFound);
             Break;
             end;

    end;

    Result := (iFound = Sugg.Count);

end;

procedure TParentList.OnBeforeStart;
begin
  // Para ser herdado
end;

procedure TParentList.OnAfterStart;
begin
  // Para ser herdado
end;

procedure TParentList.CommandClick(Sender : TObject);
var
  pCommand : TBtnCommandType;
  PosID1, PosID2 : String;
  i: integer;
  Ret: boolean;

begin

  CreateFch;

  pCommand := TBtnCommandType(TComponent(Sender).Tag);

  if (pCommand = btAlt)
     and
     quBrowse.IsEmpty then Exit;


  Ret := False;

  case pCommand of

       btInc, btAlt : begin
                        try
                          brwForm.OpenModal := OpenModal;
                          Desativar;
                          Ret := brwForm.Start(pCommand, quBrowse, False,
                                              PosID1, PosID2, ParametroFicha,
                                              MyUserRights, brwGrid);
                        finally
                          Ativar;
                        end;
                      end;

       btExc        : begin
                        if OnTestDelete then
                          ExecDelete;
                      end;

       btSelCol     : begin


                      end;

  end;

  if pCommand <> btPos then
     brwGrid.SetFocus;
end;

procedure TParentList.FormCreate(Sender: TObject);
var
   i              : Integer;
   MySqlStatement : TSQlStatement;
   aBrowseKeys    : Variant;
begin
  inherited;

  iBaseTableCount := -1;

  slFilter := TStringList.Create;

  ParametroFicha := '';

  FirstRefresh := True;

  OriginalHeaderSize := 8;
  OriginalItemSize   := 8;

  brwForm := nil;

  MyquBrowseParams   := TParams.Create;

  with quBrowse do
    if Active then
      Close;

  ParentListWaitFrm := TParentListWaitFrm.Create(Self);

  // String List que contem as operacoes validas do usuario
  MyUserRightsList := TStringList.Create;

  // Salva os parametros do quBrowse
//  MyquBrowseParams.Assign(quBrowse.Parameters);

  // Reseta String Where variaveis
  for i := 1 to High(WhereBasicFilter) do
   WhereBasicFilter[i] := '';

  pnlGenFilter.Visible := False;

  WhereGenFilter    := '';
  WhereTreeFilter   := '';
  WhereSpecial      := '';
  HavingGenFilter   := '';

  // Adiciona o NOLOCK a Query
  MySqlStatement := UnMountSQL(quBrowse.CommandText);
  if Pos('NOLOCK', UpperCase(MySqlStatement[ST_FROM])) = 0 then
     MySqlStatement[ST_FROM] :=  MySqlStatement[ST_FROM] + ' (NOLOCK) ';
  OriginalSQL := MountSQL(MySqlStatement);
  NoStateOriginalSQL := OriginalSQL;

  // Seta o estado do browse, sobre a delcao ou restore de itens, se mostar desativado ou nao
  SetBrowseState;

  //  Seta a propriedade KeyFields
  if brwGrid.KeyField <> '' then
    begin
      IndexFieldKey1 := quBrowse.FieldByName(brwGrid.KeyField).Index;
      IndexFieldKey2 := -1;
    end
  else
    begin
      // Seta as keys dos Browses
      aBrowseKeys := GetTableKeys(DM.quFreeSQL, GetSQLFirstTableName(OriginalSQL));
      if aBrowseKeys[0] = '' then
        begin
         IndexFieldKey1 := BrowseConfig.ViewIndexFieldKey1;
         IndexFieldKey2 := BrowseConfig.ViewIndexFieldKey2;
        end
      else
        begin
         IndexFieldKey1 := quBrowse.FieldByName(aBrowseKeys[0]).Index;
         if VarArrayHighBound(aBrowseKeys, 1) > 0 then
            IndexFieldKey2 := quBrowse.FieldByName(aBrowseKeys[1]).Index
         else
            IndexFieldKey2 := -1;
        end;
    end;

  quBrowse.KeyFields := quBrowse.Fields[IndexFieldKey1].FieldName;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sLines     := ' Line(s).';
           sEmptyList := '   Empty List.';
           sLinha     := '   Line ';
           sDe        := ' of ';
           sPrintBy   := 'Printed by ';
           sIn        := ' in ';
           sPages     := 'Page [Page #] of [Total Pages]';
           sFiltro    := ' Filter : ';
           end;
    LANG_PORTUGUESE :
           begin
           sLines     := ' Linha(s).';
           sEmptyList := '   Lista vazia.';
           sLinha     := '   Linha ';
           sDe        := ' de ';
           sPrintBy   := 'Impresso por ';
           sIn        := ' em ';
           sPages     := 'Página [Page #] de [Total Pages]';
           sFiltro    := ' Filtro : ';
           end;

    LANG_SPANISH :
           begin
           sLines     := ' Línea(s).';
           sEmptyList := '   Lista vacia.';
           sLinha     := '   Línea ';
           sDe        := ' de ';
           sPrintBy   := 'Imprimido por ';
           sIn        := ' el ';
           sPages     := 'Página [Page #] de [Total Pages]';
           sFiltro    := ' Filtro : ';
           end;
  end;


end;

procedure TParentList.FormDestroy(Sender: TObject);
begin
  inherited;
  slFilter.Free;
  ParentListWaitFrm.Free;
  MyUserRightsList.Free;
  MyquBrowseParams.Free;

  if assigned(brwForm) then
    FreeAndNil(brwForm);

end;

procedure TParentList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TParentList.UpdateButtons;
var
   lEnabled : Boolean;
begin
  // Deverá ser reescrita para o menu bar
{  with quBrowse do
     // Atualiza botoes
     lEnabled := not (Eof and Bof);

  pnlButton.UpdateButtons(lEnabled);
  }
end;

function TParentList.GetBaseTableCount: integer;
begin
  if iBaseTableCount = -1 then
    iBaseTableCount := DM.GetTableCount(GetSQLFirstTableName(OriginalSQL));

  Result := iBaseTableCount;
end;

procedure TParentList.SetLoadAllRecords;
begin
  with brwGrid do
    begin
      OptionsDB := OptionsDB - [edgoPartialLoad];
      OptionsDB := OptionsDB + [edgoLoadAllRecords];
    end;
end;

procedure TParentList.SetParcialLoad;
begin
  with brwGrid do
    begin
      OptionsDB := OptionsDB - [edgoLoadAllRecords];
      OptionsDB := OptionsDB + [edgoPartialLoad];
    end;

end;

function TParentList.ListRefresh: Integer;
var
  iQueryCost : integer;
begin
   Result := -1;

{   iQueryCost := GetBaseTableCount;

   if (iQueryCost > 1000) and not (BrowseConfig.AutoOpen) then
      if MsgBox(MSG_QST_PART1_QUERY_RETURN + intToStr(1000) +
                MSG_QST_PART2_QUERY_RETURN, vbQuestion + vbYesNo) = vbNo then
         Exit;

   if iQueryCost > 1000 then
      SetParcialLoad
    else
      SetLoadAllRecords;}

   Result := DoListRefresh;

end;

function TParentList.DoListRefresh: Integer;
var
  NewSQL     : String;
  i, FirstIndex : integer;
  MySqlStatement : TSQlStatement;
  OrderField: String;
  ChaveAtual: String;
  OrderAsc: Boolean;
  Column         : TdxDBTreeListColumn;

begin

  Result := 0;

  Screen.Cursor := crHourGlass;

  Application.ProcessMessages;
  ParentListWaitFrm.Show;
  Application.ProcessMessages;

  with quBrowse do
    begin
      try
        DisableControls;

        // Se a query esta aberta devo, pegar todas as informações
        // antes de fecha-la.
        // Se estiver fechada, devo pegar a ordenação do próprio SQL

        if Active then
          begin

            // Guarda a ordenacao atual
            for i := 0 to brwGrid.ColumnCount-1 do
              begin
                if brwGrid.Columns[i].Sorted <> csNone then
                  begin
                    ActualOrderField := brwGrid.Columns[i].Field;
                    OrderField       := GetFieldAlias(ActualOrderField.FieldName, CommandText) + ActualOrderField.FieldName;
                    OrderAsc         := (brwGrid.Columns[i].Sorted = csUp);
                    Break;
                  end
              end;

            // Salva a posição atual do grid
            ChaveAtual := quBrowse.Fields[0].AsString;

            // Fecho
            Close;
          end
        else
          begin
            //
            ChaveAtual := '';
          end;

        // Salva a antiga expressao do query
        OldSQLText := CommandText;

        // Pega o SQL atual
        CommandText := GetActualSQL;


        // Muda a ordenacao
//        SQL.Text := MudaOrdenacao(SQL.Text, OrderField, OrderAsc);


        // Restaura os tipos dos paramteros do browse
        for i := 0 to Parameters.Count - 1 do
           Parameters.Items[i].DataType := MyquBrowseParams[i].DataType;

        
        Open;

        //brwGrid.KeyField := quBrowse.Fields[0].FieldName;

        // Destruo todas as colunas do grid
        //brwGrid.DestroyColumns;


        // Crio as colunas dinamicamente
        if brwGrid.ColumnCount = 0 then
          with brwGrid.DataSource.DataSet do
            begin
              for i := 0 to FieldCount - 1 do
                begin
                  if Fields[i].Visible then
                    begin
                      Column := brwGrid.CreateColumn(GetdxDBGridColumnClass(Fields[I]));
                      Column.FieldName := Fields[I].FieldName;
                    end;
                end;
            end;

        // Reposiciona
        if ChaveAtual <> '' then
          Locate(brwGrid.KeyField, ChaveAtual, []);

        Application.ProcessMessages;

        // Autaliza o alinha atual e o total
        if (brwGrid.FocusedNode = nil) or (RecordCount = 0) then
          begin
            if RecordCount > 0 then
              begin
                pnlCountLine.Caption := '   ' + IntToStr(RecordCount) + sLines;
              end
            else
              pnlCountLine.Caption := sEmptyList
          end
        else
          begin
            pnlCountLine.Caption := sLinha + IntToStr(brwGrid.FocusedNode.Index + 1) + sDe + IntToStr(RecordCount) + '.';
          end;

        // retorna numero de linhas
        Result := quBrowse.RecordCount;

        UpdateButtons;
     finally
       EnableControls;
       ParentListWaitFrm.Hide;
       Screen.Cursor := crDefault;
       Application.ProcessMessages;
     end;
   end;
end;


function TParentList.MudaOrdenacao(MySQL: String; MyFieldName: String; Ascending: Boolean): String;
var
  MySqlStatement: TSqlStatement;
begin
  // Desmonto o SQL
  MySqlStatement := UnMountSQL(MySQL);

  // Coloca no nome do campo, com a alias
  MySqlStatement[ST_ORDER] := GetFieldAlias(MyFieldName, MySQL) + MyFieldName;

  // Coloca o tipo de ordenacao
  if Ascending then
    MySqlStatement[ST_ORDER] := MySqlStatement[ST_ORDER] + ' ASC'
  else
    MySqlStatement[ST_ORDER] := MySqlStatement[ST_ORDER] + ' DESC';

  // Remonto o SQL
  Result := MountSQL(MySqlStatement);
end;

procedure TParentList.RollBackSQL;
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

function TParentList.GetActualSQL : String;
var
  i : integer;
begin
  Result := OriginalSQL;

  for i := 1 to High(WhereBasicFilter) do
    if not (WhereBasicFilter[i] = '') then
       Result := ChangeWhereClause(Result, WhereBasicFilter[i], False);

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


procedure TParentList.SearchClick(Sender: TObject);
begin
  inherited;
{  if (ActualOrder <> quBrowse.FieldByName(GetRealFieldName(ClickedField)).Index) then
     SortAscClick(SortAsc);
  SearchFilterbrw.StartSearch(Self);
  }
end;

function TParentList.GetRealFieldName(VirtualField : integer) : String;
begin

//  Result := LeftStr(brwGrid.Selected.Strings[VirtualField],
//                    Pos(#9, brwGrid.Selected.Strings[VirtualField])-1);
end;

procedure TParentList.SetBrowseState;
begin
  OriginalSQL := ChangeSQLState(NoStateOriginalSQL, BrowseConfig.MostraDesativado,
                                BrowseConfig.MostraHidden);

  // Seta se mostra o trash
  case BrowseConfig.MostraDesativado of
       STD_NAODESATIVADO   : begin
                               bbListaRestore.Visible := ivInCustomizing;
                               bbListaRestore.Enabled := False;
                               bbListaNovo.Visible    := ivAlways;
                               bbListaNovo.Enabled    := True;
                               cbxStatus.ItemIndex    := 0;
                             end;
       STD_DESATIVADO      : begin
                               bbListaRestore.Visible := ivAlways;
                               bbListaRestore.Enabled := True;
                               bbListaNovo.Visible    := ivInCustomizing;
                               bbListaNovo.Enabled    := False;
                               cbxStatus.ItemIndex    := 1;
                             end;
       STD_AMBOSDESATIVADO : begin
                               bbListaRestore.Visible := ivInCustomizing;
                               bbListaRestore.Enabled := False;
                               bbListaNovo.Visible    := ivAlways;
                               bbListaNovo.Enabled    := True;
                               cbxStatus.Visible      := ivNever;
                             end;
  end;
end;


procedure TParentList.ExecDelete;
var
   i, Lines: integer;
begin
  if NOT (egoMultiSelect in brwGrid.Options) then
    begin
      Lines := 1;
    end
  else
    begin
      Lines := brwGrid.SelectedCount;
    end;

  if BrowseConfig.MostraDesativado = STD_DESATIVADO then
    begin
      if NOT (MsgBox(MSG_QST_PART1_DELETE_PERMANENT + IntToStr(Lines) + MSG_QST_PART2_DELETE_PERMANENT,
             vbYesNo + vbQuestion) = vbYes) then Exit;
    end
  else
    begin
      if NOT (MsgBox(MSG_QST_PART1_DELETE_LINES + IntToStr(Lines) + MSG_QST_PART2_DELETE_LINES,
             vbYesNo + vbQuestion) = vbYes) then Exit;
    end;

  if (egoMultiSelect in brwGrid.Options) then
    begin
      // O grid esta em mode de deleção multipla
      with quBrowse do
        begin
          DisableControls;
          for i:= 0 to brwGrid.SelectedCount - 1 do
            begin
              Bookmark := brwGrid.SelectedRows[i];
              OnBeforeDeleteItem;
              ExecDeleteItem;
              OnAfterDeleteItem;
            end;
          EnableControls;
        end;
    end
  else
    begin
      // O grid esta em mode de deleção simples
      ExecDeleteItem;
      ListRefresh;
      exit;
    end;

  ListRefresh;
end;


procedure TParentList.ExecDeleteItem;
var
  Ret         : Boolean;
  DeleteTable : String;
  aKeys       : Variant;
  MyFieldKey1, MyFieldKey2 : Integer;
  MyFieldKey1Name, MyFieldKey2Name : String;
begin
  Ret := False;

  try

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

        
      if BrowseConfig.MostraDesativado = STD_DESATIVADO then
        begin
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
        end
      else
        begin
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
                                          [quBrowse.Fields[MyFieldKey1].AsString],
                                          [quBrowse.Fields[MyFieldKey1].DataType],
                                          BrowseConfig.CheckSystemOnDelete, BrowseConfig.RealDeletion);
        end;

    if not Ret then
       PushError(CRITICAL_ERROR, 'ParentList.ExecDeleteItem.Exeception' + #13#10 + 'Result False');

  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentList.ExecDeleteItem.Exeception' + #13#10 +E.Message);
      end;
  end;

end;


procedure TParentList.ExecRestoreItem;
var
  Ret : Boolean;
begin
  if IndexFieldKey2 >= 0 then
     Ret := SystemRestoreItem( DM.quFreeSQL,
                               GetSQLFirstTableName(quBrowse.CommandText),
                               [quBrowse.Fields[IndexFieldKey1].FieldName,
                               quBrowse.Fields[IndexFieldKey2].FieldName],
                               [quBrowse.Fields[IndexFieldKey1].AsString,
                               quBrowse.Fields[IndexFieldKey2].AsString],
                               [quBrowse.Fields[IndexFieldKey1].DataType,
                               quBrowse.Fields[IndexFieldKey2].DataType])
  else
     Ret := SystemRestoreItem( DM.quFreeSQL,
                               GetSQLFirstTableName(quBrowse.CommandText),
                               [quBrowse.Fields[IndexFieldKey1].FieldName],
                               [quBrowse.Fields[IndexFieldKey1].AsString],
                               [quBrowse.Fields[IndexFieldKey1].DataType]);
end;

procedure TParentList.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
//  Params.Style := WS_BORDER;
end;

procedure TParentList.btParentMinimizeClick(Sender: TObject);
begin
  inherited;
  Application.MainForm.Next;
end;

procedure TParentList.brwGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  procedure SetPopupItems(AColumn: TdxDBGridColumn; Footer: Boolean);
  var
    SType : TdxSummaryType;
  begin
    bbDetailClassificacaoCre.Down := False;
    bbDetailClassificaoDesc.Down := False;

    // Seta no menu a opção de ordenação da coluna
    case AColumn.Sorted of
      csUp: bbDetailClassificacaoCre.Down := True;
      csDown: bbDetailClassificaoDesc.Down := True;
    end;

    // Seta no menu a opção de filtro de acordo com o tipo de dado da coluna
    if (AColumn.Field.DataType in [ftDate, ftDateTime]) then
      begin
        // Se é do tipo data mostra o filtro por data
        bdcFiltraData.Visible := ivAlways;
        beFiltraTexto.Visible := ivInCustomizing;
      end
    else
      begin
        // Mostra o filtro por texto
        bdcFiltraData.Visible := ivInCustomizing;
        beFiltraTexto.Visible := ivAlways;

      end;



    case AColumn.Alignment of
      taLeftJustify  : bbHeaderEsquerda.Down := True;
      taRightJustify : bbHeaderDireita.Down := True;
      taCenter       : bbHeaderCentro.Down := True;
    end;

    bbHeaderAgrupar.Enabled := (AColumn.GroupIndex = -1) and
                          not AColumn.DisableGrouping and
                          brwGrid.CanAddGroupColumn(AColumn);

    // Controla que opções do footer tem que estar ativadas e checadas
    if not Footer then
      SType := AColumn.SummaryType
    else
      SType := AColumn.SummaryFooterType;

    // Carrega o valor que está atualmente no grid para o menu
    case SType of
      cstNone: bbFooterNenhum.Down := True;
      cstSum:  bbFooterTotal.Down := True;
      cstMin:  bbFooterMin.Down := True;
      cstMax:  bbFooterMax.Down := True;
      cstAvg:  bbFooterAVG.Down := True;
    end;

    // Testa se é do tipo que pode ser sumarizado
    if Footer and not (AColumn.Field.DataType in
       [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime, ftAutoInc]) then
      begin
        // Não pode ser sumarizado, desliga as opções no menu
        bbFooterTotal.Enabled := False;
        bbFooterMin.Enabled := False;
        bbFooterMax.Enabled := False;
        bbFooterAVG.Enabled := False;
      end
    else
      begin
        // Liga todas
        bbFooterTotal.Enabled := True;
        bbFooterMin.Enabled := True;
        bbFooterMax.Enabled := True;
        bbFooterAVG.Enabled := True;
      end;

    if Footer and (AColumn.Field.DataType in [ftDate, ftTime, ftDateTime]) then
      begin
        // Se é do tipo data, ou time, total e media não fazem sentido
        bbFooterTotal.Enabled := False;
        bbFooterAVG.Enabled := False;
      end;
  end;

var
  p : TPoint;
  hTest : TdxTreeListHitTest;
  bpmPopUp: TdxBarPopUpMenu;
begin

  // show popup
  if Button = mbRight then
  begin
    bpmPopUp := Nil;
    hTest := brwGrid.GetHitTestInfoAt(X, Y);

    if hTest in [htColumn, htColumnEdge] then
      begin
        GridColumn := TdxDBGridColumn(brwGrid.GetColumnAt(X, Y));
        bpmPopUp := bpmHeader // TituloColunas
      end
    else if hTest = htLabel then
      begin
        GridColumn := TdxDBGridColumn(brwGrid.GetColumnAt(X, Y));
        bpmPopUp := bpmDetail // Nodes
      end
    else if hTest = htSummaryFooter then
      begin
        GridColumn := TdxDBGridColumn(brwGrid.GetFooterColumnAt(X, Y));
        bpmPopUp := bpmSummary; // SummaryFooter
      end;

    if (bpmPopUp <> nil) and (GridColumn <> nil) then
      begin
        SetPopupItems(GridColumn, True);
        p := brwGrid.ClientToScreen(Point(X, Y));
        bpmPopUp.Popup(p.X, p.Y);
      end;
  end;
  
end;


procedure TParentList.brwGridEndColumnsCustomizing(Sender: TObject);
begin
  inherited;
  bbListaColuna.Down := False;
end;

procedure TParentList.abbSumClick(Sender: TObject);
const
  SummaryType: array [0..5] of TdxSummaryType =
   (cstNone, cstSum, cstMin, cstMax, cstCount, cstAvg);
var
  SType: TdxSummaryType;
begin
  SType := SummaryType[TComponent(Sender).Tag];

  if GridFooterColumn <> nil then
    with GridFooterColumn do
      begin
        SummaryFooterType := SType;
        SummaryFooterField := GridFooterColumn.FieldName;
        // SummaryFooterFormat := TNumericField(GridColumn.Field).DisplayFormat;
      end
  else
    if GridColumn <> nil then
      with GridColumn do
        begin
          SummaryType := SType;
          SummaryField := FieldName;
          //TdxDBGrid(TreeList).RefreshGroupColumns;
        end;
  brwGrid.RefreshGroupColumns;
end;

procedure TParentList.piSortDescendingClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Sorted := csDown;

end;

procedure TParentList.miCaixadeagrupamentoClick(Sender: TObject);
begin
  inherited;
  bbListaAgrupamento.Down := not bbListaAgrupamento.Down;
  CommandClick(bbListaAgrupamento);

end;

procedure TParentList.piColumnSelectorClick(Sender: TObject);
begin
  inherited;
  bbListaColuna.Down := not bbListaColuna.Down;
  CommandClick(bbListaColuna);

end;

procedure TParentList.SaveDxDBGridToStream(dxDBGrid :TdxDBGrid;Stream: TStream);
var
  I :integer;
  ColumnCount :integer;
begin
  Stream.Position := 0;
  Stream.WriteComponentRes(dxDBGrid.ClassName,dxDBGrid);
  ColumnCount := dxDBGrid.ColumnCount;
  Stream.WriteBuffer(ColumnCount,Sizeof(ColumnCount));
  for I := 0 to dxDBGrid.ColumnCount - 1 do
    Stream.WriteComponentRes(dxDBGrid.Columns[I].ClassName,dxDBGrid.Columns[I]);
end;

procedure TParentList.LoadDxDBGridFromStream(dxDBGrid: TdxDBGrid; Stream: TStream);
var
  I :integer;
  ColumnCount :integer;
begin
  Stream.Position := 0;
  Stream.ReadComponentRes(dxDBGrid);
  Stream.ReadBuffer(ColumnCount,Sizeof(ColumnCount));
  for I := 0 to ColumnCount - 1 do
    (Stream.ReadComponentRes(nil) as TdxDBTreeListColumn).ATreeList := dxDBGrid;
  dxDBGrid.RefreshGroupColumns;
end;

procedure TParentList.UnGroupAllColumns(dxDBGrid :TdxDBGrid);
var I: Integer;
begin
  for I := 0 to dxDBGrid.ColumnCount - 1 do
    if TdxDBGridColumn(dxDBGrid.Columns[I]).GroupIndex >= 0 then
      TdxDBGridColumn(dxDBGrid.Columns[I]).GroupIndex := -1;
end;


procedure TParentList.bbDetailClassificacaoCreClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Sorted := csUp;

end;

procedure TParentList.bbDetailClassificaoDescClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Sorted := csDown;

end;

procedure TParentList.bbHeaderAgruparClick(Sender: TObject);
begin
  inherited;

  if not bbListaAgrupamento.Down then
    begin
      bbListaAgrupamento.Down := True;
      bbListaAgrupamentoClick(nil);
    end;

  if GridColumn <> nil then
    begin
      brwGrid.AddGroupColumn(GridColumn);
      brwGrid.RebuildGroupIndexes;
    end;


end;

procedure TParentList.bbHeaderRemoveColunaClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Visible := False;

end;

procedure TParentList.bbHeaderEsquerdaClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Alignment := taLeftJustify;

end;

procedure TParentList.bbHeaderCentroClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Alignment := taCenter;

end;

procedure TParentList.bbHeaderDireitaClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    GridColumn.Alignment := taRightJustify;

end;

procedure TParentList.bbHeaderAjusteClick(Sender: TObject);
begin
  inherited;
  if GridColumn <> nil then
    brwGrid.ApplyBestFit(GridColumn);

end;

procedure TParentList.bbDetailFiltraCampoClick(Sender: TObject);
var
  txtFilter, StrFilter, OldWhere, FieldOrigin, OldHaving : String;
  NewPanel: TPanel;

begin
  inherited;

  // GridColumn é global e contém a Coluna do Grid. É setada durante o mouse up do grid

  FieldOrigin := GetFieldOrigin(quBrowse.CommandText, GridColumn.Field.FieldName);

  if TControl(Sender).Tag = 0 then
    begin
      // Filtra iqual ao campo
      StrFilter := FieldOrigin + ' = ' +
                   ConvSQLValue( GridColumn.Field,
                                 GridColumn.Field.AsString);

      txtFilter := GridColumn.Field.DisplayName + ' = ' +
                   GridColumn.Field.AsString;
    end
  else if TControl(Sender).Tag = 1 then
    begin
      // Filtra iqual ao campo
      StrFilter := FieldOrigin + ' <> ' +
                   ConvSQLValue( GridColumn.Field,
                                 GridColumn.Field.AsString);

      txtFilter := GridColumn.Field.DisplayName + ' <> ' +
                   GridColumn.Field.AsString;
    end
  else if TControl(Sender).Tag = 2 then
    begin
      // Filtra pela data
      StrFilter := FieldOrigin + ' = ' +
                   chr(39) + FormatDateTime('mm/dd/yyyy', bdcFiltraData.Date) + Chr(39);

      txtFilter := GridColumn.Field.DisplayName + ' = ' +
                   FormatDateTime('c', bdcFiltraData.Date);
    end
  else
    begin
      // Filtra por texto
      StrFilter := FieldOrigin + ' LIKE ' +
                   chr(39) + beFiltraTexto.Text + Chr(39);

      txtFilter := GridColumn.Field.DisplayName + ' = ' +
                   beFiltraTexto.Text;
    end;

  // Adiciono ao String list
  NewPanel             := TPanel.Create(self);
  NewPanel.BevelInner  := bvNone;
  NewPanel.BevelOuter  := bvRaised;
  NewPanel.Visible     := False;
  NewPanel.Parent      := pnlGenFilter;
  NewPanel.Color       := $00BDE4E8;
  NewPanel.Color       := clBtnFace;
  NewPanel.Caption     := txtFilter;
  NewPanel.Font.Color  := clNavy;
  NewPanel.PopupMenu   := pmFilterBar;
  NewPanel.OnMouseDown := FilterItemMouseDown;
  NewPanel.Tag         := slFilter.AddObject(StrFilter, NewPanel);

  FilterBarPaint;
  Application.ProcessMessages;
  FilterExec;

end;

procedure TParentList.bbDetailRemoveFiltroClick(Sender: TObject);
var
 i : integer;
begin
  inherited;

  if (WhereGenFilter <> '') or (HavingGenFilter <> '') then
    begin
     WhereGenFilter    := '';
     HavingGenFilter   := '';
     bbListaFiltra.Down     := False;


    for i := (slFilter.Count-1) downto 0 do
      begin
      // Deleto os obj do filter list
      slFilter.Objects[i].Free;
      slFilter.Delete(i);
      end;

     FilterBarPaint; 
     ListRefresh;
    end;

end;

procedure TParentList.bdcFiltraDataChange(Sender: TObject);
begin
  inherited;
  bbDetailFiltraCampoClick(bdcFiltraData);
end;

procedure TParentList.beFiltraTextoChange(Sender: TObject);
begin
  inherited;
  if beFiltraTexto.Text <> '' then
    bbDetailFiltraCampoClick(beFiltraTexto);

end;

procedure TParentList.btRemoveFiltroClick(Sender: TObject);
begin
  inherited;
  bbDetailRemoveFiltroClick(nil);
end;


procedure TParentList.bbDetailHelpClick(Sender: TObject);
begin
  inherited;
  TParentListFilterHelp.Create(self).Show;
end;

procedure TParentList.brwGridCustomDraw(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
  const AText: String; AFont: TFont; var AColor: TColor; ASelected,
  AFocused: Boolean; var ADone: Boolean);
var
  G: TdxDBGrid;

begin
  if ANode.HasChildren then Exit;
  G := Sender as TdxDBGrid;

  if not ASelected  then
    begin
      if (not (egoPreview in G.Options)) AND (ANode.Index mod 2 = 0) then
        AColor := clWindow
      else
        AColor := $00EEEEEE;
    end;

  if ANode.Selected then
     begin
     AColor := G.HighlightColor;
     AFont.Color := $00EEEEEE;
     end;



end;


procedure TParentList.brwGridDblClick(Sender: TObject);
begin
  inherited;
  if bbListaOpen.Visible = ivAlways then
    CommandClick(bbListaOpen);
end;

function TParentList.OnTestDelete: Boolean;
begin
  // para ser herdado
  Result := True;
end;

procedure TParentList.OnAfterDeleteItem;
begin
  //para ser herdado
end;

procedure TParentList.OnAfterRestoreItem;
begin
 //para ser herdado

end;

procedure TParentList.OnBeforeDeleteItem;
begin
  // Para ser herdado

end;

function TParentList.HasRight(IDOperacao: Integer): Boolean;
begin

  if Trim(MyUserRights) = '' then
    Result := True
  else
    Result := (MyUserRightsList.IndexOf(IntToStr(IDOperacao)) <> -1);

end;

function TParentList.GetdxDBGridColumnClass(Field : TField) :TdxDBTreeListColumnClass;
begin
  if Field.FieldKind <> fkLookup then begin
    case Field.DataType of
      ftBoolean:  Result := TdxDBGridCheckColumn;
      ftDate,
      ftDateTime: Result := TdxDBGridDateColumn;
      ftBytes,
      ftVarBytes,
      ftBlob,
      ftMemo,
      ftGraphic,
      ftFmtMemo,
      ftParadoxOle,
      ftDBaseOle,
      ftTypedBinary:  Result := TdxDBGridButtonColumn;
      else Result := TdxDBGridMaskColumn;
    end;
  end else begin
    Result := TdxDBGridLookupColumn;
  end;
End;


procedure TParentList.bbListaImprimeClick(Sender: TObject);
begin
  inherited;

  // Novo Componente
  with cpListGridLink.PrinterPage do
    begin
      PageHeader.CenterTitle.Clear;
      PageHeader.CenterTitle.Add(Application.Title);
      PageHeader.CenterTitle.Add(Caption);


      PageFooter.LeftTitle.Text   := sPrintBy + DM.sSisUser + sIn + FormatDateTime('dddddd hh:mm', Now());
      PageFooter.CenterTitle.Text := '';
      PageFooter.RightTitle.Text  := sPages;
    end;

  with cpListGridLink.ReportTitle do
    begin
      Font.Name := Self.Font.Name;
      Font.Size := 8;
      Font.Style := [fsBold];
      AdjustOnReportScale := True;
      Text := sFiltro + MyReportFilter;
      if Trim(Text) = '' then
        Text := '';
    end;

  cpList.Preview;

end;





procedure TParentList.brwGridChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  inherited;
  pnlCountLine.Caption := sLinha + IntToStr(brwGrid.FocusedNode.Index + 1) + sDe + IntToStr(brwGrid.Count) + '.';
end;

procedure TParentList.bpmDetailPopup(Sender: TObject);
begin
  inherited;
  beFiltraTexto.text := '';
  
end;

procedure TParentList.bbListaAgrupamentoClick(Sender: TObject);
begin
  inherited;

  if bbListaAgrupamento.Down then
    begin
      brwGrid.ShowGroupPanel := True;
    end
  else
    begin
      with brwGrid do
        begin
          ShowGroupPanel := False;
          // Retiro todos os grupos
          while GroupColumnCount > 0 do
            DeleteGroupColumn(GroupColumnCount-1);

          RebuildGroupIndexes;
        end;
    end;

end;

procedure TParentList.bbListaZoomChange(Sender: TObject);
var
  Fator: double;
  ToConvert: String;

begin
  inherited;

  if OriginalItemSize = 0 then
    Exit;

  if Pos('%', bbListaZoom.Text) <> 0 then
    ToConvert := LeftStr(bbListaZoom.Text, Length(bbListaZoom.Text)-1)
  else
    ToConvert := bbListaZoom.Text;

  if MyStrToInt(ToConvert) = 0 then
    Exit;

  Fator := MyStrToInt(ToConvert) / 100;

  with brwGrid do
    begin
      Font.Size := Round(OriginalItemSize * Fator);
      HeaderFont.Size := Round(OriginalHeaderSize * Fator);

    end;

end;

procedure TParentList.LigaAviso;
begin
  trmAviso.Enabled := True;
end;

procedure TParentList.DesligaAviso;
begin
  trmAviso.Enabled := False;
  pnlExecutaAviso.ParentColor := True;

end;



procedure TParentList.trmAvisoTimer(Sender: TObject);
begin
  inherited;
  
  if pnlExecutaAviso.ParentColor then
    pnlExecutaAviso.Color := clMaroon
  else
    pnlExecutaAviso.ParentColor := True;

end;

procedure TParentList.bbListaColunaClick(Sender: TObject);
begin
  inherited;

  if bbListaColuna.Down then
    brwGrid.ColumnsCustomizing
  else
    brwGrid.EndColumnsCustomizing;

end;

procedure TParentList.bbListaRestoreClick(Sender: TObject);
var
   i, Lines: integer;
begin

  if bbListaRestore.Visible = ivInCustomizing then
    begin
      ShowMessage('EC: You entered in EXEC RETORE with the invisible button !!!!');
      Exit;
    end;

  if NOT (egoMultiSelect in brwGrid.Options) then
    begin
      Lines := 1;
    end
  else
    begin
      Lines := brwGrid.SelectedCount;
    end;

  if (MsgBox(MSQ_QST_PART1_RETORE_LINES + IntToStr(Lines) + MSQ_QST_PART2_RETORE_LINES
            ,vbYesNo + vbQuestion) = vbNo) then
    exit;

  if (egoMultiSelect in brwGrid.Options) then
    begin
      // O grid esta em mode de deleção multipla
      with quBrowse do
        begin
          DisableControls;
          for i:= 0 to brwGrid.SelectedCount - 1 do
            begin
              Bookmark := brwGrid.SelectedRows[i];
              ExecRestoreItem;
              OnAfterRestoreItem;
            end;
          EnableControls;
        end;
    end
  else
    begin
      // O grid esta em mode de deleção simples
      ExecRestoreItem;
      ListRefresh;
      exit;
    end;

  ListRefresh;
end;

procedure TParentList.bbExportaHTMLClick(Sender: TObject);
begin
  inherited;
  with SaveDialog do
  begin
    DefaultExt := 'htm';
    Filter := 'HTML File (*.htm; *.html)|*.htm';
    FileName := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date) + '.htm';
    if Execute then
      brwGrid.SaveToHTML(FileName, True);
  end;

end;

procedure TParentList.bbExportaExcelClick(Sender: TObject);
begin
  inherited;
  with SaveDialog do
  begin
    DefaultExt := 'xls';
    Filter := 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls';
    FileName := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date) + '.xls';
    if Execute then
      brwGrid.SaveToXLS(FileName, True);
  end;

end;

procedure TParentList.bbExportaTextoClick(Sender: TObject);
begin
  inherited;
  with SaveDialog do
  begin
    DefaultExt := 'txt';
    Filter := 'Text document (*.txt)|*.txt';
    FileName := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date) + '.txt';
    if Execute then
      brwGrid.SaveAllToTextFile(FileName);
  end;

end;

procedure TParentList.btnXMLClick(Sender: TObject);
begin
  inherited;
  with SaveDialog do
    begin
    DefaultExt := 'xml';
    Filter := 'XML File (*.xml)|*.xml';
    FileName := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date) + '.xml';
    if Execute then
      brwGrid.SaveToXML(FileName, True);
    end;
end;


procedure TParentList.FilterBarPaint;
var
  i, Line: integer;
  myLeft: integer;

begin
  // Baseado no string list de filtros, monto a filter bar
  with lblFilterBar do
    myLeft := Left + Width + 5;

  Line := 0;

  for i := 0 to (slFilter.Count-1) do
    begin
      with slFilter.Objects[i] as TPanel do
        begin
          // Seto o tamanho de cada panel
          Visible    := False;
          Height     := 19;
          Width      := Self.Canvas.TextWidth(Caption) + 5;

          if (Left + Width + 3) > pnlGenFilter.Width then
            begin
              Line := Line + 1;
              MyLeft := 5;
            end;

          Top        := 5 + Line * 19;
          Left       := MyLeft;
          MyLeft     := Left + Width + 3;
          Visible    := True;

        end;
    end;

  bbListaFiltra.Down := (slFilter.Count>0);
  pnlGenFilter.Visible := (slFilter.Count>0);
  pnlGenFilter.Height := 5 + (Line + 1) * 23;

end;


procedure TParentList.bbFilterItemRemoveClick(Sender: TObject);
begin
  inherited;
  bbDetailRemoveFiltroClick(nil);
end;

procedure TParentList.bbRemoveEsteFiltroClick(Sender: TObject);
begin
  inherited;
  slFilter.Objects[TMenuItem(Sender).Tag].Free;
  slFilter.Delete(TMenuItem(Sender).Tag);
  FilterExec;
  FilterBarPaint;

end;

procedure TParentList.FilterItemMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  bbRemoveEsteFiltro.Tag := TPanel(Sender).Tag;
end;

procedure TParentList.FilterExec;
var
  i: integer;

begin
  // Pego os filtros que estao no string list e monto o where
  WhereGenFilter := '';

  for i := 0 to (slFilter.Count-1) do
    begin
      WhereGenFilter := WhereGenFilter + slFilter[i];
      if i < (slFilter.Count-1) then
        WhereGenFilter := WhereGenFilter + ' AND ';
    end;
  Application.ProcessMessages;
  ListRefresh;


end;
{
procedure TParentList.ColumnLoad(sConfig: String);
begin
  // Pego uma string contendo todas as configurações de uma coluna na seguinte formato
  // ColumnName=XXX;GroupIndex=XX;Index=XX;Sorted=XX;Visible=XX;Width=XXX
  ParseParam(sConfig, 'ColumnName')

end;
}

procedure TParentList.cbxStatusChange(Sender: TObject);
begin
  inherited;

  if cbxStatus.ItemIndex = 1 then
     BrowseConfig.MostraDesativado := STD_DESATIVADO
  else
     BrowseConfig.MostraDesativado := STD_NAODESATIVADO;

  SetBrowseState;
  ListRefresh;

end;

procedure TParentList.brwGridChangeColumn(Sender: TObject;
  Node: TdxTreeListNode; Column: Integer);

var
  Info : TdxGridDrawInfo;
begin
  inherited;

  with TdxDBGrid(Sender) do
    begin
      CalcRectInfo(Info);
      InvalidateRect(Handle, @Info.HeaderRect, True);
    end;

end;

procedure TParentList.brwGridCustomDrawColumnHeader(Sender: TObject;
  AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
  var ADone: Boolean);
begin
  inherited;

  if AColumn.Index = TdxDBGrid(Sender).FocusedAbsoluteIndex then
     AFont.Style := AFont.Style + [fsBold];

end;

procedure TParentList.btExecutaClick(Sender: TObject);
begin
  inherited;

  ListParamRefresh;

end;

procedure TParentList.bbHeaderAjusteAllClick(Sender: TObject);
begin
  inherited;
  brwGrid.ApplyBestFit(nil);
end;


end.



