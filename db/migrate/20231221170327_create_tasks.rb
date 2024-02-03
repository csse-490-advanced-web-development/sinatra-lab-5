class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.text :description
      t.boolean :complete, default: false
      t.timestamps null: false
    end
  end
end
