require "administrate/base_dashboard"

class AdminDashboard < UserDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    email: Field::String,
    password:  Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    role: Field::Select.with_options(
      collection: Admin.valid_roles,
      label: 'Role'
    ),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze
end
