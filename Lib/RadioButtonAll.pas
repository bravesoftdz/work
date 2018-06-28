unit RadioButtonAll;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls, SuperComboADO;

type
  TRadioButtonAll = class(TRadioButton)
  private
    { Private declarations }
    FLinkedSuperCombo : TSuperComboADO;
    FTextAll : String;
  protected
    { Protected declarations }
    procedure Click; override;
    constructor Create( AOwner: TComponent ); override;
  public
    { Public declarations }
  published
    { Published declarations }
    property TextAll          : String read FTextAll write FTextAll;
    property LinkedSuperCombo : TSuperComboADO read FLinkedSuperCombo write FLinkedSuperCombo;
  end;

procedure Register;

implementation

uses PowerParam;

constructor TRadioButtonAll.Create( AOwner: TComponent );
begin
  inherited Create( AOwner);
  if Language = laPortuguese then
    FTextAll := '<Todos>'
  else
    FTextAll := '<ALL>';
end;

procedure TRadioButtonAll.Click;
begin
  if Checked then
    begin
      // Seta o SuperCombo associado para <ALL> e LookUpValue = ''
      if Assigned(LinkedSuperCombo) then
        begin
          with LinkedSuperCombo do
            begin
              LookUpValue := '';
              Text        := FTextAll;
            end;
        end;
    end;

  inherited Click;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TRadioButtonAll]);
end;

end.
