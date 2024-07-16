class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :dob, :string
    add_column :users, :role, :string
    add_column :users, :gender, :string
  end
end
