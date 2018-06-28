unit UDFieldSelect;

{$I UCRPEDEF.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeFieldSelectDlg = class(TForm)
    ImageList1: TImageList;
    pnlMain: TPanel;
    pnlTop: TPanel;
    pnlLeft: TPanel;
    tvFieldList: TTreeView;
    pnlRight: TPanel;
    pnlBottom: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvFieldListDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    EFSelect : boolean; {is FieldSelect being called from EmbeddedFields.Insert?}
  end;

var
  CrpeFieldSelectDlg: TCrpeFieldSelectDlg;
  bFieldSelect      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDDatabaseFields, UDFormulas, UDSpecialFields,
  UDRunningTotals, UDGroupNameFields, UDParamFields, UDTables,
  UDTableFields, UDEmbeddedFields, UDSQLExpressions;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFieldSelectDlg.FormCreate(Sender: TObject);
begin
  bFieldSelect := True;
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFieldSelectDlg.FormShow(Sender: TObject);
const
  SpecialFieldNames : array[0..17] of string = ('Page Number',
    'Total Page Count', 'Page N of M', 'Report Title', 'Report Comments',
    'File Path and Name', 'File Author', 'File Creation Date',
    'Print Date', 'Print Time', 'Data Date', 'Data Time',
    'Modification Date', 'Modification Time', 'Record Number',
    'Group Number', 'Record Selection Formula', 'Group Selection Formula');
var
  Node1, Node2, Node3 : TTreeNode;
  i,j   : integer;
begin
  tvFieldList.Items.Clear; { remove any existing nodes }
  {Add a root node - Database Fields}
  Node1 := tvFieldList.Items.Add(nil, 'Database Fields:');
  Node1.ImageIndex := 0;
  Node1.SelectedIndex := 0;
  for i := 0 to Cr.Tables.Count - 1 do
  begin
    {Add child nodes - Tables}
    Node2 := tvFieldList.Items.AddChild(Node1, Cr.Tables[i].AliasName);
    Node2.ImageIndex := 1;
    Node2.SelectedIndex := 1;
    {Add sub-child nodes - Fields}
    for j := 0 to Cr.Tables.Item.Fields.Count - 1 do
    begin
      Node3 := tvFieldList.Items.AddChild(Node2, Cr.Tables.Item.Fields[j].FieldName);
      {If Field is used in Report use different glyph}
      if Cr.Tables.Item.Fields[j].InUse then
      begin
        Node3.ImageIndex := 3;
        Node3.SelectedIndex := 3;
      end
      else
      begin
        Node3.ImageIndex := 2;
        Node3.SelectedIndex := 2;
      end;
    end;
  end;
  {Expand root}
  tvFieldList.Items[0].Expand(False);

  {Add a root node - Formula Fields}
  Node1 := tvFieldList.Items.Add(nil, 'Formula Fields:');
  Node1.ImageIndex := 4;
  Node1.SelectedIndex := 4;
  for i := 0 to Cr.Formulas.Count - 1 do
  begin
    {Add child nodes - Formula Names}
    Node2 := tvFieldList.Items.AddChild(Node1, Cr.Formulas[i].Name);
    if Cr.Formulas.Item.Handle > 0 then
    begin
      Node2.ImageIndex := 3;
      Node2.SelectedIndex := 3;
    end
    else
    begin
      Node2.ImageIndex := 2;
      Node2.SelectedIndex := 2;
    end;
  end;

  if Cr.SQLExpressions.Count > 0 then
  begin
    {Add a root node - SQL Expression Fields}
    Node1 := tvFieldList.Items.Add(nil, 'SQL Expression Fields:');
    Node1.ImageIndex := 5;
    Node1.SelectedIndex := 5;
    for i := 0 to Cr.SQLExpressions.Count - 1 do
    begin
      {Add child nodes - Expression Names}
      Node2 := tvFieldList.Items.AddChild(Node1, Cr.SQLExpressions[i].Name);
      if Cr.SQLExpressions.Item.Handle > 0 then
      begin
        Node2.ImageIndex := 3;
        Node2.SelectedIndex := 3;
      end
      else
      begin
        Node2.ImageIndex := 2;
        Node2.SelectedIndex := 2;
      end;
    end;
  end;

  {Add a root node - Parameter Fields}
  Node1 := tvFieldList.Items.Add(nil, 'Parameter Fields:');
  Node1.ImageIndex := 6;
  Node1.SelectedIndex := 6;
  for i := 0 to Cr.ParamFields.Count - 1 do
  begin
    {Add child nodes - Parameter Names}
    Node2 := tvFieldList.Items.AddChild(Node1, Cr.ParamFields[i].Name);
    if Cr.ParamFields.Item.Handle > 0 then
    begin
      Node2.ImageIndex := 3;
      Node2.SelectedIndex := 3;
    end
    else
    begin
      Node2.ImageIndex := 2;
      Node2.SelectedIndex := 2;
    end;
  end;

  {Add a root node - Running Total Fields}
  Node1 := tvFieldList.Items.Add(nil, 'Running Total Fields:');
  Node1.ImageIndex := 7;
  Node1.SelectedIndex := 7;
  for i := 0 to Cr.RunningTotals.Count - 1 do
  begin
    {Add child nodes - RunningTotal Field Names}
    Node2 := tvFieldList.Items.AddChild(Node1, Cr.RunningTotals[i].Name);
    if Cr.RunningTotals.Item.Handle > 0 then
    begin
      Node2.ImageIndex := 3;
      Node2.SelectedIndex := 3;
    end
    else
    begin
      Node2.ImageIndex := 2;
      Node2.SelectedIndex := 2;
    end;
  end;

  {Add a root node - Group Name Fields}
  Node1 := tvFieldList.Items.Add(nil, 'Group Name Fields:');
  Node1.ImageIndex := 8;
  Node1.SelectedIndex := 8;
  for i := 0 to Cr.GroupNameFields.Count - 1 do
  begin
    {Add child nodes - Group Name Field Names}
    Node2 := tvFieldList.Items.AddChild(Node1, Cr.GroupNameFields[i].FieldName);
    if Cr.GroupNameFields.Item.Handle > 0 then
    begin
      Node2.ImageIndex := 3;
      Node2.SelectedIndex := 3;
    end
    else
    begin
      Node2.ImageIndex := 2;
      Node2.SelectedIndex := 2;
    end;
  end;

  {Add a root node - Special Fields}
  Node1 := tvFieldList.Items.Add(nil, 'Special Fields:');
  Node1.ImageIndex := 9;
  Node1.SelectedIndex := 9;
  {Include all possible Special Fields}
  for i := Low(SpecialFieldNames) to High(SpecialFieldNames) do
  begin
    Node2 := tvFieldList.Items.AddChild(Node1, SpecialFieldNames[i]);
    if Cr.SpecialFields.IndexOf(SpecialFieldNames[i]) > -1 then
    begin
      Node2.ImageIndex := 3;
      Node2.SelectedIndex := 3;
    end
    else
    begin
      Node2.ImageIndex := 2;
      Node2.SelectedIndex := 2;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ tvFieldListDblClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFieldSelectDlg.tvFieldListDblClick(Sender: TObject);
var
  Node1 : TTreeNode;
  i     : integer;
begin
  Node1 := tvFieldList.Selected;
  case Node1.Level of
    0 :
      begin
        if Node1.Text = 'Database Fields:' then
        begin
          if EFSelect then Exit;
          if not bDatabaseFields then
          begin
            CrpeDatabaseFieldsDlg := TCrpeDatabaseFieldsDlg.Create(Application);
            CrpeDatabaseFieldsDlg.Cr := Cr;
          end;
          CrpeDatabaseFieldsDlg.Show;
        end;
        if Node1.Text = 'Formula Fields:' then
        begin
          if EFSelect then Exit;
          if not bFormulas then
          begin
            CrpeFormulasDlg := TCrpeFormulasDlg.Create(Application);
            CrpeFormulasDlg.Cr := Cr;
          end;
          CrpeFormulasDlg.Show;
        end;
        if Node1.Text = 'SQL Expression Fields:' then
        begin
          if EFSelect then Exit;
          if not bSQLExpressions then
          begin
            CrpeSQLExpressionsDlg := TCrpeSQLExpressionsDlg.Create(Application);
            CrpeSQLExpressionsDlg.Cr := Cr;
          end;
          CrpeSQLExpressionsDlg.Show;
        end;
        if Node1.Text = 'Parameter Fields:' then
        begin
          if EFSelect then Exit;
          if not bParamFields then
          begin
            CrpeParamFieldsDlg := TCrpeParamFieldsDlg.Create(Application);
            CrpeParamFieldsDlg.Cr := Cr;
          end;
          CrpeParamFieldsDlg.Show;
        end;
        if Node1.Text = 'Running Total Fields:' then
        begin
          if EFSelect then Exit;
          if not bRunningTotals then
          begin
            CrpeRunningTotalsDlg := TCrpeRunningTotalsDlg.Create(Application);
            CrpeRunningTotalsDlg.Cr := Cr;
          end;
          CrpeRunningTotalsDlg.Show;
        end;
        if Node1.Text = 'Group Name Fields:' then
        begin
          if EFSelect then Exit;
          if not bGroupNameFields then
          begin
            CrpeGroupNameFieldsDlg := TCrpeGroupNameFieldsDlg.Create(Application);
            CrpeGroupNameFieldsDlg.Cr := Cr;
          end;
          CrpeGroupNameFieldsDlg.Show;
        end;
        if Node1.Text = 'Special Fields:' then
        begin
          if EFSelect then Exit;
          if not bSpecialFields then
          begin
            CrpeSpecialFieldsDlg := TCrpeSpecialFieldsDlg.Create(Application);
            CrpeSpecialFieldsDlg.Cr := Cr;
          end;
          CrpeSpecialFieldsDlg.Show;
        end;
      end;
    1 :
      begin
        if Node1.Parent.Text = 'Database Fields:' then
        begin
          if EFSelect then Exit;
          if not bDatabaseFields then
          begin
            CrpeDatabaseFieldsDlg := TCrpeDatabaseFieldsDlg.Create(Application);
            CrpeDatabaseFieldsDlg.Cr := Cr;
          end;
          Cr.Tables.ItemIndex := Node1.Index;
          CrpeDatabaseFieldsDlg.Show;
          CrpeDatabaseFieldsDlg.UpdateDatabaseFields;
        end;

        if Node1.Parent.Text = 'Formula Fields:' then
        begin
          {Embedded Field Insert mode}
          if EFSelect then
          begin
            if bEmbeddedFields then
            begin
              Cr.Formulas.ItemIndex := Node1.Index;
              Cr.TextObjects.Item.EmbeddedFields.Insert('{@' + Cr.Formulas.Item.Name + '}',
                CrpeEmbeddedFieldsDlg.CursorPos);
              ModalResult := mrOk;
            end;
            Close;
            Exit;
          end;
          {Field Select mode}
          if not bFormulas then
          begin
            CrpeFormulasDlg := TCrpeFormulasDlg.Create(Application);
            CrpeFormulasDlg.Cr := Cr;
          end;
          Cr.Formulas.ItemIndex := Node1.Index;
          CrpeFormulasDlg.Show;
          CrpeFormulasDlg.UpdateFormulas;
        end;

        if Node1.Parent.Text = 'SQL Expression Fields:' then
        begin
          {Embedded Field Insert mode}
          if EFSelect then
          begin
            if bEmbeddedFields then
            begin
              Cr.SQLExpressions.ItemIndex := Node1.Index;
              Cr.TextObjects.Item.EmbeddedFields.Insert('{%' + Cr.SQLExpressions.Item.Name + '}',
                CrpeEmbeddedFieldsDlg.CursorPos);
              ModalResult := mrOk;
            end;
            Close;
            Exit;
          end;
          {Field Select mode}
          if not bSQLExpressions then
          begin
            CrpeSQLExpressionsDlg := TCrpeSQLExpressionsDlg.Create(Application);
            CrpeSQLExpressionsDlg.Cr := Cr;
          end;
          Cr.SQLExpressions.ItemIndex := Node1.Index;
          CrpeSQLExpressionsDlg.Show;
          CrpeSQLExpressionsDlg.UpdateSQLExpressions;
        end;

        if Node1.Parent.Text = 'Parameter Fields:' then
        begin
          {Embedded Field Insert mode}
          if EFSelect then
          begin
            if bEmbeddedFields then
            begin
              Cr.ParamFields.ItemIndex := Node1.Index;
              Cr.TextObjects.Item.EmbeddedFields.Insert('{?' + Cr.ParamFields.Item.Name + '}',
                CrpeEmbeddedFieldsDlg.CursorPos);
              ModalResult := mrOk;
            end;
            Close;
            Exit;
          end;
          {Field Select mode}
          if not bParamFields then
          begin
            CrpeParamFieldsDlg := TCrpeParamFieldsDlg.Create(Application);
            CrpeParamFieldsDlg.Cr := Cr;
          end;
          Cr.ParamFields.ItemIndex := Node1.Index;
          CrpeParamFieldsDlg.Show;
          CrpeParamFieldsDlg.UpdateParamFields;
        end;

        if Node1.Parent.Text = 'Running Total Fields:' then
        begin
          {Embedded Field Insert mode}
          if EFSelect then
          begin
            if bEmbeddedFields then
            begin
              Cr.RunningTotals.ItemIndex := Node1.Index;
              Cr.TextObjects.Item.EmbeddedFields.Insert('{#' + Cr.RunningTotals.Item.Name + '}',
                CrpeEmbeddedFieldsDlg.CursorPos);
              ModalResult := mrOk;
            end;
            Close;
            Exit;
          end;
          {Field Select mode}
          if not bRunningTotals then
          begin
            CrpeRunningTotalsDlg := TCrpeRunningTotalsDlg.Create(Application);
            CrpeRunningTotalsDlg.Cr := Cr;
          end;
          Cr.RunningTotals.ItemIndex := Node1.Index;
          CrpeRunningTotalsDlg.Show;
          CrpeRunningTotalsDlg.UpdateRunningTotals;
        end;

        if Node1.Parent.Text = 'Group Name Fields:' then
        begin
          {Embedded Field Insert mode}
          if EFSelect then
          begin
            if bEmbeddedFields then
            begin
              Cr.GroupNameFields.ItemIndex := Node1.Index;
              Cr.TextObjects.Item.EmbeddedFields.Insert(Cr.GroupNameFields.Item.FieldName,
                CrpeEmbeddedFieldsDlg.CursorPos);
              ModalResult := mrOk;
            end;
            Close;
            Exit;
          end;
          {Field Select mode}
          if not bGroupNameFields then
          begin
            CrpeGroupNameFieldsDlg := TCrpeGroupNameFieldsDlg.Create(Application);
            CrpeGroupNameFieldsDlg.Cr := Cr;
          end;
          Cr.GroupNameFields.ItemIndex := Node1.Index;
          CrpeGroupNameFieldsDlg.Show;
          CrpeGroupNameFieldsDlg.UpdateGroupNameFields;
        end;

        if Node1.Parent.Text = 'Special Fields:' then
        begin
          {Embedded Field Insert mode}
          if EFSelect then
          begin
            if bEmbeddedFields then
            begin
              Cr.TextObjects.Item.EmbeddedFields.Insert(RemoveSpaces(Node1.Text),
                CrpeEmbeddedFieldsDlg.CursorPos);
              ModalResult := mrOk;
            end;
            Close;
            Exit;
          end;
          {Field Select mode}
          if not bSpecialFields then
          begin
            CrpeSpecialFieldsDlg := TCrpeSpecialFieldsDlg.Create(Application);
            CrpeSpecialFieldsDlg.Cr := Cr;
          end;
          i := Cr.SpecialFields.IndexOf(Node1.Text);
          if i > -1 then
          begin
            Cr.SpecialFields.ItemIndex := i;
            CrpeSpecialFieldsDlg.Show;
            CrpeSpecialFieldsDlg.UpdateSpecialFields;
          end;
        end;
      end;
    2 :
      begin
        {Embedded Field Insert mode}
        if EFSelect then
        begin
          if bEmbeddedFields then
          begin
            Cr.Tables.ItemIndex := Node1.Parent.Index;
            Cr.Tables.Item.Fields.ItemIndex := Node1.Index;
            Cr.TextObjects.Item.EmbeddedFields.Insert(Cr.Tables.Item.Fields.Item.FullName,
              CrpeEmbeddedFieldsDlg.CursorPos);
            ModalResult := mrOk;
          end;
          Close;
          Exit;
        end;
        {Field Select mode}
        i := Cr.DatabaseFields.IndexOf('{' + Node1.Parent.Text + '.' + Node1.Text + '}');
        if i > -1 then
        begin
          Cr.DatabaseFields.ItemIndex := i;
          if not bDatabaseFields then
          begin
            CrpeDatabaseFieldsDlg := TCrpeDatabaseFieldsDlg.Create(Application);
            CrpeDatabaseFieldsDlg.Cr := Cr;
          end;
          CrpeDatabaseFieldsDlg.Show;
          CrpeDatabaseFieldsDlg.UpdateDatabaseFields;
        end
        else
        begin
          Cr.Tables.ItemIndex := Node1.Parent.Index;
          Cr.Tables.Item.Fields.ItemIndex := Node1.Index;
          if not bTables then
          begin
            CrpeTablesDlg := TCrpeTablesDlg.Create(Application);
            CrpeTablesDlg.Cr := Cr;
          end;
          CrpeTablesDlg.Show;
          CrpeTablesDlg.UpdateTables;
          if not bTableFields then
          begin
            CrpeTableFieldsDlg := TCrpeTableFieldsDlg.Create(Application);
            CrpeTableFieldsDlg.Cr := Cr;
          end;
          CrpeTableFieldsDlg.Show;
          CrpeTableFieldsDlg.UpdateFields;
        end;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFieldSelectDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveFormPos(Self);
  bFieldSelect := False;
  Release;
end;


end.
