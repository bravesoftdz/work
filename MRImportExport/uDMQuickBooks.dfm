object DMQuickBooks: TDMQuickBooks
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 200
  Top = 151
  Height = 489
  Width = 675
  object ibqCustomer: TibqCustomer
    BillingAddress = 
      '<Addr1></Addr1><Addr2></Addr2><Addr3></Addr3><Addr4></Addr4><Cit' +
      'y></City><State></State><PostalCode></PostalCode><Country></Coun' +
      'try>'
    ShippingAddress = 
      '<Addr1></Addr1><Addr2></Addr2><Addr3></Addr3><Addr4></Addr4><Cit' +
      'y></City><State></State><PostalCode></PostalCode><Country></Coun' +
      'try>'
    Left = 56
    Top = 23
  end
  object ibqObjSearch: TibqObjSearch
    Left = 55
    Top = 90
  end
  object ibqAccount: TibqAccount
    Left = 165
    Top = 25
  end
end
