unit uFinHoraList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentList, Menus, ExtCtrls, dxDBGridPrint, dxBar, BrowseConfig, Db,
  DBTables, ImgList, dxBarExtItems, StdCtrls,
  dxCntner, dxTL, dxDBGrid, Buttons, Mask, dxDateEdit, dxGrClms,
  dxDBCGrid, uFinHoraFch, dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery,
  SuperComboADO, dxEditor, dxExEdtr, dxEdLib, uStringFunctions, dxPSCore,
  dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT, DateBox;

const
    aMonthName: array [1..12]of String = ('January', 'February', 'March', 'Abril', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

type
  TFinHoraList = class(TParentList)
    Label3: TLabel;
    scPessoa: TSuperComboADO;
    btTodasPessoas: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    scStore: TSuperComboADO;
    btTodasStore: TButton;
    Label5: TLabel;
    cmbGroup: TComboBox;
    pnlTime: TPanel;
    Panel6: TPanel;
    grdTime: TdxDBCGrid;
    Splitter1: TSplitter;
    dsTime: TDataSource;
    quTime: TPowerADOQuery;
    bbShowTime: TdxBarButton;
    quBrowseIDPessoa: TIntegerField;
    quBrowseIDStore: TIntegerField;
    quBrowsePessoa: TStringField;
    quBrowseUsuario: TStringField;
    quBrowseStore: TStringField;
    quBrowseGroupIndex: TIntegerField;
    quTimeIDTime: TIntegerField;
    quTimeEnterDate: TDateTimeField;
    quTimeExitDate: TDateTimeField;
    quTimeHours: TFloatField;
    grdTimeEnterDate: TdxDBGridDateColumn;
    grdTimeExitDate: TdxDBGridDateColumn;
    grdTimeHours: TdxDBGridMaskColumn;
    quBrowseValorHora: TFloatField;
    quBrowseValorHoraExtra: TFloatField;
    quBrowseValorHoraExtraExtra: TFloatField;
    quBrowseHoursFull: TFloatField;
    quBrowseOverHour: TFloatField;
    quBrowseDoubleHour: TFloatField;
    quBrowseValue: TFloatField;
    brwGridPessoa: TdxDBGridMaskColumn;
    brwGridUsuario: TdxDBGridMaskColumn;
    brwGridStore: TdxDBGridMaskColumn;
    brwGridGroupIndex: TdxDBGridMaskColumn;
    brwGridHoursFull: TdxDBGridMaskColumn;
    brwGridOverHour: TdxDBGridColumn;
    brwGridDoubleHour: TdxDBGridColumn;
    brwGridValorHora: TdxDBGridMaskColumn;
    brwGridValorHoraExtra: TdxDBGridMaskColumn;
    brwGridValorHoraExtraExtra: TdxDBGridMaskColumn;
    brwGridValue: TdxDBGridColumn;
    quBrowseHour: TFloatField;
    brwGridHour: TdxDBGridMaskColumn;
    quBrowseRange: TStringField;
    brwGridRange: TdxDBGridMaskColumn;
    brwGridYear: TdxDBGridMaskColumn;
    quBrowseYIndex: TIntegerField;
    brwGridIDPessoa: TdxDBGridMaskColumn;
    quTimeIDPessoa: TIntegerField;
    grdTimeIDPessoa: TdxDBGridMaskColumn;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    procedure btTodasPessoasClick(Sender: TObject);
    procedure dbInicioChange(Sender: TObject);
    procedure btTodasStoreClick(Sender: TObject);
    procedure scStoreSelectItem(Sender: TObject);
    procedure bbShowTimeClick(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbGroupChange(Sender: TObject);
    procedure brwGridDblClick(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure grdTimeDblClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure quBrowseAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    iTimeCurrentHeight: integer;
    sCurrentGroup: string;
    FinHoraFch: TFinHoraFch;

    WeekLimitHour, WeekLimitOverHour: Double;
    DayLimitHour, DayLimitOverHour: Double;
    MonthLimitHour, MonthLimitOverHour: Double;

    procedure ShowTimeRefresh;
    procedure RefreshTime;
  public
    { Public declarations }
    function  ListParamRefresh : integer; override;
  end;

implementation

uses uDM, uMsgBox, uDateTimeFunctions, uSystemTypes, uMsgConstant;

{$R *.DFM}

function TFinHoraList.ListParamRefresh : integer;
var
  InicioStr, FimStr: String;
begin

  // Testa se as datas de período são válidas
  if not TestDate(dbInicio.Text) then
    begin
      MsgBox(MSG_CRT_NO_VALID_INIDATE, vbCritical + vbOkOnly);
      dbInicio.SetFocus;
      Exit;
    end;

  if not TestDate(dbFim.Text) then
    begin
      MsgBox(MSG_CRT_NO_VALID_FIMDATE, vbCritical + vbOkOnly);
      dbFim.SetFocus;
      Exit;
    end;

  // Monta o filtro por data
  InicioStr := Chr(39) + FormatDateTime('mm/dd/yyyy', dbInicio.Date) + Chr(39);
  FimStr    := Chr(39) + FormatDateTime('mm/dd/yyyy', dbFim.Date + 1) + Chr(39);
  WhereBasicFilter[1] := ' (T.EnterDate >= ' + InicioStr + ' AND T.EnterDate < ' + FimStr + ') ';

  // Monta o filtro por store
  if scStore.LookUpValue <> '' then
    begin
      brwGridStore.Visible := False;
      WhereBasicFilter[2] := 'T.IDStore = ' + scStore.LookUpValue;
    end
  else
    begin
      brwGridStore.Visible := True;
      WhereBasicFilter[2] := '';
    end;

  // Monta o filtro por Pessoa
  if scPessoa.LookUpValue <> '' then
    begin
      brwGridPessoa.Visible := False;
      WhereBasicFilter[3] := 'T.IDPessoa = ' + scPessoa.LookUpValue;
    end
  else
    begin
      brwGridPessoa.Visible := True;
      WhereBasicFilter[3] := '';
    end;

  DesligaAviso;
  ListRefresh;

end;

procedure TFinHoraList.btTodasPessoasClick(Sender: TObject);
begin
  inherited;
  scPessoa.LookUpValue := '';

  LigaAviso;


end;

procedure TFinHoraList.dbInicioChange(Sender: TObject);
begin
  inherited;
  LigaAviso;
end;

procedure TFinHoraList.btTodasStoreClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';

  LigaAviso;

end;

procedure TFinHoraList.scStoreSelectItem(Sender: TObject);
begin
  inherited;
  LigaAviso;
end;

procedure TFinHoraList.bbShowTimeClick(Sender: TObject);
begin
  inherited;

  ShowTimeRefresh;

end;


procedure TFinHoraList.RefreshTime;
begin

  with quTime do
     begin
     Close;

     Parameters.ParamByName('IDPessoa').Value := quBrowseIDPessoa.AsInteger;
     Parameters.ParamByName('IDStore').Value := quBrowseIDStore.AsInteger;
     Parameters.ParamByName('GroupIndex').Value := quBrowseGroupIndex.AsInteger;

     Open;
     end;

end;

procedure TFinHoraList.ShowTimeRefresh;
begin
  if bbShowTime.Down then
    pnlTime.Height := iTimeCurrentHeight
  else
    begin
      iTimeCurrentHeight := pnlTime.Height;
      pnlTime.Height := 18;
    end;

  quTime.Active := bbShowTime.Down;


end;

procedure TFinHoraList.Panel6Click(Sender: TObject);
begin
  inherited;
  bbShowTime.Down := not bbShowTime.Down;
  ShowTimeRefresh;

end;

procedure TFinHoraList.FormCreate(Sender: TObject);
begin
  inherited;

  DayLimitHour     := StrToInt(DM.GetPropertyValues('DayLimitHour').Strings[0]);
  DayLimitOverHour := StrToInt(DM.GetPropertyValues('DayLimitOverHour').Strings[0]);

  WeekLimitHour     := StrToInt(DM.GetPropertyValues('WeekLimitHour').Strings[0]);
  WeekLimitOverHour := StrToInt(DM.GetPropertyValues('WeekLimitOverHour').Strings[0]);

  MonthLimitHour     := StrToInt(DM.GetPropertyValues('MonthLimitHour').Strings[0]);
  MonthLimitOverHour := StrToInt(DM.GetPropertyValues('MonthLimitOverHour').Strings[0]);

  //dbInicio.Date := InicioMes(Date());
  //dbFim.Date    := FimMes(Date());

  dbInicio.Date := InicioSemana(Date())-7;
  dbFim.Date    := FimSemana(Date())-7;

  cmbGroup.ItemIndex := 1;
  sCurrentGroup := 'Week';

  btTodasStoreClick(nil);
  btTodasPessoasClick(nil);

  ShowTimeRefresh;

end;

procedure TFinHoraList.cmbGroupChange(Sender: TObject);
var
  sNewGroup: String;

begin
  inherited;

  case cmbGroup.ItemIndex of
    0: // Daily
      sNewGroup := 'DayOfYear';
    1: // Weekly
      sNewGroup := 'Week';
    2: // Monthly
      sNewGroup := 'Month';
    3: // Quaterly
      sNewGroup := 'Quarter';
    4: // Yearly
      sNewGroup := 'Year';
  end;

  OriginalSQL := Replace(OriginalSQL, sCurrentGroup, sNewGroup);
  quTime.Close;
  quTime.CommandText := Replace(quTime.CommandText, sCurrentGroup, sNewGroup);

  sCurrentGroup := sNewGroup;

  ListRefresh;
end;

procedure TFinHoraList.brwGridDblClick(Sender: TObject);
begin
  // inherited;

end;

procedure TFinHoraList.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  quTime.Close;
  if bbShowTime.Down then
    quTime.Open;
end;

procedure TFinHoraList.grdTimeDblClick(Sender: TObject);
var
  ID1, ID2: String;

begin
  inherited;
  if FinHoraFch = nil then
    FinHoraFch := TFinHoraFch.Create(Self);

  ID1 := quTimeIDTime.AsString;
  ID2 := '';

  with FinHoraFch do
    if Start(btAlt, quTime, False, ID1, ID2, '', MyUserRights, grdTime) then
      begin
        ListRefresh;
      end;

end;

procedure TFinHoraList.quBrowseCalcFields(DataSet: TDataSet);
var
  LimitOverHour, LimitHour: Double;

begin
  inherited;

  case cmbGroup.ItemIndex of
    0: // Daily
      begin
        LimitHour     := DayLimitHour;
        LimitOverHour := DayLimitOverHour;
      end;
    1: // Weekly
      begin
        LimitHour     := WeekLimitHour;
        LimitOverHour := WeekLimitOverHour;
      end;
    2: // Monthly
      begin
        LimitHour     := MonthLimitHour;
        LimitOverHour := MonthLimitOverHour;
      end;
    3: // Quaterly
      begin
        LimitHour     := 9999999;
        LimitOverHour := 9999999;
      end;
    4: // Yearly
      begin
        LimitHour     := 9999999;
        LimitOverHour := 9999999;
      end;
  end;


  // Calculo os horas
  if quBrowseHoursFull.AsFloat > LimitOverHour then
    begin
      quBrowseHour.AsFloat := LimitHour;
      quBrowseOverHour.AsFloat := LimitOverHour - LimitHour;
      quBrowseDoubleHour.AsFloat := quBrowseHoursFull.AsFloat - LimitOverHour;
    end
  else if quBrowseHoursFull.AsFloat > LimitHour then
    begin
      quBrowseHour.AsFloat := LimitHour;
      quBrowseOverHour.AsFloat := quBrowseHoursFull.AsFloat - LimitHour;
      quBrowseDoubleHour.AsFloat := 0;
    end
  else
    begin
      quBrowseHour.AsFloat := quBrowseHoursFull.AsFloat;
      quBrowseOverHour.AsFloat := 0;
      quBrowseDoubleHour.AsFloat := 0;
    end;

  // Calculo o valor
  quBrowseValue.AsFloat :=
      quBrowseHour.AsFloat * quBrowseValorHora.AsFloat +
      quBrowseOverHour.AsFloat * quBrowseValorHoraExtra.AsFloat +
      quBrowseDoubleHour.AsFloat * quBrowseValorHoraExtraExtra.AsFloat;

  // Calculo o display do group
  case cmbGroup.ItemIndex of
    0: // Daily
      quBrowseRange.AsString := FormatDateTime('dd mmmm', EncodeDate(quBrowseYIndex.AsInteger, 1, 1 ) + quBrowseGroupIndex.AsInteger);
    1: // Weekly
      quBrowseRange.AsString := 'Week ' + quBrowseGroupIndex.AsString;
    2: // Monthly
      quBrowseRange.AsString :=  aMonthName[quBrowseGroupIndex.AsInteger];
    3: // Quaterly
      quBrowseRange.AsString :=  'Quarter ' + quBrowseGroupIndex.AsString;
    4: // Yearly
      quBrowseRange.AsString :=  '';
  end;


end;

procedure TFinHoraList.quBrowseAfterScroll(DataSet: TDataSet);
begin
  inherited;
  
  //if not bbShowTime.Down then
  //   Exit;

  //RefreshTime;

end;

Initialization
  RegisterClass(TFinHoraList);


end.
