class MapController < ApplicationController
  def index
    @location = params[:city_input]
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

end
