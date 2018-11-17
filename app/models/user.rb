class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :transactions, through: :user_fiat_accounts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
