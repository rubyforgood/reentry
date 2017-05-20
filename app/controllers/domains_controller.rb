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
      redirect_to new_domain_path
      flash[:success] = "Domain saved"
    else
      render action: 'new'
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
      render action: 'edit'
      flash[:danger] = "Unable to update domain"
    end
  end

  private

  def domain_params
    params.require(:domain).permit(:name, :kind, :url, :description, :search_depth, :status, :status_date, :searched_at)
  end

end
