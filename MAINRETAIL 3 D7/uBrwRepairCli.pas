unit uBrwRepairCli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables,  Buttons, Grids, DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB,
  RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwRepairCli = class(TbrwParent)
    Label4: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label5: TLabel;
    Shape3: TShape;
    Label6: TLabel;
    Shape4: TShape;
    Label1: TLabel;
    quBrowseIDRepair: TIntegerField;
    quBrowseFase: TStringField;
    quBrowseSentDate: TDateTimeField;
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowseTipoRepair: TIntegerField;
    quBrowseCost: TFloatField;
    quBrowseSerialNumber: TStringField;
    quBrowseDefect: TStringField;
    quBrowseReturnDate: TDateTimeField;
    Label3: TLabel;
    cbxStatus: TComboBox;
    quBrowseVendor: TStringField;
    quBrowseCustomer: TStringField;
    quBrowseLastName: TStringField;
    quBrowseStore: TStringField;
    quBrowseReceiveDate: TDateTimeField;
    Label7: TLabel;
    cmbStore: TSuperComboADO;
    btAreaTodas: TButton;
    Label2: TLabel;
    cbxStatusDate: TComboBox;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    grdBrowseDBIDRepair: TcxGridDBColumn;
    grdBrowseDBSentDate: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBTipoRepair: TcxGridDBColumn;
    grdBrowseDBCost: TcxGridDBColumn;
    grdBrowseDBQty: TcxGridDBColumn;
    grdBrowseDBSerialNumber: TcxGridDBColumn;
    grdBrowseDBDefect: TcxGridDBColumn;
    grdBrowseDBReturnDate: TcxGridDBColumn;
    grdBrowseDBVendor: TcxGridDBColumn;
    grdBrowseDBCustomer: TcxGridDBColumn;
    grdBrowseDBLastName: TcxGridDBColumn;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBReceiveDate: TcxGridDBColumn;
    grdBrowseDBFase: TcxGridDBColumn;
    quBrowseQty: TFloatField;
    quBrowseSellingPrice: TBCDField;
    grdBrowseDBSellingPrice: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure cbxStatusChange(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure cmbStoreSelectItem(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFchRepair, uDM, uMsgBox, uMsgConstant, uDateTimeFunctions, uDMGlobal;

procedure TbrwRepairCli.FormCreate(Sender: TObject);
begin
  inherited;

  brwForm  := TFchRepair.Create(Self);
  TFchRepair(brwForm).Tipo := 1;

  cbxStatus.ItemIndex := 4;

  cbxStatusDate.ItemIndex := 0;

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  cmbStore.LookUpValue := intToStr(DM.fStore.ID);

end;


procedure TbrwRepairCli.CommandClick(Sender: TObject);
begin
  //Verificar se pode deletar o item
  If Sender = btRemove then
     If quBrowseFase.AsString <> 'Sent to Customer' then
        begin
        MsgBox(MSG_CRT_NO_DELETE_REPAIR, vbCritical + vbOkOnly);
        Exit;
        end;

  inherited;

end;

procedure TbrwRepairCli.cbxStatusChange(Sender: TObject);
begin
  inherited;
  //Ativa o pisca do BtnGo
  AtivaAviso;
end;

procedure TbrwRepairCli.btnExecClick(Sender: TObject);
Var
DateType : String;
begin
  inherited;
  Case cbxStatus.ItemIndex of

     0 : aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Recvd from Customer' + Chr(39);

     1 : aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Send to Vendor' + Chr(39);

     2 : aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Back from Vendor' + Chr(39);

     3 : aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Sent to Customer' + Chr(39);

     4 : aWhereBasicFilters[0] := '';
   end;

   Case cbxStatusDate.ItemIndex of
     0 : DateType := 'R.ReceiveDate';
     1 : DateType := 'R.SentDate';
     2 : DateType := 'R.ReturnDate';

   end;

   aWhereBasicFilters[1] := DateType + ' >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                            DateType + ' < '+ Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);


   if cmbStore.LookUpValue = '' then
      aWhereBasicFilters[2] := 'R.IDStore IN ('+ DM.fStore.StoreList +')'
   else
      aWhereBasicFilters[2] := 'R.IDStore = ' + cmbStore.LookUpValue;


   ExecBrowseSQL(True);

   //Desativa o pisca do BtnGo
   DesativaAviso;

end;

procedure TbrwRepairCli.DateInicioChange(Sender: TObject);
begin
  inherited;


    //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
     AtivaAviso;

end;

procedure TbrwRepairCli.btAreaTodasClick(Sender: TObject);
begin
  inherited;

  cmbStore.LookUpValue  := '';
  cmbStore.Text         := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;

end;

procedure TbrwRepairCli.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;

  AtivaAviso;

end;

end.
