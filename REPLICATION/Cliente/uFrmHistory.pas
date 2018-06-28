unit uFrmHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, siComp;

type
  TFrmHistory = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn2: TBitBtn;
    BtnSave: TBitBtn;
    memHistory: TMemo;
    BitBtn3: TBitBtn;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetHistory;
    procedure SetHistory;
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uMainConf, uDMClient;

{$R *.dfm}

procedure TFrmHistory.GetHistory;
begin
    if FileExists(DMClient.LocalPath+HISTORY_FILE) then
       memHistory.Lines.LoadFromFile(DMClient.LocalPath+HISTORY_FILE);

    memHistory.SelStart := 0;      
end;

procedure TFrmHistory.SetHistory;
begin
  memHistory.Lines.SaveToFile(DMClient.LocalPath+HISTORY_FILE);
end;

function TFrmHistory.Start:boolean;
begin

    GetHistory;

    ShowModal;

    Result := (ModalResult=mrOK);

    if Result then
       SetHistory;

end;

procedure TFrmHistory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFrmHistory.BitBtn3Click(Sender: TObject);
begin
  memHistory.Lines.Clear;
  BtnSave.Enabled := True;  
end;

end.
