# Walisson Santos Auction App<br/>Sonhos a um lance de distância

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

A seed também irá conter 4 Auctions com um item cada, Após executar o `db:seed`, deve-se logar como um admin e ir até o Admin Panel e ir até essas Auctions e mudar seu `status:` para `:awaiting_confirmation`, e em seguidar logar no segundo admin para mudar o `status:` para `:confirmed`.

### Regras de Negócios utilizadas:<br/>
**Users:**<br/>
  - Usuários tem um atributo boolean que determina se ele é admin ou não:<br/>
    - Ou seja se User.admin? == true usuário é admin!<br/>
  - Usuários Admins não podem postar bids em Auctions!<br/>
  - Somente Admins tem acesso ao Admin Menu<br/>
    - Ações de validações e confirmações podem ser feitas nesse menu.<br/>
    - Bem como cancelar CPFs<br/>
  - Somente Admins pode bloquear um CPF<br/>
  - Como solicitado pelo TreinaDev uma Auction so pode ser confirmada por um Admin diferente do qual criou a Auction<br/>
  - Usuários padrão podem adicionar ou remover favoritos<br/>
  - Usuários padrão só podem postar bids em Auction com Status `:Running`<br/>
  - Usuários tem acesso as páginas My Favorites e Won Auctions<br/>

**Auctions:**<br/>
  - Auctions possuem `Status:` que são `:draft`, `:awaiting_confirmation`, `:confirmed`, `:running`, `:ended`, `:validated`, `:canceld`</br>
  
  - `:draft` Auctions:<br/>
    - Durante o status de `:draft` é possível editar a auction e adicionar items a auction, não sendo possível quaisquer modificações a mesma depois que ela vai para confirmação, além disso so Administradores tem acesso a Auction nesse estado.<br/>
    - Uma vez que a fase de `:draft` seja concluída o admin pode mandar ela para `:awaiting_confirmation` clickando no botão na pagina da auction.<br/>
  
  - `:awaiting_confirmation` Auctions:<br/>
    - Nessa etapa outro Administrador que não seja o mesmo que tenha criado a auction, confirma as informações e autoriza a realização da auction.<br/>
    - Quando o Administrador clickar no botão de confirmar Auction automaticamente será adicionado um Job a fila do sidekiq para executar um methodo no horário do `:starting_time` e este metodo muda o status da auction para `:running`<br/>

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
    - Por fim o sidekiq executa o Job agendado para mudar o `status:` para `:ended`.<br/>

  - `:ended` Auctions:<br/>
    - Esta etapa é para um administrador verificar se houveram "Bids".<br/>
    - Se um administrador verificou que houve ao menos um "Bid" esse valida a auction clickando no botão para mudar `status:` para `:validated` e assim o usuário consegue vê na sua página de Won Auctions que ele Adquiriu o lot.<br/>
    - Durante a fase `:ended` os usuários não conseguem ter acesso ao lote.<br/>
    - Se não houve nenhum "Bid" o administrador clicka no botão para cancelar o lot mudando o seu `status:` para `:canceled`.<br/>
    - Pensei em tornar o processo de validação e cancelamento automatizado, mas como o projeto pediu para que um administrador o fizesse então deixe esse processo de forma manual.
  
  - `:validated` Auctions:<br/>
    - Nesta etapa a auction fica vísivel para os usuários aferirem os resultados.<br/>
    - Neste etapa a auction pode ser acessada também pelo vencedor atráves da página Won Auctions.<br/>

  - `:canceled` Auctions:<br/>
    - Quando uma Auction é cancelada os administradores podem migrar os itens nela cadastrados para outras Auctions desde que essa Auction destino tenha o `status:``:draft`<br/>
    - A partir daqui os usuários comuns não tem mais acesso a Auction, so os administradores atráves do Admin Menu.<br/>

  **Items:**<br/>
    - Os itens podem ser criados atráves de um link na página de uma Auction que tenha o `status:``:draft`.<br/>
    - Itens de Auctions canceladas podem ser transferido desde que a Auction siga o critério supracitado.<br/>
    - Todos os atributos são obrigatórios exceto a `:photo`.<br/>

  **Bid:**<br/>
    - "Bids" so podem ser feitas em `:running` Auctions.<br/>
    - A primeira "Bid" tem que ser >= do que `Auction.starting_bid`<br/>
    - Bids subsequentes precisam ser >= do que `Auction.new_bid_value`<br/>
    - Usuários que ja possuem a maior "bid", dar outro lance até que outro usuário dê um lance maior do que o atual. <br/>
    - Administradores não podem dar "Bids" em quaisquer Auction.<br/>

