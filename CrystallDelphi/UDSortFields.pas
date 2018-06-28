unit UDSortFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSortFieldsDlg = class(TForm)
    pnlSortFields: TPanel;
    lblFieldName: TLabel;
    lblNumber: TLabel;
    rgDirection: TRadioGroup;
    lbNumbers: TListBox;
    btnOk: TButton;
    btnClear: TButton;
    cbFieldNames: TComboBox;
    btnAdd: TButton;
    btnDelete: TButton;
    btnInsert: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    procedure lbNumbersClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure rgDirectionClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateSortFields;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure cbFieldNamesChange(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure lbNumbersDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbNumbersDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr        : TCrpe;
    SortIndex : smallint;
  end;

var
  CrpeSortFieldsDlg: TCrpeSortFieldsDlg;
  bSortFields      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.FormCreate(Sender: TObject);
begin
  bSortFields := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnAdd.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateSortFields;
end;
{------------------------------------------------------------------------------}
{ UpdateSortFields                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.UpdateSortFields;
var
  OnOff : boolean;
  i     : integer;
  sList : TStringList;
begin
  cbFieldNames.Clear;
  cbFieldNames.Items.AddStrings(Cr.Tables.FieldNames);
  sList := TStringList.Create;
  sList.AddStrings(Cr.Formulas.Names);
  for i := 0 to sList.Count-1 do
    cbFieldNames.Items.Add(NameToCrFormulaFormat(sList[i], 'Formulas'));
  sList.Free;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    btnAdd.Enabled := False;
    SortIndex := -1;
  end
  else
  begin
    OnOff := (Cr.SortFields.Count > 0);
    btnAdd.Enabled := True;
    {Get SortFields Index}
    if OnOff then
    begin
      if Cr.SortFields.ItemIndex > -1 then
        SortIndex := Cr.SortFields.ItemIndex
      else
        SortIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    for i := 0 to (Cr.SortFields.Count - 1) do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.SortFields.Count);
    lbNumbers.ItemIndex := SortIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbSNumberClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.lbNumbersClick(Sender: TObject);
var
  i : integer;
begin
  SortIndex := lbNumbers.ItemIndex;
  i := cbFieldNames.Items.IndexOf(Cr.SortFields[SortIndex].FieldName);
  if i = -1 then i := 0;
  cbFieldNames.ItemIndex := i;
  rgDirection.ItemIndex := Ord(Cr.SortFields.Item.Direction);
end;
{------------------------------------------------------------------------------}
{ lbNumbersDragOver                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.lbNumbersDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Sender is TListBox then
  begin
    if TListBox(Sender).Name = 'lbNumbers' then
      Accept := True;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersDragDrop                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.lbNumbersDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  p : TPoint;
  i : integer;
begin
  p.x := X;
  p.y := y;
  i := lbNumbers.ItemAtPos(p, True);
  if i > -1 then
  begin
    Cr.SortFields.Swap(TListBox(Source).ItemIndex, i);
    UpdateSortFields;
  end;
end;
{------------------------------------------------------------------------------}
{ cbFieldNamesChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.cbFieldNamesChange(Sender: TObject);
begin
  Cr.SortFields.Item.FieldName := cbFieldNames.Items[cbFieldNames.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ rgSDirectionClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.rgDirectionClick(Sender: TObject);
begin
  Cr.SortFields.Item.Direction := TCrSortDirection(rgDirection.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ btnAddSFieldClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.btnAddClick(Sender: TObject);
begin
  if cbFieldNames.Items.Count = 0 then
    Exit;
  Cr.SortFields.Add(cbFieldNames.Items[0]);
  UpdateSortFields;
end;
{------------------------------------------------------------------------------}
{ btnDeleteSFieldClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.btnDeleteClick(Sender: TObject);
var
  nIndex : integer;
begin
  nIndex := lbnumbers.ItemIndex;
  {Delete SortField from VCL}
  Cr.SortFields.Delete(nIndex);
  lbnumbers.Items.Delete(nIndex);
  {Reset ItemIndex}
  if lbnumbers.Items.Count > 0 then
  begin
    if (nIndex > (lbnumbers.Items.Count - 1)) or (nIndex < 0) then
      nIndex := (lbnumbers.Items.Count - 1);
    lbnumbers.ItemIndex := nIndex;
    lbnumbersClick(Self);
  end;
  UpdateSortFields;
end;
{------------------------------------------------------------------------------}
{ btnInsertClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.btnInsertClick(Sender: TObject);
var
  nIndex : integer;
begin
  if cbFieldNames.Items.Count = 0 then
    Exit;
  nIndex := lbnumbers.ItemIndex;
  if nIndex < 0 then nIndex := 0;
  {Insert SortField}
  Cr.SortFields.Insert(nIndex, cbFieldNames.Items[0], sdDescending);
  UpdateSortFields;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.SortFields.Clear;
  UpdateSortFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSortFields := False;
  Release;
end;



end.
