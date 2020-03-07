class CoinMailer < ApplicationMailer

  def low_coin_notification
    @greeting = "Hi"

    mail to: ENV['EMAIL_ADDRESS']
  end
  
  def low_coin_notification(coin)
    @coin = coin
    @admins = User.where(admin: true).pluck(:email)
    @email_address = @admins.map(&:inspect).join(',')
    mail to: @email_address  , subject: "Coins are running low!"
  end
end
