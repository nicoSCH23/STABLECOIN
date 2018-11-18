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

  # POST /transactions
  # POST /transactions.json
  def create
    typetr = transaction_params[:typetr]
    buy_stable(transaction_params[:amount_fiat], options = {currency_code: transaction_params[:currency_code]}) if typetr == "BUY"
    # respond_to do |format|
    #   if @transaction.save
    #     format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
    #     format.json { render :show, status: :created, location: @transaction }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @transaction.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # def convert_account_in(account, currency_code)
  #   if (account.currency_code == currency_code)
  #     return account.amount
  #   else
  #     return Concurrency.convert(account.amount, account.currency_code, currency_code)
  #   end
  # end

  # def sum_stables
  #   UserStableAccount.all.sum(:amount)
  # end

  # def getprice(currency_code)
  #   fiat_accounts = IncFiatAccount.all
  #   value = 0.0
  #   fiat_accounts.each do |fiat_account|
  #     value += convert_account_in(fiat_account, currency_code)
  #   end
  #   all = sum_stables
  #   return (value / sum_stables)
  #   # GetStablePricesService.new(current_user, currency_code).call
  #   # current_user.update(should_recalc: false)
  #   # redirect_to results_path
  # end

  def buy_stable(fiat_amount, options = {})
    binding.pry
    @user = current_user
    fiat_amount = fiat_amount.to_f
    currency_code = options[:currency_code]
    user_fiat_account = UserFiatAccount.where(user: @user, currency_code: currency_code)[0]
    if (user_fiat_account.amount >= fiat_amount)
      exchange_rate = Transaction.getprice(currency_code)
      amount_stable = (fiat_amount / exchange_rate)
      inc_fiat_account = IncFiatAccount.select{|account| account[:currency_code] == currency_code}[0]
      user_stable_account = UserStableAccount.where(user: @user)[0]
      @tr = Transaction.new(typetr: "BUY", amount_fiat: fiat_amount, amount_stable: amount_stable, exchange_rate: exchange_rate, currency_code: currency_code, inc_fiat_account: inc_fiat_account, user_fiat_account: user_fiat_account, user_stable_account: user_stable_account)
      if @tr.save
        user_fiat_account.update_attribute('amount', user_fiat_account.amount-fiat_amount)
        inc_fiat_account.update_attribute('amount', inc_fiat_account.amount+fiat_amount)
        user_stable_account.update_attribute('amount', user_stable_account.amount+amount_stable)
        redirect_to home_path, notice: 'Transaction was successfully created.'
      else
        redirect_to home_path, notice: 'Transaction failed.'
      end
    end
  end

  def sell_stable(currency_code, stable_amount)
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
