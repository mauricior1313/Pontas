unit uFrmRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, uDtmMain, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TTipoRelatorio = (trFazenda, trAnimal);

  TFrmRelatorio = class(TForm)
    MemRelatorio: TMemo;
    Panel1: TPanel;
    BtnSalvar: TBitBtn;
    BtnFechar: TBitBtn;
    Qry: TFDQuery;
    SaveDialog: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
  private
    FTipoRelatorio: TTipoRelatorio;
    procedure AbreConsulta;
    procedure MontarRelatorio;
  public
    property TipoRelatorio: TTipoRelatorio read FTipoRelatorio write FTipoRelatorio;
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.dfm}

{ TFrmRelatorio }

procedure TFrmRelatorio.AbreConsulta;
begin
  case TipoRelatorio of
    trFazenda:
    begin
      Qry.SQL.Text :=
        'SELECT FZN_ID ' + sLineBreak +
        '      ,FZN_RAZAOSOCIAL ' + sLineBreak +
        '      ,FZN_NOMEFANTASIA  ' + sLineBreak +
        '      ,FZN_NRODOCUMENTO  ' + sLineBreak +
        '  FROM FAZENDA ' + sLineBreak +
        ' WHERE 1=1';

    end;
    trAnimal:
    begin
      Qry.SQL.Text :=
        'SELECT ANM_Id ' + sLineBreak +
        '      ,ANM_FazendaId ' + sLineBreak +
        '      ,FZN_RazaoSocial ' + sLineBreak +
        '      ,ANM_TAG ' + sLineBreak +
        '      ,ANM_Nome ' + sLineBreak +
        '      ,ANM_Raca ' + sLineBreak +
        '      ,ANM_Ativo ' + sLineBreak +
         '  FROM Animal ' + sLineBreak +
        '  INNER JOIN Fazenda ON ANM_FazendaId = FZN_ID ' + sLineBreak +
        ' WHERE 1=1';
    end;
  end;
  Qry.Open;
  MontarRelatorio;
end;

procedure TFrmRelatorio.BtnSalvarClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    MemRelatorio.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TFrmRelatorio.FormShow(Sender: TObject);
begin
  AbreConsulta;
end;

procedure TFrmRelatorio.MontarRelatorio;
var
  I, J: Integer;
begin
  MemRelatorio.Lines.Clear;
  case TipoRelatorio of
    trFazenda:
    begin
      MemRelatorio.Lines.Add(
        Qry.FieldByName('FZN_ID').FieldName + Format('%-7s', [' ']) +
        Qry.FieldByName('FZN_RAZAOSOCIAL').FieldName + Format('%-7s', [' ']) +
        Qry.FieldByName('FZN_NRODOCUMENTO').FieldName + Format('%-7s', [' '])
      );
      while not Qry.Eof do
      begin
        MemRelatorio.Lines.Add(
          Qry.FieldByName('FZN_ID').AsString + Format('%-12s', [' ']) +
          Qry.FieldByName('FZN_RAZAOSOCIAL').AsString + Format('%-17s', [' ']) +
          Qry.FieldByName('FZN_NRODOCUMENTO').AsString + Format('%-10s', [' '])
        );
        Qry.Next;
      end;
    end;
    trAnimal:
    begin
      MemRelatorio.Lines.Add(
        Qry.FieldByName('ANM_Id').FieldName + Format('%-7s', [' ']) +
        Qry.FieldByName('ANM_FazendaId').FieldName + Format('%-7s', [' ']) +
        Qry.FieldByName('FZN_RazaoSocial').FieldName + Format('%-7s', [' ']) +
        Qry.FieldByName('ANM_TAG').FieldName + Format('%-10s', [' ']) +
        Qry.FieldByName('ANM_Nome').FieldName + Format('%-45s', [' ']) +
        Qry.FieldByName('ANM_Raca').FieldName + Format('%-50s', [' ']) +
        Qry.FieldByName('ANM_Ativo').FieldName + Format('%-55s', [' '])
      );
      while not Qry.Eof do
      begin
        MemRelatorio.Lines.Add(
          Qry.FieldByName('ANM_Id').AsString + Format('%-12s', [' ']) +
          Qry.FieldByName('ANM_FazendaId').AsString + Format('%-17s', [' ']) +
          Qry.FieldByName('FZN_RazaoSocial').AsString + Format('%-20s', [' ']) +
          Qry.FieldByName('ANM_TAG').AsString + Format('%-25s', [' ']) +
          Qry.FieldByName('ANM_Nome').AsString + Format('%-30s', [' ']) +
          Qry.FieldByName('ANM_Raca').AsString + Format('%-35s', [' ']) +
          Qry.FieldByName('ANM_Ativo').AsString + Format('%-40s', [' '])
        );
        Qry.Next;
      end;    end;
  end;



end;

end.
