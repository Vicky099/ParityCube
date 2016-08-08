class ImagesController < ApplicationController

  def new
    @image = Image.new
  end

  def create
    user = User.find(params[:image][:user_id])
    if user.images.count < 2
      image = Image.new(image_params)
      if image.save!
        redirect_to root_path
      else
        render 'new'
      end
    else
      flash[:notice] = "You have already uploaded one!!"
      redirect_to root_path
    end
  end

  def like 
    already_liked = current_user.like_users.where(:image_id => params[:id])
    unless already_liked.present?
      image = Image.find(params[:id])
      like_count = image.like + 1
      if image.update_attributes(like: like_count)
        image.like_activities.create!(image_id: image.id, like_user_id: current_user.id)
        @status = "success"
        @image = image
        flash[:success] = "You Like photo. Thank You."
        redirect_to root_path
      else
        @status = "fail"
        @image = image
        flash[:alert] = "Please vote it again."
        redirect_to root_path
      end
    else
      flash[:alert] = "You have already like these photo."
      redirect_to root_path
    end
  end

  def favourite
    already_fav = current_user.fav_users.where(:image_id => params[:id])
    unless already_fav.present?
      image = Image.find(params[:id])
      favourite_count = image.favourite + 1
      if image.update_attributes(favourite: favourite_count)
        image.like_activities.create!(image_id: image.id, favourite_user_id: current_user.id)
        @status = "success"
        @image = image
        redirect_to root_path
      else
        @status = "success"
        @image = image
        flash[:alert] = "Please vote it again."
        redirect_to root_path
      end
    else
      flash[:alert] = "You have already favourite these photo."
      redirect_to root_path
    end
  end

  def results
    @top_like_images = Image.all.order(like: :desc).first(3)
    @top_fav_images = Image.all.order(favourite: :desc).first(3)
  end

  private

  def image_params
     params.require(:image).permit(:name, :tag_line, :photo, :user_id)
  end

end
