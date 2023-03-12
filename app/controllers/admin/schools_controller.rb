class Admin::SchoolsController < Admin::ApplicationController
  before_action :authorize_access
private

  def scoped_resource
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      super.where(id: school_admin&.school&.id)
    else
      super
    end
  end

  def authorize_access
    redirect_to root_path, alert: "You do not have permission to perform this action." unless valid_action?(params[:action])
  end

  def valid_action?(name, resource = resource_class)
    return true if current_user.admin?
    return false unless current_user.admin? || current_user.school_admin?
    return false if current_user.school_admin? && %w[new create destroy].include?(name.to_s)

    return true
  end
end
