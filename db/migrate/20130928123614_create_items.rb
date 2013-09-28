class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :category
      t.string :status
      t.belongs_to :user

      t.timestamps
    end
    add_index :items, :user_id
  end
end
