object DtmMain: TDtmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 112
  Width = 105
  object ConPrincipal: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\LENOVO-EQP410\Documents\Embarcadero\Studio\Pro' +
        'jects\Pessoal\Pontas\AgroT\bin\data\AGRO_FB25.DB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'Port=3051'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 32
  end
end
