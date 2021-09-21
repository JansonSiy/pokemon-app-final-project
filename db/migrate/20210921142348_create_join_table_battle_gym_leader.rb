class CreateJoinTableBattleGymLeader < ActiveRecord::Migration[6.1]
  def change
    create_join_table :battles, :gym_leaders do |t|
    end
  end
end
