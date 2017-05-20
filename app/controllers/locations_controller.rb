class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @location = Bolation.find(params[:id])
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update_attributes(location_params)
      redirect_to action: 'index', notice: "Location updated"
    else
      render action: 'edit'
    end
  end

  private

  def location_params
    params.require(:location).permit(:county, :name, :address, :phone, :website, :services, :type_of_services)
  end
end
