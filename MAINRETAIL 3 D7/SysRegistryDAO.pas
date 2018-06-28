unit SysRegistryDAO;

interface
uses SysRegistryCls, Classes, DB, ADODb, SysUtils;

type
   TSysRegistryDAO = class
   private
      FConnection: TADOConnection;
      registry: TSysRegistry;
   public
      constructor create(connection: TADOConnection);
      function select(aAttributeName: string; aRows: TList ): Boolean;
      function insert(): Boolean;
      function update(aID: Integer): Boolean;
      function isEmpty(): Boolean;
      procedure setRegistry(registry: TSysRegistry);
   end;

implementation

uses
  Variants;

{ TSysRegistryDAO }

constructor TSysRegistryDAO.create(connection: TADOConnection);
begin
   FConnection := connection;
end;

function TSysRegistryDAO.select(aAttributeName: string; aRows: TList ): Boolean;
var
  qry: TADOQuery;
  mySysRegistry: TSysRegistry;
begin
  try
     try
       Assert(Assigned(aRows));
       result := false;

       qry := TADOQuery.Create(nil);
       qry.Connection := FConnection;
       qry.SQL.Add('select * from Sis_Registry');
       qry.Open;

       qry.First;
        while (not qry.Eof) do
        begin
          if not Variants.VarIsNull(qry.FieldValues['AttributeName']) then
          begin
            if VarToStr(qry.FieldValues['AttributeName']) = aAttributeName then
            begin
              mySysRegistry:= TSysRegistry.Create; // to be disposed in the caller function

              mySysRegistry.AttributeName:= VarToStr(qry.FieldValues['AttributeName']);

              if not Variants.VarIsNull(qry.FieldValues['ID']) then
                mySysRegistry.ID:= qry.FieldValues['ID'];

              if not Variants.VarIsNull(qry.FieldValues['AttributeValue']) then
                mySysRegistry.AttributeValue:= VarToStr(qry.FieldValues['AttributeValue']);

              if not Variants.VarIsNull(qry.FieldValues['AttributeType']) then
                mySysRegistry.AttributeType:= VarToStr(qry.FieldValues['AttributeType']);

              if not Variants.VarIsNull(qry.FieldValues['ConstraintValue']) then
                mySysRegistry.ConstraintValue:= VarToStr(qry.FieldValues['ConstraintValue']);

              if not Variants.VarIsNull(qry.FieldValues['ContraintType']) then
                mySysRegistry.ConstraintType:= (qry.FieldValues['ContraintType']);

              aRows.Add(mySysRegistry);
            end;
          end;
          qry.Next;
        end;

        result:= true;

     except
         on e: Exception do begin
               raise Exception.Create('Failed to select from Sis_Registry');
         end;
     end
  finally
    freeAndNil(qry);
  end;
end;

function TSysRegistryDAO.insert(): Boolean;
var
  qry: TADOQuery;
begin
  try
     try
        result := false;

        qry := TADOQuery.Create(nil);
        qry.Connection := FConnection;
        qry.SQL.Add('insert into Sis_Registry (');
        qry.SQL.Add('AttributeName');
        qry.SQL.Add(',AttributeValue');
        qry.SQL.Add(',AttributeType');
        qry.SQL.Add(',ConstraintValue');
        qry.SQL.Add(',ContraintType )');
        qry.SQL.Add('values (');
        qry.SQL.Add(':attname');
        qry.SQL.Add(',:attvalue');
        qry.SQL.Add(',:atttype');
        qry.SQL.Add(',:constrvalue');
        qry.SQL.Add(',:constrtype )');
        qry.Parameters.ParamByName('attname').Value := registry.AttributeName;
        qry.Parameters.ParamByName('attvalue').Value := registry.AttributeValue;
        qry.Parameters.ParamByName('atttype').Value := registry.AttributeType;
        qry.Parameters.ParamByName('constrvalue').Value := registry.ConstraintValue;
        qry.Parameters.ParamByName('constrtype').Value := registry.ConstraintType;

        qry.ExecSQL;
        result := true;

     except
         on e: Exception do begin
               raise Exception.Create('Failed to insert registry');
         end;
     end
  finally
    freeAndNil(qry);
  end;
end;

function TSysRegistryDAO.update(aID: Integer): Boolean;
var
  qry: TADOQuery;
begin
  try
     try
        result := false;

        qry := TADOQuery.Create(nil);
        qry.Connection := FConnection;
        qry.SQL.Add('update Sis_Registry set ');
        qry.SQL.Add('AttributeName=:attname, ');
        qry.SQL.Add('AttributeValue=:attvalue,');
        qry.SQL.Add('AttributeType=:atttype,');
        qry.SQL.Add('ConstraintValue=:constrvalue,');
        qry.SQL.Add('ContraintType=:constrtype ');
        qry.SQL.Add('where ID=:ID');
        qry.Parameters.ParamByName('ID').Value := aID;
        qry.Parameters.ParamByName('attname').Value := registry.AttributeName;
        qry.Parameters.ParamByName('attvalue').Value := registry.AttributeValue;
        qry.Parameters.ParamByName('atttype').Value := registry.AttributeType;
        qry.Parameters.ParamByName('constrvalue').Value := registry.ConstraintValue;
        qry.Parameters.ParamByName('constrtype').Value := registry.ConstraintType;

        qry.ExecSQL;
        result := true;

     except
         on e: Exception do begin
               raise Exception.Create('Failed to insert registry');
         end;
     end
  finally
    freeAndNil(qry);
  end;
end;

function TSysRegistryDAO.isEmpty: Boolean;
var
  qry: TADOQuery;
begin
  try
     try
        result := false;

        qry := TADOQuery.Create(nil);
        qry.Connection := FConnection;
        qry.SQL.Add('select * from Sis_Registry');

        qry.Open;

        result := (qry.recordCount = 0 );

     except
         on e: Exception do begin
               raise Exception.Create('Failed to read registry: '+e.Message);
         end;
     end
  finally
    freeAndNil(qry);
  end;
end;

procedure TSysRegistryDAO.setRegistry(registry: TSysRegistry);
begin
  self.registry := registry;
end;

end.
