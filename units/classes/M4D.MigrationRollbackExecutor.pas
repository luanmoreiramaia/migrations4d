{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pav�o
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackExecutor;

interface

uses
  Generics.Collections, M4D.MigrationRollbackExecutorInterface,
  M4D.MigrationExecExecutorInterface, M4D.MigrationsHistoryInterface;

type
  {$REGION 'TMigrationRollbackExecutor'}
    /// <Description>
    ///  Standar class to execute the rollback of migrations.
    /// </Description>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
    /// <KeyWords>Migration</KeyWords>
  {$ENDREGION}
  TMigrationRollbackExecutor = class(TInterfacedObject, IMigrationRollbackExecutor)
  public
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
  end;

implementation

uses
  System.SysUtils, M4D.MigrationsInterface;

{ TMigrationRollbackExecutor }

procedure TMigrationRollbackExecutor.Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
var
  I: Integer;
  SequenceProp: Integer;
  LClass: TClass;
  Aux: TObject;
  HadMigration: Boolean;
begin
  HadMigration := False;

  AMigrationsList.Sort;

  for I := AMigrationsList.Count - 1 downto 0 do
  begin
    LClass := AMigrationsList[I];

    Aux := LClass.Create;
    (Aux as TInterfacedObject as IMigration).Setup;

    SequenceProp := (Aux as TInterfacedObject as IMigration).SeqVersion;

    (Aux as TInterfacedObject as IMigration).Down;
    HadMigration := True;

    if HadMigration and Assigned(AMigrationHistory) then
    begin
      AMigrationHistory.Remove(SequenceProp);
    end;
  end;

  if HadMigration then
  begin
    AMigrationHistory.Save;
  end;
end;

end.
