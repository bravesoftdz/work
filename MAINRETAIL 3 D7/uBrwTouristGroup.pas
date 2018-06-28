unit uBrwTouristGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids, DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, RadioButtonAll,
  ImgList, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp,
  siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwTouristGroup = class(TbrwParent)
    quBrowseIDTouristGroup: TIntegerField;
    quBrowseEnterDate: TDateTimeField;
    quBrowseTipTouristGroup: TStringField;
    quBrowseIDGuide: TIntegerField;
    quBrowseIDAgency: TIntegerField;
    quBrowseSystemUser: TStringField;
    quBrowseNumInvoice: TIntegerField;
    pnlTip: TPanel;
    quBrowseTotInvoice: TFloatField;
    scAgency: TSuperComboADO;
    quBrowseStatusGuia: TStringField;
    quBrowseStatusAgency: TStringField;
    Label3: TLabel;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    btAreaTodas: TButton;
    Panel4: TPanel;
    btInvoice: TSpeedButton;
    grdBrowseDBIDTouristGroup: TcxGridDBColumn;
    grdBrowseDBEnterDate: TcxGridDBColumn;
    grdBrowseDBTipTouristGroup: TcxGridDBColumn;
    grdBrowseDBIDGuide: TcxGridDBColumn;
    grdBrowseDBIDAgency: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    grdBrowseDBNumInvoice: TcxGridDBColumn;
    grdBrowseDBTotInvoice: TcxGridDBColumn;
    grdBrowseDBStatusGuia: TcxGridDBColumn;
    grdBrowseDBStatusAgency: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btInvoiceClick(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure scAgencyChange(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
  private
    { Private declarations }
    IDMark: Integer;

  public
    { Public declarations }
    OnlyOpen : Boolean;

  end;

implementation

{$R *.DFM}

uses uFchTouristGroup, uDM, uPassword, uBrwInvoice, Math, uMsgBox,
     uMsgConstant, uSystemTypes, uDateTimeFunctions, uDMGlobal;

procedure TbrwTouristGroup.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm                                   := TFchTouristGroup.Create(Self);
  TFchTouristGroup(brwForm).ShowCusto       := True;
  TFchTouristGroup(brwForm).ShowProgramacao := True;

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

end;

procedure TbrwTouristGroup.FormShow(Sender: TObject);
begin
  inherited;
  // Controla o modo de abertura
  if OnlyOpen then
    aWhereBasicFilters[1] := 'TouristGroup.IDGuide IS NULL';

end;

procedure TbrwTouristGroup.btInvoiceClick(Sender: TObject);
begin
  inherited;
  // chama browse de invoice
  with TBrwInvoice.Create(self) do
  begin
    aWhereBasicFilters[1] := 'I.IDTouristGroup = ' + quBrowseIDTouristGroup.AsString;
    ShowModal;
  end;

end;

procedure TbrwTouristGroup.CommandClick(Sender: TObject);
begin
  if TBtnCommandType(TComponent(Sender).Tag) = btExc then
  begin
    if quBrowseNumInvoice.AsInteger > 0 then
    begin
      MsgBox(MSG_INF_NO_DEL_TOUR, vbOkOnly + vbInformation);
      Exit;
    end;
  end;

  inherited;
end;

procedure TbrwTouristGroup.btnExecClick(Sender: TObject);
begin
  inherited;

  if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
  begin
    aWhereBasicFilters[0] := '';

    aWhereBasicFilters[0] := 'EnterDate >= ' + Chr(39) + FormatDateTime('yyyymmdd', Trunc(DateInicio.Date)) + Chr(39) + 'AND ' +
                             'EnterDate < ' + Chr(39) + FormatDateTime('yyyymmdd', Trunc(DateFim.Date) + 1 ) + Chr(39);


    if scAgency.LookUpValue <> '' then
      aWhereBasicFilters[2] := 'TG.IDAgency = ' + scAgency.LookUpValue
    else
      aWhereBasicFilters[2] := '';

    ExecBrowseSQL(True);

    DesativaAviso;
  end;
end;

procedure TbrwTouristGroup.scAgencyChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwTouristGroup.DateInicioChange(Sender: TObject);
begin
  inherited;

  //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
     AtivaAviso;

end;

procedure TbrwTouristGroup.btAreaTodasClick(Sender: TObject);
begin
  inherited;

  scAgency.LookUpValue := '';
  scAgency.Text        := '<All>';

end;

end.
