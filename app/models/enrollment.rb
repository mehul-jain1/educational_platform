class Enrollment < ApplicationRecord
  belongs_to :student, class_name: 'Student', foreign_key: :user_id
  belongs_to :batch
  
  enum status: {
    pending: 0,
    active: 1,
    rejected: 2
  }
  scope :active, -> {where(status: :active)}
  scope :pending, -> {where(status: :pending)}
  scope :rejected, -> {where(status: :rejected)}

end
