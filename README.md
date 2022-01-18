# CotacaoMoeda

É um aplicativo simples de conversor de moedas que também exibe alguns dados adicionais em relação a cada moeda

Esse APP consome a API publica dispobilizada pelo site https://economia.awesomeapi.com.br

## Features
1- Conversor do brasil para as moedas estrangeiras. 

2- Widget na tela principal da sua moeda em destaque

3- Pesquisa fechamento de moedas

4- Pesquisa sequencial de moedas

## Imagens

### Cotação
<img src="https://github.com/NetoBatista/CotacaoMoedas/blob/main/examples/quotation.jpeg?raw=true" width="200px">

### Widget 
<img src="https://github.com/NetoBatista/CotacaoMoedas/blob/main/examples/widget.jpeg" width="200px">

### Sequencial
<img src="https://github.com/NetoBatista/CotacaoMoedas/blob/main/examples/sequential.jpeg" width="200px">

### Sobre
<img src="https://github.com/NetoBatista/CotacaoMoedas/blob/main/examples/about.jpeg" width="200px">

### Fechamento
<img src="https://github.com/NetoBatista/CotacaoMoedas/blob/main/examples/closing.jpeg" width="200px">



# Para rodar o projeto
- O projeto está configurado para ser executado sem a necessidade de alterar parametros e urls no entento,  irei descrever o que pode ser alterado caso não seja executado da forma convencional

## Configuração mobile
- A url de base deve ser ajustada para o ip/dns que desejar 
    - Essa url pode ser encontrada em **Ocurrence.java** e **application_controller.dart**

## Configuração API
- As variáveis de ambiente devem ser ajustadas para a sua preferencia
    - **ASPNETCORE_URLS** - url de saida da aplicacao 
    - **PATH_COIN_JSON** - caminho onde se apresenta todos os dados das moedas
    - **PATH_COIN_FLAG** - caminho de todas as imagens das moedas
    - **PATH_COIN_ABOUT** - caminho do json que contem as descricoes adicionais das moedas
    - **AWESOMEAPI_URL** - url da awesomeapi
    - **URL_BASE** - mesma url base definida no ambiente mobile



