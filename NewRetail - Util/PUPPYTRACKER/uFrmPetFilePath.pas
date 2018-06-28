unit uFrmPetFilePath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmPetFilePath = class(TForm)
    edtPuppyFile: TEdit;
    Label1: TLabel;
    btnOpenFile: TSpeedButton;
    OP: TOpenDialog;
    Label2: TLabel;
    edtPuppyExeRepFile: TEdit;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    edtNumCop: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OP2: TOpenDialog;
    Label4: TLabel;
    cbxExeRepVer: TComboBox;
    chDebug: TCheckBox;
    chSaveSerialNum: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOpenFileClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function Start:Boolean;
  end;

var
  FrmPetFilePath: TFrmPetFilePath;

implementation

uses uDM;

{$R *.dfm}

procedure TFrmPetFilePath.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmPetFilePath.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmPetFilePath.Start: Boolean;
begin
  edtPuppyFile.Text       := DM.PetFile;
  edtPuppyExeRepFile.Text := DM.PetExeRepFile;
  edtNumCop.Text          := DM.PetNumCop;
  cbxExeRepVer.ItemIndex  := DM.PetRepExeVer - 1;
  chDebug.Checked         := DM.UseDebug;
  chSaveSerialNum.Checked := DM.SaveSerialNum;

  ShowModal;

  Result := (ModalResult = mrOK);

   If Result then
      begin
      DM.PetFile       := edtPuppyFile.Text;
      DM.PetExeRepFile := edtPuppyExeRepFile.Text;
      DM.PetNumCop     := edtNumCop.Text;
      DM.PetRepExeVer  := cbxExeRepVer.ItemIndex + 1;
      DM.UseDebug      := chDebug.Checked;
      DM.SaveSerialNum := chSaveSerialNum.Checked
      end;

end;

procedure TFrmPetFilePath.btnOpenFileClick(Sender: TObject);
begin
  with OP do
    if Execute then
       edtPuppyFile.Text := FileName;
end;

procedure TFrmPetFilePath.SpeedButton1Click(Sender: TObject);
begin
  with OP2 do
    if Execute then
       edtPuppyExeRepFile.Text := FileName;
end;

end.
