unit DeviceIntegrationInterface;

interface

uses uCreditCardFunction, uMRPinpad, ProcessorInterface;

type
	IDeviceIntegration = Interface

        function InitializeStatus(): Boolean;
        function ProcessCommand(arg_xml: WideString): Boolean;

        // Credit Transactions
		function CreditProcessSale(): Boolean;
		function CreditProcessReturn(): Boolean;
        function CreditVoidSale(): Boolean;
        function CreditVoidReturn(): Boolean;

        // Debit Transactions
		function  DebitProcessSale(): Boolean;
		function  DebitProcessReturn(): Boolean;

        // Prepaid transactions
        function GiftProcessSale(): Boolean;
        function GiftProcessReturn(): Boolean;
        function GiftVoidSale(): Boolean;
        function GiftVoidReturn(): Boolean;
        function GiftIssue: Boolean;
        function GiftVoidIssue: Boolean;
        function GiftReload: Boolean;
        function GiftVoidReload: Boolean;
        function GiftBalance: Boolean;
        function GiftNoNSFSale: Boolean;
        function GiftCashOut: Boolean;

        // Antonio September 11, 2013
        function tryIssueCard(arg_salePrice: double): TTransactionReturn;
        function tryBalanceCard(arg_salePrice: double): TTransactionReturn;

		procedure SetProcessor(arg_processor: IProcessor);
        procedure SetPinPad(arg_device: TMRPinPad);

		function GetTransaction(): IProcessor;

        procedure BeforeProcessCard();
        procedure BeforeVoid();

	end;


implementation

end.
