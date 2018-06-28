unit uFrmModelAddColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, Db, DBTables, StdCtrls, Buttons, ExtCtrls, Mask,
  SuperComboADO, ADODB, siComp, siLangRT;

type
  TFrmModelAddColor = class(TFrmParentAll)
    Button1: TButton;
    spAddColor: TADOStoredProc;
    Label1: TLabel;
    scColor: TSuperComboADO;
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(iIDModel: integer): boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

function TFrmModelAddColor.Start(iIDModel: integer): boolean;
begin

  Result := False;

  spAddColor.Parameters.ParamByName('@IDModel').Value := iIDModel;

  scColor.LookUpValue := '';

  if (ShowModal=mrOk) then
    begin
      with spAddColor do
        begin
          try
            Parameters.ParamByName('@IDColor').Value := StrToInt(scColor.LookUpValue);
            try
              DM.ADODBConnect.BeginTrans;
              ExecProc;
              DM.ADODBConnect.CommitTrans;
            except
              DM.ADODBConnect.RollbackTrans;
              end;
            Result := True;
          except
            MsgBox(MSG_CRT_ERROR_ADD_COLOR, vbOkOnly + vbCritical);
          end;
        end;
    end;
end;

procedure TFrmModelAddColor.btCloseClick(Sender: TObject);
begin
  inherited;

  if scColor.LookUpValue = '' then
    MsgBox(MSG_CRT_NO_COLOR, vbCritical + vbOkOnly)
  else
    ModalResult := mrOk;

end;

end.
