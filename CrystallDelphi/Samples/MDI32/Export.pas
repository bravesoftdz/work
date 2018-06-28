unit Export;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe;

type
  TExportForm = class(TForm)
    RGExportType: TRadioGroup;
    ChkProgressDialog: TCheckBox;
    Crpe1: TCrpe;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    procedure ChkProgressDialogClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportForm: TExportForm;

implementation

{$R *.DFM}

procedure TExportForm.ChkProgressDialogClick(Sender: TObject);
begin
   If ChkProgressDialog.Checked then
      Crpe1.ProgressDialog := True
   else
      Crpe1.ProgressDialog := False;
end;

end.
