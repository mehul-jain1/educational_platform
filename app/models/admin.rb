class Admin < User  
  def self.valid_roles
    [User::ROLES[:admin]]
  end
end