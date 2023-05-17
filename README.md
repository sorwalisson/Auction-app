# Walisson Santos Auction App<br/>Senhos a um lance de distância

<image src="https://img.shields.io/github/languages/top/sorwalisson/Auction-app">

## Descrição: Este é um projeto com a finalidade de estudos e demonstração das minhas habilidades atuais como dev, além de uma ferramente de melhoria para minhas habilidades de desenvolvedor Rails.
- Ruby Version: <image src="https://img.shields.io/badge/Ruby-3.1.2-green"><br/>
- Rails Version: <image src= "https://img.shields.io/badge/Rails-7.0.4.3-green"><br/>
- Project Size: <image src="https://img.shields.io/github/repo-size/sorwalisson/Auction-app?style=for-the-badge"><br/>
- > Status do Projeto: Em desenvolvimento, Atualmente trabalhando em melhorias de front-end :warning:

## Dependências
Esse projeto tem o Sidekiq como um dos seus requerimentos:
<image src="https://img.shields.io/badge/Sidekiq-7.1.0-green"><br/>
E o Sidekiq por sua vez tem o Redis como requiremento:
<image src="https://img.shields.io/badge/Redis-7.0.11-green"><br/>
Para testes usei o RSpec:
<image src="https://img.shields.io/badge/rspec--rails-3.12-green"><br/>
E junto do RSpec base eu utilizei o rspec-sidekiq para testar o agendamento de jobs:
<image src="https://img.shields.io/badge/rspec--sidekiq-3.1.0-green"><br/>
E para o front End:
<image src="https://img.shields.io/badge/Bootstrap-5.2.3-green"><br/>
Authentication was handled by:
                            Devise


### QuickStart
Após instaladas as dependências, abra o terminal e faça os comandos:<br/>
`db:create`<br/>
`db:migrate`<br/>
`db:seed`<br/>
**Abra um terminal e execute o comando:** `redis-server`</br>
**Em outro terminal abra a pasta root do projeto e inicie o Sidekiq com o comando:** `bundle exec sidekiq`
- OBS:
  É de muito importante iniciar o Redis e Sidekiq antes de dar Rails S na aplicação pois é o sidekiq que vai iniciar e encerra as auctions. 

A seed irá conter 2 usuários admins e 2 usuários regulares:<br/>
**Admins:**<br/>
- **Nome:** AdminMaster, **Email:** adminmaster@leilaodogalpao.com.br, **Password:** password<br/>
- **Nome:** AdminSecond, **Email:** adminsecond@leilaodogalpao.com.br, **Password:** password<br/>
**Usuários:**<br/>
- **Nome:** FirstUser, **Email:** firstuser@email.com.br, **Password:** password<br/>
- **Nome:** SecondUser, **Email:** seconduser@email.com.br, **Password:** password<br/>

__________________________________________________________________________________________________________</br>



