// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program AgroT;

uses
  Vcl.Forms,
  uDtmMain in 'source\uDtmMain.pas' {DtmMain: TDataModule},
  uFrmMain in 'source\uFrmMain.pas' {FrmMain},
  uFrmCadastroAnimais in 'source\uFrmCadastroAnimais.pas' {FrmCadastroAnimais},
  ufrmCadastroFazendas in 'source\ufrmCadastroFazendas.pas' {FrmCadastroFazendas},
  uFrmRelatorio in 'source\uFrmRelatorio.pas' {FrmRelatorio},
  uFuncoes in 'source\uFuncoes.pas',
  uFrmPesquisa in 'source\uFrmPesquisa.pas' {FrmPesquisa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtmMain, DtmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmPesquisa, FrmPesquisa);
  Application.Run;
end.
