class Api::V1::CoinsController < ApplicationController
  before_action :set_coin, only: [:show, :update, :destroy]

  def index
    @coins = Coin.all
    render json: @coins
  end

  def show
    render json: @coin
  end

  def create
    @coin = Coin.new(coin_params)
    @user = User.find_by(access_token: @coin['access_token'])
    if @user.present? && @user.admin == true
      if @coin.save
        render json: @coin, status: :created, location: api_v1_coin_url(@coin)
      else
        render json: @coin.errors, status: :unprocessable_entity
      end
    else
      render plain: {error: "You don't have permission to create coins. Either your Access Token is invalid or you are not a admin user."}.to_json, status: 422, content_type: 'application/json'
    end
  end

  def update
    if @coin.update(coin_params)
      @user = User.find_by(access_token: @coin['access_token'])
      if @user.present? && @user.admin == true
        render json: @coin, status: :ok, location: api_v1_coin_url(@coin)
      else
        render json: @coin.errors, status: :unprocessable_entity
      end
    else
      render plain: {error: "You don't have permission to update coins. Either your Access Token is invalid or you are not a admin user."}.to_json, status: 422, content_type: 'application/json'
    end
  end

  def destroy
    @coin.destroy
    render plain: {success: "Your coin was successfully deleted."}.to_json, status: 422, content_type: 'application/json'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coin
      @coin = Coin.find_by slug: params[:slug]
    end

    # Only allow a list of trusted parameters through.
    def coin_params
      params.permit(:name, :value, :access_token)
    end
end