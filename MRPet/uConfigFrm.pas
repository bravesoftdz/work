unit uConfigFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentModalForm, XiButton, ExtCtrls, StdCtrls, ComCtrls, DB,
  DBClient, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  mrSuperCombo, uMRSQLParam;

const
  CON_DCOM   = 0;
  CON_SOCKET = 1;
  CON_WEB    = 2;

  TYPE_TAB_CONFIG    = 0;
  TYPE_TAB_PETCENTER = 1;

type
  TConfigFrm = class(TParentModalForm)
    pgConfig: TPageControl;
    tsConnection: TTabSheet;
    Label1: TLabel;
    lbHost: TLabel;
    lbPort: TLabel;
    Label2: TLabel;
    cbxConnectionType: TComboBox;
    edtHost: TEdit;
    edtPort: TEdit;
    edtClientID: TEdit;
    tsPetCenter: TTabSheet;
    pgPetCenter: TPageControl;
    tsBreeder: TTabSheet;
    scEntityType: TmrSuperCombo;
    tsInventory: TTabSheet;
    lbBreederInfo: TLabel;
    scMicrochip: TmrSuperCombo;
    scPet: TmrSuperCombo;
    scKitPet: TmrSuperCombo;
    tsStore: TTabSheet;
    scStore: TmrSuperCombo;
    tsWarrantyRep: TTabSheet;
    btnEditReport: TXiButton;
    Label3: TLabel;
    chkPreview: TCheckBox;
    cbxDefaultPrint: TcxComboBox;
    lbPrinter: TLabel;
    tsPrintServer: TTabSheet;
    Label4: TLabel;
    edtPrintIP: TcxTextEdit;
    Label5: TLabel;
    edtPrintPort: TcxTextEdit;
    tsKey: TTabSheet;
    Label6: TLabel;
    lbKey: TLabel;
    btnKey: TXiButton;
    Label7: TLabel;
    lbExpiration: TLabel;
    procedure scEntityTypeBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
    procedure scMicrochipBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
    procedure scPetBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
    procedure scKitPetBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnEditReportClick(Sender: TObject);
    procedure btnKeyClick(Sender: TObject);
  private
    FType : Integer;
    procedure GetConfigFile;
    procedure SetConfigFile;

    procedure GetPetCenterProperty;
    procedure SetPetCenterProperty;
    procedure RefreshConType;
    procedure RefreshTab;
  protected
    procedure ConfirmFrm; override;
    procedure CancelFrm; override;
  public
    function Start(AType : Integer):Boolean;
  end;

implementation

uses uDMPet, uDMGlobalNTier, uDMMaintenance, uParentPrintForm, uClasseFunctions,
  Printers, uMainRetailKeyConst, mrMsgBox;

{$R *.dfm}

{ TConfigFrm }

procedure TConfigFrm.GetConfigFile;
var
  sConType : String;
begin

  sConType := DMPet.GetAppProperty('Connection', 'Type');
  if sConType = CON_TYPE_SOCKET then
     cbxConnectionType.ItemIndex := CON_SOCKET
  else if sConType = CON_TYPE_DCOM then
     cbxConnectionType.ItemIndex := CON_DCOM
  else if sConType = CON_TYPE_WEB then
     cbxConnectionType.ItemIndex := CON_WEB;

  RefreshConType;
  edtClientID.Text     := DMPet.GetAppProperty('Connection', 'ClientID');
  edtHost.Text         := DMPet.GetAppProperty('Connection', 'Host');
  edtPort.Text         := DMPet.GetAppProperty('Connection', 'Port');
  chkPreview.Checked   := (StrToIntDef(DMPet.GetAppProperty('WarrantyRep', 'Preview'), 1) = 1);
  cbxDefaultPrint.Text := DMPet.GetAppProperty('WarrantyRep', 'PrinterName');

  edtPrintIP.Text      := DMPet.GetAppProperty('PrintServer', 'ServerIP');
  edtPrintPort.Text    := DMPet.GetAppProperty('PrintServer', 'ServerPort');

end;

procedure TConfigFrm.RefreshConType;
var
  fPort : Boolean;
begin
  inherited;

  fPort := False;

  case cbxConnectionType.ItemIndex of
    CON_DCOM   : fPort := False;
    CON_SOCKET : fPort := True;
    CON_WEB    : fPort := False;
  end;

  lbPort.Visible  := fPort;
  edtPort.Visible := fPort;

end;

