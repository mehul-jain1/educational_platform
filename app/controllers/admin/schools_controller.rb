class Admin::SchoolsController < Admin::ApplicationController
private

  def scoped_resource
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      super.where(id: school_admin&.school&.id)
    else
      super
    end
  end

  def authorize_resource(resource)
    unless show_action?(params[:action], resource)
      raise AuthorizationError
    end
  end

  def show_action?(name, resource = resource_class)
    return true if current_user.admin?
    return false unless current_user.admin? || current_user.school_admin?
    return false if current_user.school_admin? && %w[new create destroy].include?(name.to_s)

    return true
  end
end
