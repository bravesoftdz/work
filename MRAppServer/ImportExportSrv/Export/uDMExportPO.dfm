inherited DMExportPO: TDMExportPO
  OldCreateOrder = True
  Left = 333
  Top = 197
  Height = 198
  Width = 291
  object quGetPOData: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPO'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'PO.IDPO,'
      #9'PO.DataPedido as PODate,'
      #9'PO.Freight,'
      #9'PO.Charges,'
      #9'PO.SubTotal,'
      #9'PO.EstArrival,'
      #9'PO.PayDays,'
      #9'PO.OBS,'
      #9'PIM.CostPrice,'
      #9'PIM.SalePrice,'
      #9'PIM.DateEstimatedMov,'
      #9'PIM.DateRealMov,'
      #9'PIM.Qty, '
      #9'PIM.CaseQty,'
      #9'(CASE WHEN (IsNull(PIM.CaseQty, 0) <> 0) THEN PIM.CaseQty'
      
        #9#9'ELSE (CASE WHEN (PIM.Qty - IsNull(PIM.QtyRealMov, 0)) >= 0 THE' +
        'N (PIM.Qty - IsNull(PIM.QtyRealMov, 0))'
      #9#9#9'ELSE 0 END)'
      #9' END) as QtyOrdered,'
      #9'PIM.CaseCost,'
      #9'M.Model,'
      #9'M.Description,'
      #9#39#39' VendorCode,'
      #9'B.IDBarcode as Barcode, '
      #9'P.UserCode,'
      #9'P.Pessoa as Vendor,'
      #9'P.Endereco as Address,'
      #9'P.Cidade as City,'
      #9'P.CEP as ZIP,'
      #9'S.Name as StoreName,'
      #9'SVA.Account as VendorAccount,'
      #9'M.IDModel,'
      #9'PO.IDFornecedor as IDVendor'
      'FROM'
      #9'PO'
      
        #9'JOIN PreInventoryMov PIM ON (PO.IDPO = PIM.DocumentID AND PIM.I' +
        'nventMovTypeID = 2)'
      #9'JOIN Model M ON (M.IDModel = PIM.ModelID)'
      #9'JOIN PESSOA P ON (P.IDPessoa = PO.IDFornecedor)'
      #9'JOIN STORE S ON (S.IDStore = PO.IDStore)'
      
        #9'LEFT JOIN Barcode B ON (M.IDModel = B.IDModel and B.BarcodeOrde' +
        'r = 1)'
      
        #9'LEFT OUTER JOIN Mnt_StoreVendorAccount SVA ON (SVA.IDPessoa = P' +
        'O.IDFornecedor and SVA.IDStore = PO.IDStore)'
      'WHERE'
      #9'IDPO = :IDPO'
      'ORDER BY '
      #9'M.Model')
    Left = 138
    Top = 8
    object quGetPODataIDPO: TIntegerField
      FieldName = 'IDPO'
    end
    object quGetPODataPODate: TDateTimeField
      FieldName = 'PODate'
    end
    object quGetPODataFreight: TBCDField
      FieldName = 'Freight'
      Precision = 19
    end
    object quGetPODataCharges: TBCDField
      FieldName = 'Charges'
      Precision = 19
    end
    object quGetPODataSubTotal: TBCDField
      FieldName = 'SubTotal'
      Precision = 19
    end
    object quGetPODataEstArrival: TDateTimeField
      FieldName = 'EstArrival'
    end
    object quGetPODataPayDays: TIntegerField
      FieldName = 'PayDays'
    end
    object quGetPODataOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object quGetPODataCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quGetPODataSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quGetPODataDateEstimatedMov: TDateTimeField
      FieldName = 'DateEstimatedMov'
    end
    object quGetPODataDateRealMov: TDateTimeField
      FieldName = 'DateRealMov'
    end
    object quGetPODataQty: TFloatField
      FieldName = 'Qty'
    end
    object quGetPODataCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object quGetPODataCaseCost: TBCDField
      FieldName = 'CaseCost'
      Precision = 19
    end
    object quGetPODataModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quGetPODataDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quGetPODataVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 35
    end
    object quGetPODataBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
    object quGetPODataUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object quGetPODataStoreName: TStringField
      FieldName = 'StoreName'
      Size = 30
    end
    object quGetPODataVendorAccount: TStringField
      FieldName = 'VendorAccount'
      Visible = False
      Size = 35
    end
    object quGetPODataQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
    end
    object quGetPODataIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object quGetPODataVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quGetPODataAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quGetPODataCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object quGetPODataZIP: TStringField
      FieldName = 'ZIP'
      FixedChar = True
      Size = 12
    end
    object quGetPODataIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
  end
  object cdsGetPOData: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDPO'
        ParamType = ptInput
      end>
    ProviderName = 'dspGetPOData'
    Left = 133
    Top = 114
  end
  object dspGetPOData: TDataSetProvider
    DataSet = quGetPOData
    Exported = False
    Left = 148
    Top = 61
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=BodyFarmaDB;Data Source=.'
    Provider = 'SQLOLEDB.1'
    Left = 220
    Top = 12
  end
end
