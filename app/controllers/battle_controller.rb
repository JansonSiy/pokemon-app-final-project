class BattleController < ApplicationController
    def index
        @gym_leader = GymLeader.find(params[:id])
    end
end
