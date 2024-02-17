class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |user|
      user.string :email
      user.string :password_digest
      user.timestamps null: false
    end
  end
end
