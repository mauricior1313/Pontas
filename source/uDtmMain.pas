unit uDtmMain;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TDtmMain = class(TDataModule)
    ConPrincipal: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtmMain: TDtmMain;

implementation

uses
  System.SysUtils, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDtmMain.DataModuleCreate(Sender: TObject);
begin
  ConPrincipal.Params.LoadFromFile(ExtractFilePath(Application.ExeName) + 'AgroT.ini');
  ConPrincipal.Open;
end;

procedure TDtmMain.DataModuleDestroy(Sender: TObject);
begin
  ConPrincipal.Close;
end;

end.
