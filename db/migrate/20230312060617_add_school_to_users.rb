class AddSchoolToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :school, null: true, foreign_key: true
  end
end
