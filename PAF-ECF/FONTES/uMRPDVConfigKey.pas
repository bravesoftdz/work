unit uMRPDVConfigKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, uParentAll, siComp, siLangRT;

const
  FUNC_NONE                 = 0;
  FUNC_SEARCH_OPTION        = 1;
  FUNC_ADD_CUSTOMER         = 2;
  FUNC_FINALIZE_SALE        = 3;
  FUNC_CREATE_NEW_SALE      = 4;
  FUNC_OPEN_HOLD            = 5;
  FUNC_ADD_OBSERVATION      = 6;
  FUNC_DEL_ITEM             = 7;
  FUNC_HELP                 = 8;
  FUNC_APPLY_HOLD_DISCOUNT  = 9;
  FUNC_EXIT                 = 10;
  FUNC_CALL_PAYMENT_TYPES   = 11;
  FUNC_CHANGE_USER          = 12;
  FUNC_VIEW_INVENTORY       = 13;
  FUNC_CREATE_NEW_REFUND    = 14;
  FUNC_NO_SALE              = 15;
  FUNC_ITEM_DISCOUNT        = 16;
  FUNC_TEF                  = 17;
  FUNC_SALE                 = 18;

type
  TFrmMRDPVConfigKey = class(TFrmParentAll)
    lbF2: TLabel;
    lbF3: TLabel;
    lbF4: TLabel;
    lbF5: TLabel;
    lbF6: TLabel;
    lbF7: TLabel;
    pnlFunction: TPanel;
    cbxFunction: TComboBox;
    btSave: TBitBtn;
    pnlF2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    pnlF3: TPanel;
    Image2: TImage;
    Label2: TLabel;
    pnlF4: TPanel;
    Image3: TImage;
    Label3: TLabel;
    pnlF5: TPanel;
    Image4: TImage;
    Label6: TLabel;
    pnlF6: TPanel;
    Image5: TImage;
    Label7: TLabel;
    pnlF7: TPanel;
    Image6: TImage;
    Label4: TLabel;
    pnlF8: TPanel;
    Image7: TImage;
    Label5: TLabel;
    lbF8: TLabel;
    pnlF9: TPanel;
    Image8: TImage;
    Label8: TLabel;
    lbF9: TLabel;
    pnlF10: TPanel;
    Image9: TImage;
    Label9: TLabel;
    lbF10: TLabel;
    pnlF11: TPanel;
    Image10: TImage;
    Label10: TLabel;
    lbF11: TLabel;
    pnlF12: TPanel;
    Image11: TImage;
    Label11: TLabel;
    lbF12: TLabel;
    lbPgUp: TLabel;
    pnlPgUp: TPanel;
    Image12: TImage;
    Label13: TLabel;
    lbPgDn: TLabel;
    PnlPgDn: TPanel;
    Image13: TImage;
    label14: TLabel;
    lbIns: TLabel;
    pnlIns: TPanel;
    Image14: TImage;
    Label15: TLabel;
    lbDel: TLabel;
    pnlDel: TPanel;
    Image15: TImage;
    Label16: TLabel;
    lbF1: TLabel;
    pnlF1: TPanel;
    Image16: TImage;
    Label17: TLabel;
    lbEnd: TLabel;
    pnlEnd: TPanel;
    Image17: TImage;
    Label18: TLabel;
    lbHome: TLabel;
    pnlHome: TPanel;
    Image18: TImage;
    Label19: TLabel;
    lbApplyDiscount: TLabel;
    lbApplyDiscountPerExp: TLabel;
    lbChangeSearch: TLabel;
    lbSearchDetail: TLabel;
    pnlAdd: TPanel;
    Image19: TImage;
    Label12: TLabel;
    lbAdd: TLabel;
    spHelp: TSpeedButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSaveClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
  private
    fHelpMode : Boolean;
    fKey : Word;
    procedure LoadFunctions;
  public
    procedure Start;
    procedure StartHelp;
  end;

var
  FrmMRDPVConfigKey: TFrmMRDPVConfigKey;

implementation

uses uDM;

{$R *.dfm}

procedure TFrmMRDPVConfigKey.Start;
begin
  LoadFunctions;
  ShowModal;
end;

