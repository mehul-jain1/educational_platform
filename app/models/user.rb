class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :with_roles, -> (role) { where("role = ?", role) }

  ROLES = {
    admin: 'Admin',
    school_admin: 'School Admin',
    student: 'Student'
  }

  def admin?
    role.camelcase == ROLES[:admin]
  end

  def school_admin?
    role.camelcase == ROLES[:school_admin]
  end

  def student?
    role.camelcase == ROLES[:student]
  end
end
