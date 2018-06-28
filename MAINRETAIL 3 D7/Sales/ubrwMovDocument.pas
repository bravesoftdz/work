unit ubrwMovDocument;

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
  PanelRights, StdCtrls, Buttons, LblEffct, Mask, DateBox, SuperComboADO;

type
  TbrwMovDocument = class(TbrwParent)
    quBrowseIDMovDocument: TIntegerField;
    quBrowseDocumentNumber: TStringField;
    quBrowseDocumentDate: TDateTimeField;
    quBrowseDocumentStatus: TIntegerField;
    quBrowseDocumentType: TStringField;
    quBrowseCustomer: TStringField;
    grdBrowseDBIDMovDocument: TcxGridDBColumn;
    grdBrowseDBDocumentNumber: TcxGridDBColumn;
    grdBrowseDBDocumentDate: TcxGridDBColumn;
    grdBrowseDBDocumentType: TcxGridDBColumn;
    grdBrowseDBCustomer: TcxGridDBColumn;
    scDocumentType: TSuperComboADO;
    lblDocumentType: TLabel;
    lblCustomer: TLabel;
    scCustomer: TSuperComboADO;
    edtDocumentNumber: TEdit;
    lblDocumentNumber: TLabel;
    lblDocumentStatus: TLabel;
    cbxDocumentStatus: TComboBox;
    lbFrom: TLabel;
    dbxDateIni: TDateBox;
    lbTo: TLabel;
    dbxDateFim: TDateBox;
    quBrowseDocumentStatusDesc: TStringField;
    grdBrowseDBDocumentStatusDesc: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure dbxDateIniChange(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uFchMovDocument, DateUtils, uDMGlobal;

{$R *.dfm}

procedure TbrwMovDocument.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchMovDocument.Create(Self);

  dbxDateIni.Date := EncodeDate(YearOf(Now), MonthOf(Now), 1);
  dbxDateFim.Date := EncodeDate(YearOf(Now), MonthOf(Now), DaysInMonth(Now));
end;

procedure TbrwMovDocument.btnExecClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to 4 do
    aWhereBasicFilters[i] := '';

  quBrowse.ClearSuggest;

  if edtDocumentNumber.Text <> '' then
    aWhereBasicFilters[0] := 'IMD.DocumentNumber = ' + QuotedStr(edtDocumentNumber.Text)
  else
  begin
    aWhereBasicFilters[0] := 'IMD.DocumentDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', (Trunc(dbxDateIni.Date)))) +
                             ' AND ' +  'IMD.DocumentDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',(Trunc(dbxDateFim.Date)+1)));

    if cbxDocumentStatus.ItemIndex <> 0 then
      aWhereBasicFilters[1] := 'IMD.DocumentStatus = ' + IntToStr(cbxDocumentStatus.ItemIndex);

    if scDocumentType.LookUpValue <> '' then
      aWhereBasicFilters[2] := 'IMD.IDDocumentType = ' + scDocumentType.LookUpValue;

    if scCustomer.LookUpValue <> '' then
      aWhereBasicFilters[3] := 'C.IDPessoa = ' + scCustomer.LookUpValue;
  end;

  ExecBrowseSQL(True);
  DesativaAviso;
end;

procedure TbrwMovDocument.dbxDateIniChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwMovDocument.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
      case quBrowseDocumentStatus.AsInteger of
        1: quBrowseDocumentStatusDesc.AsString := 'Created';
        2: quBrowseDocumentStatusDesc.AsString := 'Signed for the customer';
        3: quBrowseDocumentStatusDesc.AsString := 'Waiting sending';
        4: quBrowseDocumentStatusDesc.AsString := 'Sent';
        5: quBrowseDocumentStatusDesc.AsString := 'Received';
        6: quBrowseDocumentStatusDesc.AsString := 'Filed';
      end;

    LANG_PORTUGUESE:
      case quBrowseDocumentStatus.AsInteger of
        1: quBrowseDocumentStatusDesc.AsString := 'Criado';
        2: quBrowseDocumentStatusDesc.AsString := 'Assinado pelo cliente';
        3: quBrowseDocumentStatusDesc.AsString := 'Aguardando envio';
        4: quBrowseDocumentStatusDesc.AsString := 'Enviado';
        5: quBrowseDocumentStatusDesc.AsString := 'Recebido';
        6: quBrowseDocumentStatusDesc.AsString := 'Arquivado';
      end;

    LANG_SPANISH:
      case quBrowseDocumentStatus.AsInteger of
        1: quBrowseDocumentStatusDesc.AsString := 'Criado';
        2: quBrowseDocumentStatusDesc.AsString := 'Assinado pelo cliente';
        3: quBrowseDocumentStatusDesc.AsString := 'Aguardando envio';
        4: quBrowseDocumentStatusDesc.AsString := 'Enviado';
        5: quBrowseDocumentStatusDesc.AsString := 'Recebido';
        6: quBrowseDocumentStatusDesc.AsString := 'Arquivado';
      end;
  end;
end;

end.
