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
