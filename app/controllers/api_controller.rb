class ApiController < ActionController::API
  include Jsonable
  respond_to :json
  before_action :decode_page
  def self.assign_params(*permitted_params)
    define_method :resource_params do
      return {} if request.get?
      resource_name = defined?(resource_request_name) ? resource_request_name : controller_name.singularize
      if action_name === 'update'
        [params.require(resource_name).permit(permitted_params)]
      elsif action_name === 'create'
        params.require(resource_name).permit(permitted_params)
      end
    end
  end
  
  def render_resource(resource)
    if resource.present? && resource.errors.empty? 
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
          detail: resource&.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def decode_page
    if params[:page].present?
      begin
        @page = JsonWebToken.decode(params[:page]) if params[:page].present?
      rescue
        render json: {error: 'Your token is expired'}, adapter: :json, status: 403
      end
    end
  end
end