procedure TConfigFrm.SetConfigFile;
begin

  case cbxConnectionType.ItemIndex of
    CON_SOCKET : DMPet.SetAppProperty('Connection', 'Type', CON_TYPE_SOCKET);
    CON_DCOM   : DMPet.SetAppProperty('Connection', 'Type', CON_TYPE_DCOM);
    CON_WEB    : DMPet.SetAppProperty('Connection', 'Type', CON_TYPE_WEB);
  end;

  DMPet.SetAppProperty('Connection', 'ClientID', edtClientID.Text);
  DMPet.SetAppProperty('Connection', 'Host', edtHost.Text);
  DMPet.SetAppProperty('Connection', 'Port', edtPort.Text);

  if chkPreview.Checked then
    DMPet.SetAppProperty('WarrantyRep', 'Preview',  '1')
  else
    DMPet.SetAppProperty('WarrantyRep', 'Preview',  '0');

  DMPet.SetAppProperty('WarrantyRep', 'PrinterName',  cbxDefaultPrint.Text);

  DMPet.SetAppProperty('PrintServer', 'ServerIP', edtPrintIP.Text);
  DMPet.SetAppProperty('PrintServer', 'ServerPort', edtPrintPort.Text);

end;

function TConfigFrm.Start(AType : Integer): Boolean;
begin
  FType := AType;
  RefreshTab;
  ShowModal;
  Result := (ModalResult = mrOK);
end;

procedure TConfigFrm.CancelFrm;
begin
  inherited;

end;

procedure TConfigFrm.ConfirmFrm;
begin
  inherited;

  SetConfigFile;
  
  Case FType of
    TYPE_TAB_CONFIG    : ;
    TYPE_TAB_PETCENTER : SetPetCenterProperty;
  end;


end;

procedure TConfigFrm.RefreshTab;
begin

  tsConnection.TabVisible := False;
  tsPetCenter.TabVisible := False;
  cbxDefaultPrint.Properties.Items := Printer.Printers;

  GetConfigFile;

  Case FType of
    TYPE_TAB_CONFIG    : begin
                         tsConnection.TabVisible := True;
                         end;
                         
    TYPE_TAB_PETCENTER : begin
                         tsPetCenter.TabVisible := True;
                         GetPetCenterProperty;
                         lbKey.Caption := Copy(DMPet.MRKey, 1, 10) + ' ... ' + Copy(DMPet.MRKey, Length(DMPet.MRKey)-10, Length(DMPet.MRKey));
                         lbExpiration.Caption := FormatDateTime('ddddd', DMPet.DataSetControl.SoftwareExpirationDate);
                         end;

  end;



end;

procedure TConfigFrm.SetPetCenterProperty;
begin
  DMPet.SetPropertyDomain('PctBreederDefaultEntityType', scEntityType.EditValue);
  DMPet.SetPropertyDomain('PctBreederDefaultEntityTypePath', scEntityType.GetFieldValue('Path'));
  DMPet.SetPropertyDomain('PctMicrochipCategory', scMicrochip.EditValue);
  DMPet.SetPropertyDomain('PctPetCategory', scPet.EditValue);
  DMPet.SetPropertyDomain('PctPetKitCategory', scKitPet.EditValue);
  DMPet.SetPropertyDomain('PctDefaultStore', scStore.EditValue);

  DMPet.ApplyUpdatePropertyDomain;
end;

procedure TConfigFrm.GetPetCenterProperty;
begin
  scEntityType.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, 'MenuDisplay=Entity Type;');
  scMicrochip.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, 'MenuDisplay=Microchip;');
  scPet.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scKitPet.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scStore.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');

  scEntityType.EditValue := DMPet.GetPropertyDomain('PctBreederDefaultEntityType');
  scMicrochip.EditValue  := DMPet.GetPropertyDomain('PctMicrochipCategory');
  scPet.EditValue        := DMPet.GetPropertyDomain('PctPetCategory');
  scKitPet.EditValue     := DMPet.GetPropertyDomain('PctPetKitCategory');
  scStore.EditValue      := DMPet.GetPropertyDomain('PctDefaultStore');
end;

procedure TConfigFrm.scEntityTypeBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      AddKey('Path').AsString := PT_PATH_MANUFACTURE;
      KeyByName('Path').Condition := tcLikeStartWith;

      AddKey('Desativado').AsBoolean := False;
      KeyByName('Desativado').Condition := tcEquals;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TConfigFrm.scMicrochipBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
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

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TConfigFrm.scPetBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
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

      AddKey('PuppyTracker').AsBoolean := True;
      KeyByName('PuppyTracker').Condition := tcEquals;

      AddKey('Hidden').AsBoolean := False;
      KeyByName('Hidden').Condition := tcEquals;

      AddKey('Desativado').AsBoolean := False;
      KeyByName('Desativado').Condition := tcEquals;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TConfigFrm.scKitPetBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      AddKey('SizeAndColor').AsBoolean := False;
      KeyByName('SizeAndColor').Condition := tcEquals;

      AddKey('PackModel').AsBoolean := True;
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

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TConfigFrm.btnEditReportClick(Sender: TObject);
var
  Form : TForm;
begin
  inherited;
  Form := CreateForm(Self, 'TPctWarrantyPrintForm');
  try
    TParentPrintForm(Form).DesignReport;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TConfigFrm.btnKeyClick(Sender: TObject);
begin
  inherited;
  DMPet.ActiveConnection.AppServer.SoftwareDelete(SOFTWARE_PC);
  MsgBox('License Updated. Close Pet Center and reopen it to use your new license.', vbInformation + vbOKOnly);
end;

end.
