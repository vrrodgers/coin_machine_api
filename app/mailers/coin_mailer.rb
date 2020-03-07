class CoinMailer < ApplicationMailer
  def new_coin_email
    @coin = Coin.first 
    @admins = User.where(admin: true).pluck(:email)
    @email_address = @admins.map(&:inspect).join(',')
    mail(to: @email_address  , subject: "Coins are running low!")
  end
end
