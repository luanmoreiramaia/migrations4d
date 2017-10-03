{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pav�o
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackUntilExecutor;

interface

uses
  Generics.Collections,
  M4D.MigrationRollbackUntilExecutorInterface,
  M4D.MigrationRollbackExecutorInterface, M4D.MigrationsHistoryInterface;

type
  {$REGION 'TMigrationRollbackUntilExecutor'}
    /// <Description>
    ///  Standar class to execute the rollback of migrations until a specif sequence.
    /// </Description>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
    /// <KeyWords>Migration</KeyWords>
  {$ENDREGION}
  TMigrationRollbackUntilExecutor = class(TInterfacedObject, IMigrationRollbackUntilExecutor)
  private
    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
  public
    constructor Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor); reintroduce;
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;

implementation

uses
  M4D.MigrationsInterface, System.SysUtils;

{ TMigrationRollbackUntilExecutor }

constructor TMigrationRollbackUntilExecutor.Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor);
begin
  if not Assigned(AMigrationRollbackExecutor) then
  begin
    raise Exception.Create('The parameter AMigrationRollbackExecutor must not be nil.');
  end
  else
  begin
    inherited Create;

    FMigrationRollbackExecutor := AMigrationRollbackExecutor;
  end;
end;

procedure TMigrationRollbackUntilExecutor.RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
var
  LList: TList<TClass>;
  I: Integer;
  SequenceProp: Integer;
  LClass: TClass;
  Aux: TObject;
begin
  if not Assigned(AMigrationsList) then
  begin
    raise Exception.Create('The parameter AMigrationsList must not be nil.');
  end
  else
  begin
    LList := nil;

    for I := AMigrationsList.Count - 1 downto 0 do
    begin
      LClass := AMigrationsList[I];

      Aux := LClass.Create;
      (Aux as TInterfacedObject as IMigration).Setup;

      SequenceProp := (Aux as TInterfacedObject as IMigration).SeqVersion;

      if SequenceProp >= AMigrationSequence then
      begin
        if not Assigned(LList) then LList := TList<TClass>.Create;
        LList.Add(LClass);
      end;
    end;

    if Assigned(LList) then
    begin
      if LList.Count > 0 then
      begin
//        Self.Rollback(LList, AMigrationHistory);
        FMigrationRollbackExecutor.Rollback(LList, AMigrationHistory);
        if Assigned(LList) then FreeAndNil(LList);
      end;
    end;
  end;
end;

end.
