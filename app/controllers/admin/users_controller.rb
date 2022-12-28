class Admin::UsersController < AdminController
  inherit_resources
  assign_params :id, :username, :email, :password, :password_confirmation, 
    :firstname, :lastname, :student_code, :phone_number, :photo
  has_scope :page, default: 1
  has_scope :per, default: 10
  def update
    params[:user].delete :password if params[:user][:password].blank?
    params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?
    super
  end
  protected
    def collection 
      @q = User.eager_load(:users_groups).ransack(params[:q])
      if params[:q].present?
        @users = @q.result(distinct: true).page params[:page]
      else 
        @users = User.eager_load(:users_groups).order(id: :asc).page(params[:page])
      end
    end
    
  
end