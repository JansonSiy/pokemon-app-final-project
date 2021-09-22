class User < ApplicationRecord
  has_and_belongs_to_many :cards
  has_and_belongs_to_many :battles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end