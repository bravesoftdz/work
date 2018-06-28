unit SplasPdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls;

type
  TSplashPadrao = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    LabelSis: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Progress: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    procedure SetMaxForm(Value : Integer);
  public
    procedure Step;
  property
    MaxForms : Integer write SetMaxForm;
  end;

var
  SplashPadrao: TSplashPadrao;

implementation

{$R *.DFM}

procedure TSplashPadrao.Step;
begin
     Progress.StepIt;
end;

procedure TSplashPadrao.SetMaxForm(Value : Integer);
begin
     Progress.Max := Value;
end;

procedure TSplashPadrao.FormCreate(Sender: TObject);
begin
     LabelSis.Caption := Application.Title;
end;

end.
