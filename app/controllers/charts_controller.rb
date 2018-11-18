class ChartsController < ApplicationController
  def new_transactions
    render json: Transaction.group_by_minute(:created_at).count
  end

  def cur_transactions
    # render json: IncFiatAccount.group(:amount).count
    # render json: Transaction.group(:currency_code).count
    accounts = IncFiatAccount.all
    accounts_eur_sum = accounts.inject(0){|sum,account| sum + Concurrency.convert(account.amount, account.currency_code, "EUR") }
    results = {}
    accounts.each do |account|
      results[account.currency_code.to_sym] = (Concurrency.convert(account.amount, account.currency_code, "EUR") / accounts_eur_sum * 100).round(2)
    end
    render json: results
  end
end
