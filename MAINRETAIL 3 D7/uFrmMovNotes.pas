unit uFrmMovNotes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, DBCtrls, LblEffct, ExtCtrls, siComp, siLangRT;

type
  TFrmMovNotes = class(TFrmParent)
    mmNotes: TMemo;
    edtReason: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(IDInventoryMov: integer);
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}


procedure TFrmMovNotes.Start(IDInventoryMov: integer);
begin
  with DM.quFreeSQL do
    begin
      Close;
      SQL.Text := 'SELECT IMC.Notes, IMR.Reason FROM Inv_MovComplement IMC  ' +
                  'JOIN Inv_MovReason IMR ON (IMR.IDMovReason = IMC.IDMovReason) WHERE IMC.IDInventoryMov = ' + IntToStr(IDInventoryMov);
      Open;
      mmNotes.Text   := Fields[0].AsString;
      edtReason.Text := Fields[1].AsString;
      Close;
    end;
  ShowModal;
end;

end.
