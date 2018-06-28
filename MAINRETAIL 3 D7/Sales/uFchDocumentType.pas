unit uFchDocumentType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, DB, StdCtrls, Mask, DBCtrls, FormConfig, ADODB,
  PowerADOQuery, siComp, siLangRT, Buttons, LblEffct, ExtCtrls;

type
  TFchDocumentType = class(TbrwFrmParent)
    edtDocument: TDBEdit;
    quFormIDDocumentType: TIntegerField;
    quFormDocumentType: TStringField;
    Label5: TLabel;
    lblDescription: TLabel;
    chkDefault: TDBCheckBox;
    quFormDefaultType: TBooleanField;
    procedure quFormBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.dfm}

procedure TFchDocumentType.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('UPDATE Mnt_DocumentType SET DefaultType = 0 WHERE DefaultType = 1');
    ExecSQL;
  finally
    Close;
  end;
end;

end.
