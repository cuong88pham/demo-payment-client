class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  respond_to :html, :json

  # def create
  #   build_resource(sign_up_params)
  #   resource.save
  #   render_resource(resource)
  # end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation]) 
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys:[:username, :email, :password, :password_confirmation])
  end
  private
    def render_resource(resource)
      if resource.errors.empty?
        render json: resource
      else
        validation_error(resource)
      end
    end

    def validation_error(resource)
      render json: {
        errors: [
          {
            status: '400',
            title: 'Bad Request',
            detail: resource.errors,
            code: '100'
          }
        ]
      }, status: :bad_request
    end
end