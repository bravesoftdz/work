unit SuperComboADO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, DB, DBTables, LookUpADOQuery, DbGrids,
  ExtCtrls, ADODb, uSystemTypes, Variants;

// Nova versao nao guardo mais o LookUpValue e ListValue no LookUpQuery, mas sim no
// Combo.

procedure Register;

const GridHeight = 12;

type
  TSubButton = class( TBitBtn )
  protected
    procedure Click; override;
  end;

type
  TDbLookUpGrid = class( TDbGrid )
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    constructor Create( AOwner: TComponent ); override;
  public
    ObjectSuperCombo : TObject;
    OnClick     : TNotifyEvent;
  end;

type
  TOnNotInListEvent = procedure (Sender : TObject; LastText : String) of object;

  TEditCodePos = (taEditCodeLeft, taEditCodeRight);

  TSuperComboADO = class(TMaskEdit)
  private
    { Private declarations }
    FOnBeforeOpenGrid : TNotifyEvent;  {# Antes de abrir o grid }
    AdjustBounds : Boolean;
    OriginalWidth, OriginalLeft      : Integer;
    FLinkedRadioButton : TRadioButton;
    FOtherColumns : String;
    FButton   :  TSubButton; {## Something to push at }
    EditCode  :  TEdit;      {## Edit do codigo }
    btnAddNew : TButton;     {## Botao de Add New }
    btnUpdate : TButton;     {## Botao de Update }
    LookUpForm  : TForm;
    LookUpPanel : TPanel; {## Botao de Update }
    bmMemory: TBitmap;   {## For the dots }
    FEnab     : Boolean;   {## My Enabled-Property }
    FVisible  : Boolean;   {## My Visible-Property }
    FReadOnly : Boolean;   {## My ReadOnly-Property }
    FLookUpSource : TDataSource; { DataSource da Lista de valores }
    FOnNotInList  : TOnNotInListEvent;  {# Evento quando item nao pertence a lista }
    FOnSelectItem : TNotifyEvent;  {# Evento quando item e selecionado }
    FOnAfterAddUpdate : TNotifyEvent;
    FOnBeforeSelectItem : TNotifyEvent;  {# Evento antes de item selecionado }
    LookUpADOQuery   : TLookUpADOQuery; { Query LookUp }
    LookUpGrid    : TDbLookUpGrid; { Grid para visualizacao }
    IsChange      : Boolean; // Habilita/Desabilita o Evento Change
    IsLocate      : Boolean;
    FShowBtnAddNew, FShowBtnUpdate, FShowBtnSelecao : Boolean;
    FDropDownRows  : integer;
    FTop, FLeft, FWidth, FHeight : integer;
    FLookUpValue   : String;
    FIsListFiltered, FFilterSugest,
    IsLookUpQuerySet, IsKeyPressed : Boolean;
    FSpcWhereClause, FltWhereClause : String;
    OldValue, OldText : String;
    FFilterFields : TStringList; { campos do filtro }
    FFilterValues : TStringList; { valores do filtro }
    IsFoundKey    : Boolean;
    LastText      : String;
    FShowEditCode, lExitSize : Boolean;
    FCodeLength   : Integer;
    FEditCodePos  : TEditCodePos;
    ForcaTrocaLookUp, NoExtraKey    : Boolean;
    FMostraDesativado : TDesativadoState;
    FMostraHidden     : THiddenState;
    First, IsLookUpValue, AllowSelectItem : Boolean;
    FComboFields: TComboFields;
    procedure AdjustComboBounds;
    procedure SetShowBtnSelecao(Value : Boolean);
    procedure SetFilterFields(Value : TStringList);
    procedure SetFilterValues(Value : TStringList);
    procedure SetExit(AShowing: Boolean = false);
    procedure SetSpcWhereClause(Value: String);
    procedure SetLookUpValue(Value: String);
    procedure SetVisible(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetLookUpSource(Value : TDataSource);
    function  GetLookUpFieldValue : Variant;
    procedure OpenGrid;
    procedure LookUpGridClick(Sender : TObject);
    procedure LookUpGridDblClick(Sender : TObject);
    procedure UpdateValues;
    procedure SelectActualValue;
    procedure AddUpdateClick(Sender : TObject);
    procedure LookUpFormShow(Sender : TObject);
    procedure OwnerDeactivate(Sender: TObject);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN; {handle esc}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    Procedure DrawDropDownArrow(Canvas: TCanvas; R: TRect;
                                State: TButtonState;
                                Enabled: Boolean;
                                ControlState: TControlState);
    procedure FillFieldValues(var AComboFields: TComboFields);
  protected
    { Protected declarations }
    FIDLanguage : Integer;
    sAll, sErrorFilter,
    sSelecLookUp, sDefineEvent,
    sPossValues, sNewItem1,
    sNewItem2, sUpdate1,
    sUpdate2 : String;
    procedure SetLookUpQuery;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;   {## Chama o OpenGrid }
    procedure DoEnter; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMSize( var Message: TWMSize ); message WM_SIZE;
    constructor Create( AOwner: TComponent ); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    DataAware       : Boolean;
    CodeValue, ListValue  : String;
    procedure SetAll;
    procedure CallUpdate;
    procedure ClearFilters;
    procedure GetFirstValue;
    procedure GetLastValue;
    procedure GetPriorValue;
    procedure GetNextValue;
    procedure GetPriorPage;
    procedure GetNextPage;
    function GetFieldByName(AFieldName: string): Variant;
    procedure AddFilter(aFields, aValues : array of string);
    procedure CreateParams( var Params: TCreateParams ); override;
    property  ComboFields: TComboFields read FComboFields;
    property  LookUpValue  : String read FLookUpValue write SetLookUpValue;
    property  LookUpFieldValue : Variant read GetLookUpFieldValue;
    property  OnBeforeSelectItem   : TNotifyEvent read FOnBeforeSelectItem write FOnBeforeSelectItem;
  published
    { Published declarations }
    property LinkedRadioButton : TRadioButton read FLinkedRadioButton write FLinkedRadioButton;
    property CodeLength     : Integer read FCodeLength write FCodeLength default 40;
    property FilterFields   : TStringList read FFilterFields write SetFilterFields;
    property FilterValues   : TStringList read FFilterValues write SetFilterValues;
    property FilterSugest   : Boolean     read FFilterSugest write FFilterSugest default False;
    property SpcWhereClause : String  read FSpcWhereClause write SetSpcWhereClause;
    property Enabled        : Boolean read FEnab write SetEnabled default True;
    property Visible        : Boolean read FVisible write SetVisible default True;
    property ReadOnly       : Boolean read FReadOnly write SetReadOnly default False;
    property LookUpSource   : TDataSource read FLookUpSource write SetLookUpSource;
    property IsListFiltered : Boolean read FIsListFiltered write FIsListFiltered default True;
    property DropDownRows   : integer read FDropDownRows write FDropDownRows default 20;
    property ShowBtnAddNew  : Boolean read FShowBtnAddNew write FShowBtnAddNew default True;
    property ShowBtnUpdate  : Boolean read FShowBtnUpdate write FShowBtnUpdate default True;
    property ShowBtnSelecao : Boolean read FShowBtnSelecao write SetShowBtnSelecao default True;
    property ShowEditCode   : Boolean read FShowEditCode write FShowEditCode default False;
    property EditCodePos    : TEditCodePos read FEditCodePos write FEditCodePos default taEditCodeLeft;
    property OtherColumns   : String  read FOtherColumns write FOtherColumns;
    property MostraDesativado : TDesativadoState read FMostraDesativado write FMostraDesativado default STD_NAODESATIVADO;
    property MostraHidden   : THiddenState read FMostraHidden write FMostraHidden default STD_NAOHIDDEN;
    property IDLanguage     : Integer read FIDLanguage write FIDLanguage default 1;

    // Eventos
    property OnSelectItem     : TNotifyEvent read FOnSelectItem write FOnSelectItem;
    property OnBeforeOpenGrid : TNotifyEvent read FOnBeforeOpenGrid write FOnBeforeOpenGrid;
    property OnNotInList      : TOnNotInListEvent read FOnNotInList write FOnNotInList;
    property OnAfterAddUpdate : TNotifyEvent read FOnAfterAddUpdate write FOnAfterAddUpdate;
{
    // Herdados
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property Picture;
    property PopupMenu;
    property ShowVertScrollBar;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UsePictureMask;
    property Visible;
    property WantReturns;
    property WordWrap;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnCheckValue;
}
  end;

  TDBSuperComboADO = class(TSuperComboADO)
  private
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField  : string read GetDataField write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property ReadOnly   : Boolean read GetReadOnly write SetReadOnly default False;
  end;

implementation

uses xBase, uNumericFunctions;

{ ---- TSubButton ---- }

procedure TSubButton.Click;
begin
  inherited Click;
  TSuperComboADO(Parent).DoEnter;

  if TSuperComboADO(Parent).LookUpForm.Visible then
    begin
     TSuperComboADO(Parent).LookUpForm.Close;
     TSuperComboADO(Parent).SetFocus;
    end
  else
     TSuperComboADO(Parent).OpenGrid;
end;

{ ---- TDBLookUpgrid ---- }

constructor TDbLookUpGrid.Create( AOwner: TComponent );
begin
  inherited Create( AOwner);
  ScrollBars := ssVertical;
end;

procedure TDbLookUpGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and not (ssDouble in Shift)  then
  begin
     // Click do grid, seta o foco no parent
     OnClick(Self);
  end;
end;

procedure TDbLookUpGrid.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
begin
  if CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    if not (Focused or (InplaceEditor <> nil) and InplaceEditor.Focused) then
       Exit;
  end;

  if TDataSet(Datasource.DataSet).Active then
  begin
    with Message, TDataSet(Datasource.DataSet) do
      case ScrollCode of
        SB_LINEUP    : TSuperComboADO(ObjectSuperCombo).GetPriorValue;
        SB_LINEDOWN  : TSuperComboADO(ObjectSuperCombo).GetNextValue;
        SB_PAGEUP    : TSuperComboADO(ObjectSuperCombo).GetPriorPage;
        SB_PAGEDOWN  : TSuperComboADO(ObjectSuperCombo).GetNextPage;
        SB_THUMBPOSITION:
          begin
            if IsSequenced then
            begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(Self.Handle, SB_VERT, SI);
              if SI.nTrackPos <= 1 then First
              else if SI.nTrackPos >= RecordCount then Last
              else RecNo := SI.nTrackPos;
            end
            else
              case Pos of
                0: TSuperComboADO(ObjectSuperCombo).GetFirstValue;
                1: TSuperComboADO(ObjectSuperCombo).GetPriorPage;
                2: Exit;
                3: TSuperComboADO(ObjectSuperCombo).GetNextPage;
                4: TSuperComboADO(ObjectSuperCombo).GetLastValue;
              end;
          end;
        SB_BOTTOM : TSuperComboADO(ObjectSuperCombo).GetLastValue;
        SB_TOP    : TSuperComboADO(ObjectSuperCombo).GetFirstValue;
      end;
    TSuperComboADO(ObjectSuperCombo).FillFieldValues(TSuperComboADO(ObjectSuperCombo).FComboFields);
  end;
end;

{---- TSuperCombo----}

constructor TSuperComboADO.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );

  Case FIDLanguage of
   1 : begin
       sAll         := '<ALL>';
       sErrorFilter := 'SuperCombo - Filter error';
       sSelecLookUp := ' - You must set the LookUpSource';
       sDefineEvent := 'SuperCombo - Event OnClickButton not defined';
       sPossValues  := 'Possible values';
       sNewItem1    := 'New Item';
       sNewItem2    := '&New';
       sUpdate1     := 'Update selected Item';
       sUpdate2     := '&Update';
       end;
   2 : begin
       sAll         := '<Todos>';
       sErrorFilter := 'SuperCombo - erro na passagem do filtro';
       sSelecLookUp := ' - selecione um LookUpSource';
       sDefineEvent := 'SuperCombo - Evento OnClickButton nao foi definido';
       sPossValues  := 'Possível valores';
       sNewItem1    := 'Novo item';
       sNewItem2    := '&Novo';
       sUpdate1     := 'Atualizar item selecionado';
       sUpdate2     := 'At&ualizar';
       end;
   3 : begin
       sAll         := '<Todos>';
       sErrorFilter := 'SuperCombo - erro na passagem do filtro';
       sSelecLookUp := ' - selecione um LookUpSource';
       sDefineEvent := 'SuperCombo - Evento OnClickButton nao foi definido';
       sPossValues  := 'Possível valores';
       sNewItem1    := 'Novo item';
       sNewItem2    := '&Novo';
       sUpdate1     := 'Atualizar item selecionado';
       sUpdate2     := 'At&ualizar';
       end;
   else begin
       sAll         := '<ALL>';
       sErrorFilter := 'SuperCombo - Filter error';
       sSelecLookUp := ' - You must set the LookUpSource';
       sDefineEvent := 'SuperCombo - Event OnClickButton not defined';
       sPossValues  := 'Possible values';
       sNewItem1    := 'New Item';
       sNewItem2    := '&New';
       sUpdate1     := 'Update selected Item';
       sUpdate2     := '&Update';
       end;
  end;

  // Inicializa tamanho do vetor de campos/valores
  SetLength(FComboFields, 0);

  // Cria o bitmap
  bmMemory := TBitmap.Create;

  // Cria o botao de chamar o grid
  FButton := TSubButton.Create( Self );
  with FButton do
   begin
    TabStop := False;
    Hint := sPossValues;
    ShowHint := True;
    Width := 16;
    Height := 16;
    Visible := True;
    Parent := Self;
    ControlStyle := ControlStyle - [csSetCaption];
   end;

  if not (csDesigning in ComponentState) then
   begin
     // Cria o EditCode
     EditCode := TEdit.Create( Self );
     with EditCode do
       begin
         Color      := clBtnFace;
         Font.Style := Font.Style + [fsBold];
         TabStop  := False;
         Enabled  := True;
         ReadOnly := True;
         Parent   := Self;
       end;

     // Cria o LookUpForm
     with TForm(AOwner) do
       OnDeactivate  := OwnerDeactivate;

     LookUpForm := TForm.Create( Self );
     with LookUpForm do
      begin
        {By Carlos}
        Parent       := Self.Parent;
        BorderStyle  := bsNone;
        FormStyle    := fsStayOnTop;
        OnShow       := LookUpFormShow;
      end;

     // Cria o Panel
     LookUpPanel := TPanel.Create( LookUpForm );
     with LookUpPanel do
      begin
       Parent  := LookUpForm;
       Align   := alClient;
       BevelWidth := 1;
       Caption := '';
      end;
     // Cria o grid
     LookUpGrid := TDBLookUpGrid.Create( LookUpPanel );
     with LookUpGrid do
      begin
       Parent     := LookUpPanel;
       ObjectSuperCombo := Self;
       OnClick    := LookUpGridClick;
       OnDblClick := LookUpGridDblClick;
       Options    := [dgTabs, dgRowSelect, dgAlwaysShowSelection, dgColLines];
       TabStop    := False;
      end;
     // Cria o botao de AddNew
     btnAddNew := TButton.Create( LookUpPanel );
     with btnAddNew do
       begin
        TabStop := False;
        Parent  := LookUpPanel;
        Hint    := sNewItem1;
        Caption := sNewItem2;
        ShowHint := True;
        Height := 20;
        Tag    := 0;
        OnClick := AddUpdateClick;
       end;
     // Cria o botao de Update
     btnUpdate := TButton.Create( LookUpPanel );
     with btnUpdate do
       begin
        TabStop := False;
        Parent  := LookUpPanel;
        Hint    := sUpdate1;
        Caption := sUpdate2;
        ShowHint := True;
        Height := 20;
        Tag    := 1;
        OnClick := AddUpdateClick;
       end;
   end;

  // Cria os filtros
  FFilterFields := TStringList.Create;
  FFilterValues := TStringList.Create;
  FFilterSugest := False;

  FltWhereClause     := '';  // String Where vinda dos filter fields
  FSpcWhereClause    := '';  // String where especial

  IsLookUpQuerySet := False;
  IsKeyPressed     := False;

  LastText       := '';
  IsFoundKey     := True;

  OriginalWidth  := 0;
  OriginalLeft   := 0;

  First          := True;
  OldText        := '';
  OldValue       := '';
  FOtherColumns  := '';
  FDropDownRows  := 20;
  FCodeLength    := 40;
  FShowBtnAddNew  := True;
  FShowBtnUpdate  := True;
  FShowBtnSelecao := True;

  ForcaTrocaLookUp := False;

  FShowEditCode   := False;
  FIsListFiltered := True;
  lExitSize       := False;
  IsLookUpValue   := True;
  AllowSelectItem := True;
  FEditCodePos    := taEditCodeLeft;
  FMostraDesativado := STD_NAODESATIVADO;
  FMostraHidden     := STD_NAOHIDDEN;

  IsLocate  := True;
  IsChange  := True;
  FEnab     := True;
  FVisible  := True;
  DataAware := False;
  AdjustBounds := True;
end;

destructor TSuperComboADO.Destroy;
begin
  SetLength(FComboFields, 0);
  EditCode := nil;
  LookUpForm.Free;
  bmMemory.Free;
  FButton := nil;

  FFilterFields.Free;
  FFilterValues.Free;

  if Assigned(LookUpADOQuery) then
    with LookUpADOQuery do
      begin
        if Active then Close;
        // LookUpADOQuery.ResetValues;
        // SQL.Text := OriginalSQL;  // Restaura o antigo SQL
      end;
  inherited Destroy;
end;

procedure TSuperComboADO.SetAll;
begin
  // Se tiver Linkado o RadioButton All coloca o checked
  if Assigned(LinkedRadioButton) then
     LinkedRadioButton.Checked := True
  else
    begin
      LookUpValue := '';
      Text := sAll;
    end;
end;

procedure TSuperComboADO.DoEnter;
begin
  inherited DoEnter;

  IsFoundKey := True;

  // Se tiver Linkado o RadioButton All tira o checked
  if Assigned(LinkedRadioButton) then
    begin
     if LinkedRadioButton.Checked then
       begin
        Text := '';
        LinkedRadioButton.Checked := False;
       end;
    end;
end;

procedure TSuperComboADO.SetSpcWhereClause(Value : String);
begin
  FSpcWhereClause := Value;
  if Assigned(LookUpADOQuery) then LookUpADOQuery.Close;
end;

procedure TSuperComboADO.SetFilterFields(Value : TStringList);
begin
  if FFilterFields <> Value then
     FFilterFields.Assign(Value);
end;

procedure TSuperComboADO.SetFilterValues(Value : TStringList);
begin
  if FFilterValues <> Value then
     FFilterValues.Assign(Value);
end;

procedure TSuperComboADO.ClearFilters;
begin
  FFilterFields.Clear;
  FFilterValues.Clear;
end;

procedure TSuperComboADO.AddFilter(aFields, aValues : array of string);
var
   i : integer;
begin
  ClearFilters;
  if High(aFields) <> High(aValues) then
     raise exception.create(sErrorFilter)
  else
    begin
     for i := Low(aFields) to High(aFields) do
       begin
         FFilterFields.Add(aFields[i]);
         FFilterValues.Add(aValues[i]);
       end;
    end;
end;

procedure TSuperComboADO.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  OldLeft, OldTop, OldHeight, OldWidth : integer;
begin
  OldLeft   := Left;
  OldTop    := Top;
  OldHeight := Height;
  OldWidth  := Width;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (ALeft <> OldLeft) or (ATop <> OldTop) or
     (AWidth <> OldWidth) or (AHeight <> OldHeight) then
  begin
    if AdjustBounds then
      AdjustComboBounds;
  end;
end;

procedure TSuperComboADO.SetLookUpSource(Value: TDataSource);
begin
  FLookUpSource := Value;
  if Value <> nil then
    begin
     Value.FreeNotification(Self);
     IsLookUpQuerySet := False;
     try
       ForcaTrocaLookUp := True;
       SetLookUpQuery;
     finally
       ForcaTrocaLookUp := False;
     end;
    end;
end;

procedure TSuperComboADO.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

procedure TSuperComboADO.AdjustComboBounds;
begin
  if not (csDesigning in ComponentState) then
    begin
      try
        AdjustBounds := False;

        if FShowEditCode then
          begin
           if OriginalWidth = 0 then
             OriginalWidth := Width;

           if OriginalLeft = 0 then
             OriginalLeft  := Left;

           EditCode.Parent := Parent;
           EditCode.Font   := Self.Font;
           EditCode.Top    := Top;

           EditCode.Height := Height;
           EditCode.Width  := FCodeLength;

           if FEditCodePos = taEditCodeLeft then
             begin
               EditCode.Left   := OriginalLeft;
               Left            := OriginalLeft + EditCode.Width + 2;
             end
           else
             begin
               EditCode.Left   := OriginalLeft + OriginalWidth - EditCode.Width;
             end;

           try
             lExitSize     := True;
             Width         := OriginalWidth - (EditCode.Width + 3);
           finally
             lExitSize := False;
           end;
          end;
            
          if Assigned(LookUpADOQuery) then
            LookUpForm.Width := LookUpADOQuery.FieldByName(LookUpADOQuery.ListField).DisplayWidth * 6
          else
            LookUpForm.Width  := Width + 20;

          // Define tamanho do LookUpForm
          if ShowEditCode then
            LookUpForm.Width  := LookUpForm.Width + EditCode.Width + 2;

          if FShowbtnAddNew or FShowbtnUpdate then
            LookUpForm.Height := FDropDownRows*GridHeight+30
          else
            LookUpForm.Height := FDropDownRows*GridHeight+3;

      finally
        AdjustBounds := True;
      end;

    end;
end;

procedure TSuperComboADO.WMSize( var Message: TWMSize );
var
  rectDraw: TRect;
begin
  if not (csDesigning in ComponentState) then
    begin
      if lExitSize then
         Exit;

      AllowSelectItem := True;

      // Define datasources do Browse e query
      SetLookUpQuery;

      // Define os tamanhos e a posicao dos controles, que nao mudam conforme o
      // form da o resize

      // TEsta se deve mostrar o EditCode
      EditCode.Visible := FShowEditCode;

      if FShowEditCode then
        begin
         // Testa o Text
         if not DataAWare then
           begin
            Text := '';
           end;
        end;

      AdjustComboBounds;

      // Define coordenadas do grid e datasource
      LookUpGrid.Left   := 3;
      LookUpGrid.Width  := LookUpForm.Width - 6;
      LookUpGrid.Height := FDropDownRows*GridHeight;

      // Define a fonte do grid
      LookUpGrid.Font   := Font;

      // Define coordenadas do botao de Add e Update
      if FShowbtnAddNew and FShowbtnUpdate then
        begin
         btnAddNew.Left    := 5;
         btnAddNew.Width   := Trunc((LookUpForm.Width-15)/2);
         btnUpdate.Left    := 10+btnAddNew.Width;
         btnUpdate.Width   := btnAddNew.Width;
        end
      else if FShowbtnAddNew then
        begin
         btnAddNew.Left    := 5;
         btnAddNew.Width   := LookUpForm.Width-10;
        end
      else if FShowbtnUpdate then
        begin
         btnUpdate.Left    := 5;
         btnUpdate.Width   := LookUpForm.Width-10;
        end;

      // Seta o visible dos controls
      btnAddNew.Visible := FShowbtnAddNew;
      btnUpdate.Visible := FShowbtnUpdate;

    end;

  // Posicionamento do botao
  FButton.Top     := 1;
  FButton.Height  := Height - 6;
  FButton.Width   := Height - 4;
  FButton.Left    := Width - Height;
  FButton.Visible := FShowBtnSelecao;

  // Desenho do bitmap
  SetRect(rectDraw, 0, 0, ClientWidth-1, ClientHeight-1);

  bmMemory.Width := rectDraw.Right - rectDraw.Left + 1;
  bmMemory.Height := rectDraw.Bottom - rectDraw.Top + 4;
  DrawDropDownArrow(bmMemory.Canvas, rectDraw, bsDown, Enabled, ControlState);

  FButton.Glyph := bmMemory;
end;

Procedure TSuperComboADO.DrawDropDownArrow(Canvas: TCanvas; R: TRect;
                                           State: TButtonState;
                                           Enabled: Boolean;
                                           ControlState: TControlState);
var Flags: Integer;
begin
  if not Enabled then
    Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
  else if (State=bsUp) or (csPaintCopy in ControlState) then
    Flags := DFCS_SCROLLCOMBOBOX
  else
    Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED;
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
end;

procedure TSuperComboADO.SetShowBtnSelecao(Value : Boolean);
begin
  FShowBtnSelecao := Value;
  FButton.Visible := Value;
  FButton.Refresh;
end;

procedure TSuperComboADO.SetLookUpQuery;
var
   i, OtherIndex : integer;
   StrCol : String;
begin
  if IsLookUpQuerySet then
     Exit
  else
     IsLookUpQuerySet := True;

  // Nao roda se estiver em design state
  if (csDesigning in ComponentState) then
     Exit;

  if not Assigned(FLookUpSource) then
     raise exception.create('SuperCombo ' + Name + sSelecLookUp);

  if not Assigned(LookUpADOQuery) or ForcaTrocaLookUp then
    begin
      // Seta o query do grid
      LookUpGrid.DataSource := FLookUpSource;
      if not (FLookUpSource.DataSet is TLookUpADOQuery) then
        begin
         IsLookUpQuerySet := False;
         Exit;
        end;

      LookUpADOQuery := TLookUpADOQuery(FLookUpSource.DataSet);

      // Coluna do LookUpField nao aparece no grid
      // Coloca na seguinte ordem :
      // CodeField | ListField  se ShowEditCode é True

      // Criacao dinamica das colunas que aparecem

      with LookUpGrid do
        begin
          Columns.Clear;

          with Columns.Add do
            begin
              if ShowEditCode then
                begin
                  if FEditCodePos = taEditCodeLeft then
                    begin
                      FieldName   := LookUpADOQuery.CodeField;
                      Width       := CodeLength-3;
                      with LookUpGrid.Columns.Add do
                        begin
                          FieldName   := LookUpADOQuery.ListField;
                          if OriginalWidth = 0 then
                            Width       := Self.Width-CodeLength-3
                          else
                            Width       := OriginalWidth-CodeLength-3;
                        end;
                    end
                  else
                    begin
                      FieldName   := LookUpADOQuery.ListField;
                      if OriginalWidth = 0 then
                        Width       := Self.Width - CodeLength - 3
                      else
                        Width       := OriginalWidth - CodeLength - 3;

                      with LookUpGrid.Columns.Add do
                        begin
                          FieldName   := LookUpADOQuery.CodeField;
                          Width       := CodeLength-3;
                        end;
                    end;
                end
              else
                begin
                  FieldName   := LookUpADOQuery.ListField;
                  Width       := Width;
                end;
            end;
        end;
    end;
end;

procedure TSuperComboADO.LookUpFormShow(Sender : TObject);
var
  rectDraw: TRect;
  FormPoint, P : TPoint;
  SizeListField, DifWidth : integer;
begin
   // Define coordenadas do LookUpForm
   rectDraw := ClientRect;
   FormPoint.X := rectDraw.Left;
   FormPoint.Y := rectDraw.Top;

   LookUpForm.Left   := ClientToScreen(FormPoint).X - 3;

   // se editcode esta a esquerda o combo deve ter left iniciando no EditCode
   if ShowEditCode and (FEditCodePos = taEditCodeLeft) then
     begin
       LookUpForm.Left := LookUpForm.Left - EditCode.Width - 2;
     end;
{
   // Seta o tamanho do LookUpForm
   try
     SizeListField    := LookUpADOQuery.FieldByName(LookUpADOQuery.ListField).Size;
     DifWidth         := SizeListField*(Font.Size) - Width;
     if DifWidth > 30 then
        DifWidth := 30;

     LookUpForm.Width := LookUpForm.Width + DifWidth;
   except
     raise exception.create('ListField nao foi encontrado');
   end;
}
   // Testa se esta fora da tela
   if (ClientToScreen(FormPoint).Y + Height + LookUpForm.Height) < Screen.Height then
     begin
      LookUpForm.Top    := ClientToScreen(FormPoint).Y + Height;
      LookUpGrid.Top    := 0;
      btnAddNew.Top     := LookUpForm.Height - 25;
      btnUpdate.Top     := btnAddNew.Top;
     end
   else
     begin
      btnAddNew.Top     := 25 - btnAddNew.Height;
      btnUpdate.Top     := btnAddNew.Top;
      LookUpGrid.Top    := LookUpForm.Height - LookUpGrid.Height;
      LookUpForm.Top    := ClientToScreen(FormPoint).Y - LookUpForm.Height;
     end;

   // Nao sei porque, mas com o codigo abaixo o LookUpform fica sempre StayOnTop
   P := LookUpForm.ClientOrigin;
   SetWindowPos (LookUpForm.Handle, HWND_TOPMOST, P.X, P.Y, LookUpForm.Width,
                 LookUpForm.Height, SWP_NOACTIVATE)
end;

procedure TSuperComboADO.WMKillFocus(var Message: TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
     EditCode.Parent  := Parent;

  // Fecha o lookupform quando clica fora da aplicacao
  if Message.WParam = 0 then
     LookUpForm.Close;
end;

procedure TSuperComboADO.OwnerDeactivate(Sender: TObject);
begin
  // Da close no LookUpform se clicar fora do form owner
  if not LookUpForm.Active then
     LookUpForm.Close;
end;

procedure TSuperComboADO.CNKeyDown(var Message: TWMKeyDown);
begin
  if not (csDesigning in ComponentState) then
  begin

  {TESTE}
  {if LookUpGrid.CanFocus then
  begin
    LookUpGrid.SetFocus;
    if not (LookUpGrid.Focused or (LookUpGrid.InplaceEditor <> nil) and LookUpGrid.InplaceEditor.Focused) then
    begin
       Exit;
       Showmessage('foi');
    end;
  end;}
  {/TESTE}



    with Message do
     begin
      case charcode of
        VK_DOWN    : GetNextValue;
        VK_END     : GetLastValue;
        VK_HOME    : GetFirstValue;
        VK_UP      : GetPriorValue;
      end;

      if (LookUpForm.Visible) then
       begin
        //LookUpGrid.Refresh;
        // Ambos os casos nao continua a capturar a tecla
        case charcode of
          VK_ESCAPE  : begin
                        LookUpForm.Close;
                        LookUpValue := '';
                        Exit;
                       end;
          VK_RETURN  : begin
                        SetExit(True);
                        Exit;
                       end;
          34         : GetNextPage; // Page Down

          33         : GetPriorPage;  // Page Up
        end;
       end
      else
       begin   // Grid Fechado, forca a busca do valor
        case charcode of
          VK_DOWN,
          VK_UP,
          VK_END,
          VK_HOME : LookUpGridDblClick(nil);

          VK_RETURN  : SetExit;
        end;
       end;
     end;
    FillFieldValues(FComboFields);
  end;
  inherited;
end;

procedure TSuperComboADO.GetFirstValue;
begin
   if LookUpADOQuery.LocateFirst('', FIsListFiltered, False,
                              FFilterFields, FFilterValues,
                              FFilterSugest, FSpcWhereClause, True, FMostraDesativado, FMostraHidden) then
      UpdateValues;
end;

procedure TSuperComboADO.GetLastValue;
begin
   if LookUpADOQuery.LocateLast(FIsListFiltered,
                             FFilterFields, FFilterValues,
                             FFilterSugest, FSpcWhereClause, FMostraDesativado, FMostraHidden) then
      UpdateValues;
end;

procedure TSuperComboADO.GetNextValue;
begin
   if LookUpADOQuery.LocateNext(Text, FIsListFiltered, 1,
                             FFilterFields, FFilterValues,
                             FFilterSugest, FSpcWhereClause, FMostraDesativado, FMostraHidden) then
      UpdateValues;
end;

procedure TSuperComboADO.GetNextPage;
begin
   if LookUpADOQuery.LocateNext(Text, FIsListFiltered, LookUpGrid.VisibleRowCount,
                             FFilterFields, FFilterValues,
                             FFilterSugest, FSpcWhereClause, FMostraDesativado, FMostraHidden) then
      UpdateValues;
end;

procedure TSuperComboADO.GetPriorValue;
begin
   if LookUpADOQuery.LocatePrior(Text, FIsListFiltered, 1,
                              FFilterFields, FFilterValues,
                              FFilterSugest, FSpcWhereClause, FMostraDesativado, FMostraHidden) then
      UpdateValues;
end;

procedure TSuperComboADO.GetPriorPage;
begin
   if LookUpADOQuery.LocatePrior(Text, FIsListFiltered, LookUpGrid.VisibleRowCount,
                              FFilterFields, FFilterValues,
                              FFilterSugest, FSpcWhereClause, FMostraDesativado, FMostraHidden) then
      UpdateValues;
end;

procedure TSuperComboADO.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  if (Message.Sender = Owner) or ((Message.Sender <> Self) and
     (Message.Sender <> LookUpForm)) then
     LookUpForm.Close;
end;

procedure TSuperComboADO.SetVisible(Value: Boolean);
begin
  FVisible := Value;
  inherited Visible := FVisible;

  if not (csDesigning in ComponentState) then
     EditCode.Visible  := FShowEditCode and FVisible;
end;

procedure TSuperComboADO.SetEnabled(Value: Boolean);
begin
  FEnab := Value;
  inherited Enabled := FEnab;
  FButton.Enabled   := FEnab;
end;

procedure TSuperComboADO.SetReadOnly(Value: Boolean);
begin
  FReadOnly := Value;
  inherited ReadOnly := FReadOnly;
  FButton.Enabled    := not FReadOnly;
end;

procedure TSuperComboADO.KeyDown(var Key: Word; Shift: TShiftState);
begin
   inherited KeyDown(Key, Shift);

   // Forca para saber se houve aperto de tecla ou e babaquice do
   // Delphi
   // Se for RETURN or ESC nao chama o change
   IsKeyPressed := ((Key <> 13) and (Key <> 27));

   NoExtraKey := False;

   if Shift = [ssAlt] then
     begin
       if UpperCase(Chr(Key)) = 'N' then
          AddUpdateClick(btnAddNew)
       else if UpperCase(Chr(Key)) = 'U' then
          AddUpdateClick(btnUpdate);
     end
   else
     begin
       if Key = VK_F2 then
          OpenGrid
       else if (Key = 8) or (Key = VK_DELETE) then  // BACKSPACE e DELETE
          IsLocate := False;
     end;
end;

procedure TSuperComboADO.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TSuperComboADO.Change;
begin
  inherited Change;

  if not (csDesigning in ComponentState) then
    begin
     EditCode.Parent  := Parent;

     // Se campo estiver vazio forca o requery
     if Text = '' then
        IsFoundKey := True;

     if IsChange and IsKeyPressed then
       begin
        OpenGrid;
        IsKeyPressed := False;
       end;
    end;
end;

procedure TSuperComboADO.OpenGrid;
var
  lExit : Boolean;
  TextLen, LastTextLen : Integer;
begin

  if Assigned(OnBeforeOpenGrid) then
    FOnBeforeOpenGrid(Self);

  with TLookUpADOQuery(FLookUpSource.DataSet) do
    if Assigned(OnBeforeOpenGrid) then
      FOnBeforeOpenGrid(Self);

  if Assigned(LookUpADOQuery) and TForm(Owner).Active then
    begin
     // Se nao achou e o tamanho do text atual e maior nao faz nada
     // Testes para saber se procura
     lExit := False;

     if (not IsFoundKey) then
       begin
        TextLen     := Length(Trim(Text));
        LastTextLen := Length(Trim(LastText));
        if (TextLen > LastTextLen) and (LastTextLen > 0) then
           lExit := True
        else if TextLen = LastTextLen then
           lExit := (TextLen >= LastTextLen)
        else
           lExit := False;
       end;

     LastText := Text;

     if lExit then
        Exit;

     AllowSelectItem := True;  // habilita o selectitem


     {TESTE
     if Text <> '' then
     begin
     LookUpADOQuery.Active := True;
     IsLocate := True;
     end;
     {/TESTE}
     IsFoundKey := LookUpADOQuery.LocateFirst(Text, FIsListFiltered, IsLocate,
                                           FFilterFields, FFilterValues,
                                           FFilterSugest, FSpcWhereClause, True, FMostraDesativado, FMostraHidden);

     if IsFoundKey then
       begin
        // Seta o LookUpValue constantemente
        FLookUpValue := LookUpADOQuery.LookUpValue;
        ListValue    := LookUpADOQuery.ListValue;
        CodeValue    := LookUpADOQuery.CodeValue;
        LookUpGrid.Options := LookUpGrid.Options + [dgAlwaysShowSelection];
       end
     else
       begin
        LookUpGrid.Options := LookUpGrid.Options - [dgAlwaysShowSelection];
        FLookUpValue := '';
        ListValue    := '';
        CodeValue    := '';
       end;

     IsLocate := True;  // Reseta o locate;

     if not LookUpForm.Visible and FEnab then
        LookUpForm.Show;

//     TForm(Owner).SetFocus;
//     TWinControl(Parent).SetFocus;
     SetFocus;
    end;
  {TESTE}
  //LookUpGrid.Refresh;
  {/TESTE}
end;

procedure TSuperComboADO.LookUpGridClick(Sender : TObject);
begin
   LookUpGrid.Options := LookUpGrid.Options + [dgAlwaysShowSelection];
   SetFocus;
   if not (FShowBtnAddNew or FShowBtnUpdate) then
      LookUpGridDblClick(Sender);
end;

procedure TSuperComboADO.LookUpGridDblClick(Sender : TObject);
begin
   // Seta o valor corrente
   UpdateValues;
   LookUpForm.Close;
   SelectActualValue;
end;

procedure TSuperComboADO.SelectActualValue;
begin
   if FLookUpValue <> '' then
     begin
      AllowSelectItem := False;
      FillFieldValues(FComboFields);
      // Altera o field associado ao combo
      if DataAware then
         TDBSuperComboADO(Self).UpdateData(Self);

      if Assigned(OnBeforeSelectItem) then
         FOnBeforeSelectItem(Self);

      if Assigned(OnSelectItem) then
         FOnSelectItem(Self);
     end;
end;

procedure TSuperComboADO.UpdateValues;
var
   Key : Char;
begin
  // Associa o LookUpValue, sem procurar pelo codigo
  // ja que o usuario clickou no item
  // Forca o delphi a saber que houve o edit state no DBSuperCombo
  Key := #32;
  KeyPress(Key);
  IsKeyPressed := False;

  // Muda o Text e o LookUpValue
  LookUpADOQuery.UpdateValues;
  ListValue    := LookUpADOQuery.ListValue;
  FLookUpValue := LookUpADOQuery.LookUpValue;
  CodeValue    := LookUpADOQuery.CodeValue;

  AllowSelectItem := True;

  try
    IsChange := False;
    Change;   // Seta o modified do Tipo DB.
    Text     := ListValue;
    EditCode.Text := Codevalue;
    LastText := Text;
  finally
    IsChange := True;
  end;

  if not LookUpGrid.Visible then
    begin
     SetFocus;
     SelectAll;
    end;
end;

procedure TSuperComboADO.CMExit(var Message: TCMExit);
begin
  SetExit(LookUpForm.Showing);

  if not DataAware then
     DoExit;

  AllowSelectItem := True;
end;

procedure TSuperComboADO.SetExit(AShowing: Boolean = false);
var
  OldText : String;
begin
  if Assigned(LookUpADOQuery) then
    begin
      LookUpForm.Close;

      OldText := Trim(Text);

      FillFieldValues(FComboFields);

      // Verifica se houve mudanca no text se e para refazer a query
      if Trim(Text) = '' then
        begin
         LookUpValue  := '';
        end
      else
        begin
         // testa se valor digitado e
         try
            IsLookUpValue := False;
            LookUpValue   := Text;  // Testa se existe descricao que faca o 'match' do codigo
         finally
            IsLookUpValue := True;
         end;
        end;

      // Sempre fecha o query na saida
      with LookUpADOQuery do
        if Active then Close;

      if (FLookUpValue = '') and Assigned(OnNotInList) then
         FOnNotInList(Self, OldText)
      else if FLookUpValue <> '' then
        begin
         if AllowSelectItem then
           begin
            // Altera o field associado ao combo
            if DataAware then
               TDBSuperComboADO(Self).UpdateData(Self);
            AllowSelectItem := False;
            {By Carlos}
            if AShowing then
            begin
              if Assigned(OnBeforeSelectItem) then
                 FOnBeforeSelectItem(Self);

              if Assigned(OnSelectItem) then
                 FOnSelectItem(Self);
            end;
           end;
        end;
    end;
end;

function  TSuperComboADO.GetLookUpFieldValue : Variant;
begin
  // Retorna o valor no tipo certo do combo
  // se nao houver nenhum valor retorna ''

  with LookUpADOQuery do
    begin
      case FieldByName(LookupField).DataType of

           ftString,
           ftMemo      : Result := LookUpValue;

           ftDateTime,
           ftDate      : Result := StrToDateTime(LookUpValue);

           ftInteger   : Result := MyStrToInt(LookUpValue);

           ftFloat     : Result := MyStrToFloat(LookUpValue);

           ftBoolean   : Result := ( Pos(LookUpValue, 'TRUE,1') > 0 );
      end;
    end;
end;

procedure TSuperComboADO.FillFieldValues(Var AComboFields: TComboFields);
var
  I : Integer;
begin
  if (FLookUpSource <> Nil) and (FLookUpSource.DataSet <> Nil) then
  begin
    SetLength(AComboFields, 0);
    for I := 0 to FLookUpSource.DataSet.FieldCount - 1 do
    begin
      SetLength(AComboFields, Length(AComboFields) + 1);
      AComboFields[Length(AComboFields) - 1].FieldName  := FLookUpSource.DataSet.Fields[I].FieldName;
      AComboFields[Length(AComboFields) - 1].FieldValue := Null;
      if not FLookUpSource.DataSet.IsEmpty then
        AComboFields[Length(AComboFields) - 1].FieldValue := FLookUpSource.DataSet.Fields[I].Value;
    end;
  end;
end;

function  TSuperComboADO.GetFieldByName(AFieldName: string) : Variant;
var
  I : Integer;
begin
  Result := Null;
  for I := 0 to Length(FComboFields) - 1 do
    if FComboFields[I].FieldName = AFieldName then
    begin
      Result := FComboFields[I].FieldValue;
      Break;
    end;
end;

procedure TSuperComboADO.SetLookUpValue(Value: String);
begin
  // Define datasources do Browse e query
  SetLookUpQuery;

  if Value = '' then
    begin
     ListValue    := '';
     FLookUpValue := '';
     OldValue     := '';
     CodeValue    := '';
     OldText      := Text;
     FillFieldValues(FComboFields);
    end
  else
    if (Value <> OldValue) or (FLookUpValue = '') then
    begin
      OldValue := Value;
      if LookUpADOQuery.DescLookUpField(Value, IsLookUpValue,
         FFilterFields, FFilterValues,
         FFilterSugest, FSpcWhereClause, FMostraDesativado, FMostraHidden) then
      begin
        ListValue    := LookUpADOQuery.ListValue;
        FLookUpValue := LookUpADOQuery.LookUpValue;
        CodeValue    := LookUpADOQuery.CodeValue;
      end;
      FillFieldValues(FComboFields);
      LookUpADOQuery.Close;
    end;

  // Associa ao text o valor do campo
  try
    IsChange := False;   // Desabilita o evento change
    Text     := ListValue;
    EditCode.Text := CodeValue;
    LastText := Text;
  finally
    IsChange := True;  // habilita evento change
  end;

  SelectAll;
end;

procedure TSuperComboADO.AddUpdateClick(Sender : TObject);
begin
  if not Assigned(LookUpADOQuery.OnClickButton) then
     raise exception.create(sDefineEvent);

  // Fecha o form LookUp
  LookUpForm.Close;
  LookUpADOQuery.FilterFields := FFilterFields;
  LookUpADOQuery.FilterValues := FFilterValues;

  if LookUpADOQuery.CallLookUpForm((TButton(Sender).Tag = 0)) and
     Assigned(OnAfterAddUpdate) then
    OnAfterAddUpdate(Self);

  // Seta o valor corrente
  UpdateValues;
  SelectActualValue;
  LookUpADOQuery.Close;
end;

procedure TSuperComboADO.CallUpdate;
begin
  if FLookUpValue <> '' then
    begin
      LookUpADOQuery.LocateFirst(Text, FIsListFiltered, IsLocate,
                              FFilterFields, FFilterValues, FFilterSugest,
                              FSpcWhereClause, True, FMostraDesativado, FMostraHidden);
      AddUpdateClick(btnUpdate);
    end;
end;

{---- TDbSuperCombo----}

constructor TDbSuperComboADO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := False;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;

  DataAware := True;
end;

destructor TDbSuperComboADO.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TDbSuperComboADO.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TDbSuperComboADO.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then DataSource := nil;
end;

procedure TDbSuperComboADO.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TDbSuperComboADO.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  // Retirado, pois o campo pode ser string ou Numero
 { if (Key in [#32..#255]) and (FDataLink.Field <> nil) then
   and not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
 }
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TDbSuperComboADO.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TDbSuperComboADO.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TDbSuperComboADO.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TDbSuperComboADO.Change;
begin
  inherited Change;
  FDataLink.Modified;
end;

function TDbSuperComboADO.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDbSuperComboADO.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDbSuperComboADO.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDbSuperComboADO.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TDbSuperComboADO.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDbSuperComboADO.SetReadOnly(Value: Boolean);
begin
  inherited ReadOnly := Value;
  FDataLink.ReadOnly := Value;
end;

function TDbSuperComboADO.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDbSuperComboADO.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    EditMask := FDataLink.Field.EditMask;
    if FDataLink.Field.DataType = ftString then
      MaxLength := FDataLink.Field.Size else
      MaxLength := 0;

    LookUpValue := FDataLink.Field.AsString;

  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    MaxLength := 0;
    if csDesigning in ComponentState then
      Text := Name else
      Text := '';
  end;
end;

procedure TDbSuperComboADO.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TDbSuperComboADO.UpdateData(Sender: TObject);
begin
  // Associa o valor ao field
  FillFieldValues(FComboFields);
  FDataLink.Edit; // Forca o edit state;
  FDataLink.Field.AsString := LookUpValue;
end;

procedure TDbSuperComboADO.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDbSuperComboADO.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDbSuperComboADO.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TDbSuperComboADO.CMExit(var Message: TCMExit);
begin
  inherited CMExit(Message);;
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TDbSuperComboADO.WMPaint(var Message: TWMPaint);
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
  if ((FAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
  begin
    inherited;
    Exit;
  end;

{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }

  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
        S := EditText;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case FAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;

end;

procedure TDbSuperComboADO.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TDbSuperComboADO.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TSuperComboADO]);
  RegisterComponents('NewPower', [TDBSuperComboADO]);
end;

end.

