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
    @initial_user_hp = @user.cards.first.hp
    @initial_gym_leader_hp = @gym_leader.cards.first.hp

    # STEP 1 - CHECK BATTLE MODEL
    # STEP 1.a - Battle.create FOR NEXT VALIDATION
    # STEP 1.b - HP -= ATTACK
    # STEP 1.c - REDIRECT SAME PAGE
    
    # STEP 2 - CHECK IF HP IS 0
    # STEP 2.a - ADJUST WINRATE
    # STEP 2.b - REDIRECT SAME PAGE

    # if "gym_leader_attack: true" = user attacks first
    if Battle.last.gym_leader_attack == true

      Battle.create(
        card_id: current_user.cards.first.id,
        user_attack: true,
        gym_leader_attack: false,
        hp: @gym_leader.cards.first.hp,
        damage: @user.cards.first.attack
      )

      @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
      @gym_leader.cards.first.update(hp: @new_hp_gym_leader)

      if @gym_leader.cards.first.hp < 1
        flash[:notice] = "You won! You have defeated #{@gym_leader.name}'s #{@gym_leader.cards.first.name}!"
        
          @new_win_count = @user.win_count + 1
          @new_battle_count = @user.battle_count + 1
          
          @user.update(win_count: @new_win_count)
          @user.update(battle_count: @new_battle_count)
          
          @new_winrate = (100 * @user.win_count) / @user.battle_count
          @user.update(winrate: @new_winrate)

        redirect_to battle_path(params[:id])
      else
        flash[:notice] = "Direct hit! #{@gym_leader.cards.first.name}'s HP fell to #{@gym_leader.cards.first.hp}
          after #{@user.cards.first.name} used #{@user.cards.first.ability}!"

        redirect_to battle_path(params[:id])
      end

    # if "user_attack: true" = gym_leader attacks first
    elsif Battle.last.user_attack == true

      Battle.create(
        card_id: current_user.cards.first.id,
        user_attack: false,
        gym_leader_attack: true,
        hp: @gym_leader.cards.first.hp,
        damage: @user.cards.first.attack
      )

      @new_hp_player = @user.cards.first.hp - @gym_leader.cards.first.attack
      @user.cards.first.update(hp: @new_hp_player)

      if @user.cards.first.hp < 1
        flash[:notice] = "You lost! You have been defeated by #{@gym_leader.name}'s #{@gym_leader.cards.first.name}!"

        @new_battle_count = @user.battle_count + 1

        @user.update(battle_count: @new_battle_count)
        
        @new_winrate = (100 * @user.win_count) / @user.battle_count
        @user.update(winrate: @new_winrate)

        redirect_to battle_path(params[:id])
      else
          flash[:notice] = "Direct hit! #{@user.cards.first.name}'s' HP fell to #{@user.cards.first.hp}
          after #{@gym_leader.cards.first.name} used #{@gym_leader.cards.first.ability}!"

          redirect_to battle_path(params[:id])
      end
    end
  end

  def gym_leader_attack
  end

  def hello 
  end
end