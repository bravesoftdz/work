unit uNewSerial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DB, DBTables, PaiDeForms,
  Grids, Buttons, LblEffct, ADODB, SuperComboADO, siComp, siLangRT;

type
  TNewSerial = class(TFrmParentForms)
    Panel1: TPanel;
    //Panel9: TPanel;
    Panel3: TPanel;
    quInsertSerial: TADOQuery;
    editSerial: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    scStore: TSuperComboADO;
    btOK: TButton;
    btCancel: TButton;
    Panel2: TPanel;
    Image3: TImage;
    Image1: TImage;
    imgTopIni: TImage;
    lbSubMenu: TLabelEffect;
    EspacamentoSuperior: TPanel;
    EEE: TPanel;
    pnlAutoInc: TPanel;
    Image2: TImage;
    btLoopInc: TSpeedButton;
    lblModified: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    MyIDModel,
    MyIDStore : Integer;
    MySerial  : String;
    IsUpdate  : Boolean;
  public
    { Public declarations }
    function Start(IDModel: Integer): boolean;
    function Update(IDModel, IDStore : Integer; Serial : String) : boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

function TNewSerial.Start(IDModel: Integer): boolean;
begin
  MyIDModel := IDModel;
  IsUpdate  := False;
  scStore.LookUpValue := IntToStr(DM.fStore.ID);
  Result    := (ShowModal = mrOk);
end;

function TNewSerial.Update(IDModel, IDStore : Integer; Serial : String) : boolean;
begin
  IsUpdate            := True;
  MyIDModel           := IDModel;
  MyIDStore           := IDStore;
  MySerial            := Serial;
  scStore.LookUpValue := IntToStr(IDStore);
  editSerial.Text     := Serial;
  Result              := (ShowModal = mrOk);
end;


procedure TNewSerial.btOKClick(Sender: TObject);
begin
  ModalResult := mrNone;

  if Length(editSerial.Text) > 30 then
  begin
    MsgBox(MSG_CRT_SERIAL_GREATER_THEN_30, vbOKOnly + vbCritical);
    Exit;
  end;

  if Trim(editSerial.Text) = '' then
  begin
    editSerial.SetFocus;
    MsgBox(MSG_CRT_NO_SERIALNUMBER, vbCritical + vbOkOnly);
    Exit;
  end;

  if Trim(scStore.LookUpValue) = '' then
  begin
    scStore.SetFocus;
    MsgBox(MSG_CRT_NO_STORE_SELECTED, vbCritical + vbOkOnly);
    Exit;
  end;

  with quInsertSerial do
  begin
   Parameters.ParamByName('IDModel').Value      := MyIDModel;
   Parameters.ParamByName('IDStore').Value      := StrToInt(scStore.LookUpValue);
   Parameters.ParamByName('SerialNumber').Value := editSerial.Text;
  try
    DM.ADODBConnect.BeginTrans;

    if isUpdate then
       DM.RunSQL( 'DELETE InventorySerial WHERE ModelID = ' + IntToStr(MyIDModel) +
                  ' AND StoreID = ' + IntToStr(MyIDStore) +
                  ' AND Serial = ' + QuotedStr(MySerial));

    ExecSQL;

    DM.ADODBConnect.CommitTrans;
  except
    DM.ADODBConnect.RollbackTrans;
    MsgBox(MSG_CRT_SERIALNUMBER_INV, vbCritical + vbOkOnly);
    Exit;
    end;
  end;


  if not (btLoopInc.Down) then
    ModalResult := mrOk;

  editSerial.Clear;
  editSerial.SetFocus;

end;

procedure TNewSerial.btCancelClick(Sender: TObject);
begin
  if btLoopInc.Down then
     ModalResult := mrOk
  else
     ModalResult := mrCancel;
end;

procedure TNewSerial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TNewSerial.FormShow(Sender: TObject);
begin
   inherited;
   editSerial.SetFocus;
end;

end.
