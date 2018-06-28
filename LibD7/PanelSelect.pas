unit PanelSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DB;

type
  TPanelSelect = class(TPanel)
  private
    { Private declarations }
    FSel_DataType : TFieldType;
    FSel_ComboLookUpValue, FSel_Faixa    : Boolean;
  protected
    { Protected declarations }
    constructor Create(AOwner : TComponent); override;
  public
    { Public declarations }
  published
    { Published declarations }
    property Sel_Faixa            : Boolean    read FSel_Faixa    write FSel_Faixa default False;
    property Sel_DataType         : TFieldType read FSel_DataType write FSel_DataType default ftString;
    property Sel_ComboLookUpValue : Boolean    read FSel_ComboLookUpValue write FSel_ComboLookUpValue default True;
  end;

procedure Register;

implementation

constructor TPanelSelect.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSel_Faixa    := False;
  FSel_ComboLookUpValue := True;
  FSel_DataType := ftString;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TPanelSelect]);
end;

end.
