class Student < User
  belongs_to :school
  has_many :enrollments,-> { active.or(pending) }, class_name: 'Enrollment', foreign_key: :user_id

  has_many :active_enrollments, -> { active }, class_name: 'Enrollment', foreign_key: :user_id
  has_many :pending_enrollments, -> { pending }, class_name: 'Enrollment', foreign_key: :user_id
  has_many :rejected_enrollments, -> { rejected }, class_name: 'Enrollment', foreign_key: :user_id

  has_many :batches, through: :active_enrollments

  def self.valid_roles
    [User::ROLES[:student]]
  end
end