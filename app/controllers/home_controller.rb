class HomeController < ApplicationController

  def index
    @all_images = Image.all    
  end

end