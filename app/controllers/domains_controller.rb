class DomainsController < ApplicationController

  def index
    @domains = Domain.all
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(domain_params)
    if @domain.save
      redirect_to domains_path
      flash[:success] = "Domain saved"
    else
      redirect_to new_domain_path
      flash[:danger] = "Domain not saved"
    end
  end

  def show
    @domain = Domain.find(params[:id])
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    if @domain.update_attributes(domain_params)
      redirect_to domain_path
      flash[:success] = "Domain updated"
    else
      redirect_to edit_domain_path
      flash[:danger] = "Unable to update domain"
    end
  end

  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy
    redirect_to domains_path
    flash[:success] = "Domain destroyed"
  end

  def perform_processor
    domain = Domain.find(params[:id])
    locations = Location.where(domain: domain)
    original_count = locations.count
    domain.perform_processor
    updated_count = locations.count
    redirect_to domain_path domain
    flash[:success] = <<~FLASH
      Search complete. Number of locations from this domain was #{original_count}, now #{updated_count}
    FLASH
  end

  private

  def domain_params
    params.require(:domain).permit(:name, :kind, :url, :description, :search_depth, :status, :status_date, :searched_at)
  end

end
