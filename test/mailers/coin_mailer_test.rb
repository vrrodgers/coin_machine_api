require 'test_helper'

class CoinMailerTest < ActionMailer::TestCase
  test "low_coin_notification" do
    mail = CoinMailer.low_coin_notification
    assert_equal "Low coin notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
