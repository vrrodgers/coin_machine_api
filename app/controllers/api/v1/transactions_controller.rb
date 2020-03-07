class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]
  


  def index
    @transactions = Transaction.all
    render json: @transactions
  end

 
  def show
    render json: @transaction
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @coin = Coin.find_by_name( @transaction['coin_name'])
    @user = User.find_by(access_token: @transaction['user_access_token'])
    @transaction_type = @transaction['transaction_type']
  
    if @coin.present? && @user.present?
      if @coin.value == 0 && @transaction_type == "withdrawal" 
        render plain: {error: "There are no more " + @coin.name.pluralize +   " to withdraw."}.to_json, status: 422, content_type: 'application/json'
      else
        if @transaction.save
          if @transaction_type == "deposit"
            @coin.increment!(:value, 1)
          else
            @coin.decrement!(:value, 1)
            if @coin.value < 4 
              @string = "
                Your running low on " + @coin.name.pluralize+ ". There is only " + @coin.value.to_s + " left in the machine. 
                "
              @admins = User.where(admin: true).where.not(slack_url: nil).pluck(:slack_url)
              @admins.each do |slack_url|
                notifier = Slack::Notifier.new slack_url
                @message = @string
                a_ok_note = {
                  fallback: "We need more coins",
                  text: Slack::Notifier::Util::LinkFormatter.format(@message),
                  color: "#4e2a84",
                  mrkdwn: true
                }
                notifier.ping text: "Hello ", attachments: [a_ok_note]
              end
            end
          end
          render json: @transaction, status: :created, location: api_v1_transaction_url(@transaction)
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end
    else
      render plain: {error: "The coin name/token is invalid."}.to_json, status: 422, content_type: 'application/json'
    end
  end


  private
  
    def set_transaction
      @transaction = Transaction.where(user_token: params[:id])
    end

    def transaction_params
      params.permit(:coin_name, 
                    :user_access_token,
                    :transaction_type
                    )
    end
end
