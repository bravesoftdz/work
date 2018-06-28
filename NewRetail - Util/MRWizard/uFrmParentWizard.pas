unit uFrmParentWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, uDMExport;

type
  TFrmParentWizard = class(TForm)
    pnlBotton: TPanel;
    imgBotton: TImage;
    pnlTop: TPanel;
    imgTopRight: TImage;
    imgTop: TImage;
    pgWizard: TPageControl;
    tsIntro: TTabSheet;
    lbInfo: TLabel;
    btnClose: TBitBtn;
    btnNext: TBitBtn;
    btnPrior: TBitBtn;
    tsFinish: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    procedure Init;
    procedure MovNext;
    procedure MovPrior;
  protected
    procedure OnMovePriorPage; virtual;
    procedure OnMoveNextPage; virtual;
    procedure Finish; virtual;
    function ValidatePage : Boolean; virtual;
  public
    procedure Start; virtual;
  end;

implementation

{$R *.dfm}

{ TFrmParentWizard }

procedure TFrmParentWizard.Finish;
begin

end;

procedure TFrmParentWizard.Init;
begin
  btnPrior.Visible := False;
  pgWizard.ActivePage := tsIntro;
  pgWizard.Top := -3;
  pgWizard.Left := -3;
  lbInfo.Caption := pgWizard.ActivePage.Caption;
  Application.ProcessMessages;
end;

procedure TFrmParentWizard.MovNext;
begin
  if pgWizard.ActivePageIndex < (pgWizard.PageCount-1) then
  begin
    btnPrior.Visible := True;
    if ValidatePage then
      pgWizard.ActivePageIndex := pgWizard.ActivePageIndex + 1;
  end
  else
    Finish;

  OnMoveNextPage;
  lbInfo.Caption := pgWizard.ActivePage.Hint;
  Application.ProcessMessages;
    
end;

procedure TFrmParentWizard.MovPrior;
begin
  if pgWizard.ActivePageIndex > 0 then
    pgWizard.ActivePageIndex := pgWizard.ActivePageIndex - 1;

  btnPrior.Visible := (pgWizard.ActivePageIndex > 0);
  OnMovePriorPage;

  lbInfo.Caption := pgWizard.ActivePage.Hint;
  Application.ProcessMessages;
end;

procedure TFrmParentWizard.Start;
begin
  Init;
  ShowModal;
end;

procedure TFrmParentWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmParentWizard.ValidatePage: Boolean;
begin
  Result := True;
end;

procedure TFrmParentWizard.btnNextClick(Sender: TObject);
begin
  MovNext;
end;

procedure TFrmParentWizard.btnPriorClick(Sender: TObject);
begin
  MovPrior;
end;

procedure TFrmParentWizard.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmParentWizard.OnMoveNextPage;
begin

end;

procedure TFrmParentWizard.OnMovePriorPage;
begin

end;


end.