## Funções Adicionais:<br/>

  **Bloqueador de CPF:**<br/>

  - O bloqueador de CPF utiliza um model chamado BlackListCpf, :warning: `:Eu utilizei essa nomeclatura e depois meio que me arrependi, pretendo muda-la depois que o projeto for para avaliação`.<br/>
  - Um Administrador pode ir até o Admin Menu e preencher o formulário com o CPF o qual deseja bloquear.<br/>
  - Usuários que tentarem se cadastrar com um CPF bloqueador serão impedidos.<br/>
  - Usuários cadastrados e que porventura tem a conta vinculada a um CPF bloqueado, serão informados e impedidos de participarem de leilões e postar dúvidas.<br/>

  **Search:**<br/>
    - Um usuário pode usar o metodo de buscar que fica localizado na 'nav-bar' para pesquisar por Itens ou Auctions.<br/>
    - Se um usuário pesquisar digitando um código completo de uma Auction ele será redirecionado diretamente para a pagina da auction, desde que mesma esteja vísivel para usuários comuns.<br/>
    - Se um usuário pesquisar digitando um código completo de um item ele será direcionado automaticamente para a página do item, desde que o mesmo pertença a uma Auction que esteja visível a usuários comuns.<br/>
    - Se um usuário usar um fragmento de texto, este será direcionado a uma tela em que mostra os resultados, que serão possíveis itens que possuam o fragmento de texto no nome.<br/>
  
  **Questions and Answer**</br>
    - Usuários podem enviar perguntas sobre um lote na página do mesmo, lembro que usuários comuns só podem acessar lotes com determinados `status:`.<br/>
    - Somente administradores podem responder essas perguntas, e o mesmo deve fazer acessando a página do lote.<br/>
    - Um administrador pode ocultar uma pergunta se julga-la ofensiva ou que quebre as regras do site, e só basta um click de botão para tal. <br/>
    - Cada pergunta só pode ter uma resposta, mas um usuário pode colocar quantas perguntas ele desejar.<br/>

  
  **Favoritos:**<br/>
    - Um usuário pode clickar no botão "Adicionar aos favoritos" para adicionar um lote a sua lista de favoritos.<br/>
    - E o mesmo pode remover um lote de sua lista de favorites, clickando para remover de sua lista.<br/>


## Considerações Finais:

Primeiramente queria agradecer ao pessoal da TreinaDev pela oportunidade e pelos conteúdos disponibilizados no site, e pela bússola que é o projeto TreinaDev. Tem sido uma jornada intensa e valiosa de aprendizados e conquistas.<br/>
Sei que ainda tenho trabalho a fazer nesse projetos e em outros que estão no meu Github, mas cada nova ferramente aprendida e cada boa prática assimalada são passos indispensáveis para a formação de um novo dev.<br/>

Além do pessoal do TreinaDev / CampusCode fica aqui também meus agradecimentos aos meus queridíssemos amigos:<br/>
[**Ricardo Silva**](https://www.linkedin.com/in/ricardobsilva13/)<br/>
  - Foi ele quem me apresentou RoR e que me guiou nos meus primeiros passos na linguagem Ruby e que me incentivou.<br/>

[**João Henrique de Souza**](https://www.linkedin.com/in/jo%C3%A3o-henrique-de-souza-5523214b/)<br/>
  - Apesar de ele não ser da área dev Rails, ele me ajudou muito me ensinando várias coisas de Terminal, Postgresql e afins.<br/>

Apesar de eles não terem participados deste projeto, sei que o conhecimento que eles me passaram lá atrás me ajudaram a superar desáfios e continuaram e me ser úteis em quanto eu for DEV.

Obrigado e fico no aguardo do FeedBack.



    
  



  




