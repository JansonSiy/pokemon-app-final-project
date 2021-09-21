class CreateJoinTableCardUser < ActiveRecord::Migration[6.1]
  def change
    create_join_table :cards, :users do |t|
    end
  end
end
