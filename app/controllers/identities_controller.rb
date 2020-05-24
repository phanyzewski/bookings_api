class IdentitiesController < ApplicationController
  before_action :set_identity, only: [:show, :update, :destroy]

  # GET /identities
  def index
    jsonapi_paginate(Identity.all) do |paginated|
      render jsonapi: paginated
    end
  end

  # GET /identities/1
  def show
    render jsonapi: @identity
  end

  # POST /identities
  def create
    @identity = Identity.new(
      account_id: identity_params.fetch('account_id') { Account.create!.id },
      first_name: identity_params['first_name'],
      last_name: identity_params['last_name'],
      )

    if @identity.save
      if email_params.dig(:email_address, :email).present?
        EmailAddress.create!(
          identity_id: @identity.id,
          email: email_params.dig(:email_address, :email),
          preferred: email_params.dig(:email_address, :preferred)
        )
      end

      if telephone_params.dig(:telephone, :phone_number).present?
        Telephone.create!(
          identity_id: @identity.id,
          phone_number: telephone_params.dig(:telephone, :phone_number),
          preferred: telephone_params.dig(:telephone, :preferred),
          phone_type: telephone_params.dig(:telephone, :phone_type),
          allow_sms: telephone_params.dig(:telephone, :allow_sms),
        )
      end

      render jsonapi: @identity, status: :created, location: @identity
    else
      render jsonapi_errors: @identity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /identities/1
  def update
    if @identity.update(identity_params)

      if email_params.dig(:email_address, :email).present?
        EmailAddress.create!(
          identity_id: @identity.id,
          email: email_params.dig(:email_address, :email),
          preferred: email_params.dig(:email_address, :preferred)
        )
      end

      if telephone_params.dig(:telephone, :phone_number).present?
        Telephone.create!(
          identity_id: @identity.id,
          phone_number: telephone_params.dig(:telephone, :phone_number),
          preferred: telephone_params.dig(:telephone, :preferred),
          phone_type: telephone_params.dig(:telephone, :phone_type),
          allow_sms: telephone_params.dig(:telephone, :allow_sms),
        )
      end

      render jsonapi: @identity
    else
      render jsonapi_errors: @identity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /identities/1
  def destroy
    @identity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_identity
      @identity = Identity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def identity_params
      params.require(:identity).permit(
        :first_name, :last_name, :account_id,
        )
    end

    def email_params
      params.permit(
        email_address: %i[email preferred]
        )
    end

    def telephone_params
      params.permit(
        telephone: %i[phone_number preferred phone_type allow_sms]
        )
    end
end
