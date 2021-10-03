class AddInthpToCard < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :initial_hp, :integer
  end
end
