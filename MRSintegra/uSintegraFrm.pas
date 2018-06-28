unit uSintegraFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls, cxLookAndFeelPainters, StdCtrls, cxButtons, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ComCtrls, DBClient;

const
  REGISTRO_50  = '50';

type
  TSintegra = class
  private
    FFileName: String;
    FTextFile: TextFile;
    FFirstDate: TDateTime;
    FLastDate: TDateTime;
    FAccord: String;
    FNatureOperation: String;
    FPurpose: String;

    FCompanyCGC: String;
    FCompanyIE: String;

    FTotalReg50: Integer;
    FTotalReg51: Integer;
    FTotalReg54: Integer;
    FTotalReg60: Integer;
    FTotalReg70: Integer;
    FTotalReg75: Integer;
    FTotalReg90: Integer;

    procedure LoadCompanyProperties;
    procedure GenerateReg10;
    procedure GenerateReg11;
    procedure GenerateReg50;
    procedure GenerateReg51;
    procedure GenerateReg54;
    procedure GenerateReg60;
    procedure GenerateReg70;
    procedure GenerateReg75;
    procedure GenerateReg90;

    function GetRegDate(ADate: TDateTime): String;
    function BrancoF(s: String; n: Integer): String;
    function Espacos(quantos: Integer): String;
  public
    constructor Create;
    procedure GenerateFile;
    function CanGenerateFile: Boolean;

    property TextFile: TextFile read FTextFile write FTextFile;
    property FirstDate: TDateTime read FFirstDate write FFirstDate;
    property LastDate: TDateTime read FLastDate write FLastDate;
    property Accord: String read FAccord write FAccord;
    property NatureOperation: String read FNatureOperation write FNatureOperation;
    property Purpose: String read FPurpose write FPurpose;
  end;

  TSintegraFrm = class(TForm)
    pnlBottom: TPanel;
    dsPurchase: TDataSource;
    btnClose: TcxButton;
    pnlFilter: TPanel;
    edtFirstDate: TcxDateEdit;
    edtLastDate: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnGo: TcxButton;
    dsSale: TDataSource;
    btnOk: TcxButton;
    PageControl: TPageControl;
    TabSheet: TTabSheet;
    TabSheet1: TTabSheet;
    grdPurchase: TcxGrid;
    grdPurchaseDBTableView: TcxGridDBTableView;
    grdPurchaseLevel: TcxGridLevel;
    grdSale: TcxGrid;
    grdSaleDBTableView: TcxGridDBTableView;
    grdSaleLevel: TcxGridLevel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cbxConvenio: TcxComboBox;
    Label3: TLabel;
    cbxNatOperacao: TcxComboBox;
    Label4: TLabel;
    cbxFinalidade: TcxComboBox;
    Label5: TLabel;
    grdProduto: TcxGrid;
    grdProdutoDBTV: TcxGridDBTableView;
    grdProdutoLevel: TcxGridLevel;
    ds60R: TDataSource;
    grdReducaoZ: TcxGrid;
    grdReducaoZTableView: TcxGridDBTableView;
    grdReducaoZLevel: TcxGridLevel;
    dsReducaoZ: TDataSource;
    grdPurchaseDBTableViewCodFornecedor: TcxGridDBColumn;
    grdPurchaseDBTableViewCodProduto: TcxGridDBColumn;
    grdPurchaseDBTableViewQtd: TcxGridDBColumn;
    grdPurchaseDBTableViewValorTotal: TcxGridDBColumn;
    grdPurchaseDBTableViewValorImposto: TcxGridDBColumn;
    grdPurchaseDBTableViewPercImposto: TcxGridDBColumn;
    grdPurchaseDBTableViewFrete: TcxGridDBColumn;
    grdPurchaseDBTableViewOutrosCustos: TcxGridDBColumn;
    grdPurchaseDBTableViewNovoCusto: TcxGridDBColumn;
    grdPurchaseDBTableViewTipo: TcxGridDBColumn;
    grdPurchaseDBTableViewNotaFiscal: TcxGridDBColumn;
    grdPurchaseDBTableViewDataRegistro: TcxGridDBColumn;
    grdPurchaseDBTableViewDataFatura: TcxGridDBColumn;
    grdPurchaseDBTableViewCFOP: TcxGridDBColumn;
    grdPurchaseDBTableViewCNPJ: TcxGridDBColumn;
    grdPurchaseDBTableViewInscEstadual: TcxGridDBColumn;
    grdPurchaseDBTableViewGrupoFornecido: TcxGridDBColumn;
    grdPurchaseDBTableViewUF: TcxGridDBColumn;
    grdPurchaseDBTableViewFornecedor: TcxGridDBColumn;
    grdPurchaseDBTableViewProduto: TcxGridDBColumn;
    grdPurchaseDBTableViewCF: TcxGridDBColumn;
    grdSaleDBTableViewCodFornecedor: TcxGridDBColumn;
    grdSaleDBTableViewCFOP: TcxGridDBColumn;
    grdSaleDBTableViewCodProduto: TcxGridDBColumn;
    grdSaleDBTableViewQtd: TcxGridDBColumn;
    grdSaleDBTableViewValorTotal: TcxGridDBColumn;
    grdSaleDBTableViewValorImposto: TcxGridDBColumn;
    grdSaleDBTableViewPercImposto: TcxGridDBColumn;
    grdSaleDBTableViewFrete: TcxGridDBColumn;
    grdSaleDBTableViewOutrosCustos: TcxGridDBColumn;
    grdSaleDBTableViewNovoCusto: TcxGridDBColumn;
    grdSaleDBTableViewNotaFiscal: TcxGridDBColumn;
    grdSaleDBTableViewDataRegistro: TcxGridDBColumn;
    grdSaleDBTableViewDataFatura: TcxGridDBColumn;
    grdSaleDBTableViewCPF: TcxGridDBColumn;
    grdSaleDBTableViewInscEstadual: TcxGridDBColumn;
    grdSaleDBTableViewGrupoFornecido: TcxGridDBColumn;
    grdSaleDBTableViewUF: TcxGridDBColumn;
    grdSaleDBTableViewCliente: TcxGridDBColumn;
    grdSaleDBTableViewProduto: TcxGridDBColumn;
    grdSaleDBTableViewCF: TcxGridDBColumn;
    grdReducaoZTableViewNumeroECF: TcxGridDBColumn;
    grdReducaoZTableViewNumeroSerie: TcxGridDBColumn;
    grdReducaoZTableViewIDReducaoZ: TcxGridDBColumn;
    grdReducaoZTableViewMovDate: TcxGridDBColumn;
    grdReducaoZTableViewNumReducaoZ: TcxGridDBColumn;
    grdReducaoZTableViewCOOInicial: TcxGridDBColumn;
    grdReducaoZTableViewCOOFinal: TcxGridDBColumn;
    grdReducaoZTableViewNumCancelamentos: TcxGridDBColumn;
    grdReducaoZTableViewValCancelamentos: TcxGridDBColumn;
    grdReducaoZTableViewValDescontos: TcxGridDBColumn;
    grdReducaoZTableViewGTInicial: TcxGridDBColumn;
    grdReducaoZTableViewGTFinal: TcxGridDBColumn;
    grdReducaoZTableViewSubstituicaoTrib: TcxGridDBColumn;
    grdReducaoZTableViewIsencao: TcxGridDBColumn;
    grdProdutoDBTVCodigoProduto: TcxGridDBColumn;
    grdProdutoDBTVProduto: TcxGridDBColumn;
    grdProdutoDBTVQuantidade: TcxGridDBColumn;
    grdProdutoDBTVValorTotal: TcxGridDBColumn;
    grdProdutoDBTVPercImposto: TcxGridDBColumn;
    grdProdutoDBTVUnidade: TcxGridDBColumn;
    grdProdutoDBTVCF: TcxGridDBColumn;
    grdReducaoZTableViewNaoTributavel: TcxGridDBColumn;
    edtCFOP: TcxTextEdit;
    Label6: TLabel;
    pb: TProgressBar;
    lbDisplay: TLabel;
    procedure btnGoClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    procedure CarregarDados;
    procedure CarregarEmpresa;
    procedure CarregarCompras;
    procedure CarregarNFCompras;
    procedure CarregarProdCompras;
    procedure CarregarNFVendas;

    procedure EnableControls;
    procedure DisableControls;
  public
    procedure Start;
  end;

