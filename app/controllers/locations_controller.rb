class LocationsController < ApplicationController
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
      flash[:success] = "Location added!"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update_attributes(location_params)
      flash[:success] = "Location updated"
      redirect_to action: 'index'
    else
      render action: 'edit'
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
