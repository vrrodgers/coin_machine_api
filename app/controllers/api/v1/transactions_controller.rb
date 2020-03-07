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
             CoinMailer.low_coin_notification(@coin).deliver
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
