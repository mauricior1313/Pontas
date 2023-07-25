unit ufrmCadastroFazendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.WinXPanels, uDtmMain;

type
  TFrmCadastroFazendas = class(TForm)
    CpnMain: TCardPanel;
    CrdLista: TCard;
    Panel1: TPanel;
    BtnExcluir: TSpeedButton;
    BtnAlterar: TSpeedButton;
    BtnIncluir: TSpeedButton;
    Grid: TDBGrid;
    CrdCadastro: TCard;
    Panel2: TPanel;
    BtnSalvar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    ImageCollection1: TImageCollection;
    Qry: TFDQuery;
    VirtualImageList1: TVirtualImageList;
    Dts: TDataSource;
    QryFZN_RAZAOSOCIAL: TWideStringField;
    QryFZN_NOMEFANTASIA: TWideStringField;
    Label2: TLabel;
    DbeRazaoSocial: TDBEdit;
    Label3: TLabel;
    DbeNomeFantasia: TDBEdit;
    Label5: TLabel;
    EdtNroDocumento: TMaskEdit;
    QryFZN_NRODOCUMENTO: TWideStringField;
    QryFZN_ID: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarTudoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure QryAfterPost(DataSet: TDataSet);
    procedure QryNewRecord(DataSet: TDataSet);
    procedure QryAfterDelete(DataSet: TDataSet);
  private
    function AplicarAtualizacao: Boolean;
    function DadosValidos: Boolean;
    procedure CarregarDataSet;
    function JaExisteCNPJ(const ANroCNPJ: string): Boolean;
    procedure CarregarCampos;
    procedure LimpaCampos;
  end;

const
  MSG_CNP = 'Campo "%s" não foi preenchido.';

var
  FrmCadastroFazendas: TFrmCadastroFazendas;

implementation

{$R *.dfm}

uses uFuncoes;


function TFrmCadastroFazendas.AplicarAtualizacao: Boolean;
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
          MessageDlg('Ocorreu', TMsgDlgType.mtError, [mbOK], 0);
        end;
        Qry.Next;
      end;
    finally
      Qry.FilterChanges := [rtUnmodified, rtModified, rtInserted];
    end;
  end;
end;

procedure TFrmCadastroFazendas.BtnAlterarClick(Sender: TObject);
begin
  Qry.Edit;
  CpnMain.ActiveCardIndex := 1;
  CarregarCampos;
end;

procedure TFrmCadastroFazendas.BtnCancelarClick(Sender: TObject);
begin
  Qry.Cancel;
  CpnMain.ActiveCardIndex := 0;
  LimpaCampos;
end;

procedure TFrmCadastroFazendas.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir o registro?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
    Qry.Delete;
end;

procedure TFrmCadastroFazendas.BtnIncluirClick(Sender: TObject);
begin
  Qry.Append;
  CpnMain.ActiveCardIndex := 1;

end;

procedure TFrmCadastroFazendas.BtnSalvarClick(Sender: TObject);
begin
  Panel2.SetFocus;
  CarregarDataSet;
  if not DadosValidos then
    Exit;
  Qry.Post;
  CpnMain.ActiveCardIndex := 0;
end;

procedure TFrmCadastroFazendas.BtnSalvarTudoClick(Sender: TObject);
begin
  AplicarAtualizacao;
end;

procedure TFrmCadastroFazendas.CarregarCampos;
begin
  EdtNroDocumento.Text := QryFZN_NRODOCUMENTO.AsString;
end;

procedure TFrmCadastroFazendas.CarregarDataSet;
begin
  QryFZN_NRODOCUMENTO.AsString := EdtNroDocumento.Text;
end;

function TFrmCadastroFazendas.DadosValidos: Boolean;
begin
  Result := True;
  if Trim(QryFZN_NRODOCUMENTO.AsString) = '' then
  begin
    MessageDlg(Format(MSG_CNP, ['CNPJ']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
  if JaExisteCNPJ(QryFZN_NRODOCUMENTO.AsString) then
  begin
    MessageDlg('Esse CNPJ já esta cadastrado!', TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
  if Trim(QryFZN_NOMEFANTASIA.AsString) = '' then
  begin
    MessageDlg(Format(MSG_CNP, ['Nome Fantasia']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
  if Trim(QryFZN_RAZAOSOCIAL.AsString) = '' then
  begin
    MessageDlg(Format(MSG_CNP, ['Razão Social']), TMsgDlgType.mtError, [MbOK], 0);
    Exit(False);
  end;
end;

procedure TFrmCadastroFazendas.FormShow(Sender: TObject);
begin
  CpnMain.ActiveCardIndex := 0;
  Qry.Open;
end;

function TFrmCadastroFazendas.JaExisteCNPJ(const ANroCNPJ: string): Boolean;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DtmMain.ConPrincipal;
    LQry.SQL.Text := 'SELECT 1 FROM Fazenda WHERE FZN_NRODOCUMENTO = :CNPJ';
    LQry.ParamByName('CNPJ').AsString := ANroCNPJ;
    LQry.Open;
    Result := not LQry.IsEmpty;
  finally
    FreeAndNil(LQry)
  end;
end;

procedure TFrmCadastroFazendas.LimpaCampos;
begin
  EdtNroDocumento.Clear;
end;

procedure TFrmCadastroFazendas.QryAfterDelete(DataSet: TDataSet);
begin
  Qry.ApplyUpdates(0);
end;

procedure TFrmCadastroFazendas.QryAfterPost(DataSet: TDataSet);
begin
  Qry.ApplyUpdates(0);
end;

procedure TFrmCadastroFazendas.QryNewRecord(DataSet: TDataSet);
begin
  QryFZN_ID.AsInteger := GetNextValueFazenda;
end;

end.
