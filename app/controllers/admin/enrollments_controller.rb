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

  def show
    requested_resource = Enrollment.find(params[:id])
    render locals: {
      page: Administrate::Page::Show.new(dashboard, requested_resource),
    }
  end

  def edit
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

    render locals: {
      page: Administrate::Page::Form.new(dashboard, requested_resource),
    }
  end

  def create_request
    @batch   = Batch.find(params[:id])
    @student = Student.find(params[:student_id])
    @enrollment = Enrollment.new(batch_id: @batch.id, student: @student, status: :pending)
    if @enrollment.save
      redirect_to admin_batch_path(@batch), notice: 'Your request has been sent to the School admin'
    else
      redirect_to root_path, notice: 'Something went wrong'
    end
  end
private

  def scoped_resource
    if current_user.school_admin?
      school_admin = current_user.becomes(SchoolAdmin)
      super.where(batch_id: school_admin&.school&.batches&.pluck(:id))
    elsif current_user.student?
      # if student get all active enrollments for him => 
      student = current_user.becomes(Student)
      student.active_enrollments 
    else
      super
    end
  end

  def authorize_resource(resource)
    unless valid_action?(params[:action], resource)
      raise AuthorizationError
    end
  end

  def valid_action?(name, resource = resource_class)
    return false if current_user.student? && %w[new create edit update destroy].include?(name.to_s)

    return true
  end
end
