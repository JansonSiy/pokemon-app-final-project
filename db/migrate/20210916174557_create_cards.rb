class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :name
      t.string :pokemon_type,       array: true, default: []    
      t.string :ability,            array: true, default: [] 
      t.string :move ,              array: true, default: []         
      t.integer :hp
      t.integer :attack
      t.string :img_url

      t.timestamps
    end
  end
end
