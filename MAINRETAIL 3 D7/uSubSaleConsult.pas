unit uSubSaleConsult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, ExtCtrls, Grids, DBGrids,
  SMDBGrid, DB, ADODB, StdCtrls, Mask, DateBox, Buttons, LblEffct,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TSubSaleConsult = class(TParentSub)
    quPreSale: TADOQuery;
    quPreSaleIDPreSale: TIntegerField;
    quPreSalePreSaleDate: TDateTimeField;
    dsPreSale: TDataSource;
    pnlFilter: TPanel;
    dtCustFileDate: TDateBox;
    cbSearchFor: TComboBox;
    edtParamText: TEdit;
    edtHold: TEdit;
    quPreSalePessoaLastName: TStringField;
    quPreSalePessoaFirstName: TStringField;
    quPreSaleIDTouristGroup: TIntegerField;
    quPreSaleOtherComissionID: TIntegerField;
    Label4: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    lbParamSearch: TLabel;
    cbSearchForName: TComboBox;
    edtNameSearch: TEdit;
    Label5: TLabel;
    lbSearchName: TLabel;
    quPreSalePessoa: TStringField;
    Panel2: TPanel;
    imgTopIni: TImage;
    lblBasicFilter: TLabel;
    Image1: TImage;
    lblSubMenu: TLabelEffect;
    Image3: TImage;
    EspacamentoSuperior: TPanel;
    EEE: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    TimeAviso: TTimer;
    quPreSaleSaleCode: TStringField;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    grdBrowseDBPreSaleDate: TcxGridDBColumn;
    grdBrowseDBTotInvoice: TcxGridDBColumn;
    grdBrowseDBPessoaFirstName: TcxGridDBColumn;
    grdBrowseDBPessoaLastName: TcxGridDBColumn;
    grdBrowseDBSaleCode: TcxGridDBColumn;
    cbxHoldStatus: TComboBox;
    lbStatus: TLabel;
    quPreSaleTotalInvoice: TBCDField;
    quPreSaleTotalParent: TBCDField;
    quPreSaleTotInvoice: TCurrencyField;
    quPreSaleSubTotalInvoice: TBCDField;
    quPreSaleSubTotalParent: TBCDField;
    grdBrowseDBCustomer: TcxGridDBColumn;
    btnShowNote: TButton;
    quPreSaleNote: TStringField;
    grdBrowseDBNote: TcxGridDBColumn;
    procedure cbSearchForChange(Sender: TObject);
    procedure edtParamTextChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdPreSalesDblClick(Sender: TObject);
    procedure cbSearchForNameChange(Sender: TObject);
    procedure TimeAvisoTimer(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure cbxHoldStatusChange(Sender: TObject);
    procedure quPreSaleCalcFields(DataSet: TDataSet);
    procedure btnShowNoteClick(Sender: TObject);
  private
    FIsClosedLayAway: Boolean;
    procedure SearchCustomer;
    procedure RefreshDataSet;
    procedure AfterSetParam;override;
    { Private declarations }
  public
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
    function GiveInfo(InfoString: String): String;override;
    procedure SubListrefresh;override;
    { Public declarations }
  end;

var
  SubSaleConsult: TSubSaleConsult;

implementation
uses uDM, uParamFunctions, uDateTimeFunctions;

{$R *.dfm}

procedure TSubSaleConsult.SearchCustomer;
var
  sField, sWhere : String;
begin
  quPreSale.Close;

  TimeAviso.Enabled    := False;
  pnlAviso.ParentColor := True;

  sWhere := '';
  quPreSale.SQL.Clear;
  quPreSale.SQL.Add('');
  quPreSale.SQL.Add('SELECT');
  quPreSale.SQL.Add('        I.IDPreSale,');
  quPreSale.SQL.Add('        I.SaleCode,');
  quPreSale.SQL.Add('        I.PreSaleDate,');
  quPreSale.SQL.Add('        I.Note,');
  quPreSale.SQL.Add('        P.PessoaFirstName,');
  quPreSale.SQL.Add('        P.PessoaLastName,');
  quPreSale.SQL.Add('        P.Pessoa,');
  quPreSale.SQL.Add('        (I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0)) as TotalInvoice,');
  quPreSale.SQL.Add('        (I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax) as SubTotalInvoice,');
  if not FIsClosedLayAway then
    begin
    quPreSale.SQL.Add('      .00 as TotalParent,');
    quPreSale.SQL.Add('      .00 as SubTotalParent,');
    end
  else
    begin
    quPreSale.SQL.Add('      (SELECT SUM(IP.SubTotal - IP.InvoiceDiscount - IP.ItemDiscount + IP.Tax + IsNull(IP.AditionalExpenses, 0))');
    quPreSale.SQL.Add('      FROM Invoice IP	WHERE IP.IDPreSaleParent = I.IDPreSale) as TotalParent,');
    quPreSale.SQL.Add('      (SELECT SUM(IP.SubTotal - IP.InvoiceDiscount - IP.ItemDiscount + IP.Tax)');
    quPreSale.SQL.Add('      FROM Invoice IP WHERE IP.IDPreSaleParent = I.IDPreSale) as SubTotalParent,');
    end;
  quPreSale.SQL.Add('        I.IDTouristGroup,');
  quPreSale.SQL.Add('        I.OtherComissionID');
  quPreSale.SQL.Add('FROM');
  quPreSale.SQL.Add('        Invoice I (NOLOCK)');
  quPreSale.SQL.Add('        INNER JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa');
  quPreSale.SQL.Add('        LEFT OUTER JOIN DeliverType DT ON (DT.IDDeliverType = I.DeliverTypeID)');
  quPreSale.SQL.Add('WHERE');
  quPreSale.SQL.Add('        I.Layaway = 1');
  quPreSale.SQL.Add('        AND I.Canceled = 0');
  quPreSale.SQL.Add('        AND I.IDInvoice Is Null');

  if FIsClosedLayAway then
     begin
     quPreSale.SQL.Add('        AND I.DeliverConfirmation = 1');
     quPreSale.SQL.Add('        AND I.DeliverDate <= Convert(DateTime, Convert(varchar, GetDate()+1, 103), 103)');
     end
  else
     begin
     quPreSale.SQL.Add('        AND I.IDPreSaleParent Is Null');
     end;

  if cbSearchFor.Itemindex > 0 then
  begin
    case cbSearchFor.Itemindex of
      1 : sField := 'P.CustomerCard';
      2 : sField := 'P.CPF';
      3 : sField := 'P.InscEstadual';
      4 : sField := 'P.CartTrabalho';
    end;
    sWhere := sWhere + ' AND ' + sField + ' Like ' + QuotedStr('%'+Trim(edtParamText.Text)+'%');
  end;

  if cbSearchForName.Itemindex > 0 then
  begin
    case cbSearchForName.Itemindex of
      1 : sField := 'P.PessoaFirstName';
      2 : sField := 'P.PessoaLastName';
      3 : sField := 'P.Pessoa';
    end;
    sWhere := sWhere + ' AND ' + sField + ' Like ' + QuotedStr('%'+Trim(edtNameSearch.Text)+'%');
  end;


  if Trim(edtHold.Text) <> '' then
    sWhere := sWhere + ' AND SaleCode Like ' + QuotedStr('%'+Trim(edtHold.Text)+'%');

  if Trim(dtCustFileDate.Text) <> '' then
    sWhere := sWhere + Format(' AND Convert(DateTime, Convert(VarChar, PreSaleDate, 103), 103) = Convert(DateTime, %S, 103)',  [QuotedStr(FormatdateTime('DD/MM/YYYY', dtCustFileDate.Date))]);

  //Mostrar itens abertos e cancelados
  if FIsClosedLayAway then
     Case cbxHoldStatus.ItemIndex of
       1 : sWhere := sWhere + 'AND IsNull(DT.CanExchangeItem,0) <> 1';
       2 : sWhere := sWhere + 'AND IsNull(DT.CanExchangeItem,0) = 1';
     end;

  quPreSale.SQL.Add(sWhere);

  quPreSale.Open;

end;

procedure TSubSaleConsult.cbSearchForChange(Sender: TObject);
begin
  inherited;
  lbParamSearch.Caption := cbSearchFor.Items[cbSearchFor.Itemindex];
  TimeAviso.Enabled := True;
end;

procedure TSubSaleConsult.edtParamTextChange(Sender: TObject);
begin
  TimeAviso.Enabled := True;
end;

procedure TSubSaleConsult.DataSetClose;
begin
  if quPreSale.Active Then
    quPreSale.Close;
end;

procedure TSubSaleConsult.DataSetOpen;
begin
  SearchCustomer;
end;

procedure TSubSaleConsult.FormDestroy(Sender: TObject);
begin
  inherited;
  DataSetClose;
end;

procedure TSubSaleConsult.FormShow(Sender: TObject);
begin
  inherited;
  SearchCustomer;
end;

procedure TSubSaleConsult.grdPreSalesDblClick(Sender: TObject);
begin
  inherited;
  NotifyChanges(Format('IDPRESALE=%D;IDTOURISTGROUP=%D;OTHERCOMISSIONID=%D;',
           [quPreSaleIDPreSale.AsInteger,
            quPreSaleIDTouristGroup.AsInteger,
            quPreSaleOtherComissionID.AsInteger]));
end;

function TSubSaleConsult.GiveInfo(InfoString: String): String;
begin
  Result :=
    Format('IDPRESALE=%D;IDTOURISTGROUP=%D;OTHERCOMISSIONID=%D;ISEMPTY=%D;SALECODE=%S;TOTALINVOICE=%F',
           [quPreSaleIDPreSale.AsInteger,
            quPreSaleIDTouristGroup.AsInteger,
            quPreSaleOtherComissionID.AsInteger,
            Byte(quPreSale.IsEmpty),
            quPreSaleSaleCode.AsString,
            quPreSaleSubTotalInvoice.AsCurrency]);
end;

procedure TSubSaleConsult.RefreshDataSet;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubSaleConsult.SubListrefresh;
begin
  inherited;
  RefreshDataSet;
end;

procedure TSubSaleConsult.AfterSetParam;
begin
  if Param = '' then Exit;
  FIsClosedLayAway := ParseParam(Param, 'ISCLOSEDLAYAWAY') = '1';

  lbStatus.Visible  := FIsClosedLayAway;
  cbxHoldStatus.Visible := lbStatus.Visible;

  RefreshDataSet;
end;

procedure TSubSaleConsult.cbSearchForNameChange(Sender: TObject);
begin
  inherited;
  lbSearchName.Caption := cbSearchForName.Items[cbSearchForName.Itemindex];
  TimeAviso.Enabled := True;
end;

procedure TSubSaleConsult.TimeAvisoTimer(Sender: TObject);
begin
  inherited;
  if pnlAviso.ParentColor = True then
     pnlAviso.Color := clNavy
  else
     pnlAviso.ParentColor := True;
end;

procedure TSubSaleConsult.btnExecClick(Sender: TObject);
begin
  inherited;
  SearchCustomer;
end;

procedure TSubSaleConsult.cbxHoldStatusChange(Sender: TObject);
begin
  inherited;
  TimeAviso.Enabled := True;
end;

procedure TSubSaleConsult.quPreSaleCalcFields(DataSet: TDataSet);
begin
  inherited;
  if not FIsClosedLayAway then
     quPreSaleTotInvoice.AsCurrency := quPreSaleTotalInvoice.AsCurrency
  else
     quPreSaleTotInvoice.AsCurrency := (quPreSaleSubTotalInvoice.AsCurrency-
                                        quPreSaleSubTotalParent.AsCurrency);
end;

procedure TSubSaleConsult.btnShowNoteClick(Sender: TObject);
begin
  inherited;
  grdBrowseDB.Preview.Visible := not grdBrowseDB.Preview.Visible;
end;

initialization
   RegisterClass(TSubSaleConsult);

end.
