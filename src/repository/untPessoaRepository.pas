unit untPessoaRepository;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  untPessoa,
  untDMPrincipal;

 type
  TPessoaRepository = class

  private
    FDM: TdmPrincipal;

  public
    constructor Create(ADM: TdmPrincipal);

    procedure Inserir(APessoa: TPessoa);
    procedure Atualizar(APessoa: TPessoa);
    function BuscarPorId(AId: Integer) : TPessoa;
    function ListarTodos : TObjectList<TPessoa>;

  end;

implementation

  { TPessoaRepository }

constructor TPessoaRepository.Create(ADM: TDMPrincipal);
begin
  FDM := ADM;
end;

procedure TPessoaRepository.Inserir(APessoa: TPessoa);
begin
  with FDM.qryPessoa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO PESSOA (NOME, TELEFONE, OBSERVACAO)');
    SQL.Add('VALUES (:NOME, :TELEFONE, :OBSERVACAO)');

    ParamByName('NOME').AsString := APessoa.Nome;
    ParamByName('TELEFONE').AsString := APessoa.Telefone;
    ParamByName('OBSERVACAO').AsString := APessoa.Observacao;

    ExecSQL;
  end;
end;

procedure TPessoaRepository.Atualizar(APessoa: TPessoa);
begin
  if APessoa.Id <= 0 then
    raise Exception.Create('Pessoa inválida para atualização');

  with FDM.qryPessoa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE PESSOA SET');
    SQL.Add(' NOME = :NOME,');
    SQL.Add(' TELEFONE = :TELEFONE,');
    SQL.Add(' OBSERVACAO = :OBSERVACAO');
    SQL.Add('WHERE ID = :ID');

    ParamByName('ID').AsInteger := APessoa.Id;
    ParamByName('NOME').AsString := APessoa.Nome;
    ParamByName('TELEFONE').AsString := APessoa.Telefone;
    ParamByName('OBSERVACAO').AsString := APessoa.Observacao;

    ExecSQL;
  end;
end;

function TPessoaRepository.BuscarPorId(AId: Integer): TPessoa;
begin
  Result := nil;

  with FDM.qryPessoa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM PESSOA WHERE ID = :ID');
    ParamByName('ID').AsInteger := AId;
    Open;

    if not Eof then
    begin
      Result := TPessoa.Create(FieldByName('NOME').AsString);
      Result.Id := FieldByName('ID').AsInteger;
      Result.Telefone := FieldByName('TELEFONE').AsString;
      Result.Observacao := FieldByName('OBSERVACAO').AsString;
    end;
  end;
end;

function TPessoaRepository.ListarTodos: TObjectList<TPessoa>;
var
  Pessoa: TPessoa;
begin
  Result := TObjectList<TPessoa>.Create(True);

  with FDM.qryPessoa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM PESSOA ORDER BY NOME');
    Open;

    while not Eof do
    begin
      Pessoa := TPessoa.Create(FieldByName('NOME').AsString);
      Pessoa.Id := FieldByName('ID').AsInteger;
      Pessoa.Telefone := FieldByName('TELEFONE').AsString;
      Pessoa.Observacao := FieldByName('OBSERVACAO').AsString;

      Result.Add(Pessoa);
      Next;
    end;
  end;
end;

end.