implementation

uses uDMSintegra, ADODB, DateUtils, uStringFunctions;

{$R *.dfm}

{ TSintegraFrm }

procedure TSintegraFrm.Start;
begin
  edtFirstDate.Date := EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edtLastDate.Date := EncodeDate(YearOf(Now), MonthOf(Now), DaysInMonth(Now));

  cbxConvenio.ItemIndex := 0;
  cbxNatOperacao.ItemIndex := 2;
  cbxFinalidade.ItemIndex := 0;

  ShowModal;
end;

procedure TSintegraFrm.btnGoClick(Sender: TObject);
var
  AFirstDate, ALastDate: TDateTime;
begin
  AFirstDate := edtFirstDate.Date;
  ALastDate := (edtLastDate.Date+1);

  Screen.Cursor := crHourGlass;
  try
    with DMSintegra.quPurchase do
    begin
      if Active then
        Close;

      Parameters.ParamByName('FirstDate').Value := AFirstDate;
      Parameters.ParamByName('LastDate').Value := ALastDate;
      Open;
    end;

    with DMSintegra.quSale do
    begin
      if Active then
        Close;

      Parameters.ParamByName('FirstDate').Value := AFirstDate;
      Parameters.ParamByName('LastDate').Value := ALastDate;
      Open;
    end;

    with DMSintegra.cdsReducaoZ do
    begin
      if Active then
        Close;

      FetchParams;
      Params.ParamByName('FirstDate').Value := AFirstDate;
      Params.ParamByName('LastDate').Value := ALastDate;
      Open;
    end;

    with DMSintegra.cdsTributacaoEcf do
    begin
      if Active then
        Close;

      FetchParams;
      Params.ParamByName('FirstDate').Value := AFirstDate;
      Params.ParamByName('LastDate').Value := ALastDate;
      Open;
    end;

    with DMSintegra.qu60R do
    begin
      if Active then
        Close;

      Parameters.ParamByName('FirstDate').Value := AFirstDate;
      Parameters.ParamByName('LastDate').Value := ALastDate;
      Open;
    end;
  finally
    btnOk.SetFocus;
    Screen.Cursor := crDefault;
    end;
end;

procedure TSintegraFrm.btnOkClick(Sender: TObject);
begin


  Screen.Cursor := crHourGlass;
  btnOk.Visible := False;

  try

    CarregarDados;

    with TSintegra.Create do
    try
      if CanGenerateFile then
      begin
        DisableControls;

        FirstDate := edtFirstDate.Date;
        LastDate := edtLastDate.Date;
        Accord := cbxConvenio.Text;
        NatureOperation := cbxNatOperacao.Text;
        Purpose := cbxFinalidade.Text;

        GenerateFile;
        ShowMessage('Arquivo Gerado com Sucesso !');
      end;
    finally
      Free;
      EnableControls;
    end;
  finally
    Screen.Cursor := crDefault;
    btnOk.Visible := True;
  end;

end;

procedure TSintegraFrm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSintegraFrm.CarregarCompras;
begin
  DmSintegra.quPurchase.First;

  pb.Visible  := True;
  pb.Position := 0;
  pb.Max      := DmSintegra.quPurchase.RecordCount;
  lbDisplay.Caption := 'Gerando Compras ...';
  Application.ProcessMessages;
  try
    while not DmSintegra.quPurchase.Eof do
    begin
      CarregarNFCompras;
      CarregarProdCompras;

      DmSintegra.quPurchase.Next;
      lbDisplay.Caption := 'Gerando Compras ('+IntToStr(pb.Position)+ ' de ' + IntToStr(pb.Max) + ')...';
      Application.ProcessMessages;
      pb.StepIt;
    end;
  finally
    pb.Visible := False;
    lbDisplay.Caption := '';
  end;
end;

procedure TSintegraFrm.CarregarNFVendas;
var
  sCPF, sNF, sIE: String;
