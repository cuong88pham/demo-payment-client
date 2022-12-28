class Admin::ManagersController < AdminController
  inherit_resources
  assign_params :id, :email, :password, :password_confirmation
  has_scope :page, default: 1
  has_scope :per, default: 10
  def update
    params[:manager].delete :password if params[:manager][:password].blank?
    params[:manager].delete :password_confirmation if params[:manager][:password_confirmation].blank?
    super
  end
  protected
    def collection 
      @q = Manager.ransack(params[:q])
      if params[:q].present?
        @managers = @q.result(distinct: true).page params[:page]
      else 
        @managers = Manager.order(id: :asc).page(params[:page])
      end
    end
    
  
end