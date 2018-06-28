unit uFchTouristGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, Variants,
  LblEffct, ExtCtrls, FormConfig, Buttons, Grids,
  DateBox, uAddTrajeto, uFchCost, ComCtrls, ADODB, RCADOQuery, PowerADOQuery,
  SuperComboADO, uFrmAddGift, siComp, siLangRT, DBGrids, SMDBGrid;

type
  TFchTouristGroup = class(TbrwFrmParent)
    DBEdit1: TDBEdit;
    Label4: TLabel;
    quCost: TADOQuery;
    dsCost: TDataSource;
    quCostIDTouristGroup: TIntegerField;
    quCostCostType: TStringField;
    quCostIDCost: TIntegerField;
    quCostCostDate: TDateTimeField;
    quCostCustoTotal: TFloatField;
    quFormIDTouristGroup: TIntegerField;
    quFormTipTouristGroup: TStringField;
    quFormIDGuide: TIntegerField;
    quFormIDAgency: TIntegerField;
    quFormEnterDate: TDateTimeField;
    quFormIDStore: TIntegerField;
    quFormNumTourist: TIntegerField;
    quFormComissaoSobreGuia: TFloatField;
    quFormDescontaCoordenacao: TBooleanField;
    pnlCost: TPanel;
    quFormIDUser: TIntegerField;
    quFormPermanente: TBooleanField;
    Label2: TLabel;
    EditnTour: TDBEdit;
    Label6: TLabel;
    quFormDiasValidade: TIntegerField;
    quFormIDLancPagGuia: TIntegerField;
    quFormIDLancPagAgencia: TIntegerField;
    Panel5: TPanel;
    Label1: TLabel;
    cmbHotel: TDBSuperComboADO;
    Label9: TLabel;
    rbStatus: TRadioGroup;
    quFormTipGuide: TStringField;
    quFormTipAgency: TStringField;
    quFormIDHotel: TIntegerField;
    Label7: TLabel;
    cmbAgency: TDBSuperComboADO;
    Label16: TLabel;
    lbCommi: TLabel;
    spCalcComm: TADOStoredProc;
    Label19: TLabel;
    edtTipTouristGroup: TDBEdit;
    Panel7: TPanel;
    pnlIDGuideAgency: TPanel;
    Label3: TLabel;
    Label10: TLabel;
    cmbGuide: TDBSuperComboADO;
    pnlIncluiTemp: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    editTipGuide: TDBEdit;
    Panel6: TPanel;
    Panel8: TPanel;
    dsCostGift: TDataSource;
    quCostGift: TADOQuery;
    quCostIDCostType: TIntegerField;
    spDelGift: TADOStoredProc;
    quCostGiftModel: TStringField;
    quCostGiftDescription: TStringField;
    quCostGiftSystemUser: TStringField;
    quCostGiftQuantity: TFloatField;
    quCostGiftIDModel: TIntegerField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    pnlCommand: TPanel;
    btAddRoute: TSpeedButton;
    btAddCost: TSpeedButton;
    btAddGift: TSpeedButton;
    btRemove: TSpeedButton;
    btDetail: TSpeedButton;
    TabSheet2: TTabSheet;
    tsProgramacao: TTabSheet;
    Panel9: TPanel;
    Panel10: TPanel;
    editCoordenacao: TDBEdit;
    cbDesconta: TDBCheckBox;
    Label20: TLabel;
    Label5: TLabel;
    editData: TDBDateBox;
    editTime: TDateTimePicker;
    Label8: TLabel;
    Label11: TLabel;
    edtDiasValidade: TDBEdit;
    Label18: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    quCostGiftIDGroupCost: TIntegerField;
    grdExpenses: TSMDBGrid;
    grdGift: TSMDBGrid;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btAddRouteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btAddCostClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure dsCostDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure rbStatusClick(Sender: TObject);
    procedure btAddGiftClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure cmbAgencySelectItem(Sender: TObject);
    procedure cmbGuideSelectItem(Sender: TObject);
    procedure grdExpensesDblClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure quCostAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    AddTrajeto : TAddTrajeto;
    FchCost    : TFchCost;
    OriginalHeight, ShowHeight : Integer;
    FrmAddGift: TFrmAddGift;
    NumPaxAnt : Integer;
    function SaveChange : boolean; override;
    procedure GroupCostOpen;
    procedure GroupCostClose;
    procedure GroupCostPost;
  public
    { Public declarations }
    ShowCusto: Boolean;
    ShowProgramacao: Boolean;
  end;

