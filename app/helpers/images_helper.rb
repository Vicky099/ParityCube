module ImagesHelper

  def user_already_like_image(image)
     image.like_activities.present? && (image.like_activities.where("like_user_id=?",current_user.id))
  end

end