begin
  with DMSintegra.quSale do
  begin
    First;

    pb.Visible  := True;
    pb.Position := 0;
    pb.Max      := DmSintegra.quSale.RecordCount;
    lbDisplay.Caption := 'Gerando Vendas ...';

    while not Eof do
    begin
      sCPF    := '00000000000000' + Trim(FieldByName('CPF').AsString);
      sCPF    := Copy(sCPF, Length(sCPF)-13, 14);

      if FieldByName('InscEstadual').AsString = '' then
        sIE := 'ISENTO'
      else
        sIE := Copy(FieldByName('InscEstadual').AsString, 1, 14);

      sNF := StringReplace(FieldByName('NotaFiscal').AsString, '/', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, '-', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, '.', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, '(', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, ')', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, 'T', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, 'N', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, 'F', '', [rfReplaceAll]);
      sNF := StringReplace(sNF, ' ', '', [rfReplaceAll]);
      sNF := FormatFloat('000000', StrToFloat(sNF));

      if DMSintegra.cdsSintegra.FindKey([REGISTRO_50, sCPF, StrToDate(Copy(FormatDateTime('ddddd', FieldByName('DataRegistro').AsDateTime), 1, 10)), sNF]) then
        DMSintegra.cdsSintegra.Edit
      else
      begin
        DMSintegra.cdsSintegra.Append;
        DMSintegra.cdsSintegraALIQ.AsString := '00';

        DMSintegra.cdsSintegraTIPO.AsString    := REGISTRO_50;
        DMSintegra.cdsSintegraCNPJ.AsString    := sCPF;
        DMSintegra.cdsSintegraIEST.AsString    := sIE;
        DMSintegra.cdsSintegraDATAREG.AsString := Copy(FormatDateTime('ddddd', FieldByName('DataRegistro').AsDateTime), 1, 10);
        DMSintegra.cdsSintegraUF.AsString      := FieldByName('Estado_UF').AsString;
        DMSintegra.cdsSintegraRF.AsString      := '01';
        DMSintegra.cdsSintegraSERIE.AsString   := '1  ';
        DMSintegra.cdsSintegraDOC.AsString     := sNF;

        if (FieldByName('CFOP').AsString <> '') and (Length(FieldByName('CFOP').AsString) = 4) then
          DMSintegra.cdsSintegraCFOP.AsString := FieldByName('CFOP').AsString
        else
          DMSintegra.cdsSintegraCFOP.AsString := edtCFOP.Text;

        DMSintegra.cdsSintegraP_T.AsString     := 'P';
        DMSintegra.cdsSintegraS_N.AsString     := 'N';
        DMSintegra.cdsSintegraISENTO.AsString  := FormatFloat('0.00', 0);
        DMSintegra.cdsSintegraOUTRAS.AsString  := FormatFloat('0.00', 0);
      end;

      DMSintegra.cdsSintegraCONTABIL.AsFloat := DMSintegra.cdsSintegraCONTABIL.AsFloat + FieldByName('ValorTotal').AsFloat;
      DMSintegra.cdsSintegraBASE.AsFloat     := DMSintegra.cdsSintegraBASE.AsFloat + FieldByName('ValorTotal').AsFloat;
      DMSintegra.cdsSintegraIMPOSTO.AsFloat  := DMSintegra.cdsSintegraIMPOSTO.AsFloat + FieldByName('ValorImposto').AsFloat;

      if FieldByName('PercImposto').AsFloat <> 0 then
        DMSintegra.cdsSintegraALIQ.asString := FormatFloat('00', FieldByName('PercImposto').AsFloat);

      DMSintegra.cdsSintegra.Post;

      pb.StepIt;
      lbDisplay.Caption := 'Gerando Vendas ('+IntToStr(pb.Position)+ ' de ' + IntToStr(pb.Max) + ')...';
      Application.ProcessMessages;
      Next;
    end;

    pb.Visible := False;
    lbDisplay.Caption := '';
  end;
end;

procedure TSintegraFrm.CarregarNFCompras;
var
  sNF: String;
begin
  with DmSintegra.quPurchase do
  begin
    sNF := StringReplace(FieldByName('NotaFiscal').AsString, '/', '', [rfReplaceAll]);
    sNF := StringReplace(sNF, '-', '', [rfReplaceAll]);
    sNF := StringReplace(sNF, '.', '', [rfReplaceAll]);
    sNF := FormatFloat('000000', StrToFloat(sNF));

    if DMSintegra.cdsSintegra.FindKey([REGISTRO_50, FieldByName('CNPJ').AsString, FieldByName('DataRegistro').AsDateTime, sNF]) then
      DMSintegra.cdsSintegra.Edit
    else
    begin
      DMSintegra.cdsSintegra.Append;

      DMSintegra.cdsSintegraTIPO.AsString          := REGISTRO_50;
      DMSintegra.cdsSintegraCNPJ.AsString          := FieldByName('CNPJ').AsString;
      DMSintegra.cdsSintegraIEST.AsString          := FieldByName('InscEstadual').AsString;
      DMSintegra.cdsSintegraDATAREG.AsDateTime     := FieldByName('DataRegistro').AsDateTime;
      DMSintegra.cdsSintegraUF.AsString            := FieldByName('UF').AsString;
      DMSintegra.cdsSintegraCFOP.AsString          := FieldByName('CFOP').AsString;
      DMSintegra.cdsSintegraCODFORNECEDOR.AsString := FieldByName('CodFornecedor').AsString;
      DMSintegra.cdsSintegraDOC.AsString           := sNF;
      DMSintegra.cdsSintegraRF.AsString            := '01';
      DMSintegra.cdsSintegraSERIE.AsString         := '1   ';
      DMSintegra.cdsSintegraALIQ.AsString          := '00';
      DMSintegra.cdsSintegraP_T.AsString           := 'T';
      DMSintegra.cdsSintegraS_N.AsString           := 'N';
    end;

    DMSintegra.cdsSintegraCONTABIL.AsFloat       := DMSintegra.cdsSintegraCONTABIL.AsFloat + FieldByName('ValorTotal').AsFloat;
    DMSintegra.cdsSintegraBASE.AsFloat           := DMSintegra.cdsSintegraBASE.AsFloat + FieldByName('ValorTotal').AsFloat;
    DMSintegra.cdsSintegraIMPOSTO.AsFloat        := DMSintegra.cdsSintegraIMPOSTO.AsFloat + FieldByName('ValorImposto').AsFloat;

    if FieldByName('CF').asString = '040' then
      DMSintegra.cdsSintegraISENTO.AsFloat   := DMSintegra.cdsSintegraISENTO.AsFloat + FieldByName('ValorTotal').AsFloat
    else
      DMSintegra.cdsSintegraOUTRAS.AsFloat   := DMSintegra.cdsSintegraOUTRAS.AsFloat + FieldByName('ValorTotal').AsFloat;

    DMSintegra.cdsSintegra.Post;
  end;
