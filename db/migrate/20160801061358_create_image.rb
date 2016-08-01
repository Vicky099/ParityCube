class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :tag_line
      t.references :user
      t.timestamps null: false
    end
  end
end
