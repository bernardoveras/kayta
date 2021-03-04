## [1.0.0]

- Adicionado novos componentes Kayta
  * KaytaButton: Botão personalizável com estilo dos app's da VVS Sistemas.
  * KaytaCheckbox: Circular Checkbox com estilo dos app's da VVS Sistemas.
  * KaytaCircularProgress: Circular Progress com estilo dos app's da VVS Sistemas.
  * KaytaTextField: TextField com estilo dos app's da VVS Sistemas.

- Adicionado novas extensões:
  DateTime:
  * Formatter de datas.
  * Getter de datas sem hora.
  * Função para adicionar dias.
  * Função para adicionar meses.
  * Função para copiar uma data e alterar algum parâmetro.
  * Função para obter o próximo dia útil.
  * Função para obter o primeiro dia do mês.
  * Função para obter o último dia do mês.

  Double:
  * Formatter para porcentagem.
  * Formatter para moedas.
  * Formatter para qualquer tipo de pattern.

  String:
  * Validação de e-mail.
  * Validação de nulo e vazio.
  * Função para criar Basic 64.

  Int:
  * Função para verificar se o número é par.

- Adicionado novos util's:
  * Shimmer: Shimmer effect para loading de listas.
  * ShimmerContainer: Container com Shimmer para loading de listas.
  * ScaleOnTap: Widget com efeito de Scale e função onTap.

- Http Service:
  * Testes: O Http está todo testado, tendo uma segurança a mais.
  * Erros: O Http tem tratamento de erros com enum de Erros.

  ## [1.0.1] Big Update!

- Somos Null-Safety!
 * O package foi migrado totalmente para Null-Safety!

- Adicionado novos validator's
  * CPFValidator: Validação de CPF.
  * CNPJValidator: Validação de CNPJ.

- Adicionado novos formatter's para TextField
  * CepInputFormatter: Formatter para TextField de CEP.
  * CpfInputFormatter: Formatter para TextField de CPF.
  * CpfOuCnpjFormatter: Formatter para TextField de CPF ou CNPJ.
  * CnpjInputFormatter: Formatter para TextField de CNPJ.
  * TelefoneInputFormatter: Formatter para TextField de Telefone.
  * RealInputFormatter: Formatter para TextField de Real (currency).