end;

procedure TSintegraFrm.CarregarProdCompras;
begin
  with DmSintegra.quPurchase do
  begin
    DMSintegra.cdsProdutoCompra.Append;

    DMSintegra.cdsProdutoCompraNF.AsString := FormatFloat('000000', StrToFloat(DMSintegra.cdsSintegraDOC.AsString));
    DMSintegra.cdsProdutoCompraCODFORNECEDOR.AsString := FieldByName('CodFornecedor').AsString;

    if FieldByName('PercImposto').IsNull then
    begin
      DMSintegra.cdsProdutoCompraQUANTIDADE.AsString := FormatFloat('00000000000', FieldByName('Qtd').AsFloat * 1000);
      DMSintegra.cdsProdutoCompraVALORTOTAL.AsString := FormatFloat('000000000000', FieldByName('ValorTotal').AsFloat * 100);
      DMSintegra.cdsProdutoCompraALIQ.AsString       := FormatFloat('0000', FieldByName('PercImposto').AsFloat * 100);
    end
    else
    begin
      DMSintegra.cdsProdutoCompraQUANTIDADE.AsString := FormatFloat('00000000000', FieldByName('Qtd').AsFloat * 1000);
      DMSintegra.cdsProdutoCompraVALORTOTAL.AsString := FormatFloat('000000000000', FieldByName('ValorTotal').AsFloat * 100);
      DMSintegra.cdsProdutoCompraALIQ.AsString       := FormatFloat('0000', FieldByName('PercImposto').AsFloat * 100);
    end;

    DMSintegra.cdsProdutoCompraCODPRODUTO.AsString   := FieldByName('CodProduto').AsString;
    DMSintegra.cdsProdutoCompraDESCRICAO.AsString    := FieldByName('PRODUTO').AsString;
    DMSintegra.cdsProdutoCompraUNIDADE.AsString      := FieldByName('TIPO').AsString;
    DMSintegra.cdsProdutoCompraCFOP.AsString         := FieldByName('CFOP').AsString;
    DMSintegra.cdsProdutoCompraKSFI.AsString         := FieldByName('CF').AsString;
    DMSintegra.cdsProdutoCompraNRITEM.AsString       := '000';

    DMSintegra.cdsProdutoCompra.Post;
  end;
end;

procedure TSintegraFrm.CarregarDados;
begin
  DMSintegra.cdsSintegra.EmptyDataSet;
  DMSintegra.cdsSintegra.IndexName := 'cdsSintegraIndex1';

  CarregarEmpresa;
  CarregarNFVendas;
  CarregarCompras;

  DMSintegra.cdsSintegra.IndexName := '';
  DMSintegra.cdsSintegra.First;
end;

procedure TSintegraFrm.CarregarEmpresa;
begin
  with DMSintegra.qryEmpresa do
  begin
    if Active then
      Close;

    Parameters.ParamByName('IDEmpresa').Value := DMSintegra.GetAppProperty('Settings', 'IDEmpresa');
    Open;
  end;
end;

procedure TSintegraFrm.DisableControls;
begin
  dsPurchase.DataSet.DisableControls;
  dsSale.DataSet.DisableControls;
  ds60R.DataSet.DisableControls;
  dsReducaoZ.DataSet.DisableControls;
end;

procedure TSintegraFrm.EnableControls;
begin
  dsPurchase.DataSet.EnableControls;
  dsSale.DataSet.EnableControls;
  ds60R.DataSet.EnableControls;
  dsReducaoZ.DataSet.EnableControls;
end;

{ TSintegra }

function TSintegra.BrancoF(s: String; n: Integer): String;
begin
  s := s + Espacos(n);
  result := Copy(s,1,n);
end;

