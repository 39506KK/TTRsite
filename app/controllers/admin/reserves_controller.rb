class Admin::ReservesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @reserves = Reserve.page(params[:page]).per(10)
  end

end
