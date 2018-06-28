unit uFrmAdvertisingConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Menus, Mask, DBCtrls, cxDBEdit, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, cxSpinEdit,
  cxCalendar, CheckLst, cxCheckBox, siComp;

type
  TFrmAdvertisingConfig = class(TForm)
    pnlButtons: TPanel;
    btnClose: TBitBtn;
    pnlFilter: TPanel;
    grdAdvertisingDB: TcxGridDBTableView;
    grdAdvertisingLevel1: TcxGridLevel;
    grdAdvertising: TcxGrid;
    dsAdvertising: TDataSource;
    grdAdvertisingDBDescription: TcxGridDBColumn;
    grdAdvertisingDBFileName: TcxGridDBColumn;
    grdAdvertisingDBStartDate: TcxGridDBColumn;
    grdAdvertisingDBEndDate: TcxGridDBColumn;
    grdAdvertisingDBDaysOfWeekString: TcxGridDBColumn;
    grdAdvertisingDBDuration: TcxGridDBColumn;
    Button1: TButton;
    OP: TOpenDialog;
    grdAdvertisingDBTypeString: TcxGridDBColumn;
    dtStart: TcxDateEdit;
    Label10: TLabel;
    Label11: TLabel;
    dtEnd: TcxDateEdit;
    cbxAdType: TcxComboBox;
    Label12: TLabel;
    grdAdvertisingDBDisplayDescription: TcxGridDBColumn;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FResult : Boolean;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, DBClient, uDMGlobal;

{$R *.dfm}

{ TFrmAdvertisingConfig }

function TFrmAdvertisingConfig.Start: Boolean;
begin
  FResult := False;
  ShowModal;
  Result := FResult;
end;

procedure TFrmAdvertisingConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAdvertisingConfig.btnCloseClick(Sender: TObject);
begin
  FResult := False;
  Close;
end;

procedure TFrmAdvertisingConfig.Button1Click(Sender: TObject);
var
  AFilter : String;
begin

  if dtStart.Text <> '' then
    AFilter := 'StartDate >= ' + QuotedStr(FormatDateTime('ddddd', dtStart.Date));

  if dtEnd.Text <> '' then
    if AFilter = '' then
      AFilter := 'EndDate < ' + QuotedStr(FormatDateTime('ddddd', dtEnd.Date + 1))
    else
      AFilter := AFilter + ' AND EndDate < ' + QuotedStr(FormatDateTime('ddddd', dtEnd.Date + 1));

  if cbxAdType.Text <> '' then
    if AFilter = '' then
      AFilter := 'Type = ' + IntToStr(cbxAdType.ItemIndex)
    else
      AFilter := AFilter + ' AND Type = ' + IntToStr(cbxAdType.ItemIndex);

  with DM.cdsAdvertising do
  begin
    Filtered := False;
    Filter := AFilter;
    Filtered := True;
  end;

end;

end.
