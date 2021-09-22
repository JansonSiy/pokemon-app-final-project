class CreateBattles < ActiveRecord::Migration[6.1]
  def change
    create_table :battles do |t|
      t.integer :card_id
      t.boolean :user_attack
      t.boolean :gym_leader_attack
      t.integer :hp
      t.integer :damage

      t.timestamps
    end
  end
end
