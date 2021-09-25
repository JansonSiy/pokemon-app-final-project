class HomeController < ApplicationController
  def index
    @users = User.all
    @gym_leader = GymLeader.all
  end

  def show
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

    @initial_user_hp = @user.cards.first.hp
    @initial_gym_leader_hp = @gym_leader.cards.first.hp

    if @user.cards.first.hp > 0
      @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
      @gym_leader.cards.first.update(hp: @new_hp_gym_leader)
      
      @new_hp_player = @user.cards.first.hp - @gym_leader.cards.first.attack
      @user.cards.first.update(hp: @new_hp_player)

        if @user.cards.first.hp < 1 && @gym_leader.cards.first.hp < 1
          flash[:notice] = "Wow! It's a tie! <br> <br> 
            #{@user.cards.first.name} and #{@gym_leader.cards.first.name} are evenly matched! <br> <br>
            Both Pokemons fainted!"

          @user.cards.first.update(hp: @initial_user_hp)
          @gym_leader.cards.first.update(hp: @initial_gym_leader_hp)

          redirect_to home_path(params[:id])
    
        elsif @gym_leader.cards.first.hp < 1
          flash[:notice] = "You won! You have defeated #{@gym_leader.name}'s #{@gym_leader.cards.first.name}! <br> <br>
            HP fell to #{@gym_leader.cards.first.hp} after #{@user.cards.first.name} used #{@user.cards.first.ability}!"
          
          @user.cards.first.update(hp: @initial_user_hp)
          @gym_leader.cards.first.update(hp: @initial_gym_leader_hp)

          @user.cards.create(
            user_id: @user.id,
            name: @gym_leader.cards.first.name,
            pokemon_type: @gym_leader.cards.first.pokemon_type,
            ability: @gym_leader.cards.first.ability,
            hp: @gym_leader.cards.first.hp,
            attack: @gym_leader.cards.first.attack,
            img_url: @gym_leader.cards.first.img_url
          )

          redirect_to home_path(params[:id])
    
        elsif @user.cards.first.hp < 1
          flash[:notice] = "You lost! You have been defeated by #{@gym_leader.name}'s #{@gym_leader.cards.first.name}! <br> <br>
            Your #{@user.cards.first.name}'s hp fell to #{@user.cards.first.hp}! <br> <br>
            #{@gym_leader.cards.first.name}'s #{@gym_leader.cards.first.ability} is unmatched!"

          @user.cards.first.update(hp: @initial_user_hp)
          @gym_leader.cards.first.update(hp: @initial_gym_leader_hp)

          redirect_to home_path(params[:id])
        end
    end

    # PLAYER to PLAYER
    # if you are updating an integer, it must be .update not .save
    # @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
    # @gym_leader.cards.first.update(hp: @new_hp_gym_leader)
    
    # if @gym_leader.cards.first.hp < 0
    #   redirect_to root_path
    #   flash[:notice] = "You won! You have defeated the Gym Leader"
    # else
    #   redirect_to home_path(params[:id])
    # end

    # session[:@gym_leader_hp_duplicate] = @gym_leader.cards.first.hp
    # session[:@gym_leader_hp_duplicate_attacked] -= @user.cards.first.attack
  end

  def gym_leader_attack
    # PLAYER to PLAYER
    # @gym_leader = GymLeader.find(params[:id])
    # @user = current_user

    # Battle.create(
    #   card_id: @gym_leader.cards.first.id,
    #   user_attack: false,
    #   gym_leader_attack: true,
    #   hp: @user.cards.first.hp,
    #   damage: @gym_leader.cards.first.attack
    # )

    # @new_hp_player = @user.cards.first.hp - @gym_leader.cards.first.attack
    # @user.cards.first.update(hp: @new_hp_player)

    # if @user.cards.first.hp < 0
    #   redirect_to root_path
    #   flash[:notice] = "You lost! You have been defeated by the Gym Leader"
    # else
    #   redirect_to home_path(params[:id])
    # end
  end
end