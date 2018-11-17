class IncFiatAccountsController < ApplicationController
  before_action :set_inc_fiat_account, only: [:show, :edit, :update, :destroy]

  # GET /inc_fiat_accounts
  # GET /inc_fiat_accounts.json
  def index
    @inc_fiat_accounts = IncFiatAccount.all
  end

  # GET /inc_fiat_accounts/1
  # GET /inc_fiat_accounts/1.json
  def show
  end

  # GET /inc_fiat_accounts/new
  def new
    @inc_fiat_account = IncFiatAccount.new
  end

  # GET /inc_fiat_accounts/1/edit
  def edit
  end

  # POST /inc_fiat_accounts
  # POST /inc_fiat_accounts.json
  def create
    @inc_fiat_account = IncFiatAccount.new(inc_fiat_account_params)

    respond_to do |format|
      if @inc_fiat_account.save
        format.html { redirect_to @inc_fiat_account, notice: 'Inc fiat account was successfully created.' }
        format.json { render :show, status: :created, location: @inc_fiat_account }
      else
        format.html { render :new }
        format.json { render json: @inc_fiat_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inc_fiat_accounts/1
  # PATCH/PUT /inc_fiat_accounts/1.json
  def update
    respond_to do |format|
      if @inc_fiat_account.update(inc_fiat_account_params)
        format.html { redirect_to @inc_fiat_account, notice: 'Inc fiat account was successfully updated.' }
        format.json { render :show, status: :ok, location: @inc_fiat_account }
      else
        format.html { render :edit }
        format.json { render json: @inc_fiat_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inc_fiat_accounts/1
  # DELETE /inc_fiat_accounts/1.json
  def destroy
    @inc_fiat_account.destroy
    respond_to do |format|
      format.html { redirect_to inc_fiat_accounts_url, notice: 'Inc fiat account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inc_fiat_account
      @inc_fiat_account = IncFiatAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inc_fiat_account_params
      params.fetch(:inc_fiat_account, {})
    end
end
