require "administrate/base_dashboard"

class StudentDashboard < UserDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    password:  Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    role: Field::Select.with_options(
      collection: Student.valid_roles,
      label: 'Role'
    ),
    school: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  FORM_ATTRIBUTES = %i[
    name
    email
    password
    role
    school
  ].freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    email
    school
  ].freeze

  def display_resource(user)
    "Student ##{user.name}"
  end
end
