class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :status
      t.date :due_date
      t.belongs_to :user

      t.timestamps
    end
    add_index :tasks, :user_id
  end
end
