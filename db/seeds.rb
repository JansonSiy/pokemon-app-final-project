Card.destroy_all
User.destroy_all

require 'httparty'

response = HTTParty.get('https://pokeapi.co/api/v2/pokemon/pikachu')
puts response.body if response.code == 200

@data_pikachu = JSON.parse(response.body)

@pikachu_name = @data_pikachu["name"]
@pikachu_type = @data_pikachu["types"][0]["type"]["name"]
@pikachu_ability = @data_pikachu["abilities"][0]["ability"]["name"]
@pikachu_hp_name = @data_pikachu["stats"][0]["stat"]["name"]
@pikachu_hp_stat = @data_pikachu["stats"][0]["base_stat"]
@pikachu_attack_name = @data_pikachu["stats"][1]["stat"]["name"]
@pikachu_attack_stat = @data_pikachu["stats"][1]["base_stat"]
@pikachu_img_url = @data_pikachu["sprites"]["front_default"]

response_two = HTTParty.get('https://pokeapi.co/api/v2/pokemon/charmander')
puts response_two.body if response_two.code == 200

@data_charmander = JSON.parse(response_two.body)

@charmander_name = @data_charmander["name"]
@charmander_type = @data_charmander["types"][0]["type"]["name"]
@charmander_ability = @data_charmander["abilities"][0]["ability"]["name"]
@charmander_hp_name = @data_charmander["stats"][0]["stat"]["name"]
@charmander_hp_stat = @data_charmander["stats"][0]["base_stat"]
@charmander_attack_name = @data_charmander["stats"][1]["stat"]["name"]
@charmander_attack_stat = @data_charmander["stats"][1]["base_stat"]
@charmander_img_url = @data_charmander["sprites"]["front_default"]

Card.create(id: 1,
            user_id: 1,
            name: @pikachu_name,
            pokemon_type: @pikachu_type,
            ability: @pikachu_ability,
            hp: @pikachu_hp_stat,
            attack: @pikachu_attack_stat,
            img_url: @pikachu_img_url)
Card.create(id: 2,
            user_id: 1,
            name: @charmander_name,
            pokemon_type: @charmander_type,
            ability: @charmander_ability,
            hp: @charmander_hp_stat,
            attack: @charmander_attack_stat,
            img_url: @charmander_img_url)



User.create(email:"user11@gmail.com", password:"user11")