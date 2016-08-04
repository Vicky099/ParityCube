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
    image = Image.find(params[:id])
    like_count = image.like + 1
    if image.update_attributes(like: like_count)
      image.like_activities.create!(image_id: image.id, like_user_id: current_user.id)
      @status = "success"
      @like = image
    else
      @status = "fail"
      flash[:alert] = "Please vote it again."
    end
  end

  def favourite
    image = Image.find(params[:id])
    favourite_count = image.favourite + 1
    if image.update_attributes(favourite: favourite_count)
      image.like_activities.create!(image_id: image.id, favourite_user_id: current_user.id)
      @status = "success"
      @favourite_count = image.favourite
    else
      @status = "success"
      flash[:alert] = "Please vote it again."
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
