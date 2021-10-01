class CardsController < ApplicationController
  # before_action :set_card, only: %i[select_card]
  # before_action :card_params, only: %i[select_card]
  # include CardsHelper
  
  def index
    @users = User.all
    @gym_leader = GymLeader.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def deck
    @user = current_user.id
    @cards = current_user.cards.order(updated_at: :asc)
  end

  def pokedex
    # require 'httparty'
    @cards = Card.all
  end
  
  def select_card
    @card = Card.find(params[:id])
    @card.update(updated_at:Time.current)
    redirect_to root_path, notice: "card succesfully update!"
  end

end
