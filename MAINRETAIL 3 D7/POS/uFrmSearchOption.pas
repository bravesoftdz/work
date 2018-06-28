unit uFrmSearchOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uParentAll, siComp, siLangRT;

const
  OP_CUSTOMER   = 3;
  OP_SERIAL     = 7;
  OP_TABLEPRICE = 8;

type
  TFrmSearchOption = class(TFrmParentAll)
    btnBarcode: TBitBtn;
    btnDescription: TBitBtn;
    btnCustomer: TBitBtn;
    btnMedia: TBitBtn;
    btnUser: TBitBtn;
    btnModel: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBarcodeClick(Sender: TObject);
  private
    SearchResult : TObject;
  public
    function Start(var oResult: TObject):Boolean;
    function StartOption(iOption: Integer; var oResult: TObject;
      bHasIdent: Boolean = False): Boolean;
  end;

implementation

uses uFrmSearchFor, uDM, uSystemConst;

{$R *.dfm}

{ TFrmSearchOption }

function TFrmSearchOption.Start(var oResult: TObject): Boolean;
begin
  SearchResult := Nil;
  btnUser.Enabled := DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER];
  ShowModal;
  oResult := SearchResult;
  Result := oResult <> nil;
end;

function TFrmSearchOption.StartOption(iOption: Integer; var oResult: TObject;
  bHasIdent: Boolean = False): Boolean;
var
  bImage : TBitmap;
begin
  case iOption of
   OP_CUSTOMER  : bImage := btnCustomer.Glyph;
   OP_SERIAL    : bImage := btnModel.Glyph;
   OP_TABLEPRICE: bImage := btnModel.Glyph;
  end;

  SearchResult := Nil;
  with TFrmSearchFor.Create(Self) do
  begin
     Start(iOption, bImage, SearchResult, bHasIdent);
     Free;
  end;
  oResult := SearchResult;
  Result  := oResult <> nil;
  Close;
end;

procedure TFrmSearchOption.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
   VK_ESCAPE : Close;
 end;
end;

procedure TFrmSearchOption.btnBarcodeClick(Sender: TObject);
begin
  with TFrmSearchFor.Create(Self) do
  begin
     Start(TBitBtn(Sender).Tag, TBitBtn(Sender).Glyph, SearchResult);
     Free;
  end;
  if SearchResult <> nil then
    Close;
end;

end.
