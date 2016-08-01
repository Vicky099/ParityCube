class ImagesController < ApplicationController

  def new
    @image = Image.new
  end

  def create
    user = User.find(params[:image][:user_id])
    if user.images.count > 1
      image = Image.new(image_params)
      if image.save!
        redirect_to root_path
      else
        render 'new'
      end
    else
      flash[:notice] = "You upload only one image."
      redirect_to root_path
    end
  end

  def like
    #remain if  c user need to like one pic ones
    #owner of pic not like to his photo
    #ajaxified change vote count 
    image = Image.find(params[:id])
    like_count = image.like + 1
    if image.update_attributes(like: like_count)
      @status = "success"
      @like_count = image.like
    else
      @status = "success"
      flash[:alert] = "Please vote it again."
    end
  end

  def favourite
    image = Image.find(params[:id])
    favourite_count = image.favourite + 1
    if image.update_attributes(favourite: favourite_count)
      @status = "success"
      @favourite_count = image.favourite
    else
      @status = "success"
      flash[:alert] = "Please vote it again."
    end
  end

  private

  def image_params
     params.require(:image).permit(:name, :tag_line, :photo, :user_id)
  end

end
