unit uFrmPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.VirtualImage, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids,
  Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmPesquisa = class(TForm)
    Panel4: TPanel;
    VirtualImage1: TVirtualImage;
    Label31: TLabel;
    Label32: TLabel;
    pnlBottom: TPanel;
    BtnSelecionar: TBitBtn;
    btnCancel: TBitBtn;
    Panel1: TPanel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    Panel2: TPanel;
    Grid: TDBGrid;
    GroupBox1: TGroupBox;
    RdbCodigo: TRadioButton;
    RdbDescricao: TRadioButton;
    EdtFiltro: TButtonedEdit;
    QryGrid: TFDQuery;
    DtsGrid: TDataSource;
    MtbResultado: TFDMemTable;
    procedure RdbCodigoClick(Sender: TObject);
    procedure RdbDescricaoClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtFiltroChange(Sender: TObject);
    procedure EdtFiltroExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FCampoDescricao: string;
    FTabela: string;
    FCampoCodigo: string;
    FCampoFiltro: string;
    FDescricao: string;
    FCodigo: Integer;
    procedure DoSetStateRadioButton(RadioButton: TRadioButton);
    procedure DoOpenQuery;
    procedure SetCampoCodigo(const Value: string);
    procedure SetCampoDescricao(const Value: string);
    procedure SetTabela(const Value: string);
  public
    property CampoCodigo: string read FCampoCodigo write SetCampoCodigo;
    property CampoDescricao: string read FCampoDescricao write SetCampoDescricao;
    property Tabela: string read FTabela write SetTabela;
    property Codigo: Integer read FCodigo;
    property Descricao: string read FDescricao;
  end;

procedure Pesquisar(const ACampoCodigo, ACampoDescricao, ATabela: string; var Codigo: Integer; var Descricao: string);

var
  FrmPesquisa: TFrmPesquisa;

implementation

{$R *.dfm}

uses uDtmMain;

procedure Pesquisar(const ACampoCodigo, ACampoDescricao, ATabela: string; var Codigo: Integer; var Descricao: string);
var
  Tela: TFrmPesquisa;
begin
  Tela := TFrmPesquisa.Create(nil);
  try
    Tela.CampoCodigo := ACampoCodigo;
    Tela.CampoDescricao := ACampoDescricao;
    Tela.Tabela := ATabela;
    Tela.ShowModal;
    if Tela.ModalResult = mrOk then
    begin
      Codigo := Tela.Codigo;
      Descricao := Tela.Descricao;
    end;

  finally
    FreeAndNil(Tela);
  end;
end;

procedure TFrmPesquisa.btnCancelClick(Sender: TObject);
begin
  Close;
  ModalResult := mrCancel;
end;

procedure TFrmPesquisa.BtnSelecionarClick(Sender: TObject);
begin

  FCodigo := QryGrid.FieldByName('CODIGO').AsInteger;
  FDescricao := QryGrid.FieldByName('DESCRICAO').AsString;
  Close;
  ModalResult := mrOk;
end;

procedure TFrmPesquisa.DoOpenQuery;
var
  SQL: string;
begin
  SQL :=
    'SELECT ' + FCampoCodigo + ' AS CODIGO, ' + FCampoDescricao + ' AS DESCRICAO ' +
    '  FROM ' + FTabela +
    ' WHERE 1 = 1 ';
  QryGrid.Open(SQL);
  MtbResultado.CloneCursor(QryGrid, True, False);
  MtbResultado.Close;
  MtbResultado.Open;
end;

procedure TFrmPesquisa.DoSetStateRadioButton(RadioButton: TRadioButton);
begin
  if RadioButton.Checked then
  begin
    RadioButton.Font.Color := clBlack;
    RadioButton.Font.Style := [TFontStyle.fsBold];
  end
  else
  begin
    RadioButton.Font.Color := clMedGray;
    RadioButton.Font.Style := [];
  end;
end;

procedure TFrmPesquisa.EdtFiltroChange(Sender: TObject);
begin
  QryGrid.Filtered := False;
  QryGrid.Filter := FCampoFiltro + ' LIKE ' + QuotedStr('%' + EdtFiltro.Text + '%');
  QryGrid.Filtered := True;
end;

procedure TFrmPesquisa.EdtFiltroExit(Sender: TObject);
begin
  if Trim(EdtFiltro.Text) = '' then
  begin
    QryGrid.Filtered := False;
    QryGrid.Filter := '';
  end;
end;

procedure TFrmPesquisa.FormCreate(Sender: TObject);
begin
  FCampoFiltro := 'CODIGO';
end;

procedure TFrmPesquisa.FormShow(Sender: TObject);
begin
  DoOpenQuery;
end;

procedure TFrmPesquisa.GridDblClick(Sender: TObject);
begin
  BtnSelecionar.Click;
end;

procedure TFrmPesquisa.RdbCodigoClick(Sender: TObject);
begin
  FCampoFiltro := 'CODIGO';
  RdbDescricao.Checked := False;
  RdbCodigo.Checked := not RdbDescricao.Checked;
  DoSetStateRadioButton(RdbCodigo);
  DoSetStateRadioButton(RdbDescricao);
  EdtFiltro.Clear;
  EdtFiltro.OnExit(EdtFiltro);
  for var I := 0 to Pred(Grid.Columns.Count) do
  begin
    if Grid.Columns[I].FieldName = FCampoFiltro then
      Grid.Columns[I].Index := 0;
  end;
end;

procedure TFrmPesquisa.RdbDescricaoClick(Sender: TObject);
begin
  FCampoFiltro := 'DESCRICAO';
  RdbCodigo.Checked := False;
  RdbDescricao.Checked := not RdbCodigo.Checked;
  DoSetStateRadioButton(RdbCodigo);
  DoSetStateRadioButton(RdbDescricao);
  EdtFiltro.Clear;
  EdtFiltro.OnExit(EdtFiltro);
  for var I := 0 to Pred(Grid.Columns.Count) do
  begin
    if Grid.Columns[I].FieldName = FCampoFiltro then
      Grid.Columns[I].Index := 0;
  end;
end;

procedure TFrmPesquisa.SetCampoCodigo(const Value: string);
begin
  if Trim(Value) = '' then
  begin
    MessageDlg('A propriedade "Codigo" deve ser preenchida com a informação do campo da tabela que ira ser o Código.',
      mtError, [mbOK], 0);
    Exit;
  end;
  FCampoCodigo := Value;
end;

procedure TFrmPesquisa.SetCampoDescricao(const Value: string);
begin
  if Trim(Value) = '' then
  begin
    MessageDlg('A propriedade "Descricao" deve ser preenchida com a informação do campo da tabela que ira ser a Descrição.',
      mtError, [mbOK], 0);
    Exit;
  end;
  FCampoDescricao := Value;
end;

procedure TFrmPesquisa.SetTabela(const Value: string);
begin
  if Trim(Value) = '' then
  begin
    MessageDlg('A propriedade "Tabela" deve ser preenchida com a informação da Tabela.',
      mtError, [mbOK], 0);
    Exit;
  end;
  FTabela := Value;
end;

end.
