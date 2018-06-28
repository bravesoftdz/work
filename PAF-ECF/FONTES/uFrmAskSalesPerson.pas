unit uFrmAskSalesPerson;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, DBCtrls;

type
  TFrmAskSalesPerson = class(TFrmPai)
    btnOK: TButton;
    lbPrice: TLabel;
    cmbUser: TDBLookupComboBox;
    chcApplyAll: TCheckBox;
    lbUserCode: TLabel;
    edUserCode: TEdit;
    procedure cmbUserDropDown(Sender: TObject);
    procedure cmbUserCloseUp(Sender: TObject);
    procedure edUserCodeEnter(Sender: TObject);
    procedure edUserCodeExit(Sender: TObject);
    procedure edUserCodeKeyPress(Sender: TObject; var Key: Char);
  private
    FEnableRepeat : Boolean;
    function getUserByCode(Code:String):Boolean;
  public
    function Start(var IDUser, IDCommis, IDCommisType : Integer;
                   var ApplyAll : Boolean; EnableRepeat, KeepSalesPerson : Boolean;
                   var sUserName : String):Boolean;
  end;

implementation

uses UDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmAskSalesPerson }

function TFrmAskSalesPerson.Start(var IDUser, IDCommis, IDCommisType:Integer;
            var ApplyAll : Boolean; EnableRepeat, KeepSalesPerson : Boolean;
            var sUserName : String): Boolean;
begin
   cmbUser.KeyValue := IDUser;

   IDUser := -1;

   chcApplyAll.Visible := EnableRepeat;
   if EnableRepeat then
     chcApplyAll.Checked := KeepSalesPerson;

   try
     DM.FiltraCDS(DM.cdsSystemUser, DM.GetStoreUsersFilter(DM.cdsSystemUser));
     ShowModal;
     Result := (ModalResult = mrOK);
     Result := Result and DM.cdsSystemUser.Locate('IDUser', cmbUser.KeyValue, []);
     if Result then
        begin
        IDUser       := DM.cdsSystemUserIDUser.AsInteger;
        IDCommis     := DM.cdsSystemUserComissionID.AsInteger;
        IDCommisType := DM.cdsSystemUserIDTipoPessoa.AsInteger;
        sUserName    := DM.cdsSystemUserSystemUser.AsString;
        ApplyAll     := chcApplyAll.Checked;
        end;
   finally;
     DM.FiltraCDS(DM.cdsSystemUser, '');
     end;

end;
            
procedure TFrmAskSalesPerson.cmbUserDropDown(Sender: TObject);
begin
  inherited;
  btnOK.Default := False;
end;

procedure TFrmAskSalesPerson.cmbUserCloseUp(Sender: TObject);
begin
  inherited;
  btnOK.Default := True;
end;

function TFrmAskSalesPerson.getUserByCode(Code: String): Boolean;
begin

  if DM.cdsSystemUser.Locate('CodSystemUser', edUserCode.Text, []) then
  begin
    cmbUser.KeyValue := DM.cdsSystemUser.FieldByName('IDUser').AsInteger;
    btnOK.SetFocus;
    Result := True;
  end
  else
  begin
    MsgBox(MSG_INF_USE_NOT_FOUND, vbCritical + vbOkOnly);
    Result := False;
  end;

  edUserCode.Clear;

end;

procedure TFrmAskSalesPerson.edUserCodeEnter(Sender: TObject);
begin
  inherited;
  btnOK.Default := False;
end;

procedure TFrmAskSalesPerson.edUserCodeExit(Sender: TObject);
begin
  inherited;
  btnOK.Default := True;
  if edUserCode.Text <> '' then
    getUserByCode(edUserCode.Text);
end;

procedure TFrmAskSalesPerson.edUserCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    if (edUserCode.Text) = '' then
      ModalResult := mrOK
    else if getUserByCode(edUserCode.Text) then
      ModalResult := mrOK;
  end;
end;

end.
