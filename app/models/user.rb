class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  validates :email, :username, uniqueness: true
  validates :name, :lastname, :username, length: {maximum: 30}, presence: true

  has_many :offers, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :draft_reservations, dependent: :destroy
end
