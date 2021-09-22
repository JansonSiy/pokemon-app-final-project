class HomeController < ApplicationController
  def index
    @users = User.all
    @gym_leader = GymLeader.all
  end

  def show
    @gym_leader = GymLeader.find(params[:id])
  end

  def user_attack
    # ALTERNATE ATTACK
    @gym_leader = GymLeader.find(params[:id])
    @user = current_user

    Battle.create(
      card_id: current_user.cards.first.id,
      user_attack: true,
      gym_leader_attack: false,
      hp: @gym_leader.cards.first.hp,
      damage: @user.cards.first.attack
    )

    # if you are updating an integer, it must be .update not .save
    # @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
    # @gym_leader.cards.first.update(hp: @new_hp_gym_leader)
    
    # if @gym_leader.cards.first.hp < 0
    #   redirect_to root_path
    #   flash[:notice] = "You won! You have defeated the Gym Leader"
    # else
    #   redirect_to home_path(params[:id])
    # end

    # MAIN METHOD
    # if @user.cards.first.hp < 1 && @gym_leader.cards.first.hp < 1
    #   redirect_to root_path
    #   flash[:notice] = "It's a tie!"

    # elsif @gym_leader.cards.first.hp < 1
    #   redirect_to root_path
    #   flash[:notice] = "You won! You have defeated the gym leader!"

    # elsif @user.cards.first.hp < 1
    #   redirect_to root_path
    #   flash[:notice] = "You lost! You have been defeated by the gym leader!"

    # elsif @user.cards.first.hp > 0
    #   @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
    #   @gym_leader.cards.first.update(hp: @new_hp_gym_leader)

    #   @new_hp_player = @user.cards.first.hp - @gym_leader.cards.first.attack
    #   @user.cards.first.update(hp: @new_hp_player)

    #   flash[:notice] = "Both trainers exchanged damage!"

    #   redirect_to home_path(params[:id])
    # end
  end

  def gym_leader_attack
    # ALTERNATE ATTACK
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
