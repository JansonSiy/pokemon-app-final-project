class CreateJoinTableCardGymLeader < ActiveRecord::Migration[6.1]
  def change
    create_join_table :cards, :gym_leaders do |t|
    end
  end
end
