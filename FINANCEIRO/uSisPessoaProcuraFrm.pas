unit uSisPessoaProcuraFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, ExtCtrls, Db, DBTables, StdCtrls, Buttons, 
  Grids,uParentDialogFrm,
  dxDBGrid, dxCntner, dxTL, dxDBCtrl, ADODB, siComp, siLangRT;

type
  TSisPessoaProcuraFrm = class(TParentDialogFrm)
    Image1: TImage;
    lblTitulo: TLabel;
    editProcura: TEdit;
    Label2: TLabel;
    btProcuraCliente: TBitBtn;
    grdResultado: TdxDBGrid;
    quResult: TADOQuery;
    dsResult: TDataSource;
    lblResult: TLabel;
    quResultIDPessoa: TIntegerField;
    cmbField: TComboBox;
    grdResultadoCodigoPessoa: TdxDBGridMaskColumn;
    grdResultadoPessoa: TdxDBGridMaskColumn;
    quResultCode: TIntegerField;
    quResultPessoa: TStringField;
    procedure btProcuraClienteClick(Sender: TObject);
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure grdResultadoDblClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(IDTipoPessoa: Integer): Integer;
  end;

implementation

uses uDM;

{$R *.DFM}

function TSisPessoaProcuraFrm.Start(IDTipoPessoa: Integer): Integer;
begin

  quResult.Parameters.ParamByName('IDTipoPessoa').Value := IDTipoPessoa;

  cmbField.ItemIndex := 0;

  lblTitulo.Caption := DM.DescCodigo(['IDTipoPessoa'], [IntToStr(IDTipoPessoa)], 'TipoPessoa', 'TipoPessoa') + ' finder';

  if (ShowModal = mrOk) then
    result := quResultIDPessoa.AsInteger
  else
    result := -1;

end;



procedure TSisPessoaProcuraFrm.btProcuraClienteClick(Sender: TObject);
begin
  inherited;
  with quResult do
    begin
      if Active then
        Close;
      Parameters.ParamByName('CampoIndex').Value := cmbField.ItemIndex;
      Parameters.ParamByName('Procura').Value := '%' + Trim(editProcura.text) + '%';
      Open;
    end;

end;

procedure TSisPessoaProcuraFrm.dsResultDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  with quResult do
    begin
      btOk.Enabled := ACTIVE AND (NOT (EOF AND BOF));
      lblResult.Caption := IntToStr(RecordCount) + ' Pessoa(s) encontrada(s).';
    end;

end;


procedure TSisPessoaProcuraFrm.grdResultadoDblClick(Sender: TObject);
begin
  inherited;
  if btOk.Enabled then
    btOkClick(nil);
end;

procedure TSisPessoaProcuraFrm.btOkClick(Sender: TObject);
begin
  inherited;
  if quResultIDPessoa.AsString = '' then
    ModalResult := mrNone
  else
    ModalResult := mrOk;

end;

end.
