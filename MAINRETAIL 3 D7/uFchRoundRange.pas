unit uFchRoundRange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchRoundRange = class(TbrwFrmParent)
    Label2: TLabel;
    dbMinValue: TDBEdit;
    Label3: TLabel;
    dbMaxValue: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbRoundType: TComboBox;
    edRoundValue: TEdit;
    lbRoundValues: TListBox;
    quFormIDRoundingTableRange: TIntegerField;
    quFormMinValue: TBCDField;
    quFormMaxValue: TBCDField;
    quFormRoundValues: TStringField;
    quFormRoundType: TIntegerField;
    quFormIDRoundingTable: TIntegerField;
    Label35: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure cbRoundTypeCloseUp(Sender: TObject);
    procedure edRoundValueKeyPress(Sender: TObject; var Key: Char);
    procedure btCloseClick(Sender: TObject);
    procedure dbMaxValueExit(Sender: TObject);
    procedure dbMinValueExit(Sender: TObject);
  private
    function FormatRoundingValues: String;
    function AddItem(RoundValue :String):Boolean;
    procedure VerifyValues(Value: TDBEdit);
  protected
    procedure OnBeforeStart; override;
  public
    { Public declarations }
  end;

implementation

uses Math, uCharFunctions, uNumericFunctions, uMsgBox, uMsgConstant;


{$R *.dfm}

procedure TFchRoundRange.OnBeforeStart;
begin
  inherited;
  lbRoundValues.Items.Delimiter := ';';
end;

procedure TFchRoundRange.BitBtn1Click(Sender: TObject);
begin
 if edRoundValue.Text <> '' then   
    if Additem(FormatFloat('0.00', MyStrToDouble(edRoundValue.Text,DecimalSeparator))) then
       begin
       lbRoundValues.Sorted := True;
       edRoundValue.Clear;
       edRoundValue.SetFocus;
       quForm.Edit;  
       end;
end;

procedure TFchRoundRange.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbRoundValues.Items.Clear;
  lbRoundValues.Items.DelimitedText := quFormRoundValues.AsString;
  cbRoundType.ItemIndex             := (quFormRoundType.AsInteger)-1;
  edRoundValue.Text                 := '';
end;

procedure TFchRoundRange.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quFormRoundType.AsInteger  := (cbRoundType.ITemIndex)+1;
  quFormRoundValues.AsString := FormatRoundingValues;
end;

procedure TFchRoundRange.BitBtn2Click(Sender: TObject);
begin
  inherited;
  lbRoundValues.DeleteSelected;
  quForm.Edit;
end;

procedure TFchRoundRange.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  cbRoundType.ItemIndex := 0;
  edRoundValue.Text     := '';
  lbRoundValues.Clear;
end;

function TFchRoundRange.FormatRoundingValues: String;
begin
  Result := lbRoundValues.Items.DelimitedText;
end;

function TFchRoundRange.AddItem(RoundValue: String):Boolean;
var i: Integer;
    Friend : Boolean;
begin

 Result := False;

 if (lbRoundValues.Items.IndexOf(RoundValue)=-1) then
    begin
    lbRoundValues.Items.Add(RoundValue);
    Result := True;
    end;

end;

procedure TFchRoundRange.cbRoundTypeCloseUp(Sender: TObject);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchRoundRange.edRoundValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key :=  ValidatePositiveCurrency(Key);
end;

procedure TFchRoundRange.btCloseClick(Sender: TObject);
begin
  inherited;
  //refresh o Browse anterior
  MybrwQuery.Close;
  MybrwQuery.Open;
end;

procedure TFchRoundRange.dbMaxValueExit(Sender: TObject);
begin
  VerifyValues(dbMaxValue);
end;

procedure TFchRoundRange.VerifyValues(Value: TDBEdit);
begin
  if (dbMinValue.Text <> '') and (dbMaxValue.Text <> '') then
  begin
    if (MyStrToMoney(dbMinValue.Text) > MyStrToMoney(dbMaxValue.Text)) then
    begin
      MsgBox(MSG_INF_NOT_MIN_GREATER_MAX, vbOKOnly + vbInformation);
      Value.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFchRoundRange.dbMinValueExit(Sender: TObject);
begin
  VerifyValues(dbMinValue);
end;

end.
