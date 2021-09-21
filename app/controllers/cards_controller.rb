class CardsController < ApplicationController
  def index
    @cards = Card.all
    @users = User.all
  end

  def show
    @card = Card.find(params[:id])
  end
end
