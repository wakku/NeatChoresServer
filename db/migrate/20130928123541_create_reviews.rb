class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :outcome
      t.belongs_to :task
      t.references :user

      t.timestamps
    end
    add_index :reviews, :task_id
    add_index :reviews, :user_id
  end
end
