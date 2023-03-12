class Admin::EnrollmentsController < Admin::ApplicationController
  def new
    # fetch all students in the assigned school of school admin if user is school admin
    # fetch all students in all the schools if user is admin
    # fetch all batches in the assigned school of school admin if user is school admin
    # fetch all batches in all the schools if user is admin
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      @students  = Student.with_roles(User::ROLES[:student]).where(school_id: school_admin&.school&.id)
      @batches  = Batch.where(school_id: school_admin&.school&.id)
    else
      @students = Student.with_roles(User::ROLES[:student])
      @batches = Batch.all
    end

    resource = new_resource
    authorize_resource(resource)
    render locals: {
      page: Administrate::Page::Form.new(dashboard, resource),
    }
  end
private

  # def scoped_resource
  #   if current_user.school_admin?
  #     school_admin = current_user.becomes(SchoolAdmin)
  #     super.where(school_id: school_admin&.school&.id)
  #   else
  #     super
  #   end
  # end
end
