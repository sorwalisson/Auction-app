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

### Regras de Negócios utilizadas:<br/>
**Users:**
  - Usuários tem um atributo boolean que determina se ele é admin ou não:<br/>
    - Ou seja se User.admin? == true usuário é admin!<br/>
  - Usuários Admins não podem postar bids em Auctions!<br/>
  - Somente Admins tem acesso ao Admin Menu<br/>
  - Somente Admins pode bloquear um CPF<br/>
  - Como solicitado pelo TreinaDev uma Auction so pode ser confirmada por um Admin diferente do qual criou a Auction<br/>
  - Usuários padrão podem adicionar ou remover favoritos<br/>
  - Usuários padrão só podem postar bids em Auction com Status `:Running`<br/>
  - Usuários tem acesso as páginas My Favorites e Won Auctions<br/>

**Auctions:**
  - Auctions possuem `Status:` que são `:draft`, `:awaiting_confirmation`, `:confirmed`, `:running`, `:ended`, `:validated`, `:canceld`</br>
  
  - `:draft` Auctions:<br/>
    - Durante o status de `:draft` é possível editar a auction e adicionar items a auction, não sendo possível quaisquer modificações a mesma depois que ela vai para confirmação, além disso so Administradores tem acesso a Auction nesse estado.<br/>
    - Uma vez que a fase de `:draft` seja concluída o admin pode mandar ela para `:awaiting_confirmation` clickando no botão na pagina da auction.<br/>
  
  - `:awaiting_confirmation` Auctions:<br/>
    - Nessa etapa outro Administrador que não seja o mesmo que tenha criado a auction, confirma as informações e autoriza a realização da auction.<br/>
    - Quando o Administrador clickar no botão de confirmar Auction automaticamente será adicionado um Job a fila do sidekiq para executar um methodo no horário do `:starting_time`<br/>

  - `:confirmed` Auctions:<br/>
    - Esse é o primeiro momento em que a auction fica disponível para os usuários comuns a visualizem, assim podendo vêr detalhes da mesma, podendo até mesmo favorita-las.
    - A partir do momento em que o Job do sidekiq inicie a Auction ela será atualizada para `:running`.<br/>

  - `:running` Auctions: <br/>
    - A partir do momento em que o Sidekiq atualiza um Auction para `:running` ele ja adiciona automaticamente um Job para ser executado no data e hora do atributo `:ending_time`. <br/>
    - A partir daqui os usuários poderão dar lances as auctions "Bids".<br/>
    - Como falado anteriormente Administradores não podem "Bidar" Auctions.<br/>
    - O usuário que ja possui o maior lance não pode "Bidar" novamente, até que outro usuário cubra o seu lance.<br/>
    - Cada Auction tem um valor mínimo adicional de "Bids" que é mostrado pelo atributo `:bid_difference` que é expresso em porcentagem, ou seja se o maior "Bid" atual for de 5000 e o `:bid_difference` for de 20 o proxímo "Bid" tem que ser composto por 5000 + 20% de 5000 ou seja valor mínimo de 6000.<br/>
    - O usuário tem que estar logado para efetuar Bids<br/>

  




