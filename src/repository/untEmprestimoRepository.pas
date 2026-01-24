unit untEmprestimoRepository;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  untEmprestimo,
  untDMPrincipal;

type
  TEmprestimoRepository = class

    private
      FDataModule: TdmPrincipal;

      function ConverterStatusParaString(AStatus: TStatusEmprestimo) : string;
      function ConverterStringParaStatus(AStatus: string): TStatusEmprestimo;

    public
      constructor Create(ADataModule: TdmPrincipal);

      procedure Inserir(AEmprestimo: TEmprestimo);
      procedure Atualizar(AEmprestimo: TEmprestimo);
      function BuscarPorIr(AId: Integer) : TEmprestimo;
      function ListarPorPessoa(APessoaId: Integer) : TObjectList<TEmprestimo>;
  end;

implementation

constructor TEmprestimoRepository.Create(ADataModule: TdmPrincipal);
begin
  FDataModule := ADataModule;
end;

function TEmprestimoRepository.ConverterStatusParaString(AStatus: TStatusEmprestimo): string;
begin

 case AStatus of
   seAberto :Result := 'Aberto';
   sePago : Result :='Pago'
 end;

end;

function TEmprestimoRepository.ConverterStringParaStatus(AStatus: string): TStatusEmprestimo;
begin

if AStatus = 'Pago' then
  Result:= sePago
else
  Result := seAberto
end;

procedure TEmprestimoRepository.Inserir(AEmprestimo: TEmprestimo);
begin

with FDataModule.qryEmprestimo do
begin
 Close;

 SQL.Clear;
 SQL.Add('ISERT INTO EMPRESTIMO');
 SQL.Add('(PESSOA_ID, VALOR, DATA_EMPRESTIMO, DESCRICAO, STATUS)');
 SQL.Add('VALUES');
 SQL.Add('(:PESSOA_ID, :VALOR, :DATA_EMPRESTIMO, :DESCRICAO, :STATUS)');

 ParamByName('PESSOA_ID').AsInteger := AEmprestimo.PessoaId;
 ParamByName('VALOR').AsCurrency := AEmprestimo.Valor;
 ParamByName('DATA_EMPRESTIMO').AsDate := AEmprestimo.DataEmprestimo;
 ParamByName('DESCRICAO').AsString := AEmprestimo.Descricao;
 ParamByName('STATUS').AsString := ConverterStatusParaString(AEmprestimo.Status);

 ExecSQL;

end;

end;

  procedure TEmprestimoRepository.Atualizar(AEmprestimo: TEmprestimo);
  begin

  if AEmprestimo.Id <= 0 then
    raise Exception.Create('Empréstimo Inválido');

    with FDataModule.qryEmprestimo do
    begin
    Close;

      SQL.Clear;
      SQL.Add('UPDATE EMPRESTIMO SET');
      SQL.Add('VALOR = :VALOR');
      SQL.Add('DESCRICAO = :DESCRICAO');
      SQL.Add('STATUS = :STATUS');
      SQL.Add('DATA_PAGAMENTO = :DATA_PAGAMENTO');
      SQL.Add('WHERE ID = :ID');

      ParamByName('VALOR').AsCurrency := AEmprestimo.Valor;
      ParamByName('DESCRICAO').AsString := AEmprestimo.Descricao;
      ParamByName('STATUS').AsString := ConverterStatusParaString(AEmprestimo.Status);

     if AEmprestimo.Status = sePago then
       ParamByName('DATA_PAGAMENTO').AsDate := AEmprestimo.DataPagamento
     else
       ParamByName('DATA_PAGAMENTO').Clear;

       ExecSQL;
    end;
  end;

  function TEmprestimoRepository.BuscarPorIr(AId: Integer): TEmprestimo;
  begin
  Result := nil;

  with FDataModule.qryEmprestimo do
  begin
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM EMPRESTIMO WHERE ID = :ID');
    ParamByName('ID').AsInteger := AId;
    Open;

      if not Eof then
    begin
      Result := TEmprestimo.Create(
        FieldByName('PESSOA_ID').AsInteger,
        FieldByName('VALOR').AsCurrency,
        FieldByName('DATA_EMPRESTIMO').AsDateTime
      );

      Result.Id := FieldByName('ID').AsInteger;
      Result.Descricao := FieldByName('DESCRICAO').AsString;
      Result.Status := ConverterStringParaStatus(
        FieldByName('STATUS').AsString
      );
      Result.DataPagamento := FieldByName('DATA_PAGAMENTO').AsDateTime

    end;

  end;

  end;

  function TEmprestimoRepository.ListarPorPessoa(APessoaId: Integer): TObjectList<TEmprestimo>;

  var
    Emprestimo : TEmprestimo;

  begin
    Result:= TObjectList<TEmprestimo>.Create(True);

    with FDataModule.qryEmprestimo do
    begin
     Close;

     SQL.Clear;
     SQL.Add('SELECT * FROM EMPRESTIMO');
     SQL.Add('WHERE PESSOA_ID = :ID');
     SQL.Add('ORDER BY DATA_EMPRESTIMO DESC');
     ParamByName('ID').AsInteger := APessoaId;
     Open;

     while not Eof do
     begin

     Emprestimo := TEmprestimo.Create(
       FieldByName('PESSOA_ID').AsInteger,
       FieldByName('VALOR').AsCurrency,
       FieldByName('DATA_EMPRESTIMO').AsDateTime
     );

     Emprestimo.Id := FieldByName('ID').AsInteger;
     Emprestimo.Descricao := FieldByName('DESCRICAO').AsString;
     Emprestimo.Status := ConverterStringParaStatus(
        FieldByName('STATUS').AsString
     );
     Emprestimo.DataEmprestimo := FieldByName('DATA_EMPRESTIMO').AsDateTime;

     Result.Add(Emprestimo);
     Next;
     end;

    end;


  end;

end.
