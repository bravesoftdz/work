unit uSelectDepartment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO;

type
  TSelectDepartment = class(TFrmParentAll)
    Label1: TLabel;
    btOK: TButton;
    cmbDepartment: TSuperComboADO;
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbDepartmentChange(Sender: TObject);
  private
    procedure FilterSelect(IDModel : Integer);
  public
    function Start(IDModel : Integer; var IDDepartment: Integer) : Boolean;
  end;

var
  SelectDepartment: TSelectDepartment;

implementation

uses uDM, DB, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TSelectDepartment }

function TSelectDepartment.Start(IDModel: Integer;
  var IDDepartment: Integer): Boolean;
begin

  if IDDepartment <> 0 then
    cmbDepartment.LookUpValue := InttoStr(IDDepartment);

  if IDModel <> 0 then
    FilterSelect(IDModel);

  Result := (ShowModal = mrOK);

  if Result then
     IDDepartment := StrToInt(cmbDepartment.LookUpValue)
  else
     IDDepartment := 0;
end;

procedure TSelectDepartment.FormShow(Sender: TObject);
begin
  inherited;
  sbHelp.Visible := False;
  btClose.Visible := False;
  cmbDepartment.SetFocus;
  btOK.Enabled := False;
end;

procedure TSelectDepartment.btOKClick(Sender: TObject);
begin
  inherited;
  if cmbDepartment.LookUpValue = '' then
    begin
     MsgBox(MSG_INF_SELECT_DEPARTMENT, vbOkOnly + vbInformation);
     Exit;
    end;

  ModalResult := mrOK;
end;

procedure TSelectDepartment.btCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TSelectDepartment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DM.LookUpDepartment.Filtered := False;
  DM.LookUpDepartment.Filter   := '';
  Action := caFree;
end;

procedure TSelectDepartment.FilterSelect(IDModel: Integer);
var
  FilterValue : String;
begin
  with DM.quFreeSQL do
      begin
      if Active then
         Close;
      SQL.Clear;

      SQL.Text := ' SELECT IDDepartment FROM Inv_ModelDepartment ' +
                  ' WHERE ModelID = ' + InttoStr(IDModel) + ' AND StoreID = ' + InttoStr(DM.fStore.IDStoreSale) ;
      Open;

      if IsEmpty then
        begin
          if Active then
            Close;

          SQL.Clear;

          SQL.Text := ' SELECT T.IDDepartment FROM Model M JOIN TabGroup T ON (T.IDGroup = M.GroupID) ' +
                      ' WHERE M.IDModel = ' + InttoStr(IDModel);
          Open;
        end;

      if not(IsEmpty) then
        begin
          First;
          while not EOF do
          begin
            if FilterValue = '' then
              FilterValue := 'IDDepartment = ' + FieldByName('IDDepartment').AsString
            else
              FilterValue := FilterValue + ' or ' + 'IDDepartment = ' + FieldByName('IDDepartment').AsString;
            Next;
          end;

          cmbDepartment.SpcWhereClause := FilterValue;
        end;

      Close;
      end;
end;

procedure TSelectDepartment.cmbDepartmentChange(Sender: TObject);
begin
  if cmbDepartment.Text <> '' then
     btOK.Enabled := True;
end;

end.
