class GymLeader < ApplicationRecord
    has_and_belongs_to_many :cards
    has_and_belongs_to_many :battles
end
