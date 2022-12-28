class Admin::UsersGroupsController < AdminController
  inherit_resources
  assign_params :id, :name, :memo, :status, :photo, user_ids: [], manager_ids: []
  has_scope :page, default: 1
  has_scope :per, default: 10

  protected
    def collection 
      @q = UsersGroup.eager_load(:users, :managers).ransack(params[:q])
      if params[:q].present?
        @users_groups = @q.result(distinct: true).page params[:page]
      else 
        @users_groups = UsersGroup.eager_load(:users, :managers).order(id: :asc).page(params[:page])
      end
    end
    
  
end