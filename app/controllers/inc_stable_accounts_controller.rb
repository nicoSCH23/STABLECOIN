class IncStableAccountsController < ApplicationController
  before_action :set_inc_stable_account, only: [:show, :edit, :update, :destroy]

  # GET /inc_stable_accounts
  # GET /inc_stable_accounts.json
  def index
    @inc_stable_accounts = IncStableAccount.all
  end

  # GET /inc_stable_accounts/1
  # GET /inc_stable_accounts/1.json
  def show
  end

  # GET /inc_stable_accounts/new
  def new
    @inc_stable_account = IncStableAccount.new
  end

  # GET /inc_stable_accounts/1/edit
  def edit
  end

  # POST /inc_stable_accounts
  # POST /inc_stable_accounts.json
  def create
    @inc_stable_account = IncStableAccount.new(inc_stable_account_params)

    respond_to do |format|
      if @inc_stable_account.save
        format.html { redirect_to @inc_stable_account, notice: 'Inc stable account was successfully created.' }
        format.json { render :show, status: :created, location: @inc_stable_account }
      else
        format.html { render :new }
        format.json { render json: @inc_stable_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inc_stable_accounts/1
  # PATCH/PUT /inc_stable_accounts/1.json
  def update
    respond_to do |format|
      if @inc_stable_account.update(inc_stable_account_params)
        format.html { redirect_to @inc_stable_account, notice: 'Inc stable account was successfully updated.' }
        format.json { render :show, status: :ok, location: @inc_stable_account }
      else
        format.html { render :edit }
        format.json { render json: @inc_stable_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inc_stable_accounts/1
  # DELETE /inc_stable_accounts/1.json
  def destroy
    @inc_stable_account.destroy
    respond_to do |format|
      format.html { redirect_to inc_stable_accounts_url, notice: 'Inc stable account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inc_stable_account
      @inc_stable_account = IncStableAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inc_stable_account_params
      params.fetch(:inc_stable_account, {})
    end
end
