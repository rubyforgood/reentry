class LocationServicesController < ApplicationController
  def index
     respond_to do |format|
       format.csv { render :csv => LocationService.all, :style => :ohana, :filename => 'services' }
     end
   end
end