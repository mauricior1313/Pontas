object FrmRelatorio: TFrmRelatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MemRelatorio: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 256
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 256
    Width = 635
    Height = 43
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      635
      41)
    object BtnSalvar: TBitBtn
      Left = 471
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Salvar'
      TabOrder = 0
      OnClick = BtnSalvarClick
    end
    object BtnFechar: TBitBtn
      Left = 552
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
      ModalResult = 8
      TabOrder = 1
    end
  end
  object Qry: TFDQuery
    Connection = DtmMain.ConPrincipal
    Left = 240
    Top = 56
  end
  object SaveDialog: TSaveDialog
    Left = 336
    Top = 56
  end
end
