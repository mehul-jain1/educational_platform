class Admin::StudentsController < Admin::UsersController
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

  def update
    if requested_resource.update(resource_params)
      redirect_to(
        [namespace, requested_resource],
        notice: translate_with_resource("update.success"),
      )
    else
      render :edit, locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
      }, status: :unprocessable_entity
    end
  end

private
  def scoped_resource
    # get all students for admin
    # get all assigned student to school for school admin
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      super.with_roles(User::ROLES[:student]).where(school_id: school_admin&.school&.id)
    else
      super.with_roles(User::ROLES[:student])
    end
  end

  def authorize_resource(resource)
    unless show_action?(params[:action], resource)
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end

  def show_action?(action, resource)
    current_user.admin? || current_user.school_admin?
  end
end