implementation

uses uDM, uPassword, uMsgBox, uMsgConstant, uSystemTypes, uStringFunctions,
     uDMGlobal, PaiDeTodos;

{$R *.DFM}

procedure TFchTouristGroup.GroupCostOpen;
begin
  with quCost do
    if not Active then
    begin
      Parameters.ParamByName('IdTouristGroup').Value:= quFormIDTouristGroup.Value;
      Open;
    end;
end;

procedure TFchTouristGroup.GroupCostClose;
begin
  GroupCostPost;

  with quCost do
    if Active then
      Close;
end;

procedure TFchTouristGroup.GroupCostPost;
begin
  with quCost do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TFchTouristGroup.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDStore.AsInteger        := DM.fStore.ID;
  quFormIDUser.AsInteger         := DM.fUser.ID;
  quFormEnterDate.AsDateTime     := Now;
  quFormPermanente.AsBoolean     := False;
  quFormDiasValidade.AsInteger   := 1;
  quFormTipTouristGroup.AsString := 'Tip';
  rbStatus.ItemIndex             := 1;
  rbStatusClick(nil);
end;

procedure TFchTouristGroup.btAddRouteClick(Sender: TObject);
begin
  inherited;
  if AddTrajeto = Nil then
     AddTrajeto := TAddTrajeto.Create(Self);

  if AddTrajeto.Start(quFormIDTouristGroup.AsInteger, EditnTour.Text) then
  begin
    quCost.Close;
    quCost.Open;
  end;
end;

procedure TFchTouristGroup.FormCreate(Sender: TObject);
begin
  inherited;
  ShowCusto      := False;
  ShowProgramacao:= False;

  OriginalHeight := Height - pnlCost.Height;

  PageControl1.ActivePage:= TabSheet1;

  if fIsRestricForm then
     begin
     btAddRoute.Visible := False;
     btAddCost.Visible  := False;
     btAddGift.Visible  := False;
     btRemove.Visible   := False;
     btDetail.Visible   := False;
     cmbAgency.TabStop  := False;
     cmbHotel.TabStop   := False;
     end;

end;

procedure TFchTouristGroup.FormDestroy(Sender: TObject);
begin
  inherited;

  if FrmAddGift <> Nil then
     FrmAddGift.Free;

  if AddTrajeto <> Nil then
     AddTrajeto.Free;

  if FchCost <> Nil then
     FchCost.Free;
end;

procedure TFchTouristGroup.btRemoveClick(Sender: TObject);
var
  ModelGift, QtyGift : Integer;
  CostDate : TDateTime;
  bIsGift: boolean;
begin
  inherited;
  if Msgbox(MSG_QST_DELETE_COST, vbYesNo + vbQuestion) = vbYes then
    with DM.quFreeSQL do
    begin
      Screen.Cursor := crHourGlass;
      ModelGift     := 0;
      CostDate      := 0;

      bIsGift:= (quCostIDCostType.Value = 5);

      if bIsGift then
      begin
        quCostGift.Locate('IdGroupCost', quCostIDCost.Value, []);

        //** Guarda o model e quantity para ajuste posterior do inventário
        ModelGift := quCostGiftIDModel.value;

        //** Guarda a data para retirar a referencia no movimento do inventário
        CostDate  := quCostCostDate.AsDateTime;

        // Deletar os CostGifts qdo IdCost = GIFT

        if Active then Close;
        SQL.Text := 'DELETE FROM GroupCostGift WHERE IDGroupCost = ' + quCostIDCost.AsString;
        ExecSQL;
      end;

      if Active then Close;
      SQL.Text := 'DELETE FROM GroupCost WHERE IDCost = ' + quCostIDCost.AsString;
      ExecSQL;

      with quCost do
      begin
        Close;
        Open;
      end;

      // ** Devolve o número de itens de gift ao inventário
      if bIsGift then
        with spDelGift do
        begin
          Parameters.ParamByName('@IDModel').Value := ModelGift;
          Parameters.ParamByName('@MovDate').Value := CostDate;
          ExecProc;
        end;

      Screen.Cursor := crDefault;
    end;
end;

procedure TFchTouristGroup.btAddCostClick(Sender: TObject);
var
  ID1, ID2 : String;
