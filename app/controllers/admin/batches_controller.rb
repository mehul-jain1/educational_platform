class Admin::BatchesController < Admin::ApplicationController
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
    else
      super
    end
  end
end
