class HomeController < ApplicationController
  def index
    @plants = Plant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @plants }
    end
  end

  def about

  end

end
