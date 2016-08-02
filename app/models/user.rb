class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [ :super_admin, :admin, :employee, :intern ]

  has_many :images
  has_many :fav_users, class_name: 'LikeActivity', :foreign_key => "favourite_user_id"
  has_many :like_users, class_name: 'LikeActivity', :foreign_key => "like_user_id"
  
end
