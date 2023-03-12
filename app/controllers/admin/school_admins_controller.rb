class Admin::SchoolAdminsController < Admin::UsersController
private

  def scoped_resource
    super.with_roles(User::ROLES[:school_admin])
  end

  def authorize_resource(resource)
    unless show_action?(params[:action], resource)
       raise AuthorizationError
    end

  end

  def show_action?(action, resource)
    current_user.admin?
  end
end
