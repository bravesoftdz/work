unit uFchMovDocument;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, StdCtrls, DBCtrls, DB, Mask, FormConfig, ADODB,
  PowerADOQuery, siComp, siLangRT, Buttons, LblEffct, ExtCtrls, DateBox,
  SuperComboADO;

type
  TFchMovDocument = class(TbrwFrmParent)
    edtDocumentNumber: TDBEdit;
    quFormIDMovDocument: TIntegerField;
    quFormDocumentNumber: TStringField;
    quFormDocumentDate: TDateTimeField;
    quFormDocumentStatus: TIntegerField;
    quFormIDDocumentType: TIntegerField;
    quFormIDInventoryMov: TIntegerField;
    quFormOBS: TStringField;
    lblDocumentNumber: TLabel;
    lblDocumentDate: TLabel;
    lblDocumentStatus: TLabel;
    lblDocumentType: TLabel;
    lblDocumentOBS: TLabel;
    mmOBS: TDBMemo;
    scDocumentType: TDBSuperComboADO;
    dbxDocumentDate: TDBDateBox;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    quFormIDPreInventoryMov: TIntegerField;
    cbxDocumentStatus: TComboBox;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure cbxDocumentStatusSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uParamFunctions;

{$R *.dfm}

procedure TFchMovDocument.quFormNewRecord(DataSet: TDataSet);
var
  sIDPreInventoryMov: String;
begin
  inherited;
  sIDPreInventoryMov := ParseParam(sParam, 'IDPreInventoryMov');

  quFormDocumentDate.AsDateTime := Now;

  if sIDPreInventoryMov <> '' then
    quFormIDPreInventoryMov.AsInteger := StrToInt(sIDPreInventoryMov);
end;

procedure TFchMovDocument.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quFormDocumentStatus.AsInteger := cbxDocumentStatus.ItemIndex+1;
end;

procedure TFchMovDocument.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cbxDocumentStatus.ItemIndex := quFormDocumentStatus.AsInteger-1;
end;

procedure TFchMovDocument.cbxDocumentStatusSelect(Sender: TObject);
begin
  inherited;
  if not (quForm.State in dsEditModes) then
    quForm.Edit;
end;

end.
