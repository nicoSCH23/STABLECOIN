class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  def create
    typetr = transaction_params[:typetr]
    if typetr == "BUY"
      buy_stable(transaction_params[:amount_fiat], options = {currency_code: transaction_params[:currency_code]})
    elsif typetr == "SELL"
      sell_stable(transaction_params[:amount_stable], options = {currency_code: transaction_params[:currency_code]})
    else
      puts "NOT BUY OR SELL"
    end
  end

  def buy_stable(amount_fiat, options = {})
    @user = current_user
    amount_fiat = amount_fiat.to_f
    currency_code = options[:currency_code]
    user_fiat_account = UserFiatAccount.where(user: @user, currency_code: currency_code)[0]
    if (user_fiat_account.amount >= amount_fiat)
      exchange_rate = Transaction.getprice(currency_code)
      amount_stable = (amount_fiat / exchange_rate)
      inc_fiat_account = IncFiatAccount.select{|account| account[:currency_code] == currency_code}[0]
      user_stable_account = UserStableAccount.where(user: @user)[0]
      @tr = Transaction.new(typetr: "BUY", amount_fiat: amount_fiat, amount_stable: amount_stable, exchange_rate: exchange_rate, currency_code: currency_code, inc_fiat_account: inc_fiat_account, user_fiat_account: user_fiat_account, user_stable_account: user_stable_account)
      if @tr.save
        user_fiat_account.update_attribute('amount', user_fiat_account.amount-amount_fiat)
        inc_fiat_account.update_attribute('amount', inc_fiat_account.amount+amount_fiat)
        user_stable_account.update_attribute('amount', user_stable_account.amount+amount_stable)
        redirect_to home_path, notice: 'Transaction was successfully created.'
      else
        redirect_to home_path, notice: 'Transaction failed.'
      end
    end
  end

  def sell_stable(amount_stable, options = {})
    @user = current_user
    amount_stable = amount_stable.to_f
    currency_code = options[:currency_code]
    user_stable_account = UserStableAccount.where(user: @user)[0]
    if (user_stable_account.amount >= amount_stable)
      exchange_rate = Transaction.getprice(currency_code)
      amount_fiat = (amount_stable * exchange_rate)
      inc_fiat_account = IncFiatAccount.select{|account| account[:currency_code] == currency_code}[0]
      user_fiat_account = (UserFiatAccount.where(user: @user, currency_code: currency_code).empty? ? UserFiatAccount.create(user: @user, currency_code: currency_code, amount: 0) : (UserFiatAccount.where(user: @user)[0]))
      @tr = Transaction.new(typetr: "SELL", amount_fiat: amount_fiat, amount_stable: amount_stable, exchange_rate: exchange_rate, currency_code: currency_code, inc_fiat_account: inc_fiat_account, user_fiat_account: user_fiat_account, user_stable_account: user_stable_account)
      if @tr.save
        user_fiat_account.update_attribute('amount', user_fiat_account.amount+amount_fiat)
        inc_fiat_account.update_attribute('amount', inc_fiat_account.amount-amount_fiat)
        user_stable_account.update_attribute('amount', user_stable_account.amount-amount_stable)
        redirect_to home_path, notice: 'Transaction was successfully created.'
      else
        redirect_to home_path, notice: 'Transaction failed.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.fetch(:transaction, {})
    end
end
