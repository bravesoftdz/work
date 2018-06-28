unit uPctMicrochipAddFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentModalForm, XiButton, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, cxCurrencyEdit,
  StdCtrls;

type
  TPctMicrochipAddFrm = class(TParentModalForm)
    scMicrochip: TmrSuperCombo;
    Label1: TLabel;
    edtBarcode: TcxTextEdit;
    Label2: TLabel;
    edtModel: TcxTextEdit;
    Label3: TLabel;
    edtDescription: TcxTextEdit;
    Label4: TLabel;
    edtSalePrice: TcxCurrencyEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure scMicrochipBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
  private
    function ValidateFields : Boolean;
  protected
    procedure ConfirmFrm; override;
    procedure CancelFrm; override;
  public
    { Public declarations }
  end;

implementation

uses uDMPet, uDMGlobalNTier, uDMMaintenance, mrMsgBox, uMRSQLParam;

{$R *.dfm}

{ TPctMicrochipAddFrm }

procedure TPctMicrochipAddFrm.CancelFrm;
begin
  inherited;

end;

procedure TPctMicrochipAddFrm.ConfirmFrm;
var
  cSalePrice : Currency;
  iIDCategory : Integer;
  sMsgResult : String;
  fResult : Boolean;
begin
  inherited;

  fResult := ValidateFields;

  if fResult then
  begin
    cSalePrice := edtSalePrice.EditValue;
    iIDCategory := scMicrochip.EditValue;
    fResult := DMPet.PetCenterConn.AppServer.PetInsertMicrochip(iIDCategory,
                                                                edtBarcode.Text,
                                                                edtModel.Text,
                                                                edtDescription.Text,
                                                                cSalePrice,
                                                                sMsgResult);
    if not fResult then
      MsgBox(sMsgResult, vbCritical + vbOKOnly);
  end;

  if not fResult then
    ModalResult := mrNone;

end;

procedure TPctMicrochipAddFrm.FormCreate(Sender: TObject);
begin
  inherited;
  scMicrochip.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, 'MenuDisplay=Microchip;');
  scMicrochip.EditValue := DMPet.GetPropertyDomain('PctMicrochipCategory');
end;

function TPctMicrochipAddFrm.ValidateFields: Boolean;
begin

  Result := False;

  if StrToIntDef(VarToStr(scMicrochip.EditValue), 0) = 0 then
  begin
    MsgBox('Microchip Category cannot be empty', vbInformation + vbOKOnly);
    scMicrochip.SetFocus;
    Exit;
  end;

  if edtBarcode.Text = '' then
  begin
    MsgBox('Barcode cannot be empty', vbInformation + vbOKOnly);
    edtBarcode.SetFocus;
    Exit;
  end;

  if edtModel.Text = '' then
  begin
    MsgBox('Model cannot be empty', vbInformation + vbOKOnly);
    edtModel.SetFocus;
    Exit;
  end;

  if edtDescription.Text = '' then
  begin
    MsgBox('Description cannot be empty', vbInformation + vbOKOnly);
    edtDescription.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TPctMicrochipAddFrm.scMicrochipBeforeGetRecordsList(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      AddKey('SizeAndColor').AsBoolean := False;
      KeyByName('SizeAndColor').Condition := tcEquals;

      AddKey('PackModel').AsBoolean := False;
      KeyByName('PackModel').Condition := tcEquals;

      AddKey('Service').AsBoolean := False;
      KeyByName('Service').Condition := tcEquals;

      AddKey('Credit').AsBoolean := False;
      KeyByName('Credit').Condition := tcEquals;

      AddKey('GiftCard').AsBoolean := False;
      KeyByName('GiftCard').Condition := tcEquals;

      AddKey('Hidden').AsBoolean := False;
      KeyByName('Hidden').Condition := tcEquals;

      AddKey('Desativado').AsBoolean := False;
      KeyByName('Desativado').Condition := tcEquals;

      AddKey('PuppyTracker').AsBoolean := False;
      KeyByName('PuppyTracker').Condition := tcEquals;

      
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

initialization
  RegisterClass(TPctMicrochipAddFrm);


end.
