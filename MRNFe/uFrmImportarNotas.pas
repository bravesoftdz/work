unit uFrmImportarNotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls;

type
  TFrmImportarNotas = class(TForm)
    pb: TProgressBar;
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FOrigem : String;
    FDataIni, FDataEnd : TDateTime;

    procedure ImportVendas;
    procedure ImportarTransferencias;
  public
    function Start(AOrigem : String; ADataIni, ADataEnd : TDateTime) : Boolean;
  end;

implementation

uses udmSQL, ADODB, DB;

{$R *.dfm}

{ TFrmImportarNotas }

procedure TFrmImportarNotas.ImportVendas;
begin
  with dmSQL.dsImportarVendas do
  Try
    if Active then
      Close;
    Parameters.ParamByName('DataIni').Value := FDataIni;
    Parameters.ParamByName('DataFim').Value := (FDataEnd+1);
    Open;
    if not IsEmpty then
    begin
      pb.Position := 0;
      pb.Max      := RecordCount;
      First;
      while not EOF do
      begin
        Application.ProcessMessages;
        dmSQL.InserirMovimento(FOrigem, FieldByName('IDInvoice').AsInteger);
        pb.StepIt;
        Next;
      end;
    end;
  finally
    Close;
  end;
end;

function TFrmImportarNotas.Start(AOrigem: String; ADataIni,
  ADataEnd : TDateTime): Boolean;
begin
  FOrigem  := AOrigem;
  FDataIni := ADataIni;
  FDataEnd := ADataEnd;
  Caption := 'Importando ' + AOrigem + 's...';
  ShowModal;
  Result := True;
end;

procedure TFrmImportarNotas.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;

  if FOrigem = 'Venda' then
    ImportVendas
  else if FOrigem = 'Transferencia' then
    ImportarTransferencias;

  Close;
end;

procedure TFrmImportarNotas.FormShow(Sender: TObject);
begin
  Timer.Enabled := True;
end;

procedure TFrmImportarNotas.ImportarTransferencias;
begin
  with dmSQL.dsImportarTransferencia do
  Try
    if Active then
      Close;
    Parameters.ParamByName('DataIni').Value := FDataIni;
    Parameters.ParamByName('DataFim').Value := (FDataEnd+1);
    Open;
    if not IsEmpty then
    begin
      pb.Position := 0;
      pb.Max      := RecordCount;
      First;
      while not EOF do
      begin
        Application.ProcessMessages;
        dmSQL.InserirMovimento(FOrigem, FieldByName('IDModelTransf').AsInteger);
        pb.StepIt;
        Next;
      end;
    end;
  finally
    Close;
  end;
end;

end.
