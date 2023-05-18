users = User.create([
  {
    name: "AdminMaster",
    email: "adminmaster@leilaodogalpao.com.br",
    password: "password",
    address: "Rua Santa Fé, 35, Boa Ventura",
    zip: "50000-000",
    cpf: "79679768007"
  },

  {
    name: "AdminSecond",
    email: "adminsecond@leilaodogalpao.com.br",
    password: "password",
    address: "Rua Santa Joana, 35, Boa Ventura",
    zip: "50000-000",
    cpf: "25689066001"
  },

  {
    name: "FirstUser",
    email: "firstuser@email.com.br",
    password: "password",
    address: "Rua Santa antonio, 35, Boa Ventura",
    zip: "50000-000",
    cpf: "10036928003"
  },
  
  {
    name: "SecondUser",
    email: "seconduser@email.com.br",
    password: "password",
    address: "Rua sao joao, 35, Boa Ventura",
    zip: "50000-000",
    cpf: "75131988020"
  },
])

first_auction = AuctionLot.create!(starting_time: 10.minutes.from_now,
    ending_time: 20.minutes.from_now, auction_code: "cba247577",
    starting_bid: 500, bid_difference: 15, user_id: User.first.id)

second_auction = AuctionLot.create!(starting_time: 30.minutes.from_now,
    ending_time: 1.hour.from_now, auction_code: "gos602034",
    starting_bid: 25000, bid_difference: 50,
    user_id: User.first.id)

third_auction = AuctionLot.create!(starting_time: 1.hour.from_now,
    ending_time: 2.hour.from_now, auction_code: "bak306202",
    starting_bid: 12000, bid_difference: 65,
    user_id: User.first.id)

fourth_auction = AuctionLot.create!(starting_time: 3.hours.from_now,
    ending_time: 4.hour.from_now, auction_code: "ccb602034",
    starting_bid: 25000, bid_difference: 50,
    user_id: User.first.id)

item_first = Item.create!(name: "Skate utilizado por Bob Burnquist,",
    description: "o qual utilizou quando ganhou o street league, e foi campeão mundial na modalidade street, AUTOGRAFADO!",
    weight: 1500, height: 16, width: 80, depth: 20, category: "sports",
    auction_lot_id: first_auction.id)

item_second = Item.create!(name: "Peugeot 208 Griffe",
    description: "Peugeot 208 Griffe, Versão Griffe, com teto solar, direção elétrica, freios abs, piloto automático adaptativo.",
    weight: 1200000, height: 150, width: 130, depth: 80, category: "cars",
    auction_lot_id: second_auction.id)

item_third = Item.create!(name: "PC Gamer i7, RTX 4080",
    description: "PC game i7, Rtx 4080, 32gb ram ddr5, gabinet Aerocool",
    weight: 2500, height: 80, width: 70, depth: 30, category: "technology",
    auction_lot_id: third_auction.id)

item_fourth = Item.create!(name: "Mesa Gamer 30",
    description: "Mesa game com altura ajustável e suporte para 4 monitores.",
    weight: 2500, height: 80, width: 70, depth: 30, category: "furniture",
    auction_lot_id: fourth_auction.id)

image_path = Rails.root.join('spec', 'support', 'images', 'skate.jpeg')
item_first.photo.attach(io: File.open(image_path), filename: 'skate.jpeg')
image_path2 = Rails.root.join('spec', 'support', 'images', 'peugeot.jpeg')
item_second.photo.attach(io: File.open(image_path2), filename: 'peugeot.jpeg')
image_path3 = Rails.root.join('spec', 'support', 'images', 'pcgamer.jpeg')
item_third.photo.attach(io: File.open(image_path3), filename: 'pcgamer.jpeg')
image_path4 = Rails.root.join('spec', 'support', 'images', 'mesa.jpeg')
item_fourth.photo.attach(io: File.open(image_path4), filename: 'mesa.jpeg')
