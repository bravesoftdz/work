inherited SubModelFeatures: TSubModelFeatures
  Left = 1254
  Top = 503
  Width = 185
  Height = 146
  Caption = 'SubModelFeatures'
  PixelsPerInch = 96
  TextHeight = 13
  object memFeatures: TMemo [0]
    Left = 0
    Top = 0
    Width = 177
    Height = 119
    TabStop = False
    Align = alClient
    BevelInner = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'memFeatures')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object quFeatures: TPowerADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'SELECT '#13#10#9'F.IDInvFeatures,'#13#10#9'F.Feature'#13#10'FROM'#13#10#9'InvFeatures F (NO' +
      'LOCK)'#13#10'WHERE'#13#10#9'F.IDModel = :IDModel'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 125
    Top = 13
    object quFeaturesIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object quFeaturesFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object quTechFeature: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'F.IDInvTechFeatures,'
      #9'F.TechFeature'
      'FROM'
      #9'InvTechFeatures F (NOLOCK)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = F.IDModel)'
      'WHERE'
      #9'F.IDModel = :IDModel')
    Left = 126
    Top = 66
    object quTechFeatureIDInvTechFeatures: TIntegerField
      FieldName = 'IDInvTechFeatures'
    end
    object quTechFeatureTechFeature: TStringField
      FieldName = 'TechFeature'
      Size = 255
    end
  end
end
