unit RegProperty;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls,
  DBTables, DesignIntf, DesignEditors, TypInfo, DB, StdCtrls, dialogs;

procedure Register;

implementation

uses
  DBTreeView;

{ TDBStringProperty }

type
  TDBStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual; abstract;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ TLookUpFieldProperty }

type
  TLookUpFieldProperty = class(TDbStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
    function GetTablePropName: string; virtual;
  end;

function TLookUpFieldProperty.GetTablePropName: string;
begin
  Result := 'LookUpTable';
end;

procedure TLookUpFieldProperty.GetValueList(List: TStrings);
var
  Instance: TComponent;
  PropInfo: PPropInfo;
  LookUpTable : TTable;
begin
  Instance := TComponent(GetComponent(0));
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, GetTablePropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
  begin
    LookUpTable := TObject(GetOrdProp(Instance, PropInfo)) as TTable;
    if (LookUpTable <> nil) then
      LookUpTable.GetFieldNames(List);
  end;
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string), TDBTreeView, 'IDItemField', TLookUpFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBTreeView, 'NameField', TLookUpFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBTreeView, 'PathField', TLookUpFieldProperty);
end;

end.