procedure TFrmMRDPVConfigKey.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 bSelection : Boolean;
begin

  bSelection := False;

  case key of
  VK_ESCAPE
        : Close;

  VK_F1 : begin
          pnlFunction.Top  := (lbF1.Top-10);
          pnlFunction.Left := lbF1.Left;
          bSelection       := True;
          end;
  VK_F2 : begin
          pnlFunction.Top  := (lbF2.Top-10);
          pnlFunction.Left := lbF2.Left;
          bSelection       := True;
          end;
  VK_F3 : begin
          pnlFunction.Top  := (lbF3.Top-10);
          pnlFunction.Left := lbF3.Left;
          bSelection       := True;
          end;
  VK_F4 : begin
          pnlFunction.Top  := (lbF4.Top-10);
          pnlFunction.Left := lbF4.Left;
          bSelection       := True;
          end;
  VK_F5 : begin
          pnlFunction.Top  := (lbF5.Top-10);
          pnlFunction.Left := lbF5.Left;
          bSelection       := True;
          end;
  VK_F6 : begin
          pnlFunction.Top  := (lbF6.Top-10);
          pnlFunction.Left := lbF6.Left;
          bSelection       := True;
          end;
  VK_F7 : begin
          pnlFunction.Top  := (lbF7.Top-10);
          pnlFunction.Left := lbF7.Left;
          bSelection       := True;
          end;
  VK_F8 : begin
          pnlFunction.Top  := (lbF8.Top-10);
          pnlFunction.Left := lbF8.Left;
          bSelection       := True;
          end;
  VK_F9 : begin
          pnlFunction.Top  := (lbF9.Top-10);
          pnlFunction.Left := lbF9.Left;
          bSelection       := True;
          end;
  VK_F10: begin
          pnlFunction.Top  := (lbF10.Top-10);
          pnlFunction.Left := lbF10.Left;
          bSelection       := True;
          end;
  VK_F11: begin
          pnlFunction.Top  := (lbF11.Top-10);
          pnlFunction.Left := lbF11.Left;
          bSelection       := True;
          end;
  VK_F12: begin
          pnlFunction.Top  := (lbF12.Top-10);
          pnlFunction.Left := lbF12.Left;
          bSelection       := True;
          end;
  VK_PRIOR: begin
          pnlFunction.Top  := (lbPgUp.Top-10);
          pnlFunction.Left := lbPgUp.Left;
          bSelection       := True;
          end;
  VK_NEXT: begin
          pnlFunction.Top  := (lbPgDn.Top-10);
          pnlFunction.Left := lbPgDn.Left;
          bSelection       := True;
          end;
  VK_INSERT: begin
          pnlFunction.Top  := (lbIns.Top-10);
          pnlFunction.Left := lbIns.Left;
          bSelection       := True;
          end;
  VK_DELETE: begin
          pnlFunction.Top  := (lbDel.Top-10);
          pnlFunction.Left := lbDel.Left;
          bSelection       := True;
          end;
  VK_END: begin
          pnlFunction.Top  := (lbEnd.Top-10);
          pnlFunction.Left := lbEnd.Left;
          bSelection       := True;
          end;
  VK_HOME: begin
          pnlFunction.Top  := (lbHome.Top-10);
          pnlFunction.Left := lbHome.Left;
          bSelection       := True;
          end;
  {
  VK_ADD: begin
          pnlFunction.Top  := (lbAdd.Top-10);
          pnlFunction.Left := lbAdd.Left;
          bSelection       := True;
          end;
  }
  end;

  if fHelpMode then
     bSelection := False;

  if bSelection then
     begin
     cbxFunction.ItemIndex := DM.GetFunction(Key);
     pnlFunction.Visible   := True;
     fKey                  := Key;
     if cbxFunction.CanFocus  then
        cbxFunction.SetFocus;
     end;

end;

procedure TFrmMRDPVConfigKey.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmMRDPVConfigKey.btSaveClick(Sender: TObject);
begin
  DM.SetFunction(fKey, cbxFunction.ItemIndex);
  pnlFunction.Visible := False;
  LoadFunctions;
end;

procedure TFrmMRDPVConfigKey.LoadFunctions;
var
 i : integer;
 fValues : TStringList;