begin
  inherited;
  if FchCost = Nil then
    FchCost := TFchCost.Create(Self);

  FchCost.IDTouristGroup := quFormIDTouristGroup.AsInteger;

  if FchCost.Start(btInc, nil, False, ID1, ID2, nil) then
    with quCost do
    begin
      DisableControls;
      Close;
      Open;
      Locate('IDCost', ID1, []);
      EnableControls;
    end;
end;


procedure TFchTouristGroup.btDetailClick(Sender: TObject);
var
  ID1, ID2: String;
begin
  inherited;
  ID1 := quCostIDCost.AsString;

  if FchCost = Nil then
    FchCost := TFchCost.Create(Self);

  if FchCost.Start(btAlt, nil, False, ID1, ID2, nil) then
    with quCost do
    begin
      DisableControls;
      ID1 := quCostIDCost.AsString;
      Close;
      Open;
      Locate('IDCost', ID1, []);
      EnableControls;
    end;
end;

procedure TFchTouristGroup.dsCostDataChange(Sender: TObject;
  Field: TField);
var
   MyBo : Boolean;
begin
  inherited;
  with quCost do
    MyBo := Not (EOF and BOF);

  btDetail.Enabled := MyBo;
  btRemove.Enabled := MyBo;
end;

procedure TFchTouristGroup.FormShow(Sender: TObject);
var
  MyDate, MyTime : double;
  bShowPanel : Boolean;
begin
  inherited;

  bShowPanel := False;

  Height := OriginalHeight;

  // Controla a tela de custo
  if ShowCusto or Password.HasFuncRight(20) then
    with pnlCost do
    begin
      Visible     := True;
      Self.Height := Self.Height + Height;
      bShowPanel  := True;
    end
  else
    pnlCost.Visible := False;

  // Controla a programacao
  if (ShowProgramacao or Password.HasFuncRight(21)) then
  begin
    tsProgramacao.TabVisible := True;

    MyDate := int(quFormEnterDate.AsDateTime);
    MyTime := quFormEnterDate.AsDateTime - int(quFormEnterDate.AsDateTime);

    if (quForm.State in [dsInsert, dsEdit]) then
       begin
       editData.Date := MyDate;
       editTime.Date := 0;
       editTime.Time := MyTime;
       end;
  end
  else
    tsProgramacao.TabVisible := False;

  // Salva a altura apos o show para posterior alteracao durante o run
  ShowHeight := Height;
  if frmCommand = btAlt then
  begin
    // Controla o modo da ficha
    if quFormIDGuide.AsInteger > 0 then // tem guia
      rbStatus.ItemIndex := 1 // Ja esta acertado
    else
      rbStatus.ItemIndex := 0; // Aberto

    rbStatusClick(nil);
  end;

{  with spCalcComm do
    begin
//      Parameters.ParamByName('@Pessoa').Value       := quFormIDGuide.AsInteger;
      Parameters.ParamByName('@IDTouristGroup').Value := quFormIDTouristGroup.AsInteger;
      ExecProc;
      lbCommi.Caption := MyFloatToStr(round(Parameters.ParamByName('@Commission').Value * 100) / 100);
    end; }

  // ** Guarda o número de passageiros atual
  NumPaxAnt := quFormNumTourist.Value;

  if fIsRestricForm then
     edtTipTouristGroup.SetFocus; 

end;

function TFchTouristGroup.SaveChange : boolean;
begin
  quFormTipGuide.AsString:= Proper(editTipGuide.Text);

  if ShowProgramacao then
    quFormEnterDate.AsDateTime:= StrToDateTime(editData.Text + ' ' + TimeToStr(editTime.Time));

  inherited SaveChange;
end;

procedure TFchTouristGroup.rbStatusClick(Sender: TObject);
begin
  inherited;

  case rbStatus.ItemIndex of
    0:  // ** Open
      begin
        quFormTipGuide.Required           := True;
        quFormIDGuide.Required            := False;
        quFormDescontaCoordenacao.Required:= False;

        pnlIncluiTemp.Visible    := True;
        pnlIDGuideAgency.Visible := False;
        cmbGuide.TabStop         := False;
        edittipguide.TabStop     := True;
        edittipguide.SetFocus;
      end;
    1:  // ** Confirmed
      begin
        quFormTipGuide.Required           := False;
        quFormIDGuide.Required            := True;
        quFormDescontaCoordenacao.Required:= True;

        pnlIncluiTemp.Visible    := False;
        pnlIDGuideAgency.Visible := True;
        edittipguide.TabStop     := False;
        cmbGuide.TabStop         := True;
        if not fIsRestricForm then
           cmbGuide.SetFocus;
      end;
  end;
