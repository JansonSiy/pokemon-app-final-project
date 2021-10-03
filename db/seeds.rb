User.destroy_all
Card.destroy_all
GymLeader.destroy_all
Battle.destroy_all

require 'httparty'

# Seed cards for pokedex
count = 0
50.times.each do 
    count += 1
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{count}/")
    @datas = JSON.parse(response.body)

    Card.create(
        name: @datas["name"],
        pokemon_type: @datas["types"].map {|x| x["type"]["name"]},
        ability: @datas["abilities"].map {|x| x["ability"]["name"]} ,
        move: @datas["moves"].map {|x| x["move"]["name"]},
        # stats: @datas["stats"].map { |x, y| "[#{x["base_stat"]} , #{x["stat"]["name"]}]" } ,
        img_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{count}.png",

        hp: @datas["stats"][0]["base_stat"],
        attack: @datas["stats"][1]["base_stat"],
    )
end

# Seed User with 3 random pokemon
PlayerOne = User.create(
    name: "ash gray",
    email: "playerone@email.com",
    password: "playerone",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/c/cd/Ash_JN.png/150px-Ash_JN.png",
    winrate: 0
)
3.times.each do 
    c1 = Card.find(rand(Card.first.id..Card.last.id))
    PlayerOne.cards.create( user_id: c1.user_id, 
                            name: c1.name  , 
                            pokemon_type: c1.pokemon_type  , 
                            ability: c1.ability  , 
                            move: c1.move  , 
                            hp: c1.hp  , 
                            attack: c1.attack  , 
                            img_url: c1.img_url ,
    )
end


# Seed GymLeader with 1 random pokemon

FirstGymLeader = GymLeader.create(
    name: "Brock",
    avatar: "https://upload.wikimedia.org/wikipedia/en/7/71/DP-Brock.png"
)

SecondGymLeader = GymLeader.create(
    name: "Team Rocket",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/9/99/Team_Rocket_trio_SM.png/180px-Team_Rocket_trio_SM.png"
)

ThirdGymLeader = GymLeader.create(
    name: "Misty",
    avatar: "https://cdn2.bulbagarden.net/upload/thumb/f/f6/Lets_Go_Pikachu_Eevee_Misty.png/183px-Lets_Go_Pikachu_Eevee_Misty.png"
)

g1 = Card.find(rand(Card.first.id..Card.last.id))

FirstGymLeader.cards.create( user_id: g1.user_id, 
    name: g1.name  , 
    pokemon_type: g1.pokemon_type  , 
    ability: g1.ability  , 
    move: g1.move  , 
    hp: g1.hp  , 
    attack: g1.attack  , 
    img_url: g1.img_url ,
)

SecondGymLeader.cards.create(    user_id: g1.user_id, 
    name: g1.name  , 
    pokemon_type: g1.pokemon_type  , 
    ability: g1.ability  , 
    move: g1.move  , 
    hp: g1.hp  , 
    attack: g1.attack  , 
    img_url: g1.img_url ,
)

ThirdGymLeader.cards.create(    user_id: g1.user_id, 
    name: g1.name  , 
    pokemon_type: g1.pokemon_type  , 
    ability: g1.ability  , 
    move: g1.move  , 
    hp: g1.hp  , 
    attack: g1.attack  , 
    img_url: g1.img_url ,
)