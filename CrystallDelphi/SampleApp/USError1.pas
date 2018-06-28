unit USError1;

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  ExtCtrls;

type
  TCrpeLoadErrorDlg = class(TForm)
    pnlLoadError: TPanel;
    lblReportFile: TLabel;
    lblLoadAnother: TLabel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CrpeLoadErrorDlg: TCrpeLoadErrorDlg;

implementation

{$R *.DFM}

procedure TCrpeLoadErrorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;

end.
