class HomeController < ApplicationController
  def index
    @users = User.all
    @gym_leader = GymLeader.all
  end

  def battle
    @gym_leader = GymLeader.find(params[:id])
  end

  def user_attack
    @user = current_user
    @gym_leader = GymLeader.find(params[:id])
    
    # STEP 1 - check who will attack first
    if Battle.last.gym_leader_attack == true

      # STEP 2 - document who attacked and who will attack next 
      Battle.create(
        card_id: current_user.cards.first.id,
        user_attack: true,
        gym_leader_attack: false,
        hp: @gym_leader.cards.first.hp,
        damage: @user.cards.first.attack
      )

      # STEP 3 - minus hp with attack then update
      @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.first.attack
      @gym_leader.cards.first.update(hp: @new_hp_gym_leader)

      # STEP 4 - declare winner
      if @gym_leader.cards.first.hp < 1
        # STEP 4.1a - flash win message
        flash[:notice] = "You won! You have defeated #{@gym_leader.name}'s #{@gym_leader.cards.first.name}!"
        
        # STEP 4.1b - aquire gym leaders's card if player wins
        @user.cards.create(
          user_id: @user.id,
          name: @gym_leader.cards.first.name,
          pokemon_type: @gym_leader.cards.first.pokemon_type,
          ability: @gym_leader.cards.first.ability,
          hp: @gym_leader.cards.first.initial_hp,
          initial_hp: @gym_leader.cards.first.initial_hp,
          attack: @gym_leader.cards.first.attack,
          img_url: @gym_leader.cards.first.img_url
        )

        # STEP 4.1c - adjust winrate
        @new_win_count = @user.win_count + 1
        @new_battle_count = @user.battle_count + 1
        
        @user.update(win_count: @new_win_count)
        @user.update(battle_count: @new_battle_count)
        
        @new_winrate = (100 * @user.win_count) / @user.battle_count
        @user.update(winrate: @new_winrate)

        # STEP 4.1d - redirect to same page
        redirect_to battle_path(params[:id])
      else
        # STEP 4.2a - flash battle update
        flash[:notice] = "Direct hit! #{@gym_leader.cards.first.name}'s HP fell to #{@gym_leader.cards.first.hp}
          after #{@user.cards.first.name} used #{@user.cards.first.ability[0]}!"

        # STEP 4.2b - redirect to same page
        redirect_to battle_path(params[:id])
      end

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
          after #{@gym_leader.cards.first.name} used #{@gym_leader.cards.first.ability[0]}!"

          redirect_to battle_path(params[:id])
      end
    end
  end

  def heal
    @user = current_user
    @gym_leader = GymLeader.find(params[:id])
    
    @user.cards.first.update(hp: @user.cards.first.initial_hp)
    @gym_leader.cards.first.update(hp: @gym_leader.cards.first.initial_hp)

    redirect_to battle_path(params[:id])
  end

  def hello 
  end
end