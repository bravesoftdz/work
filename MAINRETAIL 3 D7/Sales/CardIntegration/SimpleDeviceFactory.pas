unit SimpleDeviceFactory;

interface
uses DeviceIntegrationInterface, uSystemConst, DsiClientXIntegration, DSICLIENTXLib_TLB, DSIPDCXLib_TLB, DSIEMVXLib_TLB, VER1000XLib_TLB, VER2000XLib_TLB;

type
	TDeviceFactory = class
	public
		function CreateDevice(arg_deviceIndex: Integer): IDeviceIntegration;
	end;

implementation

function TDeviceFactory.CreateDevice(arg_deviceIndex: Integer): IDeviceIntegration;
begin

	case arg_deviceIndex of
	    PROCESSING_TYPE_DSICLIENTX: result := TDsiClientXIntegration.Create();
		
		//PROCESSING_TYPE_DSIPDCX: result := TDsiPDCX.Create(nil);

		//PROCESSING_TYPE_DSIEMVUS: result := TDsiEMVX.Create(nil);

		//... to future devices...

	end;
end;
	
end.
