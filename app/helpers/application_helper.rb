module ApplicationHelper
  def number_to_currency_br(number)
    number_to_currency(number, :unit => "", :separator => ",", :delimiter => ".")
  end

  def number_to_currency_net(number)
    number_to_currency(number,precision: 0, :unit => "", :separator => ",", :delimiter => ".")
  end
end
