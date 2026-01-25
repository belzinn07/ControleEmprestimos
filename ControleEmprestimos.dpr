program ControleEmprestimos;

uses
  Vcl.Forms,
  untPessoa in 'src\domain\untPessoa.pas',
  untDMPrincipal in 'src\infra\untDMPrincipal.pas' {dmPrincipal: TDataModule},
  untEmprestimo in 'src\domain\untEmprestimo.pas',
  untIValidador in 'src\domain\contracts\untIValidador.pas',
  untPessoaRepository in 'src\repository\untPessoaRepository.pas',
  untEmprestimoRepository in 'src\repository\untEmprestimoRepository.pas',
  untEmprestimoService in 'src\service\untEmprestimoService.pas',
  untPessoaService in 'src\service\untPessoaService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
