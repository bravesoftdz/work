unit ModInfo;

{ $Log: }

interface

uses
{$IFDEF WIN32}
	Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
	SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TModInfoForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    NewInfoEdit: TEdit;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModInfoForm: TModInfoForm;

implementation

{$R *.DFM}


procedure TModInfoForm.FormActivate(Sender: TObject);
begin
  NewInfoEdit.SetFocus;
end;

end.
