class CreateJoinTableBattleUser < ActiveRecord::Migration[6.1]
  def change
    create_join_table :battles, :users do |t|
    end
  end
end
