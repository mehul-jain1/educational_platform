class School < ApplicationRecord
  has_many :students, -> { with_roles(User::ROLES[:student])}
  has_many :school_admins, -> { with_roles(User::ROLES[:school_admin])}
  has_many :courses
  has_many :batches
end
