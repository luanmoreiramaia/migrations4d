unit MCreateTables;

interface

uses
  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
  {$ELSE}
    Vcl.Dialogs,
  {$ENDIF}
  M4D.Migrations,
  UDBRegisterMigration;


type
  TMCreateTables = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils, UDMDBDemo, FireDAC.Comp.Client, UDBMigrationHistory;

{ TMDescription1 }

procedure TMCreateTables.Setup;
begin
  Self.Version := '1.00';
  Self.SeqVersion := 1;
  Self.DateTime := StrToDateTime('05/09/2017 07:19:00');
end;

procedure TMCreateTables.Up;
var
  Query: TFDQuery;
begin
  Query := DMDBDemo.getQuery('CREATE TABLE IF NOT EXISTS CUSTOMERS (ID INTEGER NOT NULL, NAME VARCHAR(100) NOT NULL)', False);
  try
    Query.ExecSQL;
  finally
    Query.Free;
  end;

  ShowMessage('Just finish update of sequence 1 up!');
end;

procedure TMCreateTables.Down;
var
  Query: TFDQuery;
begin
  Query := DMDBDemo.getQuery('DROP TABLE CUSTOMERS', False);
  try
    Query.ExecSQL;
  finally
    Query.Free;
  end;

  ShowMessage('Just finish rollback of sequence 1 down!');
end;

initialization
  DBRegisterMigration(TMCreateTables);

end.