class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :destroy]

  # GET /accounts
  def index
    render jsonapi: Account.all
  end

# GET /accounts/search
  def search
    response = []
    response << Account.find_by_vin(params[:vin]) if search_params.dig(:vin)
    response << Account.find_by_email_address(params[:email_address]) if search_params.dig(:email_address)
    response << Account.find_by_phone_number(params[:phone_number]) if search_params.dig(:phone_number)
    response << Account.find_by_name(params[:last_name], params[:first_name]) if search_params.dig(:last_name)

    render jsonapi: response.flatten.uniq
  end

  # GET /accounts/1
  def show
    render jsonapi: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render jsonapi: @account, status: :created, location: @account
    else
      render jsonapi_errors: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.fetch(:account, {})
    end

    def search_params
      params.permit(:vin, :email_address, :phone_number, :last_name, :first_name)
    end
end
