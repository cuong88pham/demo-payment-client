class AdminController < ApplicationController
  include Pundit
  include ActionController::MimeResponds
  protect_from_forgery prepend: true
  layout 'admin'
  before_action :authenticate_manager!
end