function TSintegra.CanGenerateFile: Boolean;
begin
  Result := True;
  FFileName := DMSintegra.GetAppProperty('Settings', 'SintegraFileName');

  if FileExists(FFileName) then
    Result := MessageDlg('Arquivo ' + FFileName + ' já existe, Deseja substituir ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

constructor TSintegra.Create;
begin
  FTotalReg50 := 0;
  FTotalReg51 := 0;
  FTotalReg54 := 0;
  FTotalReg60 := 0;
  FTotalReg70 := 0;
  FTotalReg75 := 0;
  FTotalReg90 := 0;

  LoadCompanyProperties;
end;

function TSintegra.Espacos(quantos: Integer): String;
var
  p: Integer;
  retorna: String;
begin
  retorna := '';
  for p := 1 to quantos do begin
    retorna := retorna + ' ';
  end;
  result := retorna;
end;

procedure TSintegra.GenerateFile;
begin
  try
    AssignFile(FTextFile, FFileName);
    Rewrite(FTextFile);

    GenerateReg10;
    GenerateReg11;
    GenerateReg50;
    GenerateReg51;
    GenerateReg54;
    GenerateReg60;
    GenerateReg70;
    GenerateReg75;
    GenerateReg90;
  finally
    CloseFile(FTextFile);
  end;
end;

procedure TSintegra.GenerateReg10;
var
  DET, sFAX: String;
begin
  // Aqui montarei o registro 10
  DET := '10';
  DET := DET + FCompanyCGC;
  DET := DET + FCompanyIE;
  DET := DET + Copy(DMSintegra.qryEmpresaRazaoSocial.AsString + '                                   ', 1, 35);
  DET := DET + Copy(DMSintegra.qryEmpresaCidade.AsString + '                              ', 1, 30);
  DET := DET + Trim(DMSintegra.qryEmpresaIDEstado.AsString);
  sFAX := StringReplace(DMSintegra.qryEmpresaFax.AsString, '(', '', [rfReplaceAll]);
  sFAX := StringReplace(sFAX, ')', '', [rfReplaceAll]);
  sFAX := StringReplace(sFAX, '-', '', [rfReplaceAll]);
  sFAX := StringReplace(sFAX, '.', '', [rfReplaceAll]);
  sFAX := StringReplace(sFAX, '/', '', [rfReplaceAll]);
  sFAX := FormatFloat('0000000000', StrToFloatDef(sFAX, 0));
  DET := DET + sFAX;
  DET := DET + GetRegDate(FFirstDate);
  DET := DET + GetRegDate(FLastDate);
  DET := DET + Copy(FAccord, 1, 1);
  DET := DET + Copy(FNatureOperation, 1, 1);
  DET := DET + Copy(FPurpose, 1, 1);
  WriteLN(FTextFile, DET);
end;

procedure TSintegra.GenerateReg11;
var
  DET, sTEL, sCEP: String;
begin
  DET := '11';
  DET := DET + BrancoF(DMSintegra.qryEmpresaEndereco.AsString, 34);
  DET := DET + FormatFloat('00000', DMSintegra.qryEmpresaNumero.AsFloat);
  DET := DET + BrancoF(DMSintegra.qryEmpresaCoplemento.AsString, 22);
  DET := DET + BrancoF(DMSintegra.qryEmpresaBairro.AsString, 15);
  sCEP := StringReplace(DMSintegra.qryEmpresaCEP.AsString, '-', '', [rfReplaceAll]);
  sCEP := StringReplace(sCEP, '.', '', [rfReplaceAll]);
  sCEP := FormatFloat('00000000', StrToFloatDef(sCEP, 0));
  DET := DET + sCEP;
  //DET := DET + BrancoF(DMSintegra.qryEmpresaContato.AsString, 28); //Bahia
  DET := DET + BrancoF(DMSintegra.qryEmpresaContato.AsString, 28);
  sTEL := StringReplace(DMSintegra.qryEmpresaTelefone.AsString, '(', '', [rfReplaceAll]);
  sTEL := StringReplace(sTEL, ')', '', [rfReplaceAll]);
  sTEL := StringReplace(sTEL, '-', '', [rfReplaceAll]);
  sTEL := StringReplace(sTEL, '.', '', [rfReplaceAll]);
  sTEL := StringReplace(sTEL, '/', '', [rfReplaceAll]);
  sTEL := FormatFloat('000000000000', StrToFloatDef(sTEL, 0));
  DET := DET + sTEL;
  Writeln(FTextFile, DET);
end;

procedure TSintegra.GenerateReg50;
var
  DET: String;
begin
  DMSintegra.cdsSintegra.Filtered := False;
  DMSintegra.cdsSintegra.Filter := 'TIPO = ' + QuotedStr('50');
  DMSintegra.cdsSintegra.Filtered := True;
  DMSintegra.cdsSintegra.First;

  FTotalReg50 := 0;

  while not DMSintegra.cdsSintegra.Eof do
  begin
    DET := DMSintegra.cdsSintegraTIPO.AsString;
    DET := DET + DMSintegra.cdsSintegraCNPJ.AsString;
    DET := DET + BrancoF(DMSintegra.cdsSintegraIEST.AsString, 14);
    DET := DET + GetRegDate(DMSintegra.cdsSintegraDATAREG.value);
    DET := DET + BrancoF(DMSintegra.cdsSintegraUF.AsString, 2);
    DET := DET + DMSintegra.cdsSintegraRF.AsString;
    DET := DET + BrancoF(DMSintegra.cdsSintegraSERIE.AsString, 3);
    DET := DET + DMSintegra.cdsSintegraDOC.AsString;
    DET := DET + DMSintegra.cdsSintegraCFOP.AsString;
    DET := DET + 'P'; //P: Emissão Própria ou T: Emissão de terceiros
    DET := DET + FormatFloat('0000000000000', ABS(Trunc(DMSintegra.cdsSintegraDATAREG.Value)));
    DET := DET + FormatFloat('0000000000000', ABS(Trunc(DMSintegra.cdsSintegraBASE.Value)));
    DET := DET + FormatFloat('0000000000000', ABS(Trunc(DMSintegra.cdsSintegraImposto.Value)));
    DET := DET + FormatFloat('0000000000000', ABS(Trunc(DMSintegra.cdsSintegraISENTO.Value)));
    DET := DET + FormatFloat('0000000000000', ABS(Trunc(DMSintegra.cdsSintegraOUTRAS.Value)));
    DET := DET + FormatFloat('0000', ABS(StrToFloatDef(DMSintegra.cdsSintegraALIQ.AsString, 0)) * 100);
    DET := DET + DMSintegra.cdsSintegraS_N.AsString;

    WriteLN(FTextFile, DET);

    FTotalReg50 := FTotalReg50 + 1;

    DMSintegra.cdsSintegra.Next;
  end;

  DMSintegra.cdsSintegra.Filtered := False;
end;

procedure TSintegra.GenerateReg51;
var
  DET: String;
begin
  DMSintegra.cdsSintegra.Filtered := False;
  DMSintegra.cdsSintegra.Filter := 'TIPO = ' + QuotedStr('51');
  DMSintegra.cdsSintegra.Filtered := True;
  DMSintegra.cdsSintegra.First;

  FTotalReg51 := 0;

  while not DMSintegra.cdsSintegra.Eof do
  begin
    DET := DMSintegra.cdsSintegraTIPO.AsString;
    DET := DET + DMSintegra.cdsSintegraCNPJ.AsString;
    DET := DET + BrancoF(DMSintegra.cdsSintegraIEST.AsString, 14);
    DET := DET + GetRegDate(DMSintegra.cdsSintegraDATAREG.value);
    DET := DET + DMSintegra.cdsSintegraUF.AsString;
    DET := DET + DMSintegra.cdsSintegraRF.AsString;
    DET := DET + BrancoF(DMSintegra.cdsSintegraSERIE.AsString, 3);
    DET := DET + DMSintegra.cdsSintegraDOC.AsString;
    DET := DET + DMSintegra.cdsSintegraCFOP.AsString;
    DET := DET + 'T';
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraDATAREG.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraBASE.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraImposto.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraISENTO.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraOUTRAS.Value);
    DET := DET + FormatFloat('0000', StrToFloatDef(DMSintegra.cdsSintegraALIQ.AsString, 0) * 100);
    DET := DET + DMSintegra.cdsSintegraS_N.AsString;

    WriteLN(FTextFile, DET);

    FTotalReg51 := FTotalReg51 + 1;

    DMSintegra.cdsSintegra.Next;
  end;

  DMSintegra.cdsSintegra.Filtered := False;
