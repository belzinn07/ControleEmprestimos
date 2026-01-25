unit untPessoaService;

interface

uses
  untPessoaRepository,
  untPessoa,
  untDMPrincipal,
  System.Generics.Collections;

type
  TPessoaService = class

    private
      FDataModule: TdmPrincipal;
      FRepository: TPessoaRepository;

    public
      constructor Create(ADatamodule: TdmPrincipal; ARepository: TPessoaRepository);

      procedure CriarNovaPessoa(APessoa: TPessoa);
      procedure AtualizarPessoa(APessoa: TPessoa);

      function BuscarPessoaPorId(AId: Integer): TPessoa;
      function ListarPessoas: TObjectList<TPessoa>;
  end;

implementation

constructor TPessoaService.Create(ADatamodule: TdmPrincipal; ARepository: TPessoaRepository);

begin
  FDataModule := ADatamodule;
  FRepository := TPessoaRepository.Create(FDataModule);
end;

procedure TPessoaService.CriarNovaPessoa(APessoa: TPessoa);

begin
  APessoa.Validar;
  FRepository.Inserir(APessoa);  
end;

procedure TPessoaService.AtualizarPessoa(APessoa: TPessoa);

begin
   FRepository.Atualizar(APessoa);
end;

function TPessoaService.BuscarPessoaPorId(AId: Integer): TPessoa;
begin
  Result := FRepository.BuscarPorId(AId);
end;

function TPessoaService.ListarPessoas: TObjectList<TPessoa>;
begin
  Result := FRepository.ListarTodos;
end;

end.
