class Admin::CoursesController < Admin::ApplicationController
  def new
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      @schools  = School.where(id: school_admin&.school&.id)
    else
      @schools = School.all
    end

    resource = new_resource
    authorize_resource(resource)
    render locals: {
      page: Administrate::Page::Form.new(dashboard, resource),
    }
  end
  
  def edit
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      @schools  = School.where(id: school_admin&.school&.id)
    else
      @schools = School.all
    end

    render locals: {
      page: Administrate::Page::Form.new(dashboard, requested_resource),
    }
  end
private

  def scoped_resource
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      super.where(school_id: school_admin&.school&.id)
    elsif current_user.student?
      student = current_user.becomes(Student)
      super.where(school_id: student&.school&.id)
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
    return false if current_user.student? && %w[new create edit update destroy].include?(name.to_s)

    return true
  end
end
