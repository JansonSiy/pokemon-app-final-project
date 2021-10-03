User.destroy_all
Card.destroy_all
GymLeader.destroy_all
Battle.destroy_all

Battle.create(
    card_id: 1,
    user_attack: false,
    gym_leader_attack: true,
    hp: 1,
    damage: 1
)

require 'httparty'

def request(url)
    response = HTTParty.get(url)
    JSON.parse(response.body) if response.code == 200
end

# player one
request('https://pokeapi.co/api/v2/pokemon/charizard')
@data_charizard = request('https://pokeapi.co/api/v2/pokemon/charizard')

request('https://pokeapi.co/api/v2/pokemon/pikachu')
@data_pikachu = request('https://pokeapi.co/api/v2/pokemon/pikachu')

request('https://pokeapi.co/api/v2/pokemon/venusaur')
@data_venusaur = request('https://pokeapi.co/api/v2/pokemon/venusaur')

# Gym Leader Brock #1
request('https://pokeapi.co/api/v2/pokemon/mewtwo')
@data_mewtwo = request('https://pokeapi.co/api/v2/pokemon/mewtwo')

# Gym Leader Team Rocket #2
request('https://pokeapi.co/api/v2/pokemon/blastoise')
@data_blastoise = request('https://pokeapi.co/api/v2/pokemon/blastoise')

# Gym Leader Misty #3
request('https://pokeapi.co/api/v2/pokemon/magikarp')
@data_magikarp = request('https://pokeapi.co/api/v2/pokemon/magikarp')

PlayerOne = User.create(
    email: "playerone@email.com",
    password: "playerone",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/c/cd/Ash_JN.png/150px-Ash_JN.png",
    winrate: 100,
    # win_count: 0,
    win_count: 1,
    # battle_count: 0
    battle_count: 2
)
PlayerOne.cards.create(
    user_id: PlayerOne.id,
    name: @data_pikachu["name"],
    pokemon_type: @data_pikachu["types"][0]["type"]["name"],
    ability: @data_pikachu["abilities"][0]["ability"]["name"],
    # hp: @data_pikachu["stats"][0]["base_stat"],
    hp: 300,
    attack: @data_pikachu["stats"][1]["base_stat"],
    img_url: @data_pikachu["sprites"]["front_default"]
)
PlayerOne.cards.create(
    user_id: PlayerOne.id,
    name: @data_charizard["name"],
    pokemon_type: @data_charizard["types"][0]["type"]["name"],
    ability: @data_charizard["abilities"][0]["ability"]["name"],
    hp: @data_charizard["stats"][0]["base_stat"],
    attack: @data_charizard["stats"][1]["base_stat"],
    img_url: @data_charizard["sprites"]["front_default"]
)
PlayerOne.cards.create(
    user_id: PlayerOne.id,
    name: @data_venusaur["name"],
    pokemon_type: @data_venusaur["types"][0]["type"]["name"],
    ability: @data_venusaur["abilities"][0]["ability"]["name"],
    hp: @data_venusaur["stats"][0]["base_stat"],
    attack: @data_venusaur["stats"][1]["base_stat"],
    img_url: @data_venusaur["sprites"]["front_default"]
)

FirstGymLeader = GymLeader.create(
    name: "Brock",
    avatar: "https://upload.wikimedia.org/wikipedia/en/7/71/DP-Brock.png"
)
FirstGymLeader.cards.create(
    user_id: FirstGymLeader.id,
    name: @data_mewtwo["name"],
    pokemon_type: @data_mewtwo["types"][0]["type"]["name"],
    ability: @data_mewtwo["abilities"][0]["ability"]["name"],
    hp: @data_mewtwo["stats"][0]["base_stat"],
    attack: @data_mewtwo["stats"][1]["base_stat"],
    img_url: @data_mewtwo["sprites"]["front_default"]
)

SecondGymLeader = GymLeader.create(
    name: "Team Rocket",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/9/99/Team_Rocket_trio_SM.png/180px-Team_Rocket_trio_SM.png"
)
SecondGymLeader.cards.create(
    user_id: PlayerOne.id,
    name: @data_blastoise["name"],
    pokemon_type: @data_blastoise["types"][0]["type"]["name"],
    ability: @data_blastoise["abilities"][0]["ability"]["name"],
    hp: @data_blastoise["stats"][0]["base_stat"],
    attack: @data_blastoise["stats"][1]["base_stat"],
    img_url: @data_blastoise["sprites"]["front_default"]
)

ThirdGymLeader = GymLeader.create(
    name: "Misty",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/f/f6/Lets_Go_Pikachu_Eevee_Misty.png/183px-Lets_Go_Pikachu_Eevee_Misty.png"
)
ThirdGymLeader.cards.create(
    user_id: SecondGymLeader.id,
    name: @data_magikarp["name"],
    pokemon_type: @data_magikarp["types"][0]["type"]["name"],
    ability: @data_magikarp["abilities"][0]["ability"]["name"],
    # hp: @data_magikarp["stats"][0]["base_stat"],
    # hp: 100,
    hp: 300,
    attack: @data_magikarp["stats"][1]["base_stat"],
    # attack: 200,
    img_url: @data_magikarp["sprites"]["front_default"]
)