end;

procedure TFchTouristGroup.btAddGiftClick(Sender: TObject);
begin
  inherited;
  if FrmAddGift = Nil then
    FrmAddGift := TFrmAddGift.Create(Self);

  if FrmAddGift.Start(quFormIDTouristGroup.AsInteger) then;
  begin
    quCost.Close;
    quCost.Open;
  end;
end;

procedure TFchTouristGroup.btCloseClick(Sender: TObject);
begin
  // ** Verifica se o número de passageiros foi alterado. se foi, recalcula
  // ** as despesas com Routes = CostType = 2

  Screen.Cursor := crHourGlass;

  if quFormNumTourist.value <> NumPaxAnt then // alteraram o pax
  begin
    quCost.DisableControls;
    quCost.First;
    while not quCost.EOF do
    begin
      if quCostIdCostType.value = 2 then // Despesa com rota = 2
        with DM.quFreeSQL do
        begin
          if Active then
            Close;

          SQL.Text := 'UPDATE GroupCost SET Quantity = ' +
                      quFormNumTourist.asString +
                      'WHERE IdCost = ' + quCostIdCost.asString;
          ExecSQL;
        end;
      quCost.Next;
    end;
    quCost.EnableControls;
  end;

  Screen.Cursor := crDefault;
  inherited;
end;


procedure TFchTouristGroup.quFormBeforePost(DataSet: TDataSet);
begin
  if cmbAgency.LookUpValue <> '' then
  begin
    with DM.quFreeSQL do
    begin
      Close;
      SQL.Clear;
      SQL.Add ('SELECT ComissaoSobreGuia FROM vwAgency WHERE IDAgency = ' + cmbAgency.LookUpValue);
      Open;
      quFormComissaoSobreGuia.Value := FieldByName ('ComissaoSobreGuia').asFloat;
      Close;
    end;
  end;

  if rbStatus.ItemIndex = 0 then
    quFormIDGuide.Clear;

end;

procedure TFchTouristGroup.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1380);
end;

procedure TFchTouristGroup.cmbAgencySelectItem(Sender: TObject);
begin
  inherited;

  if (quFormComissaoSobreGuia.AsString = '')and
     (cmbAgency.LookUpValue <> '') and
     (quForm.State in dsEditModes) then
    with DM.quFreeSQL do
    begin
      Close;
      SQL.Text := 'SELECT ComissaoSobreGuia FROM Pessoa WHERE IDPessoa = ' + quFormIDAgency.AsString;
      Open;
      quFormComissaoSobreGuia.AsCurrency := Fields[0].AsCurrency;
      Close;
    end;

end;

procedure TFchTouristGroup.cmbGuideSelectItem(Sender: TObject);
begin
  inherited;

  if (quFormDescontaCoordenacao.AsString = '') and
     (cmbGuide.LookUpValue <> '') and
     (quForm.State in dsEditModes) then
    with DM.quFreeSQL do
    begin
      Close;
      SQL.Text := 'SELECT DescontaCoordenacao FROM Pessoa WHERE IDPessoa = ' + quFormIDGuide.AsString;
      Open;
      quFormDescontaCoordenacao.AsBoolean := Fields[0].AsBoolean;
      Close;
    end;
end;

procedure TFchTouristGroup.grdExpensesDblClick(Sender: TObject);
begin
  inherited;
  with quCost do
    if not (EOF and BOF) then btDetailClick(nil);
end;

procedure TFchTouristGroup.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GroupCostOpen;
end;

procedure TFchTouristGroup.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  GroupCostClose;
end;

procedure TFchTouristGroup.quCostAfterScroll(DataSet: TDataSet);
begin
  with quCostGift do
  begin
    Close;
    Parameters.ParamByName('IDTouristGroup').Value:= quFormIDTouristGroup.Value;
    // Mostra no Grid de Gifts informacoes isoladas sobre o Gift selecionado
    // Caso o CostType nao seja um Gift, ele mostra todos os Gifts existentes para o Grupo
    if quCostIDCostType.Value = 5 then
      Parameters.ParamByName('IDCost').Value:= quCostIDCost.Value
    else
      Parameters.ParamByName('IDCost').Value:= null;
    Open;
  end;
end;

end.
