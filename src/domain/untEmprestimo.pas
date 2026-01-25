unit untEmprestimo;

interface

uses
  System.SysUtils, untIValidador;

type
  TStatusEmprestimo = (seAberto, sePago);

  TEmprestimo =class(TInterfacedObject, IValidador)

     private
       FId: Integer;
       FPessoaId: Integer;
       FValor: Currency;
       FDataEmprestimo: TDate;
       FDescricao: string;
       FStatus: TStatusEmprestimo;
       FDataPagamento: TDate;



     public
       constructor Create(APessoaId: Integer; AValor: Currency; AData: TDate);
       procedure Validar;
       procedure MarcarComoPago(const ADataPagamento: TDateTime);

       property Id: Integer read FId write FId;
       property PessoaId: Integer read FPessoaId write FPessoaId;
       property Valor: Currency read FValor write FValor;
       property DataEmprestimo: TDate read FDataEmprestimo write FDataEmprestimo;
       property Descricao: string read FDescricao write FDescricao;
       property Status: TStatusEmprestimo read FStatus write FStatus;
       property DataPagamento: TDate read FDataPagamento write FDataPagamento;


  end;

implementation

{ TEmprestimo }

constructor TEmprestimo.Create(APessoaId: Integer; AValor: Currency; AData: TDate);
begin

FPessoaId := APessoaId;
FValor := AValor;
FDataEmprestimo := AData;
FStatus := seAberto;

Validar;

end;

procedure TEmprestimo.Validar;
begin
    if FPessoaId <= 0 then
    raise Exception.Create('Pessoa inválida');

  if FValor <= 0 then
    raise Exception.Create('Valor do empréstimo deve ser maior que zero');

    if FDataEmprestimo <= 0 then
    raise Exception.Create('Data inválida');

end;

procedure TEmprestimo.MarcarComoPago(const ADataPagamento: TDateTime);
begin

  if FStatus = sePago then
    raise Exception.Create('Empréstimos já está pago');

 FStatus := sePago;
 FDataPagamento := ADataPagamento;
end;

end.
