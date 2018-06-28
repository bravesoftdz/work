unit uSisMenuFxd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, Db, DBTables, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  dxBar, ImgList, ADODB, siComp, siLangRT;

type
  TSisMenuFxd = class(TParentFixedFrm)
    lvMenu: TListView;
    ilMenuItemLarge: TImageList;
    Panel1: TPanel;
    Panel3: TPanel;
    lblTitulo: TLabel;
    lblObs: TLabel;
    lblPath: TLabel;
    quMenu: TADOQuery;
    quMenuIDMenuItem: TIntegerField;
    quMenuMenuItem: TStringField;
    quMenuFormID: TIntegerField;
    quMenuIDMenuItemParent: TIntegerField;
    quMenuLoaderType: TIntegerField;
    quMenuParametro: TStringField;
    quMenuPriority: TIntegerField;
    quMenuImageIndex: TIntegerField;
    quMenuObs: TStringField;
    btLocalBack: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure lvMenuChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvMenuDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btLocalBackClick(Sender: TObject);
  private
    { Private declarations }
    slPilhaNome:  TStringList;
    slPilhaNivel: TStringList;

    procedure MontaNivel(NivelSuperior: integer);
    procedure MontaPath;


  public
    { Public declarations }
  end;

var
  SisMenuFxd: TSisMenuFxd;

implementation

uses uDM, uNumericFunctions;

{$R *.DFM}

procedure TSisMenuFxd.MontaNivel(NivelSuperior: integer);
var
  ListItem: TListItem;

begin
  with quMenu do
    begin
      if not Active then
        Open;

      if Locate('IDMenuItemParent', IntToStr(NivelSuperior), []) then
        begin
          // Empilho o mome e o IDMenuItemParent
          if lvMenu.ItemFocused = nil then
            slPilhaNome.Add('Raiz')
          else
            slPilhaNome.Add(lvMenu.ItemFocused.Caption);

          slPilhaNivel.Add(IntToStr(NivelSuperior));

          lvMenu.Items.Clear;

          MontaPath;

          while (quMenuIDMenuItemParent.AsInteger = NivelSuperior) AND NOT EOF do
            begin
              ListItem := lvMenu.Items.Add;
              ListItem.SubItems.Add(quMenuIDMenuItem.AsString);
              ListItem.SubItems.Add(quMenuIDMenuItemParent.AsString);
              ListItem.SubItems.Add(quMenuObs.AsString);
              ListItem.Caption    := quMenuMenuItem.AsString;
              ListItem.ImageIndex := quMenuImageindex.AsInteger;
              Next;
            end;

        end;

    end;
end;

procedure TSisMenuFxd.FormCreate(Sender: TObject);
begin
  inherited;
  slPilhaNome  := TStringList.Create;
  slPilhaNivel := TStringList.Create;

  MontaNivel(1);
end;

procedure TSisMenuFxd.lvMenuChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;

  if lvMenu.ItemFocused <> nil then
    begin
      lblTitulo.Caption := lvMenu.ItemFocused.Caption;
      lblObs.Caption    := lvMenu.ItemFocused.SubItems[2];
    end
  else
    begin
      if lvMenu.Items.Count > 0 then
        begin
          lblTitulo.Caption := lvMenu.Items[0].Caption;
          lblObs.Caption    := lvMenu.Items[0].SubItems[2];
        end;
    end;

end;

procedure TSisMenuFxd.lvMenuDblClick(Sender: TObject);
begin
  inherited;
  MontaNivel(MyStrToInt(lvMenu.ItemFocused.SubItems[0]));

end;

procedure TSisMenuFxd.FormDestroy(Sender: TObject);
begin
  inherited;
  slPilhaNome.Free;
  slPilhaNivel.Free;

end;


procedure TSisMenuFxd.MontaPath;
var
  i: integer;

begin
  lblPath.Caption := '';

  for i := 0 to slPilhaNome.Count-1 do
    lblPath.Caption := lblPath.Caption + '\ ' + slPilhaNome[i];

end;


procedure TSisMenuFxd.btLocalBackClick(Sender: TObject);
var
  NivelAnterior: Integer;

begin
  inherited;
  NivelAnterior := MyStrToInt(slPilhaNivel[slPilhaNivel.Count-2]);

  slPilhaNivel.Delete(slPilhaNivel.Count-1);
  slPilhaNome.Delete(slPilhaNome.Count-1);
  slPilhaNivel.Delete(slPilhaNivel.Count-1);
  slPilhaNome.Delete(slPilhaNome.Count-1);

  MontaNivel(NivelAnterior);

end;

end.
