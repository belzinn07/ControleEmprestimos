unit untPessoa;

interface

uses
  SysUtils, untIValidador;

type
 TPessoa = class(TInterfacedObject,IValidador)

 private
  FId: Integer;
  FNome: string;
  FTelefone: string;
  FObservacao: string;

 public
  constructor Create(const ANome: string);
  procedure Validar;

  property Id: Integer read FId write FId;
  property Nome: string read FNome write FNome;
  property Telefone: string read FTelefone write FTelefone;
  property Observacao: string read FObservacao write FObservacao;

 end;

implementation

{ TPessoa }

constructor TPessoa.Create(const ANome: string);
begin

  FNome := ANome;
  Validar;

end;

procedure TPessoa.Validar;
begin

      if Trim(FNome) = '' then
    raise Exception.Create('Nome da pessoa é obrigatório');

end;
end.
