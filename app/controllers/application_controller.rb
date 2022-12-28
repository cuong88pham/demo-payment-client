class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
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

  # Set before filter to set updated_by into params of request
  def self.assign_updated_by(params_key, actions = [:update], options = {})
    self.register_saved_by(:updated_by, params_key, actions, options = {})
  end

  # Set before filter to set created_by into params of request
  def self.assign_created_by(params_key, actions = [:create], options = {})
    self.register_saved_by(:created_by, params_key, actions, options = {})
  end

  # Set before filter to set saved_by into params of request
  def self.register_saved_by(column_name, params_key, actions, options)
   if params_key
     saved_by_params = "params[:#{params_key}][:#{column_name}]"
   else
     saved_by_params = "params[:#{column_name}]"
   end

   self.class_eval %Q"
      before_filter :add_#{params_key.to_s}_#{column_name.to_s}, only: #{actions}

      private
      def add_#{params_key.to_s}_#{column_name.to_s}
        return false if params[:#{params_key}].blank?
        #{saved_by_params} = current_user.try(:id).to_s
      end
    "
  end
end