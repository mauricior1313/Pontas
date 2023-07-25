object FrmCadastroFazendas: TFrmCadastroFazendas
  Left = 0
  Top = 0
  Caption = 'Cadastro de Fazendas'
  ClientHeight = 309
  ClientWidth = 641
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
  object CpnMain: TCardPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 309
    Align = alClient
    ActiveCard = CrdLista
    BevelOuter = bvNone
    Caption = 'CpnMain'
    TabOrder = 0
    object CrdLista: TCard
      Left = 0
      Top = 0
      Width = 641
      Height = 309
      Caption = 'CrdLista'
      CardIndex = 0
      TabOrder = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 641
        Height = 41
        Align = alTop
        BevelEdges = [beBottom]
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object BtnExcluir: TSpeedButton
          AlignWithMargins = True
          Left = 91
          Top = 3
          Width = 38
          Height = 33
          Cursor = crHandPoint
          Align = alLeft
          ImageIndex = 1
          ImageName = 'Cancel_16x16'
          Images = VirtualImageList1
          OnClick = BtnExcluirClick
          ExplicitLeft = 3
        end
        object BtnAlterar: TSpeedButton
          AlignWithMargins = True
          Left = 47
          Top = 3
          Width = 38
          Height = 33
          Cursor = crHandPoint
          Align = alLeft
          ImageIndex = 4
          ImageName = 'Edit_16x16'
          Images = VirtualImageList1
          OnClick = BtnAlterarClick
          ExplicitLeft = 3
        end
        object BtnIncluir: TSpeedButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 38
          Height = 33
          Cursor = crHandPoint
          Align = alLeft
          ImageIndex = 0
          ImageName = 'Add_16x16'
          Images = VirtualImageList1
          OnClick = BtnIncluirClick
        end
      end
      object Grid: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 44
        Width = 635
        Height = 262
        Align = alClient
        DataSource = Dts
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'FZN_ID'
            Title.Caption = 'C'#243'digo'
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FZN_RAZAOSOCIAL'
            Title.Caption = 'Raz'#227'o Social'
            Width = 222
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FZN_NOMEFANTASIA'
            Title.Caption = 'Nome Fantasia'
            Width = 152
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FZN_NRODOCUMENTO'
            Title.Caption = 'CNPJ'
            Width = 130
            Visible = True
          end>
      end
    end
    object CrdCadastro: TCard
      Left = 0
      Top = 0
      Width = 641
      Height = 309
      Caption = 'CrdCadastro'
      CardIndex = 1
      TabOrder = 1
      ExplicitWidth = 823
      ExplicitHeight = 410
      object Label2: TLabel
        Left = 32
        Top = 67
        Width = 60
        Height = 13
        Caption = 'Raz'#227'o Social'
        FocusControl = DbeRazaoSocial
      end
      object Label3: TLabel
        Left = 32
        Top = 115
        Width = 71
        Height = 13
        Caption = 'Nome Fantasia'
        FocusControl = DbeNomeFantasia
      end
      object Label5: TLabel
        Left = 32
        Top = 20
        Width = 25
        Height = 13
        Caption = 'CNPJ'
      end
      object Panel2: TPanel
        Left = 0
        Top = 268
        Width = 641
        Height = 41
        Align = alBottom
        BevelEdges = [beTop]
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 369
        ExplicitWidth = 823
        object BtnSalvar: TSpeedButton
          AlignWithMargins = True
          Left = 556
          Top = 3
          Width = 38
          Height = 33
          Cursor = crHandPoint
          Align = alRight
          ImageIndex = 7
          ImageName = 'SaveTo_16x16'
          Images = VirtualImageList1
          OnClick = BtnSalvarClick
          ExplicitLeft = 287
          ExplicitTop = 5
        end
        object BtnCancelar: TSpeedButton
          AlignWithMargins = True
          Left = 600
          Top = 3
          Width = 38
          Height = 33
          Cursor = crHandPoint
          Align = alRight
          ImageIndex = 6
          ImageName = 'SaveAndClose_16x16'
          Images = VirtualImageList1
          OnClick = BtnCancelarClick
          ExplicitLeft = 331
          ExplicitTop = 5
        end
      end
      object DbeRazaoSocial: TDBEdit
        Left = 32
        Top = 83
        Width = 577
        Height = 21
        CharCase = ecUpperCase
        DataField = 'FZN_RAZAOSOCIAL'
        DataSource = Dts
        TabOrder = 2
      end
      object DbeNomeFantasia: TDBEdit
        Left = 32
        Top = 131
        Width = 577
        Height = 21
        CharCase = ecUpperCase
        DataField = 'FZN_NOMEFANTASIA'
        DataSource = Dts
        TabOrder = 3
      end
      object EdtNroDocumento: TMaskEdit
        Left = 32
        Top = 35
        Width = 576
        Height = 21
        EditMask = '00.000.000/0000-00;0;_'
        MaxLength = 18
        TabOrder = 0
        Text = ''
      end
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Add_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C0000001B744558745469746C65004164643B506C75733B426172
              733B526962626F6E3B9506332F0000004749444154785EE592C90900200C046D
              D0A6ACCAEE4604E32B8AB8011F3E0602590672244062DBCCA532E8F5D7024017
              AC98C11B4205C6D10896F50486B744235CA09FF1FD274A34995FABF9E946D7E8
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Cancel_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C00000023744558745469746C650043616E63656C3B53746F703B
              457869743B426172733B526962626F6E3B4C9696B20000009449444154785E95
              93410A834010047D5C2027F3093F104C6461C5CD37F312C5D3641AD27810BAF1
              5030CC587510B68B88EE3BDCFAA46236F0FB190E66CA7B12C9125EFE24F1771E
              584C9009234626230FE514F1F21B2E8E22A2650654A42999011951320322A265
              E0FFF6411301219B88935F49511129F3A622567611C8B3905DA462794FD693EC
              231B5C2C19795E78CE131CCC3FD2409CCC2C3656140000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Close_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C0000001D744558745469746C6500436C6F73653B457869743B42
              6172733B526962626F6E3B4603B9E80000008D49444154785EC5D3310A843014
              8461ABA0F7DA9B7891B8284874D9B3982A47F136D9E7E26B86611A058BA9C2FF
              150969F6FE55AFEC7620DB26118CB6CC008F43AD7FF44DE2789E05DBC68074C4
              3E40229C7D10F0CD800C245EE4252222620008A2630D44020C025031221A8810
              ACFC623930622C5E676240B175182362516B2B0C70E42BFE40F2D8F7FC6FFC01
              4BA2809EA80656100000000049454E44AE426082}
          end>
      end
      item
        Name = 'CheckBox_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100803000000282D0F
              530000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C00000015744558745469746C6500436865636B3B4D61726B3B54
              69636B0B00C72400000045504C544576A797FFFFFFFCFDFD9DC0B4FBFDFC98BD
              B1FAFCFB77A7979DC0B5A2C3B8E0EBE8EAF2EF89B3A57BAA9BEDF3F180AD9EA3
              C4B9E1ECE8B8D1C978A898F9FBFA9FC1B681AEA09D03B0E00000004F49444154
              785EA5CFC90E80400803D029B3BAEFFEFFA78A36D1C8CDD8DB2B1CC0FD4C36F6
              F5F076C0C49D850642B9DC369173D05D8F14D5E79C190569567B055309403F0D
              84FB77B36EE6A6FDC33F07B637017A5826E4DC0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Edit_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000000B744558745469746C6500456469743B6535AC440000007B49444154
              785E9D93210E80400C040FC78B30BC0124AFC0A2215870F0987B161F38A06D42
              36A9622B46CE744D53B766964938854A9D88FC285F840DEC268383B93CBBC82D
              8CDC6C443695D561641F310819B35D202283A00C823208CB3ED0F2320283500B
              0B272370091911C87F03C5AE22D230FF91DCEC9E7DEF17E6DCCD046CE136C900
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Save_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C0000000B744558745469746C6500536176653BF9E8F909000000
              5249444154785EEDD1310AC0200C86D19CD7EB7810C74C39DBAF2D4A86188215
              3B397C82441E0109C056EF915391169EFA1D263B1305DC478ACEF03F006D0970
              8B81B87380AE1F7701D0915FE00F000F60AB0ABEAED30B0888EDC10000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'SaveAndClose_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C00000020744558745469746C65005361766520416E6420436C6F
              73653B536176653B436C6F73653B2A84087B0000007449444154785EBDD1B109
              C4300C46610F974DAEBB75527B869457798FDBE68F1D04AF10428890140F616C
              7F38A449BAD505ECDF63CCB4B2B55C7E6F00C487403DA037002A01613990F714
              80582901E8FFD9145501D6EC33D96C25804BCC1A608881DD7D4214009741007E
              39C0B3410CA0FA5F380154C9BB1D99C041B80000000049454E44AE426082}
          end>
      end
      item
        Name = 'SaveTo_16x16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C00000012744558745469746C65005361766520546F3B53617665
              D4AB99720000007B49444154785EBDD1B10980301085E12C788B38808B583882
              A56063E56CCF9C78E1599847142D3EE321F921310178E518866EDE32B873C60D
              FEB66525001148BC865F03680A843C5FE980F66DC063E2084C07FA6964201EF0
              F57920A8004EC6019E55C0325458ED2F2C39508B181F616D8C18DF41212ED178
              73D801EB02895D95F39E360000000049454E44AE426082}
          end>
      end>
    Left = 536
    Top = 160
  end
  object Qry: TFDQuery
    AfterPost = QryAfterPost
    AfterDelete = QryAfterDelete
    OnNewRecord = QryNewRecord
    CachedUpdates = True
    Connection = DtmMain.ConPrincipal
    SQL.Strings = (
      'SELECT FZN_ID'
      '      ,FZN_RAZAOSOCIAL'
      '      ,FZN_NOMEFANTASIA'
      '      ,FZN_NRODOCUMENTO'
      '  FROM FAZENDA'
      ' WHERE 1=1')
    Left = 280
    Top = 112
    object QryFZN_RAZAOSOCIAL: TWideStringField
      FieldName = 'FZN_RAZAOSOCIAL'
      Origin = 'FZN_RAZAOSOCIAL'
      Required = True
      Size = 60
    end
    object QryFZN_NOMEFANTASIA: TWideStringField
      FieldName = 'FZN_NOMEFANTASIA'
      Origin = 'FZN_NOMEFANTASIA'
      Required = True
      Size = 60
    end
    object QryFZN_NRODOCUMENTO: TWideStringField
      FieldName = 'FZN_NRODOCUMENTO'
      Origin = 'FZN_NRODOCUMENTO'
      Required = True
      Size = 14
    end
    object QryFZN_ID: TIntegerField
      FieldName = 'FZN_ID'
      Origin = 'FZN_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object VirtualImageList1: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Add_16x16'
        Disabled = False
        Name = 'Add_16x16'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Cancel_16x16'
        Disabled = False
        Name = 'Cancel_16x16'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Close_16x16'
        Disabled = False
        Name = 'Close_16x16'
      end
      item
        CollectionIndex = 3
        CollectionName = 'CheckBox_16x16'
        Disabled = False
        Name = 'CheckBox_16x16'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Edit_16x16'
        Disabled = False
        Name = 'Edit_16x16'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Save_16x16'
        Disabled = False
        Name = 'Save_16x16'
      end
      item
        CollectionIndex = 6
        CollectionName = 'SaveAndClose_16x16'
        Disabled = False
        Name = 'SaveAndClose_16x16'
      end
      item
        CollectionIndex = 7
        CollectionName = 'SaveTo_16x16'
        Disabled = False
        Name = 'SaveTo_16x16'
      end>
    ImageCollection = ImageCollection1
    Left = 536
    Top = 216
  end
  object Dts: TDataSource
    DataSet = Qry
    Left = 336
    Top = 112
  end
end
