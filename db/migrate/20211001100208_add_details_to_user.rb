class AddDetailsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :win_count, :integer
    add_column :users, :battle_count, :integer
  end
end
