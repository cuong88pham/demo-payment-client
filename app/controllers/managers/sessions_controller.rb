# frozen_string_literal: true

class Managers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # respond_to :html

  # GET /resource/sign_in
  # def new
  #   super
  #   byebug
  # end

  private
    # def respond_with(resource, _opts = {})
    #   # render :new
    # end
  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
