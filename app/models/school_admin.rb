class SchoolAdmin < User
  belongs_to :school
    
  def self.valid_roles
    [User::ROLES[:school_admin]]
  end
end