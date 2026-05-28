class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  enum :role, { owner: 0, vet: 1, admin: 2 }

  has_one :owner
  has_one :vet

  validates :first_name, presence: true
  validates :last_name, presence: true
end