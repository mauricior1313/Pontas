unit uFrmCadastroAnimais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPanels, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDtmMain,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TFrmCadastroAnimais = class(TForm)
    CpnMain: TCardPanel;
    CrdLista: TCard;
    CrdCadastro: TCard;
    Panel1: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAlterar: TSpeedButton;
    BtnIncluir: TSpeedButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    Grid: TDBGrid;
    Qry: TFDQuery;
    Dts: TDataSource;
    BtnSalvarTudo: TSpeedButton;
    Panel2: TPanel;
    BtnSalvar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    QryANM_ID: TIntegerField;
    QryANM_FAZENDAID: TIntegerField;
    QryANM_NOME: TWideStringField;
    QryANM_RACA: TWideStringField;
    QryANM_ATIVO: TWideStringField;
    QryANM_TAG: TWideStringField;
    QryFZN_RAZAOSOCIAL: TWideStringField;
    Label2: TLabel;
    DbeFazendaId: TDBEdit;
    Label3: TLabel;
    DbeNome: TDBEdit;
    Label4: TLabel;
    DbeRaca: TDBEdit;
    Label8: TLabel;
    EdtFazendaRazaoSocial: TEdit;
    SpeedButton1: TSpeedButton;
    DBCheckBox1: TDBCheckBox;
    EdtTAG: TEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarTudoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure QryNewRecord(DataSet: TDataSet);
    procedure BtnCancelarTudoClick(Sender: TObject);
  private
    function AplicarAtualizacao: Boolean;
    function DadosValidos: Boolean;
    procedure CarregarDataSet;
    function JaExisteTAG(const ANroTAG: string): Boolean;
    procedure CarregarCampos;
    procedure LimpaCampos;
    function PesquisaFazendaRapida(const AFazendaId: Integer): string;
  end;

const
  MSG_CNP = 'Campo "%s" não foi preenchido.';

var
  FrmCadastroAnimais: TFrmCadastroAnimais;

implementation

{$R *.dfm}

uses uFrmPesquisa, uFuncoes;


function TFrmCadastroAnimais.AplicarAtualizacao: Boolean;
var
  Errors: EFDException;
begin
  Result := (Qry.ApplyUpdates = 0);
  if not Result then
  begin
    Qry.FilterChanges := [rtModified, rtInserted, rtDeleted, rtHasErrors];
    try
      Qry.First;
      while not Qry.Eof do begin
        Errors := Qry.RowError;
        if Errors <> nil then begin
          MessageDlg('Ocorreu um erro ao tentar salvar os registros.' + sLineBreak +
            Errors.Message, TMsgDlgType.mtError, [mbOK], 0);
          BtnSalvarTudo.Enabled := False;
        end;
        Qry.Next;
      end;
    finally
      Qry.FilterChanges := [rtUnmodified, rtModified, rtInserted];
    end;
  end
  else
  begin
    MessageDlg('Todos os registros foram salvos!', TMsgDlgType.mtInformation, [mbOK], 0);
    BtnSalvarTudo.Enabled := False;
  end;
end;

procedure TFrmCadastroAnimais.BtnAlterarClick(Sender: TObject);
begin
  Qry.Edit;
  CpnMain.ActiveCardIndex := 1;
  CarregarCampos;
end;

procedure TFrmCadastroAnimais.BtnCancelarClick(Sender: TObject);
begin
  Qry.Cancel;
  CpnMain.ActiveCardIndex := 0;
end;

procedure TFrmCadastroAnimais.BtnCancelarTudoClick(Sender: TObject);
begin
  Qry.Cancel;
end;

procedure TFrmCadastroAnimais.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir o registro?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
    Qry.Delete;
end;

procedure TFrmCadastroAnimais.BtnIncluirClick(Sender: TObject);
begin
  Qry.Append;
  CpnMain.ActiveCardIndex := 1;
  LimpaCampos;
end;

procedure TFrmCadastroAnimais.BtnSalvarClick(Sender: TObject);
begin
  Panel2.SetFocus;
  CarregarDataSet;
  if not DadosValidos then
    Exit;
  Qry.Post;
  CpnMain.ActiveCardIndex := 0;
  BtnSalvarTudo.Enabled := True;
end;

procedure TFrmCadastroAnimais.BtnSalvarTudoClick(Sender: TObject);
begin
  AplicarAtualizacao;
end;

procedure TFrmCadastroAnimais.CarregarCampos;
begin
  EdtFazendaRazaoSocial.Text := PesquisaFazendaRapida(QryANM_FAZENDAID.AsInteger);
  EdtTAG.Text := QryANM_TAG.AsString;
end;

procedure TFrmCadastroAnimais.CarregarDataSet;
begin
  QryANM_TAG.AsString := EdtTAG.Text;
end;

function TFrmCadastroAnimais.DadosValidos: Boolean;
begin
  Result := True;
  if QryANM_FAZENDAID.AsInteger = 0 then
  begin
    MessageDlg(Format(MSG_CNP, ['Código da Fazenda']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;

  if Trim(QryANM_NOME.AsString) = '' then
  begin
    MessageDlg(Format(MSG_CNP, ['Nome']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
  if  Trim(QryANM_RACA.AsString) = '' then
  begin
    MessageDlg(Format(MSG_CNP, ['Raça']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
  if Trim(QryANM_TAG.AsString) = '' then
  begin
    MessageDlg(Format(MSG_CNP, ['TAG']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
  if QryANM_ATIVO.IsNull then
  begin
    MessageDlg(Format(MSG_CNP, ['Ativo']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
end;

procedure TFrmCadastroAnimais.FormShow(Sender: TObject);
begin
  CpnMain.ActiveCardIndex := 0;
  Qry.Open;
end;

function TFrmCadastroAnimais.JaExisteTAG(const ANroTAG: string): Boolean;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DtmMain.ConPrincipal;
    LQry.SQL.Text := 'SELECT 1 FROM Animal WHERE ANM_TAG = :TAG';
    LQry.ParamByName('TAG').AsString := ANroTAG;
    LQry.Open;
    Result := not LQry.IsEmpty;
  finally
    FreeAndNil(LQry)
  end;
end;

procedure TFrmCadastroAnimais.LimpaCampos;
begin
  EdtFazendaRazaoSocial.Clear;
  EdtTAG.Clear;
end;

function TFrmCadastroAnimais.PesquisaFazendaRapida(const AFazendaId: Integer): string;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DtmMain.ConPrincipal;
    LQry.SQL.Text := 'SELECT FZN_RAZAOSOCIAL FROM FAZENDA WHERE FZN_ID = ' + AFazendaId.ToString;
    LQry.Open;
    Result := LQry.Fields[0].AsString;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TFrmCadastroAnimais.QryNewRecord(DataSet: TDataSet);
begin
   QryANM_ID.AsInteger := GetNextValueAnimal + qry.RecordCount +1;
end;

procedure TFrmCadastroAnimais.SpeedButton1Click(Sender: TObject);
var
  Codigo: Integer;
  Descricao: string;
begin
  Codigo := 0;
  Descricao := '';
  Pesquisar('FZN_ID', 'FZN_RAZAOSOCIAL', 'FAZENDA', Codigo, Descricao);
  QryANM_FAZENDAID.AsInteger := Codigo;
  EdtFazendaRazaoSocial.Text := Descricao;

end;

end.
