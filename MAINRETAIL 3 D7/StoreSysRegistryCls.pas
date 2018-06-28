unit StoreSysRegistryCls;

interface
uses SysRegistryCls;

type
   TStoreSysRegistry = class(TSysRegistry)
   private
     FattributeName: String;
     FattributeValue: String;
     FattributeType: String;
     FconstraintValue: String;
     FconstraintType: Byte;
   protected
     //

   public
     constructor create();
     property AtributeName: String read FattributeName write FAttributeName;
     property AttributeValue: String read FattributeValue write FattributeValue;
     property AttributeType: String read FattributeType write FattributeType;
     property ConstraintValue: String read FconstraintValue write FconstraintValue;
     property ConstraintType: Byte read FconstraintType write FconstraintType;
     procedure fillSysRegistry; override;
   end;

implementation

{ TStoreSysRegistry }

constructor TStoreSysRegistry.create;
begin
   inherited;
end;

procedure TStoreSysRegistry.fillSysRegistry;
begin
 //
end;


end.
