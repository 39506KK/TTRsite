class Public::ReservesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @reserves = Reserve.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end
  
  def new
    @reserve = Reserve.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reserve.check_reserve_day(@day.to_date)
    if !!message
      redirect_to public_reserves_path, flash: { alert: message }
    end
  end

  def show
    @reserve = Reserve.find(params[:id])
  end

  def create
    @reserve = Reserve.new(reserve_params)
    if @reserve.save
      redirect_to public_reserve_path @reserve.id
    else
      render :new
    end
  end

  def destroy
    @reserve = Reserve.find(params[:id])
    if @reserve.destroy
      redirect_to public_customer_path(current_customer.id), flash: { success: "予約を削除しました" }
    else
      render :show, flash: { error: "予約の削除に失敗しました" }
    end
  end

  private
  def reserve_params
    params.require(:reserve).permit(:day, :time, :customer_id, :start_time)
  end
  
end
