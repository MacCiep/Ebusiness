class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  validates :email, :username, uniqueness: true
  validates :name, :lastname, :username, length: {maximum: 30}, presence: true
  before_validation :create_on_stripe, on: :create

  has_one :credit_card_data
  has_many :offers, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :draft_reservations, dependent: :destroy

  enum user_type: {
    user: 0,
    admin: 1
  }

  private

  def create_on_stripe
    params = { email: email, name: 'John' }
    response = Stripe::Customer.create(params)
    self.stripe_id = response.id
  end
end
