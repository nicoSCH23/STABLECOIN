class UserFiatAccount < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :currency_code, inclusion: { in: %w(EUR USD PHP HRK HKD GBP NGN BRL EUR),
      message: "Tu te crois malin?" }
end