begin

  try

    fValues := TStringList.Create;

    DM.fKeyFunctionFile.ReadSection('Keys',fValues);

    if fHelpMode then
       begin
       lbF1.Visible   := False;
       pnlF1.Visible  := False;
       pnlF2.Visible  := False;
       lbF2.Visible   := False;
       pnlF3.Visible  := False;
       lbF3.Visible   := False;
       pnlF4.Visible  := False;
       lbF4.Visible   := False;
       pnlF5.Visible  := False;
       lbF5.Visible   := False;
       pnlF6.Visible  := False;
       lbF6.Visible   := False;
       pnlF7.Visible  := False;
       lbF7.Visible   := False;
       pnlF8.Visible  := False;
       lbF8.Visible   := False;
       lbF9.Visible   := False;
       pnlF9.Visible  := False;
       lbF10.Visible  := False;
       pnlF10.Visible := False;
       lbF11.Visible  := False;
       pnlF11.Visible := False;
       lbF12.Visible  := False;
       pnlF12.Visible := False;
       pnlPgUp.Visible := False;
       lbPgUp.Visible := False;
       PnlPgDn.Visible := False;
       lbPgDn.Visible := False;
       pnlIns.Visible := False;
       lbIns.Visible := False;
       pnlDel.Visible := False;
       lbDel.Visible := False;
       lbEnd.Visible := False;
       pnlEnd.Visible := False;
       pnlHome.Visible := False;
       lbHome.Visible := False;
       pnlAdd.Visible := False;
       lbAdd.Visible := False;
       end;

    for i:=0 to fValues.Count-1 do
       begin
       case StrToInt(fValues.Strings[i]) of
          VK_F1 : begin
                  lbF1.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F1)];
                  lbF1.Visible  := True;
                  pnlF1.Visible := True;
                  end;
          VK_F2 : begin
                  lbF2.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F2)];
                  lbF2.Visible  := True;
                  pnlF2.Visible := True;
                  end;
          VK_F3 : begin
                  lbF3.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F3)];
                  pnlF3.Visible := True;
                  lbF3.Visible  := True;
                  end;
          VK_F4 : begin
                  lbF4.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F4)];
                  pnlF4.Visible := True;
                  lbF4.Visible  := True;
                  end;
          VK_F5 : begin
                  lbF5.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F5)];
                  pnlF5.Visible := True;
                  lbF5.Visible  := True;
                  end;
          VK_F6 : begin
                  lbF6.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F6)];
                  pnlF6.Visible := True;
                  lbF6.Visible  := True;
                  end;
          VK_F7 : begin
                  lbF7.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F7)];
                  pnlF7.Visible := True;
                  lbF7.Visible  := True;
                  end;
          VK_F8 : begin
                  lbF8.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F8)];
                  pnlF8.Visible := True;
                  lbF8.Visible  := True;
                  end;
          VK_F9 : begin
                  lbF9.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F9)];
                  lbF9.Visible  := True;
                  pnlF9.Visible := True;
                  end;
          VK_F10: begin
                  lbF10.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F10)];
                  pnlF10.Visible := True;
                  lbF10.Visible  := True;
                  end;
          VK_F11: begin
                  lbF11.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F11)];
                  pnlF11.Visible := True;
                  lbF11.Visible  := True;
                  end;
          VK_F12: begin
                  lbF12.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_F12)];
                  pnlF12.Visible := True;
                  lbF12.Visible  := True;
                  end;
          VK_PRIOR: begin
                    lbPgUp.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_PRIOR)];
                    pnlPgUp.Visible := True;
                    lbPgUp.Visible  := True;
                    end;
          VK_NEXT : begin
                    lbPgDn.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_NEXT)];
                    PnlPgDn.Visible := True;
                    lbPgDn.Visible  := True;
                    end;
          VK_INSERT: begin
                     lbIns.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_INSERT)];
                     pnlIns.Visible := True;
                     lbIns.Visible  := True;
                     end;
          VK_DELETE: begin
                     lbDel.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_DELETE)];
                     pnlDel.Visible := True;
                     lbDel.Visible  := True;
                     end;
          VK_END : begin
                   lbEnd.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_END)];
                   lbEnd.Visible  := True;
                   pnlEnd.Visible := True;
                   end;
          VK_HOME: begin
                   lbHome.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_HOME)];
                   pnlHome.Visible := True;
                   lbHome.Visible  := True;
                   end;
          {
          VK_ADD:  begin
                   lbAdd.Caption  := cbxFunction.Items.Strings[DM.GetFunction(VK_ADD)];
                   lbAdd.Visible := True;
                   lbAdd.Visible  := True;
                   end;
          }
          end;

       end;
  finally
    FreeAndNil(fValues);
    end;
end;

procedure TFrmMRDPVConfigKey.StartHelp;
begin
  fHelpMode := True;
  lbApplyDiscount.Visible       := True;
  lbApplyDiscountPerExp.Visible := True;
  lbChangeSearch.Visible        := True;
  lbSearchDetail.Visible        := True;
  Start;
end;

procedure TFrmMRDPVConfigKey.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(380);
end;

end.
