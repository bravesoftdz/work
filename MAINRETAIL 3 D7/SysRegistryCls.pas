unit SysRegistryCls;

interface

type
   TSysRegistry = class
   private
     FID: Integer;
     FAttributeName: String;
     FAttributeValue: String;
     FAttributeType: String;
     FConstraintValue: String;
     FConstraintType: Byte;
   protected
     //

   public
     property ID: Integer read FID write FID;
     property AttributeName: String read FAttributeName write FAttributeName;
     property AttributeValue: String read FAttributeValue write FAttributeValue;
     property AttributeType: String read FAttributeType write FAttributeType;
     property ConstraintValue: String read FConstraintValue write FConstraintValue;
     property ConstraintType: Byte read FConstraintType write FConstraintType;

     procedure fillSysRegistry; virtual; abstract;
   end;

implementation

{ TSysRegistry }

end.
