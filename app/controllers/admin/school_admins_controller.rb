class Admin::SchoolAdminsController < Admin::UsersController
private

  def scoped_resource
    super.with_roles(User::ROLES[:school_admin])
  end

  def authorize_resource(resource)
    unless show_action?(params[:action], resource)
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end

  def show_action?(action, resource)
    current_user.admin?
  end
end