end;

procedure TSintegra.GenerateReg54;
var
  NrItem: Integer;
  DET, DET54: String;
begin
  FTotalReg54 := 0;

  DMSintegra.cdsSintegra.First;
  while not DMSintegra.cdsSintegra.Eof do
  begin
    NrItem := 0;
    DET := DMSintegra.cdsSintegraTIPO.AsString;

    DMSintegra.cdsProdutoCompra.FindNearest([DMSintegra.cdsSintegraDOC.AsString, DMSintegra.cdsSintegraCODFORNECEDOR.AsString]);
    while not DMSintegra.cdsProdutoCompra.Eof do
    begin
      if DMSintegra.cdsProdutoCompraNF.AsString + Trim(DMSintegra.cdsProdutoCompraCODFORNECEDOR.AsString) <> DMSintegra.cdsSintegraDOC.AsString + Trim(DMSintegra.cdsSintegraCODFORNECEDOR.AsString) then
        Break;

      NrItem := NrItem + 1;

      if DMSintegra.Virtual_Produtos.FindKey([DMSintegra.cdsProdutoCompraCODPRODUTO.AsString + '      ']) = False then
      begin
        DMSintegra.Virtual_Produtos.Append;
        DMSintegra.Virtual_ProdutosCodigoProduto.AsString := DMSintegra.cdsProdutoCompraCODPRODUTO.AsString + '      ';
        DMSintegra.Virtual_ProdutosDescricao.AsString     := DMSintegra.cdsProdutoCompraDESCRICAO.AsString;
        DMSintegra.Virtual_ProdutosAliquota.AsString      := DMSintegra.cdsProdutoCompraALIQ.AsString;
        DMSintegra.Virtual_ProdutosCF.AsString            := DMSintegra.cdsProdutoCompraKSFI.AsString;
        DMSintegra.Virtual_ProdutosUnidade.AsString       := DMSintegra.cdsProdutoCompraUnidade.AsString;
        if (DMSintegra.Virtual_ProdutosCF.AsString <> '000') and (DMSintegra.Virtual_ProdutosCF.AsString <> '040') and (DMSintegra.Virtual_ProdutosCF.AsString <> '090') then
          DMSintegra.Virtual_ProdutosCF.AsString := '000';

        DMSintegra.Virtual_Produtos.Post;
      end;

      DET54 := '54';
      DET54 := DET54 + DMSintegra.cdsSintegraCNPJ.AsString;
      DET54 := DET54 + DMSintegra.cdsSintegraRF.AsString;
      DET54 := DET54 + '1  ';
      DET54 := DET54 + DMSintegra.cdsProdutoCompraNF.AsString;
      DET54 := DET54 + DMSintegra.cdsSintegraCFOP.AsString;

      if DMSintegra.cdsProdutoCompraKSFI.AsString = '' then
        DET54 := DET54 + '000'
      else
        DET54 := DET54 + DMSintegra.cdsProdutoCompraKSFI.AsString;

      DET54 := DET54 + FormatFloat('000', NrItem);
      DET54 := DET54 + Copy(DMSintegra.cdsProdutoCompraCodProduto.AsString + '              ', 1, 14);
      DET54 := DET54 + DMSintegra.cdsProdutoCompraQuantidade.AsString;
      DET54 := DET54 + DMSintegra.cdsProdutoCompraValorTotal.AsString;
      DET54 := DET54 + '000000000000';
      DET54 := DET54 + DMSintegra.cdsProdutoCompraValorTotal.AsString;
      DET54 := DET54 + '000000000000';
      DET54 := DET54 + '000000000000';
      DET54 := DET54 + DMSintegra.cdsProdutoCompraAliq.AsString;

      FTotalReg54 := FTotalReg54 + 1;

      WriteLN(FTextFile, DET54);
      DMSintegra.cdsProdutoCompra.Next;
    end;

    DMSintegra.cdsSintegra.Next;
  end;
end;

procedure TSintegra.GenerateReg60;
var
  YY, MM, DD: Word;
  ConvData: TDate;
  DET: String;
  FTotal : Currency;
