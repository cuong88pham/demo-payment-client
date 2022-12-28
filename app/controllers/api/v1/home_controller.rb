module Api 
  module V1 
    class HomeController < Api::V1::BaseController
      before_action :authenticate_user!
      def index
        render json: {status: true}, adapter: :json, status: 201
      end
    end    
  end
end
