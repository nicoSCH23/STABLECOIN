class UserFiatAccount < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validate :account_limits
  validates :currency_code, inclusion: { in: %w(EUR USD PHP HRK HKD GBP RUB BRL EUR),
      message: "Tu te crois malin?" }

    def account_limits
      !UserFiatAccount.where(user: self.user).any?{|e| e.currency_code == self.currency_code}
    end
end
