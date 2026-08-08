# Duplicata-Escritural
Classe Harbour de manipulação da API de Duplicata Escritural

Explicação da Classe
Principais Características
Autenticação: Suporte a token Bearer via header Authorization

Ambientes: Produção e Sandbox (B3 e CER)

Métodos HTTP: GET, POST, PATCH

Manipulação de JSON: Codificação e decodificação nativa do Harbour

Tratamento de Erros: Captura de respostas HTTP e erros de negócio

Exemplo de Uso Básico
harbour
// Instanciar a API
oAPI := TRDEAPI():New( "Bearer SEU_TOKEN", .F. )  // .F. = Produção

// Consultar duplicatas
oAPI:GetDuplicatas( { "cnpjSolicitante" => "92591919000115" } )

// Incluir duplicata manual
hData := { "data" => { ... } }  // conforme especificação
oAPI:PostDuplicataManualV1( hData )

// Consultar por ID
oAPI:GetDuplicataById( "ID_DUPLICATA", "0001" )
Dependências
Harbour com suporte a JSON (hb_JsonDecode, hb_JsonEncode)

libcurl (hbcurl.ch) para requisições HTTP

Observações
Substitua SEU_TOKEN_AQUI pelo token de autorização real

A classe captura todas as respostas e exibe exemplos básicos de cada endpoint

Para produção, recomenda-se adicionar validações adicionais e tratamento de erros específicos


// ============================================================
// PROGRAMA PRINCIPAL (EXEMPLO DE USO)
// ============================================================

PROCEDURE Main()
   LOCAL oAPI, hResult

   // Exemplo de uso da API
   oAPI := TRDEAPI():New( "Bearer SEU_TOKEN_AQUI", .F. )  // .F. = Produção, .T. = Sandbox

   ? "=== TESTE DA API RDE ==="
   ?

   // Exemplo 1: Consultar duplicatas
   ? "Exemplo 1: Consultar duplicatas"
   hResult := oAPI:GetDuplicatas( {=>} )
   ?

   // Exemplo 2: Incluir duplicata manual (V1)
   ? "Exemplo 2: Incluir duplicata manual (V1)"
   hResult := oAPI:PostDuplicataManualV1( ;
      { "data" => { ;
         "dadosPartes" => { ;
            "tipoDocumentoSacador" => "CNPJ", ;
            "numeroDocumentoSacador" => "92591919000115", ;
            "nomeSacador" => "Empresa Sacadora LTDA", ;
            "tipoDocumentoSacado" => "CNPJ", ;
            "numeroDocumentoSacado" => "83561661000113", ;
            "nomeSacado" => "Empresa Sacada LTDA", ;
            "pcaPagtoSacado" => 3550308 ;
         }, ;
         "dadosTransacao" => { ;
            "numeroFatura" => "20241210" ;
         }, ;
         "tipoDuplicata" => "DUPLICATA_MERCANTIL", ;
         "totalParcelas" => 1, ;
         "duplicatas" => { { ;
            "dadosDuplicata" => { ;
               "numeroOrdem" => "0001", ;
               "numeroParcela" => 1, ;
               "dataVencimento" => "2026-12-31", ;
               "valorDuplicata" => 15000.00, ;
               "liberadoNegociacao" => "S" ;
            } ;
         } } ;
      } } )
   ?

   // Exemplo 3: Consultar duplicata por ID
   ? "Exemplo 3: Consultar duplicata por ID"
   hResult := oAPI:GetDuplicataById( "ID_DUPLICATA_EXEMPLO", NIL )
   ?

   // Exemplo 4: Verificar processamento
   ? "Exemplo 4: Verificar processamento"
   hResult := oAPI:GetProcessamento( "ID_PROCESSAMENTO_EXEMPLO" )
   ?

   // Exemplo 5: Incluir duplicata via chave de acesso
   ? "Exemplo 5: Incluir duplicata via chave de acesso"
   hResult := oAPI:PostDuplicata( ;
      { "data" => { ;
         "tipoDocumentoFiscal" => "NFEL", ;
         "chaveAcesso" => "35180601234567890123550010000000012345678903" ;
      } } )
   ?

   ? "=== FIM DOS TESTES ==="

RETURN
