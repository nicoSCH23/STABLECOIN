class UserStableAccountsController < ApplicationController
  before_action :set_user_stable_account, only: [:show, :edit, :update, :destroy]

  # GET /user_stable_accounts
  # GET /user_stable_accounts.json
  def index
    @user_stable_accounts = UserStableAccount.all
  end

  # GET /user_stable_accounts/1
  # GET /user_stable_accounts/1.json
  def show
  end

  # GET /user_stable_accounts/new
  def new
    @user_stable_account = UserStableAccount.new
  end

  # GET /user_stable_accounts/1/edit
  def edit
  end

  # POST /user_stable_accounts
  # POST /user_stable_accounts.json
  def create
    @user_stable_account = UserStableAccount.new(user_stable_account_params)

    respond_to do |format|
      if @user_stable_account.save
        format.html { redirect_to @user_stable_account, notice: 'User stable account was successfully created.' }
        format.json { render :show, status: :created, location: @user_stable_account }
      else
        format.html { render :new }
        format.json { render json: @user_stable_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stable_accounts/1
  # PATCH/PUT /user_stable_accounts/1.json
  def update
    respond_to do |format|
      if @user_stable_account.update(user_stable_account_params)
        format.html { redirect_to @user_stable_account, notice: 'User stable account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_stable_account }
      else
        format.html { render :edit }
        format.json { render json: @user_stable_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stable_accounts/1
  # DELETE /user_stable_accounts/1.json
  def destroy
    @user_stable_account.destroy
    respond_to do |format|
      format.html { redirect_to user_stable_accounts_url, notice: 'User stable account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stable_account
      @user_stable_account = UserStableAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_stable_account_params
      params.fetch(:user_stable_account, {})
    end
end
