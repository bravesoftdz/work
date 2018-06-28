unit uFrmExportItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB,
  ComCtrls;

type
  TFrmExportItems = class(TForm)
    pnlBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsLevel: TcxGridLevel;
    quItems: TADODataSet;
    dsItems: TDataSource;
    lbPath: TLabel;
    quItemsModelo: TStringField;
    quItemsDescricao: TStringField;
    quItemsUnidade: TStringField;
    quItemsCodTrib: TStringField;
    quItemsSellingPrice: TBCDField;
    quItemsIDModel: TIntegerField;
    grdItemsDBModelo: TcxGridDBColumn;
    grdItemsDBDescricao: TcxGridDBColumn;
    grdItemsDBUnidade: TcxGridDBColumn;
    grdItemsDBCodTrib: TcxGridDBColumn;
    grdItemsDBSellingPrice: TcxGridDBColumn;
    PB: TProgressBar;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FTextFile: TextFile;
    FFileName : String;

    procedure ExportarArquivo;
    procedure CriarItems;

    procedure OpenItems;
    procedure CloseItems;
  public
    procedure Start;
  end;


implementation

uses uFrmMain, uStringFunctions;

{$R *.dfm}

{ TFrmExportItems }

procedure TFrmExportItems.Start;
begin
  ShowModal;
end;

procedure TFrmExportItems.btnCancelClick(Sender: TObject);
begin
  Close;
  CloseItems;
end;

procedure TFrmExportItems.btnOkClick(Sender: TObject);
begin
  try
    ExportarArquivo;
    MessageDlg('Arquivo exportado com sucesso!', mtInformation, [mbOK], 0);
  except
    MessageDlg('Erro ao exportar arquivo.', mtError, [mbOK], 0);
  end;
end;

procedure TFrmExportItems.FormShow(Sender: TObject);
var
  sFilePath: String;
begin

  sFilePath := FrmMain.GetAppProperty('Default', 'FilePath');

  if sFilePath = '' then
  begin
    MessageDlg('O caminho para o arquivo não foi configurado!', mtInformation, [mbOK], 0);
    Close;
  end;

  FFileName := ExtractFileDir(sFilePath) + '\PRODUTO.GSS';

  lbPath.Caption := 'Criar arquivo em: ' + FFileName;

  try
    Cursor := crHourGlass;
    OpenItems;
  finally
    Cursor := crDefault;
    end;

end;

procedure TFrmExportItems.ExportarArquivo;
begin

  try
    AssignFile(FTextFile, FFileName);
    Rewrite(FTextFile);
    CriarItems;
  finally
    CloseFile(FTextFile);
  end;


end;

procedure TFrmExportItems.CloseItems;
begin
  with quItems do
    if Active then
      Close;
end;

procedure TFrmExportItems.OpenItems;
begin
  with quItems do
    if not Active then
      Open;
end;

procedure TFrmExportItems.CriarItems;
var
  sLinha : String;
begin

  try
    PB.Visible := True;
    with quItems do
    begin
      DisableControls;
      PB.Max := RecordCount;
      PB.Position := 1;
      First;
      while not Eof do
      begin
        if FieldByName('CodTrib').AsString <> '' then
        begin
          sLinha := AE(FieldByName('Modelo').AsString, 20);
          sLinha := sLinha + AE(FieldByName('Modelo').AsString, 16);
          sLinha := sLinha + AE(FieldByName('Descricao').AsString, 40);
          sLinha := sLinha + AE(FieldByName('Descricao').AsString, 39);
          sLinha := sLinha + '00000001'; //Seção
          sLinha := sLinha + AE(FieldByName('CodTrib').AsString, 3); //COD TRIB;
          sLinha := sLinha + Replace(Replace(FormatFloat('000000000000.00', FieldByName('SellingPrice').AsFloat), ',', ''), '.', '');
          sLinha := sLinha + FieldByName('Unidade').AsString;
          Writeln(FTextFile, sLinha);
        end;
        Next;
        PB.StepIt;
      end;
      EnableControls;
      First;
    end;
  finally
    PB.Visible := False;
  end;

end;

end.
