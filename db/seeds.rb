User.destroy_all

User.create(id: 1,
            email:"playerone@email.com",
            password:"playerone",
            avatar:"https://cdn2.bulbagarden.net/upload/thumb/c/cd/Ash_JN.png/150px-Ash_JN.png",
            winrate: 100
            )

User.create(id: 2,
            email:"playertwo@email.com",
            password:"playertwo",
            avatar:"https://upload.wikimedia.org/wikipedia/en/7/71/DP-Brock.png",
            winrate: 100
            )

User.create(id: 3,
            email:"playerthree@email.com",
            password:"playerthree",
            avatar:"https://cdn2.bulbagarden.net/upload/thumb/f/fb/Misty_SM.png/150px-Misty_SM.png",
            winrate: 100
            )

Card.destroy_all

require 'httparty'

def request(url)
    response = HTTParty.get(url)
    JSON.parse(response.body) if response.code == 200
end
request('https://pokeapi.co/api/v2/pokemon/pikachu')
request('https://pokeapi.co/api/v2/pokemon/charmander')
request('https://pokeapi.co/api/v2/pokemon/bulbasaur')

@data_pikachu = request('https://pokeapi.co/api/v2/pokemon/pikachu')
@data_charmander = request('https://pokeapi.co/api/v2/pokemon/charmander')
@data_bulbasaur = request('https://pokeapi.co/api/v2/pokemon/bulbasaur')

Card.create(id: 1,
            user_id: 1,
            name: @data_pikachu["name"],
            pokemon_type: @data_pikachu["types"][0]["type"]["name"],
            ability: @data_pikachu["abilities"][0]["ability"]["name"],
            hp: @data_pikachu["stats"][0]["base_stat"],
            attack: @data_pikachu["stats"][1]["base_stat"],
            img_url: @data_pikachu["sprites"]["front_default"]
)

Card.create(id: 2,
            user_id: 2,
            name: @data_charmander["name"],
            pokemon_type: @data_charmander["types"][0]["type"]["name"],
            ability: @data_charmander["abilities"][0]["ability"]["name"],
            hp: @data_charmander["stats"][0]["base_stat"],
            attack: @data_charmander["stats"][1]["base_stat"],
            img_url: @data_charmander["sprites"]["front_default"]
)

Card.create(id: 3,
            user_id: 3,
            name: @data_bulbasaur["name"],
            pokemon_type: @data_bulbasaur["types"][0]["type"]["name"],
            ability: @data_bulbasaur["abilities"][0]["ability"]["name"],
            hp: @data_bulbasaur["stats"][0]["base_stat"],
            attack: @data_bulbasaur["stats"][1]["base_stat"],
            img_url: @data_bulbasaur["sprites"]["front_default"]
)