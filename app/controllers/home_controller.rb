class HomeController < ApplicationController
  # before_action :authenticate_user!
  
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
        # card_id: current_user.cards.order(updated_at: :asc).last.id,
        user_attack: true,
        gym_leader_attack: false,
        # hp: @gym_leader.cards.first.hp,
        # damage: @user.cards.order(updated_at: :asc).last.attack
      )

      copy_card = Card.find_by(name: @gym_leader.cards.first.name)


    
      # STEP 3 - minus hp with attack then update
      @new_hp_gym_leader = @gym_leader.cards.first.hp - @user.cards.order(updated_at: :asc).last.attack
      @gym_leader.cards.first.update(hp: @new_hp_gym_leader)
    
      # STEP 4 - declare winner
      if @gym_leader.cards.first.hp < 1
        
        # STEP 4.1a - aquire gym leaders's card if player wins
        @user.cards.create(
          user_id: @user.id, 
          name: copy_card.name, 
          pokemon_type: copy_card.pokemon_type, 
          ability: copy_card.ability,
          hp: copy_card.hp,
          initial_hp: copy_card.initial_hp,
          attack: copy_card.attack, 
          img_url: copy_card.img_url,
          move: copy_card.move,
          updated_at: 10.minutes.ago,
        )
    
        # STEP 4.1b - adjust winrate
        @new_win_count = @user.win_count + 1
        @new_battle_count = @user.battle_count + 1
        
        @user.update(win_count: @new_win_count)
        @user.update(battle_count: @new_battle_count)
        
        @new_winrate = (100 * @user.win_count) / @user.battle_count
        @user.update(winrate: @new_winrate)
    
        # STEP 4.1c - flash win message
        flash[:notice] = "You won! You have defeated #{@gym_leader.name}'s #{@gym_leader.cards.first.name}!<br>Your pokemon #{@user.cards.order(updated_at: :asc).last.name} is getting stronger!"

        # STEP 4.1d - redirect to same page
        redirect_to battle_path(params[:id])
      else
        # STEP 4.2a - flash battle update
        flash[:notice] = "Direct hit! #{@gym_leader.cards.first.name}'s HP fell to #{@gym_leader.cards.first.hp}
          after #{@user.cards.order(updated_at: :asc).last.name} used #{@user.cards.order(updated_at: :asc).last.ability[0]}!"
    
        # STEP 4.2b - redirect to same page
        redirect_to battle_path(params[:id])
      end
    
    elsif Battle.last.user_attack == true
    
      Battle.create(
        # card_id: current_user.cards.order(updated_at: :asc).last.id,
        user_attack: false,
        gym_leader_attack: true,
        # hp: @gym_leader.cards.first.hp,
        # damage: @user.cards.order(updated_at: :asc).last.attack,
      )
    
      @new_hp_player = @user.cards.order(updated_at: :asc).last.hp - @gym_leader.cards.first.attack
      @user.cards.order(updated_at: :asc).last.update(hp: @new_hp_player)
    
      if @user.cards.order(updated_at: :asc).last.hp < 1
        
        @new_battle_count = @user.battle_count + 1
    
        @user.update(battle_count: @new_battle_count)
        
        @new_winrate = (100 * @user.win_count) / @user.battle_count
        @user.update(winrate: @new_winrate)
    
        flash[:notice] = "You lost! You have been defeated by #{@gym_leader.name}'s #{@gym_leader.cards.first.name}!"

        redirect_to battle_path(params[:id])
      else
          flash[:notice] = "Direct hit! #{@user.cards.order(updated_at: :asc).last.name}'s' HP fell to #{@user.cards.order(updated_at: :asc).last.hp}
          after #{@gym_leader.cards.first.name} used #{@gym_leader.cards.first.ability[0]}!"
    
          redirect_to battle_path(params[:id])
      end
    end
  end
      
  def heal
    @user = current_user
    @gym_leader = GymLeader.find(params[:id])

    new_hp =  @user.cards.order(updated_at: :asc).last.initial_hp + 10
    new_attack = @user.cards.order(updated_at: :asc).last.attack + 10

    @user.cards.order(updated_at: :asc).last.update(hp: new_hp, initial_hp: new_hp, attack: new_attack)

    @gym_leader.cards.first.update(hp: @gym_leader.cards.first.initial_hp)
    
    redirect_to battle_path(params[:id])
  end

  def hello 
  end
end