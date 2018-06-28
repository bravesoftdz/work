unit uAddTrajeto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uDialogParent, StdCtrls, Db, DBTables, Grids,
  ExtCtrls, Mask, Buttons, checklst, DBCtrls, ADODB, LblEffct, siComp,
  siLangRT;

type
  TAddTrajeto = class(TDialogParent)
    quTrajeto: TADOQuery;
    editNumPass0: TLabel;
    Label2: TLabel;
    editTotGas: TEdit;
    Label3: TLabel;
    editTotMot: TEdit;
    quTrajetoIDTrajeto: TIntegerField;
    quTrajetoTrajeto: TStringField;
    quTrajetoCustoMotorista: TFloatField;
    quTrajetoCustoGasolina: TFloatField;
    quTrajetoDesativado: TIntegerField;
    quTrajetoMinPax: TIntegerField;
    ChkListTrajeto: TCheckListBox;
    Label19: TLabel;
    Label17: TLabel;
    Shape1: TShape;
    Label22: TLabel;
    Label1: TLabel;
    EditTotal: TEdit;
    Panel4: TPanel;
    imgTopIni: TImage;
    Image2: TImage;
    lblSubMenu: TLabelEffect;
    imgMenu: TImage;
    Image3: TImage;
    Panel5: TPanel;
    Panel6: TPanel;
    spHelp: TSpeedButton;
    editNumPass: TEdit;
    procedure editNumPassChange(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChkListTrajetoClickCheck(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editNumPassKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    IsChange : Boolean;
    TotGas, TotMot : Currency;
    IDTouristGroup, MyMinPax : Integer;
    procedure RefreshList(Reset : Boolean);
  public
    { Public declarations }
    function Start(MyIDTouristGroup: Integer; strPassenger : String) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uNumericFunctions, uMsgConstant, uDMGlobal, uSystemConst;

{$R *.DFM}

function TAddTrajeto.Start(MyIDTouristGroup: Integer; strPassenger : String) : Boolean;
begin
  IDTouristGroup := MyIDTouristGroup;

  IsChange := False;
  if strPassenger <> '' then
     editNumPass.Text := strPassenger
  else
     editNumPass.Text := '1';
  IsChange := True;

  // Da o Refresh inicial e reseta os checked
  RefreshList(True);

  ShowModal;

  Result := (ModalResult = mrOk);
end;

procedure TAddTrajeto.editNumPassChange(Sender: TObject);
begin
  inherited;
  if IsChange then
     RefreshList(False);
end;

procedure TAddTrajeto.AplicarClick(Sender: TObject);
var
  iID : Integer;
begin
  inherited;
  if MyStrToFloat(editNumPass.Text) < MyMinPax then
  begin
    MsgBox(MSG_INF_TRY_ADD_ROUTES + IntToStr(MyMinPax) +  '.', vbOkOnly + vbInformation);
    editNumPass.Text := IntToStr(MyMinPax);
  end;

  //Pega o proximo registro
  iID := DM.GetNextID(MR_GROUP_COST_ID);
  with DM.quFreeSQL do
  begin
    if Active then Close;
    SQL.Text:= 'INSERT INTO GroupCost ' +
            '(IDCost, IDCostType, IDTouristGroup, UnitCost, CostDate, Quantity)' +
            'VALUES' +
            '('+IntToStr(iID)+', 2, ' + IntToStr(IDTouristGroup) + ', ' + MyFormatCur(TotMot/MyStrToInt(editNumPass.Text),'.') +
            ', ' + chr(39) + FormatDateTime('mm/dd/yyyy', Date()) + chr(39) + ', ' + editNumPass.Text + ')';
    ExecSQL;
  end;

  ModalResult := mrOk;
end;

procedure TAddTrajeto.CancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TAddTrajeto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  quTrajeto.Close;
end;

procedure TAddTrajeto.RefreshList(Reset : Boolean);
var
  i        : integer;
begin
  MyMinPax := 0;
  TotGas   := 0;
  TotMot   := 0;
  i        := 0;

  if Reset then
  begin
    quTrajeto.Close;
    quTrajeto.Open;
    ChkListTrajeto.Enabled := not (quTrajeto.Eof and quTrajeto.Bof);
    ChkListTrajeto.Items.Clear;
  end;

  with quTrajeto do
  begin
    First;
    while not Eof do
    begin
      if Reset then
         ChkListTrajeto.Items.Add(quTrajetoTrajeto.AsString);

      // Recalcula os totais
      if ChkListTrajeto.State[i]= cbChecked then
      begin
        TotGas := TotGas + quTrajetoCustoGasolina.AsFloat;
        TotMot := TotMot + quTrajetoCustoMotorista.AsFloat;
        if quTrajetoMinPax.AsInteger > MyMinPax then
          MyMinPax := quTrajetoMinPax.AsInteger;
      end;

      Inc(i);
      Next;
    end;
  end;

  // Adiciona o numero de passageiros
  TotGas := TotGas * MyStrToInt(editNumPass.Text);
  TotMot := TotMot * MyStrToInt(editNumPass.Text);
  
  editTotGas.Text := FloatToStrF(TotGas, ffCurrency, 20, 2);
  editTotMot.Text := FloatToStrF(TotMot, ffCurrency, 20, 2);
  editTotal.Text  := FloatToStrF(TotMot+TotGas, ffCurrency, 20, 2);
end;

procedure TAddTrajeto.ChkListTrajetoClickCheck(Sender: TObject);
begin
  inherited;
  RefreshList(False);
end;

procedure TAddTrajeto.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(306);
end;

procedure TAddTrajeto.FormShow(Sender: TObject);
begin
  inherited;
  Caption:= Application.Title;
end;

procedure TAddTrajeto.editNumPassKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key IN ['.', '-'] then
    Key := #0
  else
    Key := ValidateFloat(Key);
end;

end.
