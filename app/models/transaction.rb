class Transaction < ApplicationRecord
  belongs_to :user_fiat_account
  belongs_to :user_stable_account
  belongs_to :inc_fiat_account
  validates :typetr, presence: true, allow_blank: false, inclusion: { in: %w(BUY SELL),
      message: "%{value} is not a valid option" }
  validates :amount_fiat, presence: true, allow_blank: false
  validates :amount_stable, presence: true, allow_blank: false
  validates :exchange_rate, presence: true, allow_blank: false
  validates :currency_code, presence: true, allow_blank: false
  validates :inc_fiat_account_id, presence: true, allow_blank: false
  validates :user_fiat_account_id, presence: true, allow_blank: false
  validates :user_stable_account_id, presence: true, allow_blank: false

  def self.getprice(currency_code)
    url = 'https://api.exchangeratesapi.io/latest'
    exchange_serialized = open(url).read
    exchange_rates = JSON.parse(exchange_serialized)

    fiat_accounts = IncFiatAccount.all
    value = 0.0
    fiat_accounts.each do |fiat_account|
    if (fiat_account.currency_code == currency_code)
      account_value = fiat_account.amount
    elsif (fiat_account.currency_code == "EUR")
      account_value = fiat_account.amount * exchange_rates["rates"][currency_code]
    elsif (currency_code == "EUR")
      account_value = (fiat_account.amount / exchange_rates["rates"][fiat_account.currency_code])
    else
      begin
      puts "for currency: #{fiat_account.currency_code}"
      account_value = (fiat_account.amount / exchange_rates["rates"][fiat_account.currency_code]) * exchange_rates["rates"][currency_code]
      puts "account value=#{account_value}"
      rescue
        puts "I AM BEING RESCUED"
        retry
      end
    end
      value += account_value
    end
    return (value / UserStableAccount.all.sum(:amount))
    # GetStablePricesService.new(current_user, currency_code).call
    # current_user.update(should_recalc: false)
    # redirect_to results_path
  end
end
