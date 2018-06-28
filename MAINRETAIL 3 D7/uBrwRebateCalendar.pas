unit uBrwRebateCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeBrowses, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxGridCustomPopupMenu, cxGridPopupMenu, dxPSCore,
  dxPScxGridLnk, ExtCtrls, BrowseConfig, ADODB, PowerADOQuery, siComp,
  siLangRT, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  PanelRights, StdCtrls, Buttons, LblEffct, DateBox, Mask, SuperComboADO;

type
  TbrwRebateCalendar   = class(TbrwParent)
    btnAllDaysOfWeek: TButton;
    cbxDayofWeek: TComboBox;
    lbDaysOfWeek: TLabel;
    lbStore: TLabel;
    scStore: TSuperComboADO;
    btnAllStore: TButton;
    DateFim: TDateBox;
    lbTo: TLabel;
    DateInicio: TDateBox;
    lbFrom: TLabel;
    quBrowseIDRebateCalendar: TIntegerField;
    quBrowseDescription: TStringField;
    quBrowseDaysOfWeek: TStringField;
    quBrowseDiscountPerc: TFloatField;
    quBrowseStore: TStringField;
    quBrowseStartDate: TDateTimeField;
    quBrowseEndDate: TDateTimeField;
    grdBrowseDBIDRebateCalendar: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBDaysOfWeek: TcxGridDBColumn;
    grdBrowseDBDiscountPerc: TcxGridDBColumn;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBStartDate: TcxGridDBColumn;
    grdBrowseDBEndDate: TcxGridDBColumn;
    procedure btnAllDaysOfWeekClick(Sender: TObject);
    procedure btnAllStoreClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
  private
    sOrigSQL : String;
  public
    function Start:Boolean;
  end;

implementation

uses uFchRebateCalendar;

{$R *.dfm}

{ TbrwRebateCalendar }

function TbrwRebateCalendar.Start: Boolean;
begin
  sOrigSQL := quBrowse.CommandText;
  ShowModal;
end;

procedure TbrwRebateCalendar.btnAllDaysOfWeekClick(Sender: TObject);
begin
  inherited;
  cbxDayofWeek.ItemIndex := 0;
  AtivaAviso;
end;

procedure TbrwRebateCalendar.btnAllStoreClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '<'+ btnAllStore.Caption +'>';

  AtivaAviso;
end;

procedure TbrwRebateCalendar.btnExecClick(Sender: TObject);
Var
  sWhere : String;
begin
  inherited;
  if cbxDayofWeek.ItemIndex > 0 then
    sWhere := sWhere + ' SR.DaysOfWeek Like ' + QuotedStr('%' + IntToStr(cbxDayofWeek.ItemIndex) + '%');

  if scStore.LookUpValue <> '' then
  begin
    if sWhere <> '' then
      sWhere := sWhere + ' AND ';
    sWhere := sWhere + ' S.IDStore = ' + scStore.LookUpValue;
  end;

  if (DateInicio.Text <> '') and (DateFim.Text <> '') then
  begin
    if sWhere <> '' then
      sWhere := sWhere + ' AND ';
    sWhere := sWhere + 'SR.StartDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date)))) +
                       ' AND SR.EndDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)));
  end;

  with quBrowse do
  begin
    Close;
    if sWhere <> '' then
      CommandText := sOrigSQL + ' WHERE ' + sWhere
    else
      CommandText := sOrigSQL;
    //Open;
  end;

  ExecBrowseSQL(True);
  DesativaAviso;
end;

procedure TbrwRebateCalendar.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TFchRebateCalendar.Create(self);
end;

procedure TbrwRebateCalendar.FormShow(Sender: TObject);
begin
  inherited;
  cbxDayofWeek.ItemIndex := 0;
  scStore.Text := '<'+ btnAllStore.Caption +'>';
end;

procedure TbrwRebateCalendar.DateInicioChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwRebateCalendar.CommandClick(Sender: TObject);
begin
  inherited;
  ExecBrowseSQL(True);
end;

procedure TbrwRebateCalendar.grdBrowseDBDblClick(Sender: TObject);
begin
  inherited;
  ExecBrowseSQL(True);
end;

end.
