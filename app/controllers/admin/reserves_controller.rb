class Admin::ReservesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @reserves = Reserve.all
    @reserve = Reserve.page(params[:page]).per(10)
  end

  # def show
  #   @customer = Customer.find(params[:id])
  # end

  # def edit
  #   @customer = Customer.find(params[:id])
  # end
  
  # def update
  #   @customer = Customer.find(params[:id])
  #   if @customer.update(customer_params)
  #     redirect_to admin_customer_path(@customer)
  #   else
  #     render :edit
  #   end
  # end
  
  private
  def reserve_params
    params.require(:reserve).permit(:day, :time, :customer_id, :start_time)
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_kana, :first_kana, :tell, :email)
  end
  
end
