unit untEmprestimoService;

interface

uses
  untEmprestimo,
  untEmprestimoRepository,
  untDMPrincipal,
  System.Generics.Collections;
type
 TEmprestimoService = class

   private
     FDataModule: TdmPrincipal;
     FRepository: TEmprestimoRepository;

   public
     constructor Create(ADataModule: TdmPrincipal; ARepository : TEmprestimoRepository);

     procedure CriarEmprestimo( AEmprestimo : TEmprestimo);
     procedure AtualizarEmprestimo(AEmprestimo : TEmprestimo);
     procedure MarcarComoPago(AEmpestimo : TEmprestimo; AData: TDate);

     function BuscarPorId(AId : Integer): TEmprestimo;
     function ListarPorPessoa(APessoaId: Integer): TObjectList<TEmprestimo>;
 end;
implementation

constructor TEmprestimoService.Create(ADataModule: TdmPrincipal; ARepository: TEmprestimoRepository);
begin
  FDataModule := ADataModule;
  FRepository := TEmprestimoRepository.Create(FDataModule);
end;

procedure TEmprestimoService.CriarEmprestimo(AEmprestimo: TEmprestimo);
begin

AEmprestimo.Validar;
FRepository.Inserir(AEmprestimo);

end;

procedure  TEmprestimoService.AtualizarEmprestimo(AEmprestimo: TEmprestimo);
begin

FRepository.Atualizar(AEmprestimo);

end;

procedure TEmprestimoService.MarcarComoPago(AEmpestimo: TEmprestimo; AData: TDate);

begin

AEmpestimo.MarcarComoPago(AData);
FRepository.Atualizar(AEmpestimo);

end;

function TEmprestimoService.BuscarPorId(AId: Integer): TEmprestimo;
begin

FRepository.BuscarPorIr(AId);

end;

function TEmprestimoService.ListarPorPessoa(APessoaId: Integer): TObjectList<TEmprestimo>;

begin

Result := FRepository.ListarPorPessoa(APessoaId);

end;

end.
