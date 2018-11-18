class UserFiatAccountsController < ApplicationController
  before_action :set_user_fiat_account, only: [:show, :edit, :update, :destroy]

  # GET /user_fiat_accounts
  # GET /user_fiat_accounts.json
  def index
    @user_fiat_accounts = UserFiatAccount.all
  end

  # GET /user_fiat_accounts/1
  # GET /user_fiat_accounts/1.json
  def show
  end

  # GET /user_fiat_accounts/new
  def new
    @user_fiat_account = UserFiatAccount.new
  end

  # GET /user_fiat_accounts/1/edit
  def edit
  end

  # POST /user_fiat_accounts
  # POST /user_fiat_accounts.json
  def create
    @user_fiat_account = UserFiatAccount.new
    @user_fiat_account.currency_code = user_fiat_account_params[:currency_code]
    @user_fiat_account.amount = user_fiat_account_params[:amount].to_f
    @user_fiat_account.user = current_user

    respond_to do |format|
      if @user_fiat_account.save
        UserStableAccount.create(user: current_user, amount: 0.0) if UserStableAccount.where(user: current_user).empty?
        format.html { redirect_to home_path, notice: 'User fiat account was successfully created.' }
        format.json { render :show, status: :created, location: @user_fiat_account }
      else
        format.html { render :new }
        format.json { render json: @user_fiat_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_fiat_accounts/1
  # PATCH/PUT /user_fiat_accounts/1.json
  def update
    respond_to do |format|
      if @user_fiat_account.update(user_fiat_account_params)
        format.html { redirect_to @user_fiat_account, notice: 'User fiat account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_fiat_account }
      else
        format.html { render :edit }
        format.json { render json: @user_fiat_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_fiat_accounts/1
  # DELETE /user_fiat_accounts/1.json
  def destroy
    @user_fiat_account.destroy
    respond_to do |format|
      format.html { redirect_to user_fiat_accounts_url, notice: 'User fiat account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_fiat_account
      @user_fiat_account = UserFiatAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_fiat_account_params
      params.fetch(:user_fiat_account, {})
    end
end
