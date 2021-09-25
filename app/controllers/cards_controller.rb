class CardsController < ApplicationController
  def index
    @cards = Card.all
    @users = User.all
    @gym_leader = GymLeader.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def deck
    @user = current_user.id
    @cards = current_user.cards.all
  end
end
