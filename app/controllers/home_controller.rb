class HomeController < ApplicationController
  def index
    @users = User.all
    @gym_leader = GymLeader.all
  end

  def battle
    @gym_leader = GymLeader.find(params[:id])
  end

  def user_attack
    @gym_leader = GymLeader.find(params[:id])
    @user = current_user

    Battle.create(
      card_id: current_user.cards.first.id,
      user_attack: true,
      gym_leader_attack: false,
      hp: @gym_leader.cards.first.hp,
      damage: @user.cards.first.attack
    )

    # initial hp of cards
    @initial_user_hp = @user.cards.first.hp
    @initial_gym_leader_hp = @gym_leader.cards.first.hp
    
    # if player's hp is more than 0, the battle continues
    if @user.cards.first.hp > 0
      # player attacks gym leader and hp updates
      @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
      @gym_leader.cards.first.update(hp: @new_hp_gym_leader)

      # gym leader attacks player and hp updates
      @new_hp_player = @user.cards.first.hp - @gym_leader.cards.first.attack
      @user.cards.first.update(hp: @new_hp_player)

        # if both player and gym leader are still alive, flash message
        if @user.cards.first.hp < 1 && @gym_leader.cards.first.hp < 1
          flash[:notice] = "Wow! It's a tie! <br> <br> 
            #{@user.cards.first.name} and #{@gym_leader.cards.first.name} are evenly matched! <br> <br>
            Both Pokemons fainted!"

          # @user.cards.first.update(hp: @initial_user_hp)
          # @gym_leader.cards.first.update(hp: @initial_gym_leader_hp)

          redirect_to battle_path(params[:id])
        
        # if gym leader's hp is less than 1
        elsif @gym_leader.cards.first.hp < 1
        # flash the message below that player won the battle
          flash[:notice] = "You won! You have defeated #{@gym_leader.name}'s #{@gym_leader.cards.first.name}! <br> <br>
            HP fell to #{@gym_leader.cards.first.hp} after #{@user.cards.first.name} used #{@user.cards.first.ability}!"
          
          # revert pokemon's/card's hp back to the initial one
          @user.cards.first.update(hp: @initial_user_hp)
          @gym_leader.cards.first.update(hp: @initial_gym_leader_hp)

          # create a copy of the gym leader's pokemon/card for the player
          @user.cards.create(
            user_id: @user.id,
            name: @gym_leader.cards.first.name,
            pokemon_type: @gym_leader.cards.first.pokemon_type,
            ability: @gym_leader.cards.first.ability,
            hp: @gym_leader.cards.first.hp,
            attack: @gym_leader.cards.first.attack,
            img_url: @gym_leader.cards.first.img_url
          )

          # compute win rate of the user
          # first ++ the win_count and battle count and update database
          @new_win_count = @user.win_count + 1
          @new_battle_count = @user.battle_count + 1
          
          @user.update(win_count: @new_win_count)
          @user.update(battle_count: @new_battle_count)
          
          # use simple percentage math and update database
          @new_winrate = (100 * @user.win_count) / @user.battle_count
          @user.update(winrate: @new_winrate)

          # redirect to the same page
          redirect_to battle_path(params[:id])
        
        # if player's hp is less than 1
        elsif @user.cards.first.hp < 1
        # flash the message below that player lost the battle
          flash[:notice] = "You lost! You have been defeated by #{@gym_leader.name}'s #{@gym_leader.cards.first.name}! <br> <br>
            Your #{@user.cards.first.name}'s hp fell to #{@user.cards.first.hp}! <br> <br>
            #{@gym_leader.cards.first.name}'s #{@gym_leader.cards.first.ability} is unmatched!"

          # revert pokemon's/card's hp back to the initial one
          @user.cards.first.update(hp: @initial_user_hp)
          @gym_leader.cards.first.update(hp: @initial_gym_leader_hp)
          
          # compute win rate of the user
          # first ++ the battle count ONLY and update database
          @new_battle_count = @user.battle_count + 1

          @user.update(battle_count: @new_battle_count)
          
          # use simple percentage math and update database
          @new_winrate = (100 * @user.win_count) / @user.battle_count
          @user.update(winrate: @new_winrate)

          # redirect to the same page
          redirect_to battle_path(params[:id])
        end
    end
  end

  def gym_leader_attack
  end

  def hello 
  end
end