object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Menu'
  ClientHeight = 64
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MnMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MnMenu: TMainMenu
    Left = 16
    Top = 8
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object MniFazenda: TMenuItem
        Caption = '&Fazendas'
        OnClick = MniFazendaClick
      end
      object MniAnimais: TMenuItem
        Caption = '&Animais'
        OnClick = MniAnimaisClick
      end
      object Animais2: TMenuItem
        Caption = '-'
      end
      object MniSair: TMenuItem
        Caption = '&Sair'
      end
    end
    object Cadastros2: TMenuItem
      Caption = 'Relat'#243'rios'
      object MniRelCadFazendas: TMenuItem
        Caption = '&Fazendas Cadastradas'
        OnClick = MniRelCadFazendasClick
      end
      object MniRelCadAnimais: TMenuItem
        Caption = '&Animais Cadastrados'
        OnClick = MniRelCadAnimaisClick
      end
    end
  end
end
