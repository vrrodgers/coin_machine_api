# Preview all emails at http://localhost:3000/rails/mailers/coin_mailer
class CoinMailerPreview < ActionMailer::Preview
  def new_coin_email
    
    coin = Coin.new(name: "penny",  value: 2)

    CoinMailer.with(coin: coin).new_coin_email
  end
end