begin
  // Aqui vamos gerar os ECF
  FTotalReg60 := 0;

  with DMSintegra do
  begin
    cdsReducaoZ.First;

    while not cdsReducaoZ.Eof do
    begin
      ConvData := cdsReducaoZ.FieldByName('MovDate').AsDateTime;
      DecodeDate(ConvData , YY, MM, DD);

      DET := '60M';
      DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
      DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
      DET := DET + FormatFloat('000', cdsReducaoZ.FieldByName('NumeroECF').AsFloat);
      DET := DET + '2C';
      DET := DET + FormatFloat('000000', cdsReducaoZ.FieldByName('COOInicial').AsFloat);
      DET := DET + FormatFloat('000000', cdsReducaoZ.FieldByName('COOFinal').AsFloat);
      DET := DET + FormatFloat('000000', cdsReducaoZ.FieldByName('NumReducaoZ').AsFloat);
      DET := DET + '001';
      FTotal := (cdsReducaoZ.FieldByName('GTFinal').AsFloat - cdsReducaoZ.FieldByName('GTInicial').AsFloat);
      DET := DET + FormatFloat('0000000000000000', FTotal * 100);

      FTotal := cdsReducaoZ.FieldByName('GTFinal').AsFloat;

      DET := DET + FormatFloat('0000000000000000', FTotal * 100);
      DET := DET + '                                     ';
      WriteLN(FTextFile, DET);
      FTotalReg60 := FTotalReg60 + 1;

      FTotal := cdsReducaoZ.FieldByName('SubstituicaoTrib').AsFloat;
      if FTotal <> 0 then
      begin
        DET := '60A';
        DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
        DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
        DET := DET + 'F   ';
        DET := DET + FormatFloat('000000000000', FTotal * 100);
        DET := DET + '                                                                               ';
        WriteLN(FTextFile, DET);
        FTotalReg60 := FTotalReg60 + 1;
      end;

      FTotal := cdsReducaoZ.FieldByName('Isencao').Value;
      if FTotal <> 0 then
      begin
        DET := '60A';
        DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
        DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
        DET := DET + 'I   ';
        DET := DET + FormatFloat('000000000000', FTotal * 100);
        DET := DET + '                                                                               ';
        WriteLN(FTextFile, DET);
        FTotalReg60 := FTotalReg60 + 1;
      end;

      FTotal := cdsReducaoZ.FieldByName('NaoTributavel').AsFloat;
      if FTotal <> 0 then
      begin
        DET := '60A';
        DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
        DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
        DET := DET + 'N   ';
        DET := DET + FormatFloat('000000000000', FTotal * 100);
        DET := DET + '                                                                               ';
        WriteLN(FTextFile, DET);
        FTotalReg60 := FTotalReg60 + 1;
      end;

      FTotal := cdsReducaoZ.FieldByName('ValDescontos').AsFloat;
      if FTotal <> 0 then
      begin
        DET := '60A';
        DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
        DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
        DET := DET + 'CANC';
        DET := DET + FormatFloat('000000000000', FTotal * 100);
        DET := DET + '                                                                               ';
        WriteLN(FTextFile, DET);
        FTotalReg60 := FTotalReg60 + 1;
      end;

      FTotal := cdsReducaoZ.FieldByName('ValCancelamentos').AsFloat;
      if FTotal <> 0 then
      begin
        DET := '60A';
        DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
        DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
        DET := DET + 'DESC';
        DET := DET + FormatFloat('000000000000', FTotal * 100);
        DET := DET + '                                                                               ';
        WriteLN(FTextFile, DET);
        FTotalReg60 := FTotalReg60 + 1;
      end;

      cdsTributacaoEcf.Filter := 'IDReducaoZ = ' + cdsReducaoZ.FieldByName('IDReducaoZ').AsString;
      cdsTributacaoEcf.Filtered := True;
      cdsTributacaoEcf.First;
      while not cdsTributacaoEcf.Eof do
      begin
        DET := '60';
        DET := DET + 'A';
        DET := DET + FormatFloat('0000', YY) + FormatFloat('00', MM) + FormatFloat('00', DD);
        DET := DET + cdsReducaoZ.FieldByName('NumeroSerie').AsString;
        DET := DET + FormatFloat('0000', cdsTributacaoEcf.FieldByName('Aliquota').Value * 100 );
        FTotal := cdsTributacaoEcf.FieldByName('BaseCalculo').AsFloat;
        DET := DET + FormatFloat('000000000000', FTotal * 100);
        DET := DET + '                                                                               ';
        WriteLN(FTextFile, DET);
        FTotalReg60 := FTotalReg60 + 1;

        cdsTributacaoEcf.Next;
      end;
      cdsTributacaoEcf.Filter := '';
      cdsTributacaoEcf.Filtered := False;

      cdsReducaoZ.Next;
    end;
  end;

  DMSintegra.qu60R.First;
  while not DMSintegra.qu60R.Eof do
  begin
    if (DMSintegra.qu60RQuantidade.value > 0) and (DMSintegra.qu60RValorTotal.value > 0) then
    begin
      DET := '60';
      DET := DET + 'R';
      DET := DET + FormatFloat('00', MM) + FormatFloat('0000', YY);
      DET := DET + Copy(DMSintegra.qu60RCodigoProduto.AsString + '              ', 1, 14);
      DET := DET + FormatFloat('0000000000000', DMSintegra.qu60RQuantidade.Value * 1000);
      FTotal := DMSintegra.qu60RValorTotal.Value;
      DET := DET + FormatFloat('0000000000000000', FTotal * 100);
      DET := DET + FormatFloat('0000000000000000', DMSintegra.qu60RValorTotal.Value * 100);
      DET := DET + FormatFloat('0000', DMSintegra.qu60RPercImposto.Value * 100);  // Pode ser 0700 1200 1800 2500 F   I     - F-SubsTrib I-Isento
      DET := DET + '                                                      '; // 54 espacos verificar ????
      WriteLN(FTextFile, DET);
      FTotalReg60 := FTotalReg60 + 1;
    end;
    DMSintegra.qu60R.Next;
  end;
end;

procedure TSintegra.GenerateReg70;
var
  DET: String;
begin
  DMSintegra.cdsSintegra.Filtered := False;
  DMSintegra.cdsSintegra.Filter := 'TIPO = ' + QuotedStr('70');
  DMSintegra.cdsSintegra.Filtered := True;
  DMSintegra.cdsSintegra.First;

  FTotalReg70 := 0;

  while not DMSintegra.cdsSintegra.Eof do
  begin
    DET := DMSintegra.cdsSintegraTIPO.AsString;
    DET := DET + DMSintegra.cdsSintegraCNPJ.AsString;
    DET := DET + BrancoF(DMSintegra.cdsSintegraIEST.AsString, 14);
    DET := DET + GetRegDate(DMSintegra.cdsSintegraDATAREG.value);
    DET := DET + DMSintegra.cdsSintegraUF.AsString;
    DET := DET + DMSintegra.cdsSintegraRF.AsString;
    DET := DET + BrancoF(DMSintegra.cdsSintegraSERIE.AsString, 3);
    DET := DET + DMSintegra.cdsSintegraDOC.AsString;
    DET := DET + DMSintegra.cdsSintegraCFOP.AsString;
    DET := DET + 'T';
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraDATAREG.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraBASE.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraImposto.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraISENTO.Value);
    DET := DET + FormatFloat('0000000000000', DMSintegra.cdsSintegraOUTRAS.Value);
    DET := DET + FormatFloat('0000', StrToFloatDef(DMSintegra.cdsSintegraALIQ.AsString, 0) * 100);
    DET := DET + DMSintegra.cdsSintegraS_N.AsString;

    WriteLN(FTextFile, DET);

    FTotalReg70 := FTotalReg70 + 1;

    DMSintegra.cdsSintegra.Next;
  end;

  DMSintegra.cdsSintegra.Filtered := False;
end;

procedure TSintegra.GenerateReg75;
var
  DET: String;
