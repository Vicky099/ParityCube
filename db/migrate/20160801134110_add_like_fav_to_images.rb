class AddLikeFavToImages < ActiveRecord::Migration
  def change
    add_column :images, :like, :integer, default: 0
    add_column :images, :favourite, :integer, default: 0
    remove_column :images, :name
  end
end
