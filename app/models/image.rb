class Image < ActiveRecord::Base

  mount_uploader :photo, ImageUploader
  belongs_to :user
  has_many :like_activities 
end


# user
#   - has_many :images
#   - has_many :like_activities
# image 
#   - belongs_to :user
#   - has_many :like_activities
# like_activities
#   - belongs_to :image
#   - belongs_to :user