class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def manage
  end
end
