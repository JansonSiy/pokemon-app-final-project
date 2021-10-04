User.destroy_all
Card.destroy_all
GymLeader.destroy_all
Battle.destroy_all

# user's first turn
Battle.create(
    card_id: 1,
    user_attack: false,
    gym_leader_attack: true,
    hp: 1,
    damage: 1
)

require 'httparty'

# seed cards for pokedex
count = 0
2.times.each do 
    count += 1
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{count}/")
    @datas = JSON.parse(response.body)

    Card.create(
        name: @datas["name"],
        pokemon_type: @datas["types"].map {|x| x["type"]["name"]},
        ability: @datas["abilities"].map {|x| x["ability"]["name"]},
        hp: @datas["stats"][0]["base_stat"] * 5,
        initial_hp: @datas["stats"][0]["base_stat"] * 5,
        attack: @datas["stats"][1]["base_stat"],
        img_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{count}.png",
        move: @datas["moves"].map {|x| x["move"]["name"]},
    )
end

# for user and gym leader cards
def request(url)
    response = HTTParty.get(url)
    JSON.parse(response.body) if response.code == 200
end

request('https://pokeapi.co/api/v2/pokemon/pikachu')
@data_pikachu = request('https://pokeapi.co/api/v2/pokemon/pikachu')

request('https://pokeapi.co/api/v2/pokemon/mewtwo')
@data_mewtwo = request('https://pokeapi.co/api/v2/pokemon/mewtwo')

request('https://pokeapi.co/api/v2/pokemon/magikarp')
@data_magikarp = request('https://pokeapi.co/api/v2/pokemon/magikarp')

# seed user
PlayerOne = User.create(
    name: "Ash Gray",
    email: "playerone@email.com",
    password: "playerone",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/c/cd/Ash_JN.png/150px-Ash_JN.png",
    winrate: 100,
    win_count: 0,
    battle_count: 0
)
PlayerOne.cards.create(
    user_id: PlayerOne.id,
    name: @data_pikachu["name"],
    # pokemon_type: @data_pikachu["types"][0]["type"]["name"],
    # ability: @data_pikachu["abilities"][0]["ability"]["name"],
    pokemon_type: @data_pikachu["types"].map {|x| x["type"]["name"]},
    ability: @data_pikachu["abilities"].map {|x| x["ability"]["name"]},
    hp: @data_pikachu["stats"][0]["base_stat"] * 5,
    initial_hp: @data_pikachu["stats"][0]["base_stat"] * 5,
    attack: @data_pikachu["stats"][1]["base_stat"],
    img_url: @data_pikachu["sprites"]["front_default"],
    move: @data_pikachu["moves"].map {|x| x["move"]["name"]}
)

# seed gym leaders
FirstGymLeader = GymLeader.create(
    name: "Brock",
    avatar: "https://upload.wikimedia.org/wikipedia/en/7/71/DP-Brock.png"
)
FirstGymLeader.cards.create(
    user_id: FirstGymLeader.id,
    name: @data_mewtwo["name"],
    pokemon_type: @data_mewtwo["types"].map {|x| x["type"]["name"]},
    ability: @data_mewtwo["abilities"].map {|x| x["ability"]["name"]},
    hp: @data_mewtwo["stats"][0]["base_stat"] * 5,
    initial_hp: @data_mewtwo["stats"][0]["base_stat"] * 5,
    attack: @data_mewtwo["stats"][1]["base_stat"],
    img_url: @data_mewtwo["sprites"]["front_default"],
    move: @data_mewtwo["moves"].map {|x| x["move"]["name"]}
)

SecondGymLeader = GymLeader.create(
    name: "Team Rocket",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/9/99/Team_Rocket_trio_SM.png/180px-Team_Rocket_trio_SM.png"
)
SecondGymLeader.cards.create(
    user_id: SecondGymLeader.id,
    name: @data_magikarp["name"],
    pokemon_type: @data_magikarp["types"].map {|x| x["type"]["name"]},
    ability: @data_magikarp["abilities"].map {|x| x["ability"]["name"]},
    hp: @data_magikarp["stats"][0]["base_stat"] * 5,
    initial_hp: @data_magikarp["stats"][0]["base_stat"] * 5,
    attack: @data_magikarp["stats"][1]["base_stat"],
    img_url: @data_magikarp["sprites"]["front_default"],
    move: @data_magikarp["moves"].map {|x| x["move"]["name"]}
)

# seed gym leader with random card
ThirdGymLeader = GymLeader.create(
    name: "Misty",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/f/f6/Lets_Go_Pikachu_Eevee_Misty.png/183px-Lets_Go_Pikachu_Eevee_Misty.png"
)

g1 = Card.find(rand(Card.first.id..Card.last.id))

ThirdGymLeader.cards.create(
    user_id: g1.user_id, 
    name: g1.name, 
    pokemon_type: g1.pokemon_type, 
    ability: g1.ability,
    hp: g1.hp,
    initial_hp: g1.initial_hp,
    attack: g1.attack, 
    img_url: g1.img_url,
    move: g1.move
)