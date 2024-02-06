class CreateUsers < ActiveRecord::Migration[7.1]
 def change
    create_table :users do |u|
      u.string :email
      u.string :password_digest

      u.timestamps null: false
    end
  end
end
