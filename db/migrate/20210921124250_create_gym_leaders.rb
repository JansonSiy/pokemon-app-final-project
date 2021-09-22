class CreateGymLeaders < ActiveRecord::Migration[6.1]
  def change
    create_table :gym_leaders do |t|
      t.string :name
      t.string :avatar

      t.timestamps
    end
  end
end
