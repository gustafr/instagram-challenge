class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :status

      t.timestamps null: false
    end
  end
end
