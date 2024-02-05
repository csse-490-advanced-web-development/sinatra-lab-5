class CreateUsers < ActiveRecord::Migration[7.1]
  def change

    # : a string for email, a string for password_digest, and the default timestamps (e.g. `t.timestamps null: false`)
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
