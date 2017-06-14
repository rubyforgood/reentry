class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to locations_path
      flash[:success] = "Location added!"
    else
      redirect_to new_location_path
      flash[:danger] = "Could not save location."
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update_attributes(location_params)
      redirect_to locations_path
      flash[:success] = "Location updated"
    else
      redirect_to edit_location_path
      flash[:danger] = "Location not updated"
    end
  end

  def delete
    Location.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  def destroy
    Location.find(params[:id]).destroy
    flash[:success] = "Location removed"
    redirect_to action: 'index'
  end

  private

  def location_params
    params.require(:location).permit(:county, :name, :address, :phone, :website, :services, :type_of_services)
  end
end
