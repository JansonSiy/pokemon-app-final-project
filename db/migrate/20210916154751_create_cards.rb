class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.string :ability
      t.integer :hp
      t.integer :attack
      t.string :img_url

      t.timestamps
    end
  end
end
