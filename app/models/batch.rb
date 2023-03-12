class Batch < ApplicationRecord
  belongs_to :school

  has_many :enrollments

  has_many :active_enrollments, -> { active }, class_name: 'Enrollment'
  has_many :pending_enrollments, -> { pending }, class_name: 'Enrollment'
  has_many :rejected_enrollments, -> { rejected }, class_name: 'Enrollment'  
end
