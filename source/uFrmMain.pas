unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, uFrmCadastroAnimais, ufrmCadastroFazendas,
  uFrmRelatorio;

type
  TFrmMain = class(TForm)
    MnMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Cadastros2: TMenuItem;
    MniFazenda: TMenuItem;
    MniAnimais: TMenuItem;
    Animais2: TMenuItem;
    MniSair: TMenuItem;
    MniRelCadFazendas: TMenuItem;
    MniRelCadAnimais: TMenuItem;
    procedure MniFazendaClick(Sender: TObject);
    procedure MniAnimaisClick(Sender: TObject);
    procedure MniRelCadFazendasClick(Sender: TObject);
    procedure MniRelCadAnimaisClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.MniAnimaisClick(Sender: TObject);
begin
  FrmCadastroAnimais := TFrmCadastroAnimais.Create(nil);
  try
    FrmCadastroAnimais.ShowModal;
  finally
    FreeAndNil(FrmCadastroAnimais);
  end;
end;

procedure TFrmMain.MniFazendaClick(Sender: TObject);
begin
  FrmCadastroFazendas := TFrmCadastroFazendas.Create(nil);
  try
    FrmCadastroFazendas.ShowModal;
  finally
    FreeAndNil(FrmCadastroFazendas);
  end;
end;

procedure TFrmMain.MniRelCadAnimaisClick(Sender: TObject);
begin
  FrmRelatorio := TFrmRelatorio.Create(nil);
  try
    FrmRelatorio.TipoRelatorio := trAnimal;
    FrmRelatorio.ShowModal;
  finally
    FreeAndNil(FrmRelatorio);
  end;
end;

procedure TFrmMain.MniRelCadFazendasClick(Sender: TObject);
begin
  FrmRelatorio := TFrmRelatorio.Create(nil);
  try
    FrmRelatorio.TipoRelatorio := trFazenda;
    FrmRelatorio.ShowModal;
  finally
    FreeAndNil(FrmRelatorio);
  end;
end;

end.