begin
  // Registro com a listagem de produtos dos outros registros
  FTotalReg75 := 0;

  DMSintegra.qu60R.First;
  while not DMSintegra.qu60R.Eof do
  begin
    if (DMSintegra.qu60RQuantidade.value > 0) and (DMSintegra.qu60RValorTotal.value > 0) then
    begin
      DET := '75';
      DET := DET + GetRegDate(FFirstDate);
      DET := DET + GetRegDate(FLastDate);
      DET := DET + Copy(DMSintegra.qu60RCodigoProduto.AsString + '              ', 1, 14); // 14 posicoes
      DET := DET + '        ';
      DET := DET + Copy(DMSintegra.qu60RProduto.AsString + '                                                              ',1,53);
      DET := DET + Copy(DMSintegra.qu60RUnidade.AsString + '      ', 1, 6);

      if (DMSintegra.qu60RCF.asString <> '000') and (DMSintegra.qu60RCF.asString <> '040') and (DMSintegra.qu60RCF.asString <> '090') then
          DET := DET + DMSintegra.qu60RCF.asString else
          DET := DET + '000';

      DET := DET + '00';

      if DMSintegra.qu60RCF.asString = '000' then
        DET := DET + FormatFloat('0000', DMSintegra.qu60RPercImposto.Value * 100);

      if DMSintegra.qu60RCF.asString = '040' then
        DET := DET + 'I   ';

      if DMSintegra.qu60RCF.asString = '090' then
        DET := DET + 'F   ';

      DET := DET + '000000';
      DET := DET + '000000000000';
      WriteLN(FTextFile, DET);

      if DMSintegra.Virtual_Produtos.FindKey([copy(DMSintegra.qu60RCodigoProduto.AsString + '                   ', 1, 20)]) = True then
           DMSintegra.Virtual_Produtos.Delete;

      FTotalReg75 := FTotalReg75 + 1;
    end;

    DMSintegra.qu60R.Next;
  end;

  DMSintegra.Virtual_Produtos.First;

  while not DMSintegra.Virtual_Produtos.Eof do
  begin
    DET := '75';
    DET := DET + GetRegDate(FFirstDate);
    DET := DET + GetRegDate(FLastDate);
    DET := DET + copy(DMSintegra.Virtual_ProdutosCodigoProduto.AsString + '              ', 1, 14); // 14 posicoes
    DET := DET + '        ';
    DET := DET + Copy(DMSintegra.Virtual_ProdutosDESCRICAO.AsString + '                                                              ',1,53);
    DET := DET + Copy(DMSintegra.Virtual_ProdutosUNIDADE.AsString + '      ', 1, 6);
    DET := DET + DMSintegra.Virtual_ProdutosCF.AsString;
    DET := DET + '00';

    if DMSintegra.Virtual_ProdutosCF.AsString = '000' then
      DET := DET + FormatFloat('0000', DMSintegra.Virtual_ProdutosAliquota.Value * 100);

    if DMSintegra.Virtual_ProdutosCF.AsString = '040' then
      DET := DET + 'I   ';

    if DMSintegra.Virtual_ProdutosCF.AsString = '090' then
      DET := DET + 'F   ';

    DET := DET + '000000';
    DET := DET + '0000000000';
    WriteLN(FTextFile, DET);

    FTotalReg75 := FTotalReg75 + 1;

    DMSintegra.Virtual_Produtos.Next;
  end;
end;

procedure TSintegra.GenerateReg90;
var
  DET: String;
begin
  // Totalizadores
  FTotalReg90 := FTotalReg50 + FTotalReg51 + FTotalReg54 + FTotalReg70 + FTotalReg60 + FTotalReg75 + 2 + 1;

  DET := '90';
  DET := DET + FCompanyCGC;
  DET := DET + FCompanyIE;
  DET := DET + '50' + FormatFloat('00000000', FTotalReg50);
  DET := DET + '51' + FormatFloat('00000000', FTotalReg51);
  DET := DET + '54' + FormatFloat('00000000', FTotalReg54);
  DET := DET + '60' + FormatFloat('00000000', FTotalReg60);
  DET := DET + '70' + FormatFloat('00000000', FTotalReg70);
  DET := DET + '75' + FormatFloat('00000000', FTotalReg75);
  DET := DET + '99' + FormatFloat('00000000', FTotalReg90) + '                         ' + '1';
  Writeln(FTextFile, DET);
end;

function TSintegra.GetRegDate(ADate: TDateTime): String;
var
  wDay, wMonth, wYear: Word;
begin
  DecodeDate(ADate, wYear, wMonth, wDay);
  Result := FormatFloat('0000', wYear) + FormatFloat('00', wMonth) + FormatFloat('00', wDay);
end;

procedure TSintegra.LoadCompanyProperties;
var
  i: Integer;
  sLetter: String;
begin
  FCompanyCGC := '';

  for i := 1 to Length(DMSintegra.qryEmpresaCGC.AsString) do
  begin
    sLetter := Copy(DMSintegra.qryEmpresaCGC.AsString, i, 1);
    if (sLetter = '1') or (sLetter = '2') or (sLetter = '3') or (sLetter = '4') or (sLetter = '5') or
       (sLetter = '6') or (sLetter = '7') or (sLetter = '8') or (sLetter = '9') or (sLetter = '0') then
      FCompanyCGC := FCompanyCGC + sLetter;
  end;

  FCompanyCGC := Copy(FCompanyCGC + '              ', 1, 14);

  FCompanyIE := '';

  for i := 1 to length(DMSintegra.qryEmpresaInscricaoEstadual.AsString) do
  begin
    sLetter := Copy(DMSintegra.qryEmpresaInscricaoEstadual.AsString, i, 1);
    if (sLetter = '1') or (sLetter = '2') or (sLetter = '3') or (sLetter = '4') or (sLetter = '5') or
       (sLetter = '6') or (sLetter = '7') or (sLetter = '8') or (sLetter = '9') or (sLetter = '0') then
      FCompanyIE := FCompanyIE + sLetter;
  end;

  if FCompanyIE = '' then
    FCompanyIE := '00000000000000';

  FCompanyIE := Copy(FCompanyIE + '              ', 1, 14);
end;

end.
