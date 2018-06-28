unit uFrmDefaultValues;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, SuperComboADO;

type
  TFrmDefaultValues = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    scStore: TSuperComboADO;
    Label1: TLabel;
    Label2: TLabel;
    scCateg: TSuperComboADO;
  private
    { Private declarations }
  public
    function Start:Boolean;
  end;

implementation

uses uDM, uFrmMain;

{$R *.dfm}

{ TFrmDefaultValues }

function TFrmDefaultValues.Start: Boolean;
begin
   DM.MRInventoryConnectionOpen;
   scStore.LookUpValue := IntToStr(DM.DefaultStore);
   scCateg.LookUpValue := IntTostr(DM.DefaultCateg);

   ShowModal;

   Result := (ModalResult = mrOK);

   If Result then
      begin
      DM.DefaultCateg := StrToInt(scCateg.LookUpValue);
      DM.DefaultStore := StrToInt(scStore.LookUpValue);
      end;
end;

end.
