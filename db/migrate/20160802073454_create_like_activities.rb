class CreateLikeActivities < ActiveRecord::Migration
  def change
    create_table :like_activities do |t|
      t.references :image
      t.integer :like_user_id
      t.integer :favourite_user_id
      t.timestamps null: false
    end
  end
end
