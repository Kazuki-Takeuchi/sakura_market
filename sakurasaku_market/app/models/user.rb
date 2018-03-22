class User < ApplicationRecord
  has_one :shopping_cart, dependent: :destroy
  has_many :shopping_histories, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  enum admin_type: { administrator: 1, user: 2 }
end
