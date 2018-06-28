unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmMain = class(TForm)
    BitBtn1: TBitBtn;
    pnlBotton: TPanel;
    imgBotton: TImage;
    btnClose: TBitBtn;
    btnInit: TBitBtn;
    rbPortuguesBR: TRadioButton;
    imgBR: TImage;
    lbBR: TLabel;
    rbUSA: TRadioButton;
    imgUSA: TImage;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure rbUSAClick(Sender: TObject);
    procedure rbPortuguesBRClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uWzdPortugueseBR, uFrmParentWizard, uFrmCreateModel, uDMExport,
     uWzdEnglish, uWzdPetCenter;

{$R *.dfm}

procedure TFrmMain.BitBtn1Click(Sender: TObject);
begin
  with TFrmCreateModel.Create(Self) do
    Start;
end;

procedure TFrmMain.btnInitClick(Sender: TObject);
begin


  if rbPortuguesBR.Checked then
  begin
    DMExport.IDLanguage := 2;
    with TWzdPortugueseBR.Create(Self) do
      Start;
  end else if rbUSA.Checked then
  begin
    DMExport.IDLanguage := 1;
    with TWzdEnglish.Create(Self) do
      Start;
  end;

  Close;
      
end;

procedure TFrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.rbUSAClick(Sender: TObject);
begin
  btnInit.Caption := '&Start';
  btnClose.Caption := '&Exit';
end;

procedure TFrmMain.rbPortuguesBRClick(Sender: TObject);
begin
  btnInit.Caption := 'I&niciar';
  btnClose.Caption := '&Sair';
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin

  if ((ParamCount > 0) and (ParamStr(1) = 'PET')) or (DMExport.CheckPetWrdFile) then
  begin
    with TWzdPetCenter.Create(Self) do
      Start;
    Close;
  end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  DMExport.IDLanguage := 1;
end;

end.
