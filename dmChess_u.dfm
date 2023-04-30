object dmChess: TdmChess
  OldCreateOrder = False
  Height = 375
  Width = 465
  object conChess: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=dbChe' +
      'ss.mdb;Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Syst' +
      'em database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Pas' +
      'sword="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode' +
      '=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Tra' +
      'nsactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create ' +
      'System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB' +
      ':Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without Re' +
      'plica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 128
  end
  object tblUsers: TADOTable
    Active = True
    Connection = conChess
    CursorType = ctStatic
    Filtered = True
    TableName = 'tblUsers'
    Left = 136
    Top = 24
  end
  object tblGames: TADOTable
    Active = True
    Connection = conChess
    CursorType = ctStatic
    Filtered = True
    TableName = 'tblGames'
    Left = 136
    Top = 80
    object tblGamesGameID: TAutoIncField
      FieldName = 'GameID'
      ReadOnly = True
    end
    object tblGamesWhite: TWideStringField
      FieldName = 'White'
    end
    object tblGamesBlack: TWideStringField
      FieldName = 'Black'
    end
    object tblGamesResult: TWideStringField
      FieldName = 'Result'
      Size = 3
    end
    object tblGamesRated: TBooleanField
      FieldName = 'Rated'
    end
    object tblGamesDateTimePlayed: TDateTimeField
      FieldName = 'DateTimePlayed'
    end
  end
  object tblLessons: TADOTable
    Active = True
    Connection = conChess
    CursorType = ctStatic
    TableName = 'tblLessons'
    Left = 136
    Top = 136
  end
  object qryChess: TADOQuery
    Connection = conChess
    Parameters = <>
    Left = 136
    Top = 264
  end
  object dsrGames: TDataSource
    DataSet = tblGames
    Left = 192
    Top = 80
  end
  object dsrChess: TDataSource
    DataSet = qryChess
    Left = 200
    Top = 280
  end
end
