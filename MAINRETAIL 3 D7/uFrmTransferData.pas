unit uFrmTransferData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, Mask, LblEffct, ExtCtrls, Buttons,
  SuperComboADO, Db, ADODB, siComp, siLangRT;

type
  TFrmTransferData = class(TFrmParent)
    cmbTransfer: TComboBox;
    pnlGuide: TPanel;
    scGuideOrigem: TSuperComboADO;
    scGuideDestino: TSuperComboADO;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlAgency: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    scAgencyOrigem: TSuperComboADO;
    scAgencyDestino: TSuperComboADO;
    Button1: TButton;
    spHelp: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure cmbTransferChange(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

procedure TFrmTransferData.Button1Click(Sender: TObject);
var
  R: Boolean;
begin
  inherited;
  case cmbTransfer.ItemIndex of
   -1: Exit;
    0: // Agency
      begin
        if scAgencyOrigem.LookUpValue = '' then
          begin
            scAgencyOrigem.SetFocus;
            MsgBox(MSG_CRT_NO_FROM_AGENCY, vbCritical + vbOkOnly);
            Exit;
          end;
        if scAgencyDestino.LookUpValue = '' then
          begin
            scAgencyDestino.SetFocus;
            MsgBox(MSG_CRT_NO_TO_AGENCY, vbCritical + vbOkOnly);
            Exit;
          end;

        R := DM.RunSQL('sp_Commission_ChangeAgency ' + scAgencyOrigem.LookUpValue + ' , '
                                                     + scAgencyDestino.LookUpValue);
      end;
    1: // Guide
      begin
        if scGuideOrigem.LookUpValue = '' then
          begin
            scGuideOrigem.SetFocus;
            MsgBox(MSG_CRT_NO_FROM_GUIDE, vbCritical + vbOkOnly);
            Exit;
          end;
        if scGuideDestino.LookUpValue = '' then
          begin
            scGuideDestino.SetFocus;
            MsgBox(MSG_CRT_NO_TO_GUIDE, vbCritical + vbOkOnly);
            Exit;
          end;

        R := DM.RunSQL('sp_Commission_ChangeGuide ' + scGuideOrigem.LookUpValue + ' , '
                                                    + scGuideDestino.LookUpValue);
      end;
  end;
  if R then
    begin
      MsgBox(MSG_INF_DATA_SUCESSFULY, vbInformation + vbOkOnly);
      Close;
    end
  else
    begin
      MsgBox(MSG_CRT_ERROR_OCURRED, vbCritical + vbOkOnly);
      Close;
    end;

end;

procedure TFrmTransferData.cmbTransferChange(Sender: TObject);
begin
  inherited;
  case cmbTransfer.ItemIndex of
    0: // Agency
      begin
        pnlAgency.Visible := True;
        pnlGuide.Visible := False;
      end;
    1: // Guide
      begin
        pnlAgency.Visible := False;
        pnlGuide.Visible := True;
      end;
  end;

end;

procedure TFrmTransferData.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmTransferData.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TFrmTransferData.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(2070);
end;

end.
