unit uFuncoes;

interface

uses uDtmMain;

function GetNextValueFazenda: Integer;
function GetNextValueAnimal: Integer;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils;

function GetNextValueFazenda: Integer;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DtmMain.ConPrincipal;
    LQry.SQL.Text :=
      'SELECT MAX(FZN_ID) AS ID FROM FAZENDA';
    LQry.Open;
    Result := LQry.Fields[0].AsInteger +1;
  finally
    FreeAndNil(LQry);
  end;
end;

function GetNextValueAnimal: Integer;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DtmMain.ConPrincipal;
    LQry.SQL.Text :=
      'SELECT MAX(ANM_ID) AS ID FROM Animal';
    LQry.Open;
    Result := LQry.Fields[0].AsInteger +1;
  finally
    FreeAndNil(LQry);
  end;
end;

end.
