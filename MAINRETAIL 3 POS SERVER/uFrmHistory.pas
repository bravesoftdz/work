unit uFrmHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, siComp;

const
  HIST_TRANSACTION = 0;
  HIST_ERROR       = 1;
  HIST_IMPORT      = 2;

type
  TFrmHistory = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    memHistory: TMemo;
    siLang: TsiLang;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    BtnSave: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    cbxHistory: TComboBox;
    btnEmail: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure cbxHistoryChange(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetHistory(iType:Integer);
    procedure SetHistory(iType:Integer);
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uMainConf, uPOSServerConsts;

{$R *.dfm}

procedure TFrmHistory.GetHistory(iType:Integer);
var
  sHistoryFile : String;
  sPath: String;
begin

  sPath := ExtractFileDir(Application.ExeName) + '\';

  case iType of
   HIST_TRANSACTION : sHistoryFile := sPath + HISTORY_FILE;
   HIST_ERROR       : sHistoryFile := sPath + ERROR_FILE;
   HIST_IMPORT      : sHistoryFile := sPath + IMPORT_FILE;
  end;

  memHistory.Lines.Clear;

  if FileExists(sHistoryFile) then
   memHistory.Lines.LoadFromFile(sHistoryFile);

  btnEmail.Enabled := (Trim(memHistory.Lines.Text) <> '');

  memHistory.SelStart := 0;

end;

procedure TFrmHistory.SetHistory(iType:Integer);
var
  sPath: String;
begin
   sPath := ExtractFileDir(Application.ExeName) + '\';
   case iType of
     HIST_TRANSACTION : memHistory.Lines.SaveToFile(sPath + HISTORY_FILE);
     HIST_ERROR       : memHistory.Lines.SaveToFile(sPath + ERROR_FILE);
     HIST_IMPORT      : memHistory.Lines.SaveToFile(sPath + IMPORT_FILE);
   end;
end;

function TFrmHistory.Start:boolean;
begin

    GetHistory(HIST_TRANSACTION);

    ShowModal;

    Result := (ModalResult=mrOK);

    if Result then
       SetHistory(cbxHistory.ItemIndex);

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

procedure TFrmHistory.cbxHistoryChange(Sender: TObject);
begin
 GetHistory(cbxHistory.ItemIndex);
end;

procedure TFrmHistory.btnEmailClick(Sender: TObject);
begin
 with FrmMain.Email do
  begin
    Recipients.Text := 'suporte@mainretai.com';
    FromName        := FrmMain.fIniConfig.ReadString('Local','Customer', '');
    Subject         := cbxHistory.Items.Text;
    Body            := memHistory.Lines.Text;
    //Mostra o Email
    ShowDialog := True;
    SendMail;
  end;
end;

end.
