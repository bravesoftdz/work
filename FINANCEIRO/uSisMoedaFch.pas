unit uSisMoedaFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, StdCtrls, DBCtrls, Mask, Db, FormConfig, DBTables,
  Buttons, ExtCtrls, Grids,
  BrowseConfig, ComCtrls, dxBar, uParentFchList, dxDBGrid, dxGrClms,
  dxCntner, dxTL, ImgList, dxDBCtrl, dxDBTLCl, ADODB, PowerADOQuery,
  siComp, siLangRT;

type
  TSisMoedaFch = class(TParentFchList)
    quFormIDMoeda: TIntegerField;
    quFormCodigoMoeda: TStringField;
    quFormMoeda: TStringField;
    quFormSigla: TStringField;
    quFormValorMoedaPadrao: TFloatField;
    quFormDataCotacao: TDateTimeField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    quFchBrwIDMoeda: TIntegerField;
    quFchBrwDataCotacao: TDateTimeField;
    quFchBrwValorMoedaPadrao: TFloatField;
    cbPadrao: TDBCheckBox;
    quFormMoedaPadrao: TBooleanField;
    quFchBrwIDMoedaCotacao: TIntegerField;
    Label25: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    grbFchBrwDataCotacao: TdxDBGridDateColumn;
    grbFchBrwValorMoedaPadrao: TdxDBGridMaskColumn;
    procedure FormShow(Sender: TObject);
    procedure cbPadraoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    Opening: Boolean;
    procedure UpdateMoedaPadrao;
  public
    { Public declarations }
  end;

implementation

uses uDM, uMsgBox, uSisMoedaCotacaoFch, uMsgConstant;

{$R *.DFM}


procedure TSisMoedaFch.FormShow(Sender: TObject);
begin
  inherited;
  UpdateMoedaPadrao;
end;

procedure TSisMoedaFch.UpdateMoedaPadrao;
begin
end;

procedure TSisMoedaFch.cbPadraoClick(Sender: TObject);
begin
  inherited;
  // confirma se o usuário sabe realmente o que esta fazendo
  if cbPadrao.Checked AND not Opening then
    begin
      if MsgBox(MSG_INF_CHANGE_CURRENCY_RECALC, vbQuestion + vbYesNo) = vbNo then
        begin
          quForm.Cancel;
        end;
    end;
end;

procedure TSisMoedaFch.FormCreate(Sender: TObject);
begin
  inherited;
  FchBrwForm := TSisMoedaCotacaoFch.Create(Self);

end;

procedure TSisMoedaFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormMoedaPadrao.AsBoolean := False;
end;

procedure TSisMoedaFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  Opening := True;
end;

procedure TSisMoedaFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Opening := False;

end;


Initialization
  RegisterClass(TSisMoedaFch);


end.
