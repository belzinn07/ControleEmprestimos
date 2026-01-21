object dmPrincipal: TdmPrincipal
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\netob\AppData\Roaming\ControleEmprestimos\CONT' +
        'ROLE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=UTF8'
      'DriverID=FB')
    Connected = True
    Left = 248
    Top = 264
  end
  object qryPessoa: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    Left = 368
    Top = 264
  end
  object qryEmprestimo: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    Left = 472
    Top = 264
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 592
    Top = 264
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 248
    Top = 376
  end
  object dsPessoa: TDataSource
    DataSet = qryPessoa
    Left = 376
    Top = 376
  end
  object dsEmprestimo: TDataSource
    DataSet = qryEmprestimo
    Left = 480
    Top = 384
  end
end
