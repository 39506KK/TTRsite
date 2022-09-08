class Public::CustomersController < ApplicationController
  
  def show
    @customer =Customer.find(params[:id])
    @customer = current_customer
    @customer_reserves = current_customer.reserves.where("day >= ?", Date.current).order(day: :desc)
    @visit_historys = current_customer.reserves.where("day < ?", Date.current).where("day > ?", Date.today << 12).order(day: :desc)

  end

  def edit
   @customer = current_customer

  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_customer_path(@customer)
  end

  def quit
    @customer = current_customer
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_kana, :first_kana, :tell, :email)
  end

end
