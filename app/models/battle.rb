class Battle < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :gym_leaders
end
