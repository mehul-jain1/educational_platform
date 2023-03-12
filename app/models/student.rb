class Student < User
  belongs_to :school
  has_many :enrollments
  has_many :batches, through: :enrollments

  def self.valid_roles
    [User::ROLES[:student]]
  end
end