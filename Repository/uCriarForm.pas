unit uCriarForm;

interface
Uses
   Forms, Classes;


Function CriaForm(aOwner:TComponent;Const aNomeCadastro:String): TForm;

implementation

Function CriaForm(aOwner:TComponent;Const aNomeCadastro:String): TForm;
var
  FrmClass   : TFormClass;
begin
  FrmClass := TFormClass(GetClass(aNomeCadastro));
  if FrmClass<>nil then
  begin
    Result := FrmClass.Create(aOwner);
  end
  else
    Result := Nil;
end;

end.
 