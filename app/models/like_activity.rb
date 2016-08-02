class LikeActivity < ActiveRecord::Base
  belongs_to :image
  belongs_to :like_user, class_name: 'User', foreign_key: 'like_user_id'
  belongs_to :fav_user, class_name: 'User', foreign_key: 'favourite_user_id'
end
