# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def buy_stable(fiat_amount, options = {})
  @user = options[:user]
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
    end
  end
end

puts 'Creating Stable INC fiat accounts...'

IncFiatAccount.create(bank: "Well Fargo", currency_code: 'USD', amount: 0.0)
IncFiatAccount.create(bank: "BNP Paribas",currency_code: 'EUR', amount: 0.0)
IncFiatAccount.create(bank: "BDO",currency_code: 'PHP', amount: 0.0)
IncFiatAccount.create(bank: "Croatian National Bank", currency_code: 'HRK', amount: 0.0)
IncFiatAccount.create(bank: "HSBC", currency_code: 'HKD', amount: 0.0)
IncFiatAccount.create(bank: "Barclays", currency_code: 'GBP', amount: 0.0)
IncFiatAccount.create(bank: "FirstBank Nigeria", currency_code: 'NGN', amount: 0.0)
IncFiatAccount.create(bank: "Banco Itaú", currency_code: 'BRL', amount: 0.0)
# IncFiatAccount.create(currency_code: 'ZAR', amount: rand(1600000...16000000).to_f)
# IncFiatAccount.create(currency_code: 'CAD', amount: rand(100000...1000000).to_f)
puts "finished. Time to create user accounts"

emails = [['Geraldine','geraldine@toto.fr', "EUR"],
 ['Mike','mike@toto.fr', 'USD'],
  ['Rod','rod@toto.fr', 'PHP'],
  ['Marko','marko@toto.fr', 'HRK'],
  ['Zao','zao@toto.fr', 'HKD'],
  ['Elizabeth','elizabeth@toto.fr', 'GBP'],
  ['Onyeka','onyeka@toto.fr', 'NGN'],
  ['Patricia','patricia@toto.fr', 'BRL']
]
emails.each do |email|
  user = User.new(
      :name                 => "#{email[0]}",
      :email                 => "#{email[1]}",
      :currency_pref         => "#{email[2]}",
      :password              => "123456",
      :password_confirmation => "123456"
  )
  user.save!
  UserStableAccount.create(user: user, amount: 0.0)
end
puts "finished. Now create user fiat and stable accounts:"
users = User.all
UserFiatAccount.create(user: users[0], currency_code: 'EUR', amount: rand(100000...1000000).to_f)
UserFiatAccount.create(user: users[1], currency_code: 'USD', amount: rand(100000...1000000).to_f)
UserFiatAccount.create(user: users[2], currency_code: 'PHP', amount: rand(6000000...60000000).to_f)
UserFiatAccount.create(user: users[3], currency_code: 'HRK', amount: rand(700000...7000000).to_f)
UserFiatAccount.create(user: users[4], currency_code: 'HKD', amount: rand(900000...9000000).to_f)
UserFiatAccount.create(user: users[5], currency_code: 'GBP', amount: rand(90000...1000000).to_f)
UserFiatAccount.create(user: users[6], currency_code: 'NGN', amount: rand(41500000...415000000).to_f)
UserFiatAccount.create(user: users[7], currency_code: 'BRL', amount: rand(400000...4000000).to_f)

puts "finished"
puts "create 1st transaction"
user1 = User.where(email: "geraldine@toto.fr")[0]
user1_fiat_account = UserFiatAccount.where(user: user1)[0]
user1_stable_account = UserStableAccount.where(user: user1)[0]
user1_fiat_account.amount -= 100.0
user1_fiat_account.save
user1_stable_account.amount += 150.0
user1_stable_account.save
inc_fiat_account = IncFiatAccount.all.where(currency_code: "EUR")[0]
inc_fiat_account.amount += 100.0
inc_fiat_account.save
transac = Transaction.new(amount_fiat: 100.0, amount_stable: 100.0, exchange_rate: 1.0, currency_code: "EUR")
transac.inc_fiat_account = inc_fiat_account
transac.user_stable_account = user1_stable_account
transac.user_fiat_account = user1_fiat_account
transac.typetr = "BUY"
transac.save
puts "1st transaction done!"

puts "generating transactions..."
UserFiatAccount.all.each do |account|
  buy_stable(0.1 * account.amount, {currency_code: account.currency_code, user: account.user})
end
puts "finished!"
