unit uFrmModelAddSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, Db, DBTables, StdCtrls, Buttons, ExtCtrls, Mask,
  SuperComboADO, ADODB, siComp, siLangRT;

type
  TFrmModelAddSize = class(TFrmParentAll)
    Button1: TButton;
    spAddSize: TADOStoredProc;
    Label1: TLabel;
    scSize: TSuperComboADO;
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

function TFrmModelAddSize.Start(iIDModel: integer): boolean;
begin

  Result := False;

  spAddSize.Parameters.ParamByName('@IDModel').Value := iIDModel;

  scSize.LookUpValue := '';

  if (ShowModal=mrOk) then
    begin
      with spAddSize do
        begin
          try
            Parameters.ParamByName('@IDSize').Value := StrToInt(scSize.LookUpValue);
            try
              DM.ADODBConnect.BeginTrans;
              ExecProc;
              DM.ADODBConnect.CommitTrans;
            except
              DM.ADODBConnect.RollbackTrans;
              end;
            Result := True;
          except
            MsgBox(MSG_CRT_ERROR_ADD_SIZE, vbOkOnly + vbCritical);
          end;
        end;
    end;
end;

procedure TFrmModelAddSize.btCloseClick(Sender: TObject);
begin
  inherited;

  if scSize.LookUpValue = '' then
    MsgBox(MSG_CRT_NO_SIZE, vbCritical + vbOkOnly)
  else
    ModalResult := mrOk;

end;

end.
