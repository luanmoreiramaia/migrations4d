{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pav�o
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.Defaults;

interface

uses
  M4D.MigrationSerializerInterface, M4D.MigrationsHistoryInterface,
  M4D.MigrationListOrderInterface, M4D.MigrationExecutorInterface,
  M4D.GetterMigrationsInterface, M4D.MigrationsRegisterInterface;

type
  {$REGION 'TDefaultInstanceOfMigrationsSerializerCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationSerializer.
    /// </Description>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationsSerializerCreator = class
  private
    class var FMigrationSerializer: IMigrationSerializer;
  public
    {$REGION 'TDefaultInstanceOfMigrationsSerializerCreator.instanceOfMigrationsSerializer'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationSerializer interface.
    ///  For more information, see the IMigrationSerializer documentation.
    /// </Description>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationSerializer.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance: IMigrationSerializer;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationsHistoryCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationsHistory.
    /// </Description>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationsHistoryCreator = class
  private
    class var FMigrationsHistory: IMigrationsHistory;
  public
    {$REGION 'TDefaultInstanceOfMigrationsHistoryCreator.instanceOfMigrationsHistory'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationsHistory interface.
    ///  For more information, see the IMigrationsHistory documentation.
    /// </Description>
    /// <InputParameters>
    ///  AMigrationSerializer - A instance of a IMigrationSerializer. This is a
    ///  necessary parameter for the creation of IMigrationsHistory.
    /// </InputParameters>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationsHistory.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance(AMigrationSerializer: IMigrationSerializer): IMigrationsHistory;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationGetterCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IGetterMigrations.
    /// </Description>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationGetterCreator = class
  private
    class var FMigrationGetter: IGetterMigrations;
  public
    {$REGION 'TDefaultInstanceOfMigrationGetterCreator.instanceOfMigrationGetter'}
    /// <Description>
    ///  Factory from the default instance of the IGetterMigrations interface.
    ///  For more information, see the IGetterMigrations documentation.
    /// </Description>
    /// <OutputParameters>
    ///  Result - Default instance of IGetterMigrations.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance: IGetterMigrations;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationListOrderCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationListOrder.
    /// </Description>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationListOrderCreator = class
  private
    class var FMigrationListOrder: IMigrationListOrder;
  public
    {$REGION 'TDefaultInstanceOfMigrationListOrderCreator.instanceOfMigrationListOrder'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationListOrder interface.
    ///  For more information, see the IMigrationListOrder documentation.
    /// </Description>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationListOrder.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance: IMigrationListOrder;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationsRegisterCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationsRegister.
    /// </Description>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationsRegisterCreator = class
  private
    class var FMigrationsRegister: IMigrationsRegister;
  public
    {$REGION 'TDefaultInstanceOfMigrationsRegisterCreator.instanceOfMigrationsRegister'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationsRegister interface.
    ///  For more information, see the IMigrationsRegister documentation.
    /// </Description>
    /// <InputParameters>
    ///  AMigrationListOrder - A instance of a IMigrationListOrder. This is a
    ///  necessary parameter for the creation of IMigrationsRegister.
    /// </InputParameters>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationsRegister.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
  end;

type
  TDefaultInstanceOfMigrationExecutorCreator = class
  private
    class var FExecutor: IMigrationExecutor;
  public
    {$REGION 'TDefaultInstanceOfMigrationExecutorCreator.instanceOfMigrationExecutor'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationExecutor interface.
    ///  For more information, see the IMigrationExecutor documentation.
    /// </Description>
    /// <InputParameters>
    ///  AMigrationsHistory - A instance of a IMigrationsHistory. This is a
    ///  necessary parameter for the creation of IMigrationExecutor.
    /// </InputParameters>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationExecutor.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance(AMigrationsHistory: IMigrationsHistory): IMigrationExecutor;
  end;

implementation

uses
  M4D.Defs, M4D.MigrationSerializer, M4D.MigrationsHistory, System.SysUtils,
  M4D.MigrationListOrder, M4D.MigrationExecutor, M4D.GetterMigrations,
  M4D.MigrationsRegister;

{ TDefaultInstanceOfMigrationsSerializer }

class function TDefaultInstanceOfMigrationsSerializerCreator.getInstance: IMigrationSerializer;
begin
  if Assigned(FMigrationSerializer) then
  begin
    Result := FMigrationSerializer;
  end
  else
  begin
    FMigrationSerializer := TMigrationSerializer.Create;
    Result := FMigrationSerializer;
  end;
end;

{ TDefaultInstanceOfMigrationsHistoryCreator }

class function TDefaultInstanceOfMigrationsHistoryCreator.getInstance(AMigrationSerializer: IMigrationSerializer): IMigrationsHistory;
var
  LPath: String;
begin
  if Assigned(FMigrationsHistory) then
  begin
    Result := FMigrationsHistory;
  end
  else
  begin
    LPath := ExtractFilePath(ParamStr(0)) + CFILE_NAME;
    Result := TMigrationsHistory.Create(LPath, AMigrationSerializer);
  end;
end;

{ TDefaultInstanceOfMigrationGetterCreator }

class function TDefaultInstanceOfMigrationGetterCreator.getInstance: IGetterMigrations;
begin
  if Assigned(FMigrationGetter) then
  begin
    Result := FMigrationGetter;
  end
  else
  begin
    Result := TGetterMigrations.Create;
  end;
end;

{ TDefaultInstanceOfMigrationListOrderCreator }

class function TDefaultInstanceOfMigrationListOrderCreator.getInstance: IMigrationListOrder;
begin
 if Assigned(FMigrationListOrder) then
  begin
    Result := FMigrationListOrder;
  end
  else
  begin
    Result := TMigrationListOrder.Create;
  end;
end;

{ TDefaultInstanceOfMigrationsRegisterCreator }

class function TDefaultInstanceOfMigrationsRegisterCreator.getInstance(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
begin
 if Assigned(FMigrationsRegister) then
  begin
    Result := FMigrationsRegister;
  end
  else
  begin
    Result := TMigrationsRegister.Create(AMigrationListOrder);
  end;
end;

{ TDefaultInstanceOfMigrationExecutorCreator }

class function TDefaultInstanceOfMigrationExecutorCreator.getInstance(AMigrationsHistory: IMigrationsHistory): IMigrationExecutor;
begin
 if Assigned(FExecutor) then
  begin
    Result := FExecutor;
  end
  else
  begin
    Result := TMigrationExecutor.Create(AMigrationsHistory);
  end;
end;

end.