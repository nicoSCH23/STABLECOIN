class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @transaction = Transaction.new
    @user_fiat_account = UserFiatAccount.new
  end